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

	if(isset($_POST['action']) and $_POST['action']=='save_settings_appearance' and !empty($_POST['template']) and checkToken('admin_save_settings_appearance')){

		settings::save('template');

		if(!_ADMIN_TEST_MODE_){
			settings::saveArrays(
				['logo','logo_facebook','favicon','rodo_alert_text','footer_top','footer_bottom','code_style','code_head','code_body'],
				['rodo_alert']
			);
		}

		$dir = '../tmp/';
		$objects = scandir($dir);
		foreach ($objects as $object) {
			if ($object != "." && $object != "..") {
				if (filetype($dir."/".$object) == "dir"){
					$objects2 = scandir($dir."/".$object);
					foreach ($objects2 as $object2) {
						if ($object2 != "." && $object2 != "..") {
							unlink($dir."/".$object."/".$object2);
						}
					}
					rmdir($dir."/".$object);
				}else{
					unlink($dir."/".$object);
				}
			}
		}

		getSettings();
		$render_variables['alert_success'][] = trans('Changes have been saved');

	}

	// get list of templates
	$path = '../views/';
	$results = scandir($path);
	$templates = [];
	foreach ($results as $result) {
		if ($result === '.' or $result === '..') continue;
		if (is_dir($path . '/' . $result)) {
		   $templates[] .= $result;
		}
	}
	$render_variables['templates'] = $templates;

	$title = trans('Appearance settings').' - '.$title_default;
}
