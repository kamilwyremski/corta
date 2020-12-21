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

require_once(realpath(dirname(__FILE__)).'/config/config.php');

function cron_daily(){
	global $settings, $db;

	$db->query('DELETE FROM '._DB_PREFIX_.'admin_session WHERE date<(NOW() - INTERVAL 1 DAY)');

	$db->query('UPDATE '._DB_PREFIX_.'reset_password SET active=0 WHERE active=1 AND date<(NOW() - INTERVAL 1 DAY)');

	$db->query('DELETE FROM '._DB_PREFIX_.'session_link WHERE date<(NOW() - INTERVAL 1 DAY)');

	$db->query('DELETE FROM '._DB_PREFIX_.'newsletter WHERE active=0 AND date<(NOW() - INTERVAL 1 DAY)');

	if($settings['generate_sitemap']){
		include(realpath(dirname(__FILE__)).'/php/sitemap_generator.php');
		sitemap_generator();
	}
}
cron_daily();
