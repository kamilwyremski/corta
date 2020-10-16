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

class logsLink {

  	public static function add(int $id){
		global $db;
		$sth = $db->prepare('INSERT INTO `'._DB_PREFIX_.'logs_link`(`link_id`, `ip`) VALUES (:link_id,:ip)');
		$sth->bindValue(':link_id', $id, PDO::PARAM_INT);
		$sth->bindValue(':ip', getClientIp(), PDO::PARAM_STR);
		$sth->execute();
	}

  	public static function list(int $limit=100){
		global $db;
		$logs_links = [];
		$sth = $db->prepare('SELECT SQL_CALC_FOUND_ROWS ll.*, l.url, l.short_url FROM '._DB_PREFIX_.'logs_link ll LEFT JOIN '._DB_PREFIX_.'link l ON ll.link_id = l.id ORDER BY '.orderBy().' LIMIT :limit_from, :limit_to');
		$sth->bindValue(':limit_from', paginationPageFrom($limit), PDO::PARAM_INT);
		$sth->bindValue(':limit_to', $limit, PDO::PARAM_INT);
		$sth->execute();
		while ($row = $sth->fetch(PDO::FETCH_ASSOC)){
			$logs_links[] = $row;
		}
		generatePagination($limit);
		return $logs_links;
	}

  public static function removeWithoutLinks(){
		global $db;
    	$db->query('DELETE FROM '._DB_PREFIX_.'logs_link WHERE link_id NOT IN (SELECT id FROM '._DB_PREFIX_.'link)');
	}

	public static function removeAll(){
		global $db;
	 	$db->query('TRUNCATE `'._DB_PREFIX_.'logs_link`');
	}
}
