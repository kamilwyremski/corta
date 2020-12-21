<?php
/************************************************************************
 * Link shortener script Corta
 * Copyright (c) 2020 - 2021 by IT Works Better https://itworksbetter.net
 * Project by Kamil Wyremski https://wyremski.pl
 * 
 * All right reserved
 *
 * *********************************************************************
 * THIS SOFTWARE IS LICENSED - YOU CAN MODIFY THESE FILES
 * BUT YOU CAN NOT REMOVE OF ORIGINAL COMMENTS!
 * ACCORDING TO THE LICENSE YOU CAN USE THE SCRIPT ON ONE DOMAIN. DETECTION
 * COPY SCRIPT WILL RESULT IN A HIGH FINANCIAL PENALTY AND WITHDRAWAL
 * LICENSE THE SCRIPT
 * *********************************************************************/

function generateToken(string $name){
	if(empty($_SESSION['token'])){
		$_SESSION['token'] = [];
	}
	if(!empty($_SESSION['token'][$name])){
		$token = $_SESSION['token'][$name];
	}else{
		$token = bin2hex(random_bytes(32));
		$_SESSION['token'][$name] = $token;
	}
	return $token;
}

function checkToken(string $name, string $token = ''){
	if(!$token and isset($_POST['token'])){
		$token = $_POST['token'];
	}
	$check = false;
	if($token and !empty($_SESSION['token'][$name]) and hash_equals($_SESSION['token'][$name], $token)){
		$check = true;
		unset($_SESSION['token'][$name]);
	}
	return $check;
}

function path(string $controller, int $id = 0, string $slug = ''){
	global $links, $settings;
	if($controller=='short_url'){
		return $slug;
	}elseif(isset($links[$controller])){
		if($id and $slug){
			return $links[$controller].'/'.$id.'-'.$slug;
		}elseif($slug){
			return $links[$controller].'/'.$slug;
		}else{
			return $links[$controller];
		}
	}elseif($controller=='rules'){
		return $links['info'].'/2-'.$settings['url_rules'];
	}elseif($controller=='privacy_policy'){
		return $links['info'].'/1-'.$settings['url_privacy_policy'];
	}
}

function absolutePath(string $controller, int $id = 0, string $slug = ''){
	global $settings;
	return $settings['base_url'].'/'.path($controller,$id,$slug);
}

function arrangeAlphabetically(string $table, string $condition = 'true'){
	global $db;
	$position = 1;
	$sth = $db->query('SELECT id FROM `'._DB_PREFIX_.$table.'` WHERE '.$condition.' ORDER BY name');
	foreach($sth as $row){
		$db->query('UPDATE '._DB_PREFIX_.$table.' SET position='.$position.' WHERE id='.$row['id'].' LIMIT 1');
		$position++;
	}
}

function getPosition(string $table, string $condition = 'true'){
	global $db;
	$sth = $db->query('SELECT position FROM `'._DB_PREFIX_.$table.'` WHERE '.$condition.' ORDER BY position DESC LIMIT 1');
	$pos = $sth->fetch(PDO::FETCH_ASSOC);
	if(!empty($pos)){
		return $pos['position']+1;
	}else{
		return 1;
	}
}

function setPosition(string $table, int $id, int $position, string $plusminus, string $additional_condition = 'true'){
	global $db;
	if($table and $id>0 and $position>0){
		if($plusminus=='+'){$condition = '<'; $sort = 'desc';}else{$condition = '>'; $sort = 'asc';}
		$sth = $db->query('SELECT id, position FROM `'._DB_PREFIX_.$table.'` WHERE position '.$condition.' '.$position.' AND '.$additional_condition.' ORDER BY position '.$sort.' LIMIT 1');
		$pos = $sth->fetch(PDO::FETCH_ASSOC);
		if($pos){
			$sth = $db->query('UPDATE `'._DB_PREFIX_.$table.'` SET position='.$pos['position'].' WHERE id='.$id.' LIMIT 1');
			$sth = $db->query('UPDATE `'._DB_PREFIX_.$table.'` SET position='.$position.' WHERE id='.$pos['id'].' LIMIT 1');
		}
	}
}

function orderBy(string $sort=' id DESC '){
	if(!empty($_GET['sort'])){
		$sort = slug($_GET['sort']);
		if(isset($_GET['sort_desc'])){
			$sort .= ' DESC ';
		}
	}
	return $sort;
}

function paginationPageFrom(int $limit){
	$limit_start = 0;
	if(isset($_GET['page']) and is_numeric($_GET['page']) and $_GET['page']>0){
		$limit_start = ($_GET['page']-1)*$limit;
	}
	return $limit_start;
}

