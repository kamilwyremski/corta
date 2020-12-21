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

class mail {

	public static function list(){
		global $db;
		$mails = [];
		$sth = $db->query('SELECT * FROM '._DB_PREFIX_.'mails order by name');
		while($row = $sth->fetch(PDO::FETCH_ASSOC)) {$mails[] = $row;}
		return $mails;
	}

	public static function save(array $mails){
		global $db;
		$sth = $db->prepare('UPDATE `'._DB_PREFIX_.'mails` SET subject=:subject, message=:message WHERE name=:name LIMIT 1');
		foreach($mails as $key=>$value){
			$sth->bindValue(':subject', $value['subject'], PDO::PARAM_STR);
			$sth->bindValue(':message', $value['message'], PDO::PARAM_STR);
			$sth->bindValue(':name', $key, PDO::PARAM_STR);
			$sth->execute();
		}
	}

	public static function prepareMailing(array $data){
		global $db;
		$sth = $db->query('SELECT email, code FROM '._DB_PREFIX_.'newsletter WHERE active=1');
		while ($row = $sth->fetch(PDO::FETCH_ASSOC)){
			mailQueue::add('mailing',$row['email'],['subject'=>$data['subject'], 'message'=>$data['message'], 'newsletter_cancel_code'=>$row['code']]);
		}
	}

	public static function send(string $type,string $email,array $data=[]){
		global $db, $settings, $mail_smtp;
		$mail_sent = false;

		if($type!='' and $email!=''){

			if($settings['smtp'] and !isset($mail_smtp)){
				$mail_smtp = require_once(realpath(dirname(__FILE__)).'/../config/smtp.php');
			}

			if($type=='mailing' or $type=='test'){
				$mail_content = ['subject'=>$data['subject'],'message'=>$data['message']];
			}else{
				$sth = $db->prepare('SELECT * FROM '._DB_PREFIX_.'mails WHERE name=:name limit 1');
				$sth->bindParam(':name', $type, PDO::PARAM_STR);
				$sth->execute();
				$mail_content = $sth->fetch(PDO::FETCH_ASSOC);
			}

			if($mail_content){

				$header = 'Reply-To: <'.$settings['email']."> \r\n";
				$message = '<!doctype html><html lang="'.$settings['lang'].'"><head><meta charset="utf-8">'.$mail_content['message'].'</head><body>';
				$subject = $mail_content['subject'];
				$ip = getClientIp();

				$message = str_replace("{title}",$settings['title'],$message);
				$subject = str_replace("{title}",$settings['title'],$subject);
				$message = str_replace("{base_url}",$settings['base_url'],$message);
				$subject = str_replace("{base_url}",$settings['base_url'],$subject);
				if($settings['logo']){
					$message = str_replace("{link_logo}",'<img src="'.makeAbsoluteUrl($settings['logo']).'" style="max-width:300px; max-height: 200px">',$message);
					$subject = str_replace("{link_logo}",'<img src="'.makeAbsoluteUrl($settings['logo']).'" style="max-width:300px; max-height: 200px">',$subject);
				}else{
					$message = str_replace("{link_logo}",'',$message);
					$subject = str_replace("{link_logo}",'',$subject);
				}
				$message = str_replace("{date}",date("Y-m-d"),$message);
				$subject = str_replace("{date}",date("Y-m-d"),$subject);
				if(isset($data['newsletter_activation_code'])){
					$message = str_replace("{newsletter_activation_link}",$settings['base_url'].'?newsletter_activation_code='.$data['newsletter_activation_code'],$message);
					$subject = str_replace("{newsletter_activation_link}",$settings['base_url'].'?newsletter_activation_code='.$data['newsletter_activation_code'],$subject);
				}
				if(!empty($data['newsletter_cancel_code'])){
					$message .= '<br><hr><br><p><a href="'.$settings['base_url'].'?newsletter_cancel='.$data['newsletter_cancel_code'].'">'.trans('Delete my email address from the newsletter').'</a></p>';
				}
				if(isset($data['name'])){
					$message = str_replace("{name}",$data['name'],$message);
					$subject = str_replace("{name}",$data['name'],$subject);
				}
				if(isset($data['email'])){
					$header = 'Reply-To: <'.$data['email']."> \r\n";
					if($settings['smtp']){$mail_smtp->AddReplyTo($data['email']);}
					$message = str_replace("{email}",$data['email'],$message);
					$subject = str_replace("{email}",$data['email'],$subject);
				}
				if(isset($data['message'])){
					$message = str_replace("{message}",$data['message'],$message);
					$subject = str_replace("{message}",$data['message'],$subject);
				}

				$header .= 'From: '.$settings['email'].' <'.$settings['email'].">\r\n";
				$header .= "MIME-Version: 1.0 \r\n";

				if($settings['mail_attachment'] and isset($_FILES['attachment']) and $_FILES['attachment']['name']!=''){

					$file_tmp_name    = $_FILES['attachment']['tmp_name'];
					$file_name        = $_FILES['attachment']['name'];
					$file_size        = $_FILES['attachment']['size'];
					$file_type        = $_FILES['attachment']['type'];
					$file_error       = $_FILES['attachment']['error'];

					if($file_error>0 or $file_size>5000000){
						die('error - bad attachment');
					}

					$handle = fopen($file_tmp_name, "r");
					$content = fread($handle, $file_size);
					fclose($handle);
					$encoded_content = chunk_split(base64_encode($content));

					$boundary = md5("sanwebe");

					$header .= "Content-Type: multipart/mixed; boundary = $boundary\r\n\r\n";

					$body = "--$boundary\r\n";
					$body .= "Content-Type: text/html; charset=utf-8\r\n";
					$body .= "Content-Transfer-Encoding: base64\r\n\r\n";
					$body .= chunk_split(base64_encode($message));

					//attachment
					$body .= "--$boundary\r\n";
					$body .="Content-Type: $file_type; name=\"$file_name\"\r\n";
					$body .="Content-Disposition: attachment; filename=\"$file_name\"\r\n";
					$body .="Content-Transfer-Encoding: base64\r\n";
					$body .="X-Attachment-Id: ".rand(1000,99999)."\r\n\r\n";
					$body .= $encoded_content;

				}else{
					$header .= "Content-Type: text/html; charset=UTF-8";
					$body = $message;
				}

				if($settings['smtp']){
					$mail_smtp->Subject = $subject;
					$mail_smtp->Body = $message;
					$mail_smtp->MsgHTML = $message;
					$mail_smtp->AltBody = $message;
					if(isset($boundary)){
						$mail_smtp->AddAttachment($_FILES['attachment']['tmp_name'],$_FILES['attachment']['name']);
					}
					$mail_smtp->ClearAllRecipients();
					$mail_smtp->AddAddress($email);

					if($mail_smtp->Send()){
						$mail_sent = true;
					}
				}else{
					$subject = '=?utf-8?B?'.base64_encode($subject).'?=';
					if(mail($email, $subject, $body, $header)){
						$mail_sent = true;
					}
				}
			}
		}
		if($mail_sent){
			logsMail::add($email,$type,$body,$ip);
			return true;
		}else{
			return false;
		}
	}
}
