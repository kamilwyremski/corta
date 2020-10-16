<?php
/************************************************************************
 * Link shortener script Corta
 * Copyright (c) 2020 by IT Works Better https://itworksbetter.net
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

if(!isset($settings['base_url'])){
	die('Access denied!');
}

if(isset($_POST['action']) and $_POST['action']=='add' and !empty($_POST['url']) and !empty($_POST['session_code']) and sessionLink::check($_POST['session_code'])){
	$url = link::addHttp($_POST['url']);
	if(settings::checkIpBlackList(getClientIp()) or settings::existDomainsBlackList($url)){
		$render_variables['alert_danger'][] = trans('The link could not be added');
	}elseif(!link::isValidUrl($url)){
		$render_variables['alert_danger'][] = trans('Invalid domain name');
	}else{
		$link = link::showByUrl($url);
		if($link){
			$short_url = $link['short_url'];
		}else{
			$short_url = link::add($url);
		}
		$render_variables['alert_success'][] = trans('The link has been added correctly');

		$render_variables['info_link'] = ['url'=>$url, 'short_url'=>absolutePath('short_url',0,$short_url)];
	}
}


$render_variables['session_code'] = sessionLink::new();

$render_variables['slider'] = slider::list();

if($settings['enable_articles']){
	$render_variables['articles'] = article::list(4);
}
