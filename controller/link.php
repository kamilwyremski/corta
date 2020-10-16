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

$link = link::show($_GET['path']);

if(!$link){
	throw new noFoundException();
}

if($settings['time_to_redirect']==0){
	header('Location: '.$link['url']);
	die('redirect');
}

$render_variables['link'] = $link;

