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

if($admin->is_logged()){

	if(!_ADMIN_TEST_MODE_ and isset($_POST['action'])){
		if($_POST['action']=='save_settings' and !empty($_POST['base_url']) and !empty($_POST['email']) and !empty($_POST['title']) and checkToken('admin_save_settings')){

			$_POST['base_url'] = webAddress($_POST['base_url']);

			settings::saveArrays(
				['base_url','email','title','keywords','description','analytics','min_length_url',
				'time_to_redirect','recaptcha_site_key','recaptcha_secret_key','smtp_host','smtp_mail','smtp_user','smtp_password','smtp_port','smtp_secure'],
				['enable_articles','generate_sitemap','check_ip_user','mail_attachment','smtp']
			);
			if($settings['lang']!=$_POST['lang']){
				unset($translate);
				$_POST['lang'] = langLoad($_POST['lang']);
				settings::save('lang');
			}
			getSettings();
			$render_variables['alert_success'][] = trans('Changes have been saved');

		}elseif($_POST['action']=='send_test_message' and !empty($_POST['email']) and !empty($_POST['subject']) and !empty($_POST['message']) and checkToken('admin_send_test_message')){
			if(mail::send('test',$_POST['email'],['subject'=>$_POST['subject'], 'message'=>$_POST['message']])){
				$render_variables['alert_success'][] = trans('The message was correctly sent');
			}else{
				$render_variables['alert_danger'][] = trans('The message was not sent');
			}
		}
	}

	$render_variables['lang_list'] = langList();

	$title = trans('Settings').' - '.$title_default;

}
