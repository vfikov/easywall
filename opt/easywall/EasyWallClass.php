<?php
class EasyWall {
	public function def_files(){
		ini_set('auto_detect_line_endings', TRUE);
		$file = array(
			'friend' => '/etc/easywall/db/friends.db',
			'white' => '/etc/easywall/db/whitelist.db',
			'limit' => '/etc/easywall/db/shaped.db',
			'net' => '/etc/easywall/db/nets.db',
			'black' => '/etc/easywall/db/blacklist.db',
			'tcp' => '/etc/easywall/db/tcp.db',
			'udp' => '/etc/easywall/db/udp.db'
			);
		$list = array(
			'friend' => 'friends list',
			'white' => 'whitelist',
			'limit' => 'shaped list',
			'net' => 'shaped networks list',
			'black' => 'blacklist',
			'tcp' => 'tcp ports list',
			'udp' => 'udp ports list'
			);
	}
	public function add_ip($ip, $file){
		$put_to_file = file_put_contents($file, $ip."\n", FILE_APPEND | LOCK_EX);
	}
	public function del_ip($ip, $file){
		$find = $ip."\n";
		$handle = @fopen($file, "r");
		if ($handle) {
			while (!feof($handle)){
			    $buffer = fgets($handle, 4096);
			    if ($buffer <> $find){
				echo "$buffer";
			    }else{
				$buffer = $ip;
				echo "$buffer";
			    }
			}
	}
}
?>