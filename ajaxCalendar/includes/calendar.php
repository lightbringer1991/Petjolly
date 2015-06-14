<?php
require_once('../../include/base.inc.php');

	/*************************************************************************
	*	Ajax Full Featured Calendar
	*	- Add Event To Calendar
	*	- Edit Event On Calendar
	*	- Delete Event On Calendar
	*	- View Event On Calendar
	*	- Update Event On Rezise
	*	- Update Event On Drag
	*
	*	Author: Paulo Regina
	*	Version: 2.0 (January 2015)
	**************************************************************************/
	
	class calendar
	{
		
		###############################################################################################
		#### Properties
		###############################################################################################
		
		// Initializes A Container Array For All Of The Calendar Events
		var $json_array = array();
		var $categories = '';
		var $connection = '';
				
		############################################################################################### 
		#### Methods
		###############################################################################################
		
		/**
		* Construct
		* Returns connection
		*/
		public function __construct($db_server, $db_username, $db_password, $db_name, $table, $condition=false)
		{
			// Set Internal Variables
			$this->db_server = $db_server;	
			$this->db_username = $db_username;
			$this->db_password = $db_password;
			$this->db_name = $db_name;
			$this->table = $table;	
			
			$this->condition = $condition;
			
			// Connection @params 'Server', 'Username', 'Password'
			$this->connection = mysqli_connect($this->db_server, $this->db_username, $this->db_password, $this->db_name);
			
			// Display Friend Error Message On Connection Failure
			if(!$this->connection) 
			{
				die('Could not connect: ('.mysqli_connect_errno().') - ' . mysqli_connect_error());
			}
			
			// Internal UTF-8
			mysqli_query($this->connection, "SET NAMES 'utf8'");
			mysqli_query($this->connection, 'SET character_set_connection=utf8');
			mysqli_query($this->connection, 'SET character_set_client=utf8');
			mysqli_query($this->connection, 'SET character_set_results=utf8');
			
			// Run The Query
/*
			if($this->condition == false)
			{
				$this->result = mysqli_query($this->connection, "SELECT * FROM $this->table ");
			} else {
				$this->result = mysqli_query($this->connection, "SELECT * FROM $this->table WHERE $this->condition");	
			}
*/
			$query = "SELECT `meda_appointments`.`id`, `appointment_number`, 
						`appointment_description`, `appointment_date`, `appointment_time`, `visit_duration`,
						`color`, `first_name`, `last_name`, `email`, `phone` 
					  FROM `meda_appointments`, `meda_patients` WHERE `patient_id`=`meda_patients`.`id`";
			$this -> result = mysqli_query($this -> connection, $query);
		}
		
		/**
		* Function To Transform MySQL Results To jQuery Calendar Json
		* Returns converted json
		*/
		public function json_transform($js = true)
		{
			
			while($this->row = mysqli_fetch_array($this->result, MYSQLI_ASSOC))
			{
				// Set Variables Data from DB
#				$event_id = $this->row['repeat_id'];
				$event_id = 1; // no repeat event
				$event_original_id = $this->row['id'];
				$event_title = $this->row['appointment_number'];
				$event_description = $this->row['appointment_description'];
				$event_start = $this->row['appointment_date'] . " " . $this->row['appointment_time'];
				$endTime = strtotime($this->row['appointment_time']);
				$endTime = date("H:i", strtotime("+" . $this -> row['visit_duration'] . " minutes", $endTime));
				$event_end = $this->row['appointment_date'] . " " . $endTime;
#				$event_allDay = $this->row['allDay'];
				$event_color = $this->row['color'] == "" ? "blue" : $this -> row['color'];
#				$event_url = $this->row['url'];
				$event_allDay = 'false';
				$event_url = 'false';

			if($js == true) {
				// JS MODE
				if($event_url == '?page=') { $event_url = 'undefined'; }

				// When allDay = false the allDay options appears on the script, when its true it doesnot appear 
				if($event_url == 'false' && $event_allDay == 'false') {
					// Build it Without URL & allDay
					// Stores Each Database Record To An Array (Without URL)
					$build_json = array(
						'id' => $event_id, 
						'original_id' => $event_original_id, 
						'title' => $event_title, 
						'start' => $event_start, 
						'end' => $event_end, 
						'color' => $event_color,
						'name' => $this -> row['first_name'] . " " . $this -> row['last_name'],
						'email' => $this -> row['email'],
						'phone' => $this -> row['phone']
					);
	
					// Adds Each Array Into The Container Array
					array_push($this->json_array, $build_json);
				} elseif ($event_url == 'false' && $event_allDay == 'true') {
					// Build it Without URL 
					// Stores Each Database Record To An Array (Without URL)
					$build_json = array('id' => $event_id, 'original_id' => $event_original_id, 'title' => $event_title, 'start' => $event_start, 'end' => $event_end, 'color' => $event_color);
	
					// Adds Each Array Into The Container Array
					array_push($this->json_array, $build_json);
				} elseif ($event_url == 'true' && $event_allDay == 'false') {
						// Built it Without URL & allDay True
						// Stores Each Database Record To An Array
						$build_json = array('id' => $event_id, 'original_id' => $event_original_id, 'title' => $event_title, 'start' => $event_start, 'end' => $event_end, 'allDay' => $event_allDay, 'color' => $event_color, 'url' => $event_url);
						
						// Adds Each Array Into The Container Array
						array_push($this->json_array, $build_json);
				} else {
					if($event_allDay == 'false') {
						// Built it With URL & allDay false
						// Stores Each Database Record To An Array
						$build_json = array('id' => $event_id, 'original_id' => $event_original_id, 'title' => $event_title, 'start' => $event_start, 'end' => $event_end, 'allDay' => $event_allDay, 'color' => $event_color);
						if($event_url == '?page=') { } else { $build_json['url'] = $event_url; }

						// Adds Each Array Into The Container Array
						array_push($this->json_array, $build_json);
					} else {
							// Built it With URL & allDay True (fixed on 1.6.4)
							 
							// Stores Each Database Record To An Array
							$build_json = array('id' => $event_id, 'original_id' => $event_original_id, 'title' => $event_title, 'start' => $event_start, 'end' => $event_end, 'color' => $event_color, 'url' => $event_url);
							
							// Adds Each Array Into The Container Array
							array_push($this->json_array, $build_json);	 
						 }
						 
					 }
				 
				 } else {
						
					// PHP MODE
					
					// When allDay = false the allDay options appears on the script, when its true it doesnot appear 
					 if($event_url == 'false' && $event_allDay == 'false')
					 {
						 // Build it Without URL & allDay
						 // Stores Each Database Record To An Array (Without URL)
						$build_json = array('id' => $event_id, 'original_id' => $event_original_id, 'title' => $event_title, 'start' => $event_start, 'end' => $event_end, 'allDay' => $event_allDay, 'color' => $event_color);
						// Adds Each Array Into The Container Array
						array_push($this->json_array, $build_json);
					 } elseif($event_url == 'false' && $event_allDay == 'true') {
						 // Build it Without URL
						 // Stores Each Database Record To An Array (Without URL)
						$build_json = array('id' => $event_id, 'original_id' => $event_original_id, 'title' => $event_title, 'start' => $event_start, 'end' => $event_end, 'color' => $event_color);
						// Adds Each Array Into The Container Array
						array_push($this->json_array, $build_json);
					 } elseif($event_url == 'true' && $event_allDay == 'false') {
						 // Built it Without URL & allDay True
						// Stores Each Database Record To An Array
						$build_json = array('id' => $event_id, 'original_id' => $event_original_id, 'title' => $event_title, 'start' => $event_start, 'end' => $event_end, 'allDay' => $event_allDay, 'color' => $event_color, 'url' => $event_url);
						// Adds Each Array Into The Container Array
						array_push($this->json_array, $build_json);
					 } else {
						 if($event_allDay == 'false' && substr($event_url, -4, 1) == '.' || substr($event_url, -3, 1) == '.') { // domain top level checking
							// Built it With URL & allDay false
							// Stores Each Database Record To An Array
							$build_json = array('id' => $event_id, 'original_id' => $event_original_id, 'title' => $event_title, 'start' => $event_start, 'end' => $event_end, 'allDay' => $event_allDay, 'color' => $event_color, 'url' => $event_url);
							// Adds Each Array Into The Container Array
							array_push($this->json_array, $build_json);
						 } elseif($event_allDay == 'true' && substr($event_url, -4, 1) == '.' || substr($event_url, -3, 1) == '.') {
							// Built it With URL & allDay true
							// Stores Each Database Record To An Array
							$build_json = array('id' => $event_id, 'original_id' => $event_original_id, 'title' => $event_title, 'start' => $event_start, 'end' => $event_end,  'color' => $event_color, 'url' => $event_url);
							// Adds Each Array Into The Container Array
							array_push($this->json_array, $build_json);
						 } elseif($event_allDay == 'false' && isset($event_url)) {
							// Built it With any URL and allDay false
							// Stores Each Database Record To An Array
							$build_json = array('id' => $event_id, 'original_id' => $event_original_id, 'title' => $event_title, 'start' => $event_start, 'end' => $event_end,  'allDay' => $event_allDay, 'color' => $event_color, 'url' => $event_url . $event_original_id);
							// Adds Each Array Into The Container Array
							array_push($this->json_array, $build_json);
					 	 } else {
							// Built it With URL & allDay True 
							// Stores Each Database Record To An Array
							$build_json = array('id' => $event_id, 'original_id' => $event_original_id, 'title' => $event_title, 'start' => $event_start, 'end' => $event_end, 'color' => $event_color, 'url' => $event_url . $event_original_id);
							// Adds Each Array Into The Container Array
							array_push($this->json_array, $build_json);	 
						 }
					 }
				 }
			} // end while loop
			
			// Output The Json Formatted Data So That The jQuery Call Can Read It
			return json_encode($this->json_array);	
		}
		
		/**
		* This function will check for repetitive events (since 1.6.4)
		* Returns true
		*/
		public function check_repetitive_events($id)
		{
/*
			$query = sprintf('SELECT * FROM %s WHERE repeat_id != id AND id = %d || repeat_id = %d',
				  mysqli_real_escape_string($this->connection, $this->table),
				  mysqli_real_escape_string($this->connection, $id),
				  mysqli_real_escape_string($this->connection, $id)
			);
			
			$res = mysqli_query($this->connection, $query);
			
			if(mysqli_num_rows($res) > 1)
			{
				return true; 
			} elseif(mysqli_num_rows($res) == 1) {
				$row = mysqli_fetch_assoc($res);
				if($row['id'] == $row['repeat_id'])
				{
					return false;
				} else {
					return true;	
				}
			} else {
				return false;	
			}
*/
			// this project does not have repetitive events
			return false;
		}
		
		/**
		* This function will get description (since 1.6.4)
		* Returns true
		*/
		public function get_description($id)
		{
			$query = sprintf('SELECT description FROM %s WHERE id = %d',
				  mysqli_real_escape_string($this->connection, $this->table),
				  mysqli_real_escape_string($this->connection, $id)
			);
			
			$res = mysqli_query($this->connection, $query);

			if(mysqli_num_rows($res) >= 1)
			{
				$result = mysqli_fetch_assoc($res);
				return $result['description'];
			} else {
				return false;	
			}
		}
		
		/**
		* This function will get event data (since 2.0)
		* Returns boolean
		*/
		public function get_event($id) {
			$query = sprintf('SELECT `%s`.`id`, 
								`appointment_number`, 
								`appointment_description`, 
								`appointment_date`, 
								`appointment_time`, 
								`visit_duration`, 
								`%s`.`id` AS `customer_id`,
								`first_name`, 
								`last_name`,
								`color`,
								`speciality_list`
							FROM %s, %s 
							WHERE `%s`.`id`=%d 
								AND `patient_id`=`%s`.`id`',
				mysqli_real_escape_string($this->connection, $this->table),
				'meda_patients',
				mysqli_real_escape_string($this->connection, $this->table),
				'meda_patients',
				mysqli_real_escape_string($this->connection, $this->table),
				mysqli_real_escape_string($this->connection, $id),
				'meda_patients'
			);
			
			$res = mysqli_query($this->connection, $query);

			if(mysqli_num_rows($res) >= 1) {
				$result = mysqli_fetch_assoc($res);
				return $result;
			} else {
				return false;	
			}
		}
		
		/**
		* This function updates event drag, resize, repetitive event from jquery fullcalendar
		* Returns true
		*/
		
		// update for repetitive events
		private function update_ui_repetitive($start, $end, $allDay_value, $repeat_type, $id, $extra)
		{
			if(strlen($allDay_value) == 0)
			{
				if(is_array($extra))
				{
					if(isset($extra['url']))
					{
						$url = $extra['url'];
					} else {
						$url = "false";	
					}
					
					$title = $extra['title'];
					$description = $extra['description'];
					$color = $extra['color'];
					$category = $extra['category'];

					$the_query = "title = '$title', description = '$description', color = '$color', category = '$category', url = '$url',";	
				} else {
					$the_query = '';	
				}
			} else {
				$the_query = "allDay = '$allDay_value',";	
			}
			
			$query = sprintf('UPDATE %s 
									SET 
										start = "%s",
										end = "%s",
										%s
										repeat_type = "%s"
									WHERE
										id = %d
						',
										mysqli_real_escape_string($this->connection, $this->table),
										mysqli_real_escape_string($this->connection, $start),
										mysqli_real_escape_string($this->connection, $end),
										$the_query,
										$repeat_type,
										mysqli_real_escape_string($this->connection, $id)
						);
			
			// The result
			return $this->result = mysqli_query($this->connection, $query);
		}
		
		// repetitive event procedure (for updates)
		private function repetitive_event_procedure($allDay, $start, $end, $id, $original_id, $extra)
		{
			$current_date = date('d', strtotime($start));
			$current_month = date('m', strtotime($start));
			$current_year = date('Y', strtotime($start));
			$start_time = date('H:i:s', strtotime($start));
			
			$end_current_date = date('d', strtotime($end));
			$end_current_month = date('m', strtotime($end));
			$end_current_year = date('Y', strtotime($end));
			$end_time = date('H:i:s', strtotime($end));
			
			$query = mysqli_query($this->connection, sprintf('SELECT id, repeat_type FROM %s WHERE repeat_id = %d ORDER BY id ASC', 
				mysqli_real_escape_string($this->connection, $this->table),
				mysqli_real_escape_string($this->connection, $id)
			));
			
			while($row = mysqli_fetch_assoc($query))
			{
				$ids[] = $row['id'];
				$rt = $row['repeat_type'];
			}
	
			$num_rows = mysqli_num_rows($query);
			
			$allDay_value = $allDay;
			
			if($num_rows >= 1)
			{ 
				switch($rt)
				{
					case 'every_day':
						for($i = 0; $i <= $num_rows-1; $i++)
						{
							$start = date('Y-m-d', strtotime("+$i day", strtotime($current_year.'-'.$current_month.'-'.$current_date))) . ' ' .$start_time;
							$end = date('Y-m-d', strtotime("+$i day", strtotime($end_current_year.'-'.$end_current_month.'-'.$end_current_date))) . ' ' .$end_time;
							$this->update_ui_repetitive($start, $end, $allDay_value, 'every_day', $ids[$i], $extra);
						}
						return true;
					break;
					
					case 'every_week':
						for($i = 0; $i <= $num_rows-1; $i++)
						{
							$start = date('Y-m-d', strtotime("+$i week", strtotime($current_year.'-'.$current_month.'-'.$current_date))) . ' ' .$start_time;
							$end = date('Y-m-d', strtotime("+$i week", strtotime($end_current_year.'-'.$end_current_month.'-'.$end_current_date))) . ' ' .$end_time;
							$this->update_ui_repetitive($start, $end, $allDay_value, 'every_week', $ids[$i], $extra);
						}
						return true;
					break;
					
					case 'every_month':
						for($i = 0; $i <= $num_rows-1; $i++)
						{
							$start = date('Y-m-d', strtotime("+$i month", strtotime($current_year.'-'.$current_month.'-'.$current_date))) . ' ' .$start_time;
							$end = date('Y-m-d', strtotime("+$i month", strtotime($end_current_year.'-'.$end_current_month.'-'.$end_current_date))) . ' ' .$end_time;
							$this->update_ui_repetitive($start, $end, $allDay_value, 'every_month', $ids[$i], $extra);
						}
						return true;
					break;	
				}
			}	
		}
		
		// normal update (update on drag and resize)
		public function update($params) {			
			$id = $params['id'];
			$start_date = $params['start_date'];
			$start_time = $params['start_time'];
			$duration = $params['duration'];
			// Convert Date Time
//			$start = strftime('%Y-%m-%d %H:%M:%S', strtotime(substr($start, 0, 24)));
//			$end = strftime('%Y-%m-%d %H:%M:%S', strtotime(substr($end, 0, 24)));
/*
			if($allDay == 'false') {
				$allDay_value = 'true';
			} elseif($allDay == 'true') {
				$allDay_value = 'false';	
			}
*/			
			// Before updating on drag or resize check if it is repetitive event
//			$is_rep = $this->check_repetitive_events($original_id);
			$is_rep = false;

			if($is_rep == true)
			{
				$process = $this->repetitive_event_procedure($allDay, $start, $end, $id, $original_id, '');
				
				if($process == true)
				{
					return true;
				} else {
					return false;	
				}
			 }
			
			// The update query for normal events
			$query = sprintf('UPDATE %s 
									SET 
										`appointment_date` = "%s",
										`appointment_time` = "%s",
										`visit_duration` = "%s"
									WHERE
										`id` = %s
						',
										mysqli_real_escape_string($this->connection, $this->table),
										mysqli_real_escape_string($this->connection, $start_date),
										mysqli_real_escape_string($this->connection, $start_time),
										mysqli_real_escape_string($this->connection, $duration),
										mysqli_real_escape_string($this->connection, $id)
						);
			
			// The result
			return $this->result = mysqli_query($this->connection, $query);
		}
		
		/**
		* This function updates events to the database (Edit Update)
		* Returns true
		*/
		public function updates($params) {	
			$id = isset($params['app_id']) ? mysqli_real_escape_string($this->connection, $params['app_id']) : '';
			$patient_id = isset($params['patient_id']) ? mysqli_real_escape_string($this->connection, $params['patient_id']) : '';
			$date =  isset($params['date']) ? $params['date'] : '0000-00-00';
			$start_time = $start_time = isset($params['start_time']) ? str_replace('-', ':', $params['start_time']) : '00:00:00';
			$duration = isset($params['duration']) ? $params['duration'] : '';
			$speciality = mysqli_real_escape_string($this->connection, $params['speciality']);
			$color = mysqli_real_escape_string($this->connection, $_POST['color']);

/*			
			if(isset($event['rep_id']) && strlen($event['rep_id']) !== 0)
			{
				$is_rep = $this->check_repetitive_events($id);
				
				if($is_rep == true)
				{
					$process = $this->repetitive_event_procedure('', $start, $end, $event['rep_id'], $id, $event);

					if($process == true)
					{
						return true;
					} else {
						return false;	
					}
				 }
			}
*/			
			// The update query
			$query = sprintf('UPDATE %s 
									SET 
										`patient_id` = "%s",
										`appointment_date` = "%s",
										`appointment_time` = "%s",
										`visit_duration` = "%s",
										`speciality_list` = "%s",
										`color` = "%s"
									WHERE
										`id` = %d
						',
										mysqli_real_escape_string($this->connection, $this->table),
										$patient_id,
										mysqli_real_escape_string($this->connection, $date),
										mysqli_real_escape_string($this->connection, $start_time),
										mysqli_real_escape_string($this->connection, $duration),
										$speciality,
										$color,
										$id
						);
			
			// The result
			return $this->result = mysqli_query($this->connection, $query);
		}
		
		/**
		* This function adds events to the database
		* Returns true
		*/
		public function addEvent($params = array())
		{
			$docid = isset($params['docid']) ? $params['docid'] : '';
			$date = isset($params['date']) ? $params['date'] : '0000-00-00';
			$start_time = isset($params['start_time']) ? str_replace('-', ':', $params['start_time']) : '00:00:00';
			$duration = isset($params['duration']) ? $params['duration'] : '';
			$patient_id = isset($params['patient_id']) ? $params['patient_id'] : '';
			$services = isset($params['speciality']) ? $params['speciality'] : array();
			$color = isset($params['color']) ? $params['color'] : "#0089FF";
			$appt_number = strtoupper(get_random_string(10));
			
			// Check for empty data
			if($date == '0000-00-00') { return false; }
			
			// Add Data to Database based on users $extra field
			$query = sprintf("INSERT INTO %s 
									SET 
										`appointment_number` = '%s',
										`appointment_description` = '%s',
										`doctor_id` = '%s',
										`patient_id` = '%s',
										`date_created` = '%s',
										`appointment_date` = '%s',
										`appointment_time` = '%s',
										`visit_duration` = '%s',
										`service_list` = '%s',
										`color` = '%s',
										`status` = 1
						",
										mysqli_real_escape_string($this->connection, $this->table),
										$appt_number,
										'Appointment with a doctor',
										mysqli_real_escape_string($this->connection, $docid),
										mysqli_real_escape_string($this->connection, $patient_id),
										date('Y-m-d H:i:s'),
										mysqli_real_escape_string($this->connection, htmlspecialchars($date)),
										mysqli_real_escape_string($this->connection, htmlspecialchars($start_time)),
										mysqli_real_escape_string($this->connection, $duration),
										mysqli_real_escape_string($this->connection, implode(",", $services)),
										mysqli_real_escape_string($this->connection, $color)
						);

			// The result
			$this->result = mysqli_query($this->connection, $query);
			
			$inserted_id = mysqli_insert_id($this->connection);
			Appointments::SendAppointmentEmail('new_appointment_confirm_by_email', $inserted_id);
			echo $this -> result;
		}
		
		/**
		* Repetitive Events (since 1.6.4)
		* Returns true
		*/
		private function insert_repetitive_query($fields, $start, $end)
		{
			$query =  mysqli_query($this->connection, sprintf('INSERT INTO %s 
															SET 
																title = "%s",
																description = "%s",
																start = "%s",
																end = "%s",
																allDay = "%s",
																color = "%s",
																url = "%s",
																category = "%s",
																user_id = %d,
																repeat_id = %d,
																repeat_type = "%s"
												',
													$fields['table'],
													$fields['title'],
													$fields['description'],
													$start,
													$end,
													$fields['allDay'],
													$fields['color'],
													$fields['url'],
													$fields['category'],
													$fields['user_id'],
													$fields['repeat_id'],
													$fields['repeat_method']
												));	
		}
		
		private function insert_repetitive_events($fields, $current_date, $current_month, $current_year)
		{
			$repeat_times = $fields['repeat_times'];
			
			$end_current_date = date('d', strtotime($fields['end_date']));
			$end_current_month = date('m', strtotime($fields['end_date']));
			$end_current_year = date('Y', strtotime($fields['end_date']));
			
			switch($fields['repeat_method'])
			{
				case 'every_day':
					if($repeat_times <= '30')
					{
						for($i = 1; $i <= $repeat_times; $i++)
						{
							$start = date('Y-m-d', strtotime("+$i day", strtotime($current_year.'-'.$current_month.'-'.$current_date))) . ' ' .$fields['start_time'].':00';
							$end = date('Y-m-d', strtotime("+$i day", strtotime($end_current_year.'-'.$end_current_month.'-'.$end_current_date))) . ' ' .$fields['end_time'].':00';
							$this->insert_repetitive_query($fields, $start, $end);
						}
						return true;
					}
				break;
				
				case 'every_week':
					if($repeat_times <= 30)
					{
						for($i = 1; $i <= $repeat_times; $i++)
						{
							$start = date('Y-m-d', strtotime("+$i week", strtotime($current_year.'-'.$current_month.'-'.$current_date))) . ' ' .$fields['start_time'].':00';
							$end = date('Y-m-d', strtotime("+$i week", strtotime($end_current_year.'-'.$end_current_month.'-'.$end_current_date))) . ' ' .$fields['end_time'].':00';
							$this->insert_repetitive_query($fields, $start, $end);
						}
						return true;
					}
				break;
				
				case 'every_month':
					if($repeat_times <= 30)
					{
						for($i = 1; $i <= $repeat_times; $i++)
						{
							$start = date('Y-m-d', strtotime("+$i month", strtotime($current_year.'-'.$current_month.'-'.$current_date))) . ' ' .$fields['start_time'].':00';
							$end = date('Y-m-d', strtotime("+$i month", strtotime($end_current_year.'-'.$end_current_month.'-'.$end_current_date))) . ' ' .$fields['end_time'].':00';
							$this->insert_repetitive_query($fields, $start, $end);
						}
						return true;
					}
				break;
			}
		}
		
		/**
		* Gets all Categories - since version 1.4
		* Returns array
		*/
		public function getCategories()
		{
			// Set default category in case the user do not have categories with events
			$results = $this->categories;
			asort($results);
			$return = array_unique(array_filter($results));
			
			if(count($return) == 0)
			{
				return false;
			} else {
				return $return;	
			}
		}
		
		/**
		* This function deletes event from database
		* Returns true
		*/
		public function delete($id, $rep_id, $method='')
		{
			// Delete Query
/*			
			if($method == '')
			{
				$query = "DELETE FROM $this->table WHERE id = $id";		
			} else {
				$query = "DELETE FROM $this->table WHERE repeat_id = $rep_id";		
			}
*/
			$query = "UPDATE $this->table SET `status`=2 WHERE `id`=$id";
			// Result
			$this->result = mysqli_query($this->connection, $query);
			if($this->result) {
				Appointments::SendAppointmentEmail('appointment_canceled', $id);
				return true;
			} else {
				return false;	
			}
			
		}
		
		/**
		* This function exports each event to the icalendar format and forces a download
		* Returns true
		*/		
		public function icalExport($id, $title, $description, $start_date, $end_date, $url=false)
		{
			
			if($url == 'undefined') 
			{
				$url = '';
			} else {
				$url = ' '.$url.' ';	
			}
			
			$event = $this->get_event($id);
			
			$description_fn = $str = str_replace(array("\r","\n","\t"),'\n',$description);
			
			// Build the ics file
$ical = 'BEGIN:VCALENDAR
PRODID:-//Paulo Regina//Ajax Calendar 2.0 MIMEDIR//EN
VERSION:2.0
BEGIN:VEVENT
CREATED:'.date('Ymd\This', time()).'Z'.'
DESCRIPTION:'.$description_fn.'
DTEND:'.$end_date.'
DTSTAMP:'.date('Ymd\This', time()).'Z'.'
DTSTART:'.$start_date.'
CATEGORIES:'.$event['category'].'
AFFC-ALLDAY:'.$event['allDay'].'
AFFC-COLOR:'.$event['color'].'
AFFC-URL:'.$event['url'].'
AFFC-UID:'.$event['user_id'].'
LAST-MODIFIED:'.date('Ymd\This', time()).'Z'.'
SUMMARY:'.addslashes($title).'
END:VEVENT
END:VCALENDAR';
			 
			if(isset($id)) {
				return $ical;
			} else {
				return false;
			}
		}
		
		/**
		* Export entire calendar to icalendar (since 1.6.4)
		* Returns true
		*/
		public function icalExport_all($uid=0)
		{
			
			if(isset($uid))
			{
				$u_f = $uid;
			} else {
				$u_f = 0;	
			}
			
#			$query = mysqli_query($this->connection, "SELECT * FROM $this->table WHERE user_id = $u_f");
			$query = mysqli_query($this->connection, "SELECT * FROM $this->table");
			
			if(mysqli_num_rows($query) > 0)
			{
				$ical = '';
				
$ical .= 'BEGIN:VCALENDAR' ."\n";
$ical .= 'PRODID:-//Paulo Regina//Ajax Calendar 2.0 MIMEDIR//EN'."\n";
$ical .= 'VERSION:2.0'."\n";
				while($row = mysqli_fetch_assoc($query))
				{
$ical .= 'BEGIN:VEVENT'."\n";
$ical .= 'CREATED:'.date('Ymd\This', time()).'Z'."\n";
$ical .= 'DESCRIPTION:'.str_replace(array("\r","\n","\t"),'\n',$row['description'])."\n";
$ical .= 'DTEND:'.date('Ymd\This', strtotime($row['end'])).'Z'."\n";
$ical .= 'DTSTAMP:'.date('Ymd\This', time()).'Z'."\n";
$ical .= 'DTSTART:'.date('Ymd\This', strtotime($row['start'])).'Z'."\n";
$ical .= 'CATEGORIES:'.$row['category']."\n";
$ical .= 'AFFC-ALLDAY:'.$row['allDay']."\n";
$ical .= 'AFFC-COLOR:'.$row['color']."\n";
$ical .= 'AFFC-URL:'.$row['url']."\n";
$ical .= 'AFFC-UID:'.$row['user_id']."\n";
$ical .= 'LAST-MODIFIED:'.date('Ymd\This', time()).'Z'."\n";
$ical .= 'SUMMARY:'.addslashes($row['title'])."\n";
$ical .= 'END:VEVENT'."\n";			
				}
$ical .= 'END:VCALENDAR'."\n";

			return $ical;
			
			} else {
				return false;	
			}
				
		}
		
		/**
		* This function retrieves calendar data
		* Returns true
		*/
		public function retrieve($id)
		{
			// Result Query
			$this->result = mysqli_query($this->connection, sprintf("SELECT * FROM $this->table WHERE id = %s", mysqli_real_escape_string($this->connection, $id)));
			
			if($this->result) {
				return mysqli_fetch_assoc($this->result);
			} else {
				return false;	
			}
				
		}
		
		/**
		* Strip unwanted tags from the calendar
		* Those that want HTML support on the calendar use this function on the 'updates' and 'addEvent' to the $description
		* like this $this->strip_html_tags($description) to filter it and use on the function 'json_transform' htmlspecialchars_decode($event_description)
		* to render html to the event description.
		*/
		private function strip_html_tags($text)
		{
			$text = preg_replace('~<\s*\bscript\b[^>]*>(.*?)<\s*\/\s*script\s*>~is', '', $text);
			$text = preg_replace('~<\s*\bhead\b[^>]*>(.*?)<\s*\/\s*head\s*>~is', '', $text);
			$text = preg_replace('~<\s*\bstyle\b[^>]*>(.*?)<\s*\/\s*style\s*>~is', '', $text);
			$text = preg_replace('~<\s*\bobject\b[^>]*>(.*?)<\s*\/\s*object\s*>~is', '', $text);
			$text = preg_replace('~<\s*\bapplet\b[^>]*>(.*?)<\s*\/\s*applet\s*>~is', '', $text);
			$text = preg_replace('~<\s*\bnoframes\b[^>]*>(.*?)<\s*\/\s*noframes\s*>~is', '', $text);
			$text = preg_replace('~<\s*\bnoscript\b[^>]*>(.*?)<\s*\/\s*noscript\s*>~is', '', $text);
			$text = preg_replace('~<\s*\bframeset\b[^>]*>(.*?)<\s*\/\s*frameset\s*>~is', '', $text);
			$text = preg_replace('~<\s*\bframe\b[^>]*>(.*?)<\s*\/\s*frame\s*>~is', '', $text);
			$text = preg_replace('~<\s*\biframe\b[^>]*>(.*?)<\s*\/\s*iframe\s*>~is', '', $text);
			$text = preg_replace('~<\s*\bform\b[^>]*>(.*?)<\s*\/\s*form\s*>~is', '', $text);
			$text = preg_replace('/on[a-z]+=\".*\"/i', '', $text);
			
			return $text;
			
		}
				
	}

?>