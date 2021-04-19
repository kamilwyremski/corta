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

class link {

	public static function list(int $limit=50,array $data=[]){
		global $db;
		$where_statement = ' true ';
		$bind_values = [];
		if(isset($data['search'])){
			if(isset($data['id']) and $data['id']>0){
				$where_statement .= ' AND l.id = :id ';
				$bind_values['id'] = $data['id'];
			}
			if(!empty($data['url'])){
				$where_statement .= ' AND l.url LIKE :url ';
				$bind_values['url'] = '%'.$data['url'].'%';
			}
			if(!empty($data['short_url'])){
				$where_statement .= ' AND l.short_url LIKE :short_url ';
				$bind_values['short_url'] = '%'.$data['short_url'].'%';
			}
			if(!empty($data['date_from'])){
				$where_statement .= ' AND c.date >= :date_from ';
				$bind_values['date_from'] = $data['date_from'];
			}
			if(!empty($data['date_to'])){
				$where_statement .= ' AND c.date <= :date_to ';
				$bind_values['date_to'] = $data['date_to'].' 23:59:59 ';
			}
			if(!empty($data['ip'])){
				$where_statement .= ' AND c.ip like :ip ';
				$bind_values['ip'] = '%'.$data['ip'].'%';
			}
		}

		$links = [];

		$sth = $db->prepare('SELECT SQL_CALC_FOUND_ROWS l.*,
		(SELECT count(1) FROM '._DB_PREFIX_.'logs_link WHERE link_id=l.id) AS view_all, 
		(SELECT count(Distinct lo.ip) FROM '._DB_PREFIX_.'logs_link lo WHERE link_id=l.id) AS view_unique 
		FROM '._DB_PREFIX_.'link l WHERE '.$where_statement.' ORDER BY '.orderBy().' LIMIT :limit_from, :limit_to');

		$sth->bindValue(':limit_from', paginationPageFrom($limit), PDO::PARAM_INT);
		$sth->bindValue(':limit_to', $limit, PDO::PARAM_INT);
		foreach($bind_values as $key => $value){
			$sth->bindValue(':'.$key, $value, PDO::PARAM_STR);
		}
		$sth->execute();
		while($row = $sth->fetch(PDO::FETCH_ASSOC)){
			$links[] = $row;
		}

		generatePagination($limit);

		return $links;
	}

	public static function add(string $url){
		global $db;
		
		$short_url = static::generateShortUrl();

		$sth = $db->prepare('INSERT INTO `'._DB_PREFIX_.'link`(`url`, `short_url`, `ip`) VALUES (:url,:short_url,:ip)');
		$sth->bindValue(':url', $url, PDO::PARAM_STR);
		$sth->bindValue(':short_url', $short_url, PDO::PARAM_STR);
		$sth->bindValue(':ip', getClientIp(), PDO::PARAM_STR);
		$sth->execute();

		return $short_url;
	}

	public static function show(string $short_url){
		global $db;

		$sth = $db->prepare('SELECT * FROM '._DB_PREFIX_.'link WHERE short_url=:short_url LIMIT 1');
		$sth->bindValue(':short_url', $short_url, PDO::PARAM_STR);
		$sth->execute();
		$link = $sth->fetch(PDO::FETCH_ASSOC);

		if($link){
			logsLink::add($link['id']);
		}
		
		return $link;
	}

	public static function showByUrl(string $url){
		global $db;

		$sth = $db->prepare('SELECT * FROM '._DB_PREFIX_.'link WHERE url=:url LIMIT 1');
		$sth->bindValue(':url', $url, PDO::PARAM_STR);
		$sth->execute();
		$link = $sth->fetch(PDO::FETCH_ASSOC);
		
		return $link;
	}

	public static function isCorrectShortUrl(string $short_url){
		global $db, $links;
		if(in_array($short_url, $links)){
			return false;
		}
		if(file_exists(realpath(dirname(__FILE__)).'/../'.$short_url)){
			return false;
		}
		$sth = $db->prepare('SELECT 1 FROM '._DB_PREFIX_.'link WHERE short_url=:short_url LIMIT 1');
		$sth->bindValue(':short_url', $short_url, PDO::PARAM_STR);
		$sth->execute();
		if($sth->fetchColumn()){
			return false;
		}
		return true;
	}

	public static function isValidUrl($url){
        if(!$url || !is_string($url)){
            return false;
        }
        if( ! preg_match('/^http(s)?:\/\/[a-z0-9-]+(\.[a-z0-9-]+)*(:[0-9]+)?(\/.*)?$/i', $url) ){
            return false;
        }
	    if(static::getHttpResponseCode_using_getheaders($url) != 200){
            return false;
        }
        return true;
    }

    public static function getHttpResponseCode_using_getheaders($url, $followredirects = true){
        if(! $url || ! is_string($url)){
            return false;
        }
        $headers = @get_headers($url);
        if($headers && is_array($headers)){
            if($followredirects){
                $headers = array_reverse($headers);
            }
            foreach($headers as $hline){
                if(preg_match('/^HTTP\/\S+\s+([1-9][0-9][0-9])\s+.*/', $hline, $matches) ){
                    $code = $matches[1];
                    return $code;
                }
            }
            return false;
        }
        return true;
    }

	public static function addHttp(string $url){
		$url = trim(strip_tags($url));
		if(substr($url, 0, 7) != "http://" and substr($url, 0, 8) != "https://") {
			$url = 'http://'.$url;
		}
		return $url;
	}

	public static function generateShortUrl(){
		global $settings;
		$checked_short_url = [];
		$alphabet = "abcdefghijklmnopqrstuwxyz0123456789";
		$short_url_length = $settings['min_length_url'];
		$attemps_to_generate = 0;
		do{
			if($attemps_to_generate >= $short_url_length){
				$short_url_length++;
				$attemps_to_generate = 0;
			}
			$short_url_array = [];
			$alphaLength = strlen($alphabet) - 1;
			for ($i = 0; $i < $short_url_length; $i++) {
				$n = rand(0, $alphaLength);
				$short_url_array[] = $alphabet[$n];
			}
			$short_url = implode($short_url_array);
			if(!in_array($short_url,$checked_short_url)){
				$checked_short_url[] = $short_url;
				$is_correct_short_url = static::isCorrectShortUrl($short_url);
				$attemps_to_generate++;
			}
		}while(!$is_correct_short_url);
		return $short_url;
	}

	public static function remove(int $id){
		global $db;

		$sth = $db->prepare('DELETE FROM '._DB_PREFIX_.'link WHERE id=:id LIMIT 1');
		$sth->bindValue(':id', $id, PDO::PARAM_INT);
		$sth->execute();
	}
}