function generatePagination(int $limit){
	global $render_variables, $db;
	$limit_start = paginationPageFrom($limit);
	$page_number = 1;
	if(isset($_GET['page']) and is_numeric($_GET['page']) and $_GET['page']>0){
		$page_number = $_GET['page'];
	}

	$sth = $db->query('SELECT FOUND_ROWS()');
	$page_count = ceil($sth->fetch(PDO::FETCH_ASSOC)['FOUND_ROWS()']/$limit);

	if($page_number<6){
		$pagination['page_start'] = 1;
	}else{
		$pagination['page_start'] =  $page_number-4;
	}

	$gets_admin = $gets = $_GET;
	unset($gets['page'],$gets['category_path'],$gets['path'],$gets['slug'],$gets['id']);
	$gets_admin = $gets;
	$page_url['page_admin'] = http_build_query($gets);
	unset($gets_admin['sort'], $gets_admin['sort_desc']);
	$page_url['sort_admin'] = http_build_query($gets_admin);
	$page_url['page'] = http_build_query($gets);
	unset($gets['sort']);
	$page_url['sort'] = $gets;

	$pagination['page_url'] = $page_url;
	$pagination['page_count'] = $page_count;
	$pagination['page_number'] = $page_number;
	$pagination['limit_start'] = $limit_start;

	$render_variables['pagination'] = $pagination;
}

function trans(string $text){
	global $translate;
	if(isset($translate[$text])){
		return ($translate[$text]);
	}else{
		return ($text);
	}
}

function langList(){
	$files = array_diff(scandir(realpath(dirname(__FILE__)).'/../config/langs/'), ['.', '..']);
	foreach($files as $key=>$file){
		$path_parts = pathinfo($file);
		if($path_parts['extension']=='php'){
			$langList[] = $path_parts['filename'];
		}
	}
	return($langList);
}

function langLoad(string $lang='en'){
	global $translate, $links;
	if(!in_array($lang, langList())){$lang = 'en';}
	require_once(realpath(dirname(__FILE__)).'/../config/langs/'.$lang.'.php');
	return $lang;
}

function slug(string $string){
	return strtolower(slugWithUpper($string));
}

function slugWithUpper(string $string){
	$cyr = [
      'а','б','в','г','д','е','ё','ж','з','и','й','к','л','м','н','о','п',
      'р','с','т','у','ф','х','ц','ч','ш','щ','ъ','ы','ь','э','ю','я',
      'А','Б','В','Г','Д','Е','Ё','Ж','З','И','Й','К','Л','М','Н','О','П',
      'Р','С','Т','У','Ф','Х','Ц','Ч','Ш','Щ','Ъ','Ы','Ь','Э','Ю','Я'
  ];
  $lat = [
      'a','b','v','g','d','e','io','zh','z','i','y','k','l','m','n','o','p',
      'r','s','t','u','f','h','ts','ch','sh','sht','a','i','y','e','yu','ya',
      'A','B','V','G','D','E','Io','Zh','Z','I','Y','K','L','M','N','O','P',
      'R','S','T','U','F','H','Ts','Ch','Sh','Sht','A','I','Y','e','Yu','Ya'
  ];
  $string = str_replace($cyr, $lat, $string);
	$string = trim(str_replace([' ','%','$',':',',','/','=','?','Ę','Ó','Ą','Ś','Ł','Ż','Ź','Ć','Ń','ę','ó','ą','ś','ł','ż','ź','ć','ń'], ['-','-','','','','','','','E','O','A','S','L','Z','Z','C','N','e','o','a','s','l','z','z','c','n'], $string));
	$string = preg_replace("/[^a-zA-Z0-9-_]+/", "", $string);
	return $string;
}

function isSlug(string $string){
	if($string and !preg_match('/[^a-z0-9-_]/', $string)){
		return true;
	}
	return false;
}

function getClientIp() {
	if(!empty($_SERVER['HTTP_CLIENT_IP'])){
		return $_SERVER['HTTP_CLIENT_IP'];
	}elseif(!empty($_SERVER['HTTP_X_FORWARDED_FOR'])){
		return $_SERVER['HTTP_X_FORWARDED_FOR'];
	}elseif(!empty($_SERVER['REMOTE_ADDR'])){
		return $_SERVER['REMOTE_ADDR'];
	}else{
		return 'SERVER';
	}
}

function webAddress(string $address=''){
	if(substr($address, 0, 7) != "http://" and substr($address, 0, 8) != "https://" and $address !='') {
		$address = 'http://'.$address;
	}
	if(substr($address, -1)=='/'){
		$address = substr($address,0,-1);
	}
	return trim($address);
}

function makeAbsoluteUrl(string $address){
	global $settings;
	if(substr($address, 0, 7) != "http://" and substr($address, 0, 8) != "https://" and $address !='') {
		if(substr($address, 0, strlen($settings['base_url'])) != $settings['base_url']) {
			if(substr($address, 0, 1)!='/'){
				$address = '/'.$address;
			}
			$address = $settings['base_url'].$address;
		}
	}
	return $address;
}

function getFullUrl(string $address){
	global $settings;
	if(substr($address, 0, 7) != "http://" and substr($address, 0, 8) != "https://" and $address !='') {
		if(substr($address, 0, 1)!='/'){
			$address = '/'.$address;
		}
		$address = $settings['base_url'].$address;
	}
	return $address;
}
