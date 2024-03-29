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

if(!isset($settings['base_url'])){
	die('Access denied!');
}

if($admin->is_logged()){

	if(!_ADMIN_TEST_MODE_ and isset($_POST['action'])){
		if($_POST['action']=='remove_link' and isset($_POST['id']) and $_POST['id']>0 and checkToken('remove_link')){
			link::remove($_POST['id']);
			if(isset($_POST['add_ip_black_list']) and !empty($_POST['ip'])){
				settings::addIpToBlackList($_POST['ip']);
			}
			$render_variables['alert_danger'][] = trans('The link has been deleted');
		}elseif($_POST['action']=='remove_links' and isset($_POST['links']) and is_array($_POST['links']) and checkToken('action_links')){
			foreach($_POST['links'] as $key => $value){
				if($value>0){
					link::remove($value);
				}
			}
			$render_variables['alert_danger'][] = trans('The link has been deleted');
		}
	}

	$render_variables['links'] = link::list(100,$_GET);

	$title = trans('Links').' - '.$title_default;

}
