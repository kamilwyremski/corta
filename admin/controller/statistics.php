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

	if(isset($_POST['select_1']) and isset($_POST['select_2']) and !empty($_POST['date_from']) and !empty($_POST['date_to'])){

		function plot_select($select){
			global $db;
			$result = [];
			$begin = new DateTime($_POST['date_from']);
			$end   = new DateTime($_POST['date_to']);
			for($i = $begin; $i <= $end; $i->modify('+1 day')){
				$data[0] = $i->format("Y-m-d");
				$data[1] = 0;
				$result[] = $data;
			}
			switch($select){
				case 'links':
					$sth = $db->prepare('SELECT date, count(1) as number FROM '._DB_PREFIX_.'link WHERE date>=:date_from and date<=:date_to GROUP BY date(date)');
					break;
				case 'logs_links':
					$sth = $db->prepare('SELECT date, count(1) as number FROM '._DB_PREFIX_.'logs_link WHERE date>=:date_from and date<=:date_to GROUP BY date(date)');
					break;
				case 'newsletter':
					$sth = $db->prepare('SELECT date, count(1) as number FROM '._DB_PREFIX_.'newsletter WHERE active=1 AND date>=:date_from AND date<=:date_to GROUP BY date(date)');
					break;
				default:
					return [];
			}
			$sth->bindValue(':date_from', $_POST['date_from'], PDO::PARAM_STR);
			$sth->bindValue(':date_to', $_POST['date_to']." 23:59", PDO::PARAM_STR);
			$sth->execute();
			while ($row = $sth->fetch(PDO::FETCH_ASSOC)){
				foreach($result as $key=>$value){
					if($value[0] == date("Y-m-d",strtotime($row['date']))){
						$result[$key][1] = (int) $row['number'];
					}
				}
			}
			return $result;
		}

		$statistics = [];
		$statistics[] = plot_select($_POST['select_1']);
		$statistics[] = plot_select($_POST['select_2']);
		echo json_encode($statistics);
		die();
	}

	$sth = $db->query('SELECT COUNT(1) FROM '._DB_PREFIX_.'link');
	$statistics['links'] = $sth->fetchColumn();
	$sth = $db->query('SELECT COUNT(1) FROM '._DB_PREFIX_.'logs_link');
	$statistics['logs_links'] = $sth->fetchColumn();
	$sth = $db->query('SELECT COUNT(1) FROM '._DB_PREFIX_.'logs_mail');
	$statistics['logs_mails'] = $sth->fetchColumn();
	$sth = $db->query('SELECT COUNT(1) FROM '._DB_PREFIX_.'mails_queue');
	$statistics['mails_queue'] = $sth->fetchColumn();
	$sth = $db->query('SELECT COUNT(1) FROM '._DB_PREFIX_.'newsletter WHERE active=1');
	$statistics['newsletter'] = $sth->fetchColumn();

	$render_variables['statistics'] = $statistics;

	$title = trans('Statistics').' - '.$title_default;
}
