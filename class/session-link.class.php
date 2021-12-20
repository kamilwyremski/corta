<?php
/************************************************************************
 * Link shortener script Corta
 * Copyright (c) 2020 - 2022 by IT Works Better https://itworksbetter.net
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

class sessionLink {

	public static function new(){
		global $db;
		$session_code = bin2hex(random_bytes(32));
		$sth = $db->prepare('INSERT INTO `'._DB_PREFIX_.'session_link`(`code`, `ip`) VALUES (:code,:ip)');
		$sth->bindValue(':code', $session_code, PDO::PARAM_STR);
		$sth->bindValue(':ip', getClientIp(), PDO::PARAM_STR);
		$sth->execute();
		return $session_code;
	}

	public static function check(string $session_code){
		global $db, $settings;
		if($settings['check_ip_user']){
			$sth = $db->prepare('SELECT 1 from '._DB_PREFIX_.'session_link WHERE code=:code AND ip=:ip LIMIT 1');
			$sth->bindValue(':ip', getClientIp(), PDO::PARAM_STR);
		}else{
			$sth = $db->prepare('SELECT 1 from '._DB_PREFIX_.'session_link WHERE code=:code LIMIT 1');
		}
		$sth->bindValue(':code', $session_code, PDO::PARAM_STR);
		$sth->execute();
		if($sth->fetchColumn()){
			$sth = $db->prepare('DELETE FROM `'._DB_PREFIX_.'session_link` WHERE code=:code');
			$sth->bindValue(':code', $session_code, PDO::PARAM_STR);
			$sth->execute();
			return true;
		}
		return false;
	}
}
