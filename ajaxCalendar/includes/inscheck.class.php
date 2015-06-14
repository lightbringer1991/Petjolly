<?php
	
	class InstallCheck
	{
		// Tables from db
		public $tables = array(); 
		
		// Required Fields
		public $reqFields = '';
		
		// Check table
		public function check($con)
		{
			$q = $con->query('show tables');
			$r = $con->results($q);
			$af_r = $con->affected_rows();
			
			if($af_r > 0)
			{
				$q2 = $con->query('SHOW COLUMNS FROM '.TABLE);
				$r2 = $con->results($q2);
				
				$r2_total = count($r2);
				$main_tbl = count($this->tables[TABLE]);
			
				foreach($r as $r_v)
				{
					// found at least 1 table
					if(in_array($r_v['Tables_in_'.DATABASE], array_keys($this->tables)))
					{
						// check at all fields of main_tbl
						if($r2_total == $main_tbl)
						{
							return true;
						} else {
							return false;	
						}
					} else {
						return false;	
					}
				}
			} else {
				return false;	
			}
		}
	}
	
	$insCheck = new InstallCheck();
	
?>