DROP TABLE IF EXISTS meda_accounts;

CREATE TABLE `meda_accounts` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `last_name` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `user_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `password` varchar(50) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `email` varchar(70) CHARACTER SET latin1 NOT NULL,
  `account_type` enum('owner','mainadmin','admin') CHARACTER SET latin1 NOT NULL DEFAULT 'mainadmin',
  `preferred_language` varchar(2) CHARACTER SET latin1 NOT NULL,
  `date_created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_lastlogin` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO meda_accounts VALUES("1","John","Smith","admin@ingagemd.com","e10adc3949ba59abbe56e057f20f883e","","owner","en","0000-00-00 00:00:00","2015-01-03 20:47:42","1");



DROP TABLE IF EXISTS meda_appointments;

CREATE TABLE `meda_appointments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `appointment_number` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `appointment_description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `doctor_id` int(10) unsigned NOT NULL DEFAULT '0',
  `doctor_speciality_id` int(10) unsigned NOT NULL DEFAULT '0',
  `doctor_address_id` int(10) unsigned NOT NULL DEFAULT '0',
  `patient_id` int(10) unsigned NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `appointment_date` date NOT NULL DEFAULT '0000-00-00',
  `appointment_time` time NOT NULL DEFAULT '00:00:00',
  `visit_duration` tinyint(3) unsigned NOT NULL DEFAULT '15',
  `visit_price` decimal(10,2) unsigned NOT NULL DEFAULT '0.00',
  `doctor_notes` text COLLATE utf8_unicode_ci NOT NULL,
  `patient_notes` text COLLATE utf8_unicode_ci NOT NULL,
  `for_whom` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '0 - me, 1 - someone else',
  `first_visit` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `insurance_id` int(10) unsigned NOT NULL DEFAULT '0',
  `visit_reason_id` int(10) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0 - reserved, 1 - verifyed, 2 - canceled',
  `status_changed` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` enum('admin','doctor','patient') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'patient',
  `p_arrival_reminder_sent` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `p_confirm_reminder_sent` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `d_confirm_reminder_sent` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `status` (`status`),
  KEY `doctor_id` (`doctor_id`),
  KEY `patient_id` (`patient_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO meda_appointments VALUES("1","0V3O5U2ALG","Appointment with a doctor","3","1","0","2","2015-01-03 18:30:43","2015-01-05","08:40:00","20","80.00","","","0","0","5","0","0","0000-00-00 00:00:00","patient","0","0","0");



DROP TABLE IF EXISTS meda_banlist;

CREATE TABLE `meda_banlist` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ban_item` varchar(70) CHARACTER SET latin1 NOT NULL,
  `ban_item_type` enum('IP','Email') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'IP',
  `ban_reason` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ban_ip` (`ban_item`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;




DROP TABLE IF EXISTS meda_banners;

CREATE TABLE `meda_banners` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `image_file` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `image_file_thumb` varchar(70) COLLATE utf8_unicode_ci NOT NULL,
  `priority_order` tinyint(1) NOT NULL DEFAULT '0',
  `link_url` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `priority_order` (`priority_order`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO meda_banners VALUES("1","kfvxwwmyw5az29mob5s9.jpg","kfvxwwmyw5az29mob5s9_thumb.jpg","1","","1");
INSERT INTO meda_banners VALUES("2","r2djoind0m2qxuudafkj.jpg","r2djoind0m2qxuudafkj_thumb.jpg","2","","1");
INSERT INTO meda_banners VALUES("3","s9yujfkuwibpgupnsh1g.jpg","s9yujfkuwibpgupnsh1g_thumb.jpg","0","","1");



DROP TABLE IF EXISTS meda_banners_description;

CREATE TABLE `meda_banners_description` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `banner_id` int(10) unsigned NOT NULL DEFAULT '0',
  `language_id` varchar(2) COLLATE utf8_unicode_ci NOT NULL,
  `image_text` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO meda_banners_description VALUES("1","1","en","Our Clinic is located on the Presidents Hospital Medical Campus at 100 North 3rd Street in our sity.");
INSERT INTO meda_banners_description VALUES("2","1","es","Nuestra clínica está ubicada en el Campus Médico del Hospital de Presidentes en 100 North 3rd Street en nuestro dad.");
INSERT INTO meda_banners_description VALUES("3","1","de","Unsere Klinik ist auf die Präsidenten Hospital Medical Campus am 100 North 3rd Street in unserer sität entfernt.");
INSERT INTO meda_banners_description VALUES("4","2","en","");
INSERT INTO meda_banners_description VALUES("5","2","es","");
INSERT INTO meda_banners_description VALUES("6","2","de","");
INSERT INTO meda_banners_description VALUES("7","3","en","Our Clinic is a vital resource for this country and the surrounding area and provides state-of-the-art healthcare to improve our quality of life.");
INSERT INTO meda_banners_description VALUES("8","3","es","Nuestra clínica es un recurso vital para este país y la zona circundante y proporciona el estado de la técnica de salud para mejorar nuestra calidad de vida.");
INSERT INTO meda_banners_description VALUES("9","3","de","Unsere Klinik ist eine lebenswichtige Ressource für dieses Land und die Umgebung und bietet state-of-the-art im Gesundheitswesen zu unserer Lebensqualität zu verbessern.");



DROP TABLE IF EXISTS meda_clinic;

CREATE TABLE `meda_clinic` (
  `id` smallint(6) NOT NULL,
  `phone` varchar(50) CHARACTER SET latin1 NOT NULL,
  `fax` varchar(50) CHARACTER SET latin1 NOT NULL,
  `time_zone` varchar(5) CHARACTER SET latin1 NOT NULL,
  `map_code` text COLLATE utf8_unicode_ci NOT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO meda_clinic VALUES("1","1-800-123-4567","1-800-123-5689","-8","<iframe width=\"640\" height=\"340\" frameborder=\"0\" scrolling=\"no\" marginheight=\"0\" marginwidth=\"0\" src=\"http://maps.google.com/maps?f=q&source=s_q&hl=en&geocode=&q=Clinic+near+Ruston,+LA,+United+States&aq=2&oq=Clinic+rus&sll=39.67826,-104.965563&sspn=0.033029,0.072441&ie=UTF8&hq=Clinic&hnear=Ruston,+Lincoln,+Louisiana&ll=32.534995,-92.621609&spn=0.036176,0.072441&t=m&z=14&iwloc=A&cid=15802153073582196724&output=embed\"></iframe><br /><small><a href=\"http://maps.google.com/maps?f=q&source=embed&hl=en&geocode=&q=Clinic+near+Ruston,+LA,+United+States&aq=2&oq=Clinic+rus&sll=39.67826,-104.965563&sspn=0.033029,0.072441&ie=UTF8&hq=Clinic&hnear=Ruston,+Lincoln,+Louisiana&ll=32.534995,-92.621609&spn=0.036176,0.072441&t=m&z=14&iwloc=A&cid=15802153073582196724\" style=\"color:#0000FF;text-align:left\">View Larger Map</a></small>");



DROP TABLE IF EXISTS meda_clinic_description;

CREATE TABLE `meda_clinic_description` (
  `id` smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  `clinic_id` smallint(6) unsigned NOT NULL DEFAULT '1',
  `language_id` varchar(2) CHARACTER SET latin1 NOT NULL DEFAULT 'en',
  `name` varchar(125) COLLATE utf8_unicode_ci NOT NULL,
  `address` varchar(225) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`language_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO meda_clinic_description VALUES("1","1","en","Your Clinic Name","Our Clinic is located on the Lincoln Hospital Medical Campus at 100 North 3rd Street in out town.","<p>The <strong>Clinic Name</strong> is a full-service medical clinic with five Board Certified Family physicians, a Board Certified General/Gynecological Surgeon and four Board Certified mid-level providers (Physician&rsquo;s Assistant &amp; Nurse Practitioners).</p>");
INSERT INTO meda_clinic_description VALUES("2","1","es","Su clínica de Nombre","Nuestra clínica está ubicada en el Campus Médico del Hospital Lincoln en el 100 Norte de la Calle 3 ª de la ciudad.","<p>El <strong>Nombre de la cl&iacute;nica</strong> es una cl&iacute;nica de servicio completo con cinco m&eacute;dicos de familia Certificado por la Junta, una Junta General Certificado / cirujano ginecol&oacute;gico y cuatro Certificado de nivel medio (asistente m&eacute;dico y enfermeras practicantes).</p>");
INSERT INTO meda_clinic_description VALUES("3","1","de","Ihre Klinik Namen","Unsere Klinik ist in der Lincoln Hospital Medical Campus bei 100 North 3 rd Street in der Stadt.","<p>Die <strong>Klinik-Name</strong> ist ein Full-Service-Klinik mit f&uuml;nf Board Certified Haus&auml;rzte, ein Board Certified General / Gyn&auml;kologische Chirurgie und vier Board Certified Mid-Level-Provider (Arzthelferin &amp; Nurse Practitioners).</p>");



DROP TABLE IF EXISTS meda_comments;

CREATE TABLE `meda_comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `article_id` int(10) NOT NULL DEFAULT '0',
  `user_id` int(10) NOT NULL DEFAULT '0',
  `user_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `user_email` varchar(70) CHARACTER SET latin1 NOT NULL,
  `comment_text` text COLLATE utf8_unicode_ci NOT NULL,
  `date_created` datetime NOT NULL,
  `is_published` tinyint(1) NOT NULL DEFAULT '0',
  `date_published` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `article_id` (`article_id`,`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;




DROP TABLE IF EXISTS meda_countries;

CREATE TABLE `meda_countries` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `abbrv` varchar(2) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(70) COLLATE utf8_unicode_ci NOT NULL,
  `is_active` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `is_default` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `priority_order` smallint(6) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `abbrv` (`abbrv`)
) ENGINE=MyISAM AUTO_INCREMENT=237 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO meda_countries VALUES("12","AW","Aruba","1","0","0");
INSERT INTO meda_countries VALUES("13","AU","Australia","1","0","0");
INSERT INTO meda_countries VALUES("14","AT","Austria","1","0","0");
INSERT INTO meda_countries VALUES("15","AZ","Azerbaijan","1","0","0");
INSERT INTO meda_countries VALUES("16","BS","Bahamas","1","0","0");
INSERT INTO meda_countries VALUES("17","BH","Bahrain","1","0","0");
INSERT INTO meda_countries VALUES("18","BD","Bangladesh","1","0","0");
INSERT INTO meda_countries VALUES("19","BB","Barbados","1","0","0");
INSERT INTO meda_countries VALUES("20","BY","Belarus","1","0","0");
INSERT INTO meda_countries VALUES("21","BE","Belgium","1","0","0");
INSERT INTO meda_countries VALUES("22","BZ","Belize","1","0","0");
INSERT INTO meda_countries VALUES("23","BJ","Benin","1","0","0");
INSERT INTO meda_countries VALUES("24","BM","Bermuda","1","0","0");
INSERT INTO meda_countries VALUES("25","BT","Bhutan","1","0","0");
INSERT INTO meda_countries VALUES("26","BO","Bolivia","1","0","0");
INSERT INTO meda_countries VALUES("27","BA","Bosnia and Herzegowina","1","0","0");
INSERT INTO meda_countries VALUES("28","BW","Botswana","1","0","0");
INSERT INTO meda_countries VALUES("29","BV","Bouvet Island","1","0","0");
INSERT INTO meda_countries VALUES("30","BR","Brazil","1","0","0");
INSERT INTO meda_countries VALUES("31","IO","British Indian Ocean Territory","1","0","0");
INSERT INTO meda_countries VALUES("32","VG","British Virgin Islands","1","0","0");
INSERT INTO meda_countries VALUES("33","BN","Brunei Darussalam","1","0","0");
INSERT INTO meda_countries VALUES("34","BG","Bulgaria","1","0","0");
INSERT INTO meda_countries VALUES("35","BF","Burkina Faso","1","0","0");
INSERT INTO meda_countries VALUES("36","BI","Burundi","1","0","0");
INSERT INTO meda_countries VALUES("37","KH","Cambodia","1","0","0");
INSERT INTO meda_countries VALUES("38","CM","Cameroon","1","0","0");
INSERT INTO meda_countries VALUES("39","CA","Canada","1","0","0");
INSERT INTO meda_countries VALUES("40","CV","Cape Verde","1","0","0");
INSERT INTO meda_countries VALUES("41","KY","Cayman Islands","1","0","0");
INSERT INTO meda_countries VALUES("42","CF","Central African Republic","1","0","0");
INSERT INTO meda_countries VALUES("43","TD","Chad","1","0","0");
INSERT INTO meda_countries VALUES("44","CL","Chile","1","0","0");
INSERT INTO meda_countries VALUES("45","CN","China","1","0","0");
INSERT INTO meda_countries VALUES("46","CX","Christmas Island","1","0","0");
INSERT INTO meda_countries VALUES("47","CC","Cocos (Keeling) Islands","1","0","0");
INSERT INTO meda_countries VALUES("48","CO","Colombia","1","0","0");
INSERT INTO meda_countries VALUES("49","KM","Comoros","1","0","0");
INSERT INTO meda_countries VALUES("50","CG","Congo","1","0","0");
INSERT INTO meda_countries VALUES("51","CK","Cook Islands","1","0","0");
INSERT INTO meda_countries VALUES("52","CR","Costa Rica","1","0","0");
INSERT INTO meda_countries VALUES("53","CI","Cote D\'ivoire","1","0","0");
INSERT INTO meda_countries VALUES("54","HR","Croatia","1","0","0");
INSERT INTO meda_countries VALUES("55","CU","Cuba","1","0","0");
INSERT INTO meda_countries VALUES("56","CY","Cyprus","1","0","0");
INSERT INTO meda_countries VALUES("57","CZ","Czech Republic","1","0","0");
INSERT INTO meda_countries VALUES("58","DK","Denmark","1","0","0");
INSERT INTO meda_countries VALUES("59","DJ","Djibouti","1","0","0");
INSERT INTO meda_countries VALUES("60","DM","Dominica","1","0","0");
INSERT INTO meda_countries VALUES("61","DO","Dominican Republic","1","0","0");
INSERT INTO meda_countries VALUES("62","TP","East Timor","1","0","0");
INSERT INTO meda_countries VALUES("63","EC","Ecuador","1","0","0");
INSERT INTO meda_countries VALUES("64","EG","Egypt","1","0","0");
INSERT INTO meda_countries VALUES("65","SV","El Salvador","1","0","0");
INSERT INTO meda_countries VALUES("66","GQ","Equatorial Guinea","1","0","0");
INSERT INTO meda_countries VALUES("67","ER","Eritrea","1","0","0");
INSERT INTO meda_countries VALUES("68","EE","Estonia","1","0","0");
INSERT INTO meda_countries VALUES("69","ET","Ethiopia","1","0","0");
INSERT INTO meda_countries VALUES("70","FK","Falkland Islands (Malvinas)","1","0","0");
INSERT INTO meda_countries VALUES("71","FO","Faroe Islands","1","0","0");
INSERT INTO meda_countries VALUES("72","FJ","Fiji","1","0","0");
INSERT INTO meda_countries VALUES("73","FI","Finland","1","0","0");
INSERT INTO meda_countries VALUES("74","FR","France","1","0","0");
INSERT INTO meda_countries VALUES("75","GF","French Guiana","1","0","0");
INSERT INTO meda_countries VALUES("76","PF","French Polynesia","1","0","0");
INSERT INTO meda_countries VALUES("77","TF","French Southern Territories","1","0","0");
INSERT INTO meda_countries VALUES("78","GA","Gabon","1","0","0");
INSERT INTO meda_countries VALUES("79","GM","Gambia","1","0","0");
INSERT INTO meda_countries VALUES("80","GE","Georgia","1","0","0");
INSERT INTO meda_countries VALUES("81","DE","Germany","1","0","0");
INSERT INTO meda_countries VALUES("82","GH","Ghana","1","0","0");
INSERT INTO meda_countries VALUES("83","GI","Gibraltar","1","0","0");
INSERT INTO meda_countries VALUES("84","GR","Greece","1","0","0");
INSERT INTO meda_countries VALUES("85","GL","Greenland","1","0","0");
INSERT INTO meda_countries VALUES("86","GD","Grenada","1","0","0");
INSERT INTO meda_countries VALUES("87","GP","Guadeloupe","1","0","0");
INSERT INTO meda_countries VALUES("88","GU","Guam","1","0","0");
INSERT INTO meda_countries VALUES("89","GT","Guatemala","1","0","0");
INSERT INTO meda_countries VALUES("90","GN","Guinea","1","0","0");
INSERT INTO meda_countries VALUES("91","GW","Guinea-Bissau","1","0","0");
INSERT INTO meda_countries VALUES("92","GY","Guyana","1","0","0");
INSERT INTO meda_countries VALUES("93","HT","Haiti","1","0","0");
INSERT INTO meda_countries VALUES("94","HM","Heard and McDonald Islands","1","0","0");
INSERT INTO meda_countries VALUES("95","HN","Honduras","1","0","0");
INSERT INTO meda_countries VALUES("96","HK","Hong Kong","1","0","0");
INSERT INTO meda_countries VALUES("97","HU","Hungary","1","0","0");
INSERT INTO meda_countries VALUES("98","IS","Iceland","1","0","0");
INSERT INTO meda_countries VALUES("99","IN","India","1","0","0");
INSERT INTO meda_countries VALUES("100","ID","Indonesia","1","0","0");
INSERT INTO meda_countries VALUES("101","IQ","Iraq","1","0","0");
INSERT INTO meda_countries VALUES("102","IE","Ireland","1","0","0");
INSERT INTO meda_countries VALUES("103","IR","Islamic Republic of Iran","1","0","0");
INSERT INTO meda_countries VALUES("104","IL","Israel","1","0","0");
INSERT INTO meda_countries VALUES("105","IT","Italy","1","0","0");
INSERT INTO meda_countries VALUES("106","JM","Jamaica","1","0","0");
INSERT INTO meda_countries VALUES("107","JP","Japan","1","0","0");
INSERT INTO meda_countries VALUES("108","JO","Jordan","1","0","0");
INSERT INTO meda_countries VALUES("109","KZ","Kazakhstan","1","0","0");
INSERT INTO meda_countries VALUES("110","KE","Kenya","1","0","0");
INSERT INTO meda_countries VALUES("111","KI","Kiribati","1","0","0");
INSERT INTO meda_countries VALUES("112","KP","Korea, Dem. Peoples Rep of","1","0","0");
INSERT INTO meda_countries VALUES("113","KR","Korea, Republic of","1","0","0");
INSERT INTO meda_countries VALUES("114","KW","Kuwait","1","0","0");
INSERT INTO meda_countries VALUES("115","KG","Kyrgyzstan","1","0","0");
INSERT INTO meda_countries VALUES("116","LA","Laos","1","0","0");
INSERT INTO meda_countries VALUES("117","LV","Latvia","1","0","0");
INSERT INTO meda_countries VALUES("118","LB","Lebanon","1","0","0");
INSERT INTO meda_countries VALUES("119","LS","Lesotho","1","0","0");
INSERT INTO meda_countries VALUES("120","LR","Liberia","1","0","0");
INSERT INTO meda_countries VALUES("121","LY","Libyan Arab Jamahiriya","1","0","0");
INSERT INTO meda_countries VALUES("122","LI","Liechtenstein","1","0","0");
INSERT INTO meda_countries VALUES("123","LT","Lithuania","1","0","0");
INSERT INTO meda_countries VALUES("124","LU","Luxembourg","1","0","0");
INSERT INTO meda_countries VALUES("125","MO","Macau","1","0","0");
INSERT INTO meda_countries VALUES("126","MK","Macedonia","1","0","0");
INSERT INTO meda_countries VALUES("127","MG","Madagascar","1","0","0");
INSERT INTO meda_countries VALUES("128","MW","Malawi","1","0","0");
INSERT INTO meda_countries VALUES("129","MY","Malaysia","1","0","0");
INSERT INTO meda_countries VALUES("130","MV","Maldives","1","0","0");
INSERT INTO meda_countries VALUES("131","ML","Mali","1","0","0");
INSERT INTO meda_countries VALUES("132","MT","Malta","1","0","0");
INSERT INTO meda_countries VALUES("133","MH","Marshall Islands","1","0","0");
INSERT INTO meda_countries VALUES("134","MQ","Martinique","1","0","0");
INSERT INTO meda_countries VALUES("135","MR","Mauritania","1","0","0");
INSERT INTO meda_countries VALUES("136","MU","Mauritius","1","0","0");
INSERT INTO meda_countries VALUES("137","YT","Mayotte","1","0","0");
INSERT INTO meda_countries VALUES("138","MX","Mexico","1","0","0");
INSERT INTO meda_countries VALUES("139","FM","Micronesia","1","0","0");
INSERT INTO meda_countries VALUES("140","MD","Moldova, Republic of","1","0","0");
INSERT INTO meda_countries VALUES("141","MC","Monaco","1","0","0");
INSERT INTO meda_countries VALUES("142","MN","Mongolia","1","0","0");
INSERT INTO meda_countries VALUES("143","MS","Montserrat","1","0","0");
INSERT INTO meda_countries VALUES("144","MA","Morocco","1","0","0");
INSERT INTO meda_countries VALUES("145","MZ","Mozambique","1","0","0");
INSERT INTO meda_countries VALUES("146","MM","Myanmar","1","0","0");
INSERT INTO meda_countries VALUES("147","NA","Namibia","1","0","0");
INSERT INTO meda_countries VALUES("148","NR","Nauru","1","0","0");
INSERT INTO meda_countries VALUES("149","NP","Nepal","1","0","0");
INSERT INTO meda_countries VALUES("150","NL","Netherlands","1","0","0");
INSERT INTO meda_countries VALUES("151","AN","Netherlands Antilles","1","0","0");
INSERT INTO meda_countries VALUES("152","NC","New Caledonia","1","0","0");
INSERT INTO meda_countries VALUES("153","NZ","New Zealand","1","0","0");
INSERT INTO meda_countries VALUES("154","NI","Nicaragua","1","0","0");
INSERT INTO meda_countries VALUES("155","NE","Niger","1","0","0");
INSERT INTO meda_countries VALUES("156","NG","Nigeria","1","0","0");
INSERT INTO meda_countries VALUES("157","NU","Niue","1","0","0");
INSERT INTO meda_countries VALUES("158","NF","Norfolk Island","1","0","0");
INSERT INTO meda_countries VALUES("159","MP","Northern Mariana Islands","1","0","0");
INSERT INTO meda_countries VALUES("160","NO","Norway","1","0","0");
INSERT INTO meda_countries VALUES("161","OM","Oman","1","0","0");
INSERT INTO meda_countries VALUES("162","PK","Pakistan","1","0","0");
INSERT INTO meda_countries VALUES("163","PW","Palau","1","0","0");
INSERT INTO meda_countries VALUES("164","PA","Panama","1","0","0");
INSERT INTO meda_countries VALUES("165","PG","Papua New Guinea","1","0","0");
INSERT INTO meda_countries VALUES("166","PY","Paraguay","1","0","0");
INSERT INTO meda_countries VALUES("167","PE","Peru","1","0","0");
INSERT INTO meda_countries VALUES("168","PH","Philippines","1","0","0");
INSERT INTO meda_countries VALUES("169","PN","Pitcairn","1","0","0");
INSERT INTO meda_countries VALUES("170","PL","Poland","1","0","0");
INSERT INTO meda_countries VALUES("171","PT","Portugal","1","0","0");
INSERT INTO meda_countries VALUES("172","PR","Puerto Rico","1","0","0");
INSERT INTO meda_countries VALUES("173","QA","Qatar","1","0","0");
INSERT INTO meda_countries VALUES("174","RE","Reunion","1","0","0");
INSERT INTO meda_countries VALUES("175","RO","Romania","1","0","0");
INSERT INTO meda_countries VALUES("176","RU","Russian Federation","1","0","0");
INSERT INTO meda_countries VALUES("177","RW","Rwanda","1","0","0");
INSERT INTO meda_countries VALUES("178","LC","Saint Lucia","1","0","0");
INSERT INTO meda_countries VALUES("179","WS","Samoa","1","0","0");
INSERT INTO meda_countries VALUES("180","SM","San Marino","1","0","0");
INSERT INTO meda_countries VALUES("181","ST","Sao Tome and Principe","1","0","0");
INSERT INTO meda_countries VALUES("182","SA","Saudi Arabia","1","0","0");
INSERT INTO meda_countries VALUES("183","SN","Senegal","1","0","0");
INSERT INTO meda_countries VALUES("184","RS","Republic of Serbia","1","0","0");
INSERT INTO meda_countries VALUES("185","SC","Seychelles","1","0","0");
INSERT INTO meda_countries VALUES("186","SL","Sierra Leone","1","0","0");
INSERT INTO meda_countries VALUES("187","SG","Singapore","1","0","0");
INSERT INTO meda_countries VALUES("188","SK","Slovakia","1","0","0");
INSERT INTO meda_countries VALUES("189","SI","Slovenia","1","0","0");
INSERT INTO meda_countries VALUES("190","SB","Solomon Islands","1","0","0");
INSERT INTO meda_countries VALUES("191","SO","Somalia","1","0","0");
INSERT INTO meda_countries VALUES("192","ZA","South Africa","1","0","0");
INSERT INTO meda_countries VALUES("193","ES","Spain","1","0","0");
INSERT INTO meda_countries VALUES("194","LK","Sri Lanka","1","0","0");
INSERT INTO meda_countries VALUES("195","SH","St. Helena","1","0","0");
INSERT INTO meda_countries VALUES("196","KN","St. Kitts and Nevis","1","0","0");
INSERT INTO meda_countries VALUES("197","PM","St. Pierre and Miquelon","1","0","0");
INSERT INTO meda_countries VALUES("198","VC","St. Vincent and the Grenadines","1","0","0");
INSERT INTO meda_countries VALUES("199","SD","Sudan","1","0","0");
INSERT INTO meda_countries VALUES("200","SR","Suriname","1","0","0");
INSERT INTO meda_countries VALUES("201","SJ","Svalbard and Jan Mayen Islands","1","0","0");
INSERT INTO meda_countries VALUES("202","SZ","Swaziland","1","0","0");
INSERT INTO meda_countries VALUES("203","SE","Sweden","1","0","0");
INSERT INTO meda_countries VALUES("204","CH","Switzerland","1","0","0");
INSERT INTO meda_countries VALUES("205","SY","Syrian Arab Republic","1","0","0");
INSERT INTO meda_countries VALUES("206","TW","Taiwan","1","0","0");
INSERT INTO meda_countries VALUES("207","TJ","Tajikistan","1","0","0");
INSERT INTO meda_countries VALUES("208","TZ","Tanzania, United Republic of","1","0","0");
INSERT INTO meda_countries VALUES("209","TH","Thailand","1","0","0");
INSERT INTO meda_countries VALUES("210","TG","Togo","1","0","0");
INSERT INTO meda_countries VALUES("211","TK","Tokelau","1","0","0");
INSERT INTO meda_countries VALUES("212","TO","Tonga","1","0","0");
INSERT INTO meda_countries VALUES("213","TT","Trinidad and Tobago","1","0","0");
INSERT INTO meda_countries VALUES("214","TN","Tunisia","1","0","0");
INSERT INTO meda_countries VALUES("215","TR","Turkey","1","0","0");
INSERT INTO meda_countries VALUES("216","TM","Turkmenistan","1","0","0");
INSERT INTO meda_countries VALUES("217","TC","Turks and Caicos Islands","1","0","0");
INSERT INTO meda_countries VALUES("218","TV","Tuvalu","1","0","0");
INSERT INTO meda_countries VALUES("219","UG","Uganda","1","0","0");
INSERT INTO meda_countries VALUES("220","UA","Ukraine","1","0","0");
INSERT INTO meda_countries VALUES("221","AE","United Arab Emirates","1","0","0");
INSERT INTO meda_countries VALUES("223","US","United States","1","1","1");
INSERT INTO meda_countries VALUES("224","VI","United States Virgin Islands","1","0","0");
INSERT INTO meda_countries VALUES("225","UY","Uruguay","1","0","0");
INSERT INTO meda_countries VALUES("226","UZ","Uzbekistan","1","0","0");
INSERT INTO meda_countries VALUES("227","VU","Vanuatu","1","0","0");
INSERT INTO meda_countries VALUES("228","VA","Vatican City State","1","0","0");
INSERT INTO meda_countries VALUES("229","VE","Venezuela","1","0","0");
INSERT INTO meda_countries VALUES("230","VN","Vietnam","1","0","0");
INSERT INTO meda_countries VALUES("231","WF","Wallis And Futuna Islands","1","0","0");
INSERT INTO meda_countries VALUES("232","EH","Western Sahara","1","0","0");
INSERT INTO meda_countries VALUES("233","YE","Yemen","1","0","0");
INSERT INTO meda_countries VALUES("234","ZR","Zaire","1","0","0");
INSERT INTO meda_countries VALUES("235","ZM","Zambia","1","0","0");
INSERT INTO meda_countries VALUES("236","ZW","Zimbabwe","1","0","0");



DROP TABLE IF EXISTS meda_currencies;

CREATE TABLE `meda_currencies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(70) COLLATE utf8_unicode_ci NOT NULL,
  `symbol` varchar(5) COLLATE utf8_unicode_ci NOT NULL,
  `code` varchar(3) CHARACTER SET latin1 NOT NULL,
  `rate` double(10,4) NOT NULL DEFAULT '1.0000',
  `decimals` tinyint(1) NOT NULL DEFAULT '2',
  `symbol_placement` enum('before','after') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'before',
  `primary_order` tinyint(1) NOT NULL DEFAULT '0',
  `is_default` tinyint(1) NOT NULL DEFAULT '0',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO meda_currencies VALUES("1","US Dollar","$","USD","1.0000","2","before","1","1","1");



DROP TABLE IF EXISTS meda_doctor_addresses;

CREATE TABLE `meda_doctor_addresses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `doctor_id` int(10) unsigned NOT NULL DEFAULT '0',
  `address` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `latitude` varchar(11) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `longitude` varchar(11) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `access_level` enum('public','registered') CHARACTER SET latin1 NOT NULL DEFAULT 'public',
  `priority_order` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `is_default` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `is_active` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `doctor_id` (`doctor_id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO meda_doctor_addresses VALUES("1","1","5 Ave, 125 New York, NY 10037","40.8168702","-73.9345842","public","0","1","1");
INSERT INTO meda_doctor_addresses VALUES("2","1","58 Street, New York","40.7609390","-73.9670508","public","1","0","1");
INSERT INTO meda_doctor_addresses VALUES("3","1","37 Street, New Yourk","40.7540910","-73.9920790","registered","0","0","1");
INSERT INTO meda_doctor_addresses VALUES("4","2","5 Ave, New York, NY 10037	","40.8168702","-73.9345842","public","0","1","1");
INSERT INTO meda_doctor_addresses VALUES("6","3","46292 Warm Springs Blvd\nSte 630\nFremont, CA 94539","37.492414","-121.93080","public","0","1","1");



DROP TABLE IF EXISTS meda_doctor_images;

CREATE TABLE `meda_doctor_images` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `doctor_id` int(11) NOT NULL DEFAULT '0',
  `item_file` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `item_file_thumb` varchar(70) COLLATE utf8_unicode_ci NOT NULL,
  `image_title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `priority_order` smallint(6) NOT NULL DEFAULT '0',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `doctor_id` (`doctor_id`),
  KEY `priority_order` (`priority_order`),
  KEY `doctor_id_2` (`doctor_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO meda_doctor_images VALUES("1","3","wtcqibbd4zpi5c45ulwx.jpg","wtcqibbd4zpi5c45ulwx_thumb.jpg","","0","1");



DROP TABLE IF EXISTS meda_doctor_specialities;

CREATE TABLE `meda_doctor_specialities` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `doctor_id` int(10) unsigned NOT NULL DEFAULT '0',
  `speciality_id` int(10) unsigned NOT NULL DEFAULT '0',
  `visit_price` decimal(10,2) unsigned NOT NULL DEFAULT '0.00',
  `is_default` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `priority_order` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `doctor_id` (`doctor_id`),
  KEY `speciality_id` (`speciality_id`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO meda_doctor_specialities VALUES("1","1","12","98.00","0","1");
INSERT INTO meda_doctor_specialities VALUES("2","1","1","98.00","1","0");
INSERT INTO meda_doctor_specialities VALUES("3","1","29","89.00","0","2");
INSERT INTO meda_doctor_specialities VALUES("4","3","4","80.00","1","0");
INSERT INTO meda_doctor_specialities VALUES("5","3","1","79.00","0","1");
INSERT INTO meda_doctor_specialities VALUES("6","3","11","80.00","0","2");
INSERT INTO meda_doctor_specialities VALUES("7","2","5","75.00","0","0");
INSERT INTO meda_doctor_specialities VALUES("8","2","9","75.00","1","1");
INSERT INTO meda_doctor_specialities VALUES("9","1","37","98.00","0","0");
INSERT INTO meda_doctor_specialities VALUES("10","3","37","80.00","0","0");
INSERT INTO meda_doctor_specialities VALUES("11","3","35","80.00","0","0");
INSERT INTO meda_doctor_specialities VALUES("12","2","37","75.00","0","0");



DROP TABLE IF EXISTS meda_doctors;

CREATE TABLE `meda_doctors` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(70) COLLATE utf8_unicode_ci NOT NULL,
  `middle_name` varchar(70) COLLATE utf8_unicode_ci NOT NULL,
  `last_name` varchar(70) COLLATE utf8_unicode_ci NOT NULL,
  `gender` enum('f','m') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'm',
  `birth_date` date NOT NULL DEFAULT '0000-00-00',
  `title` enum('','Mr.','Ms.','Mrs.','Miss') COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `b_address` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `b_address_2` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `b_city` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `b_state` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `b_country` varchar(2) COLLATE utf8_unicode_ci NOT NULL,
  `b_zipcode` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(70) COLLATE utf8_unicode_ci NOT NULL,
  `user_name` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `user_password` varchar(50) CHARACTER SET latin1 NOT NULL,
  `preferred_language` varchar(2) CHARACTER SET latin1 NOT NULL,
  `date_created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_lastlogin` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `registered_from_ip` varchar(15) CHARACTER SET latin1 NOT NULL,
  `last_logged_ip` varchar(15) CHARACTER SET latin1 NOT NULL DEFAULT '000.000.000.000',
  `email_notifications` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `notification_status_changed` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `medical_degree` enum('','BMBS','MBBS','BDS','MBChB','MB BCh','BMed','MD','MDCM','Dr.MuD','Dr.Med','Cand.med','Med') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'MD',
  `additional_degree` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `license_number` varchar(30) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `education` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `experience_years` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `residency_training` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `hospital_affiliations` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `board_certifications` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `awards_and_publications` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `languages_spoken` varchar(125) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `insurances_accepted` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `doctor_photo` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `doctor_photo_thumb` varchar(70) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `work_phone` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `work_mobile_phone` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `phone` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `fax` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `default_visit_price` decimal(10,2) unsigned NOT NULL DEFAULT '0.00',
  `default_visit_duration` tinyint(3) unsigned NOT NULL DEFAULT '15',
  `membership_plan_id` int(10) unsigned NOT NULL DEFAULT '0',
  `membership_images_count` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `membership_addresses_count` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `membership_show_in_search` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `membership_expires` date NOT NULL DEFAULT '0000-00-00',
  `is_active` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `is_removed` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `comments` text COLLATE utf8_unicode_ci NOT NULL,
  `registration_code` varchar(20) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`id`),
  KEY `membership_plan_id` (`membership_plan_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO meda_doctors VALUES("1","John","M.","Smith","m","1965-05-24","Mr.","st.Yoremo Neva, 16","","Bordon","JH","IN","12345","doctor1@email.me","doctor1","","en","2014-03-13 14:53:14","2014-03-13 14:53:14","","127.0.0.1","0","0000-00-00 00:00:00","MBBS","","","Medical School - University of Pennsylvania, School of Medicine,\nGoverment Medical Center\n","4","","Goverment Medical Center - Petrie Division ,\nNew York University Elaine A. and Kenneth G., \nLangone Medical Center \n","American Board of Internal Medicine","Dr. Smith was named in Castle Connolly’s \"Top Doctors-New York Metro Area\" 2006, 2007, 2008 2009, 2010.","English, Spanish, Russian","","k066wrk2wxbh8deg3sps.jpg","k066wrk2wxbh8deg3sps_thumb.jpg","050-123-45067","050-455-23127","","","98.00","15","4","3","5","1","0000-00-00","1","0","","");
INSERT INTO meda_doctors VALUES("2","Rebeka","","Miller","f","2012-02-07","","","","","","","","doctor2@email.me","doctor2","","en","2014-03-13 14:53:14","2014-03-13 14:53:14","","000.000.000.000","0","0000-00-00 00:00:00","Dr.Med","","","Medical School - New York Medical College, \nSaint Vincent\'s Hospital, Internship in Internal Medicine","6","","","American Board of Internal Medicine","Undergraduate Research Award: UTY-Chapel, 2003, Bachelor of Science in Biology with Honors: UTY-Chapel, 2003","English","1199SEIZ,\nAtnaZ,\nBlue Cross Shield ","qxxjnn3ht41lccreu3om.jpg","qxxjnn3ht41lccreu3om_thumb.jpg","","","","","75.00","15","3","2","3","1","2018-12-31","1","0","","");
INSERT INTO meda_doctors VALUES("3","Blue Moon ","","Pet Wash","m","2012-10-16","","123","","Surat","GJ","IN","395003","doctor3@email.me","doctor3","a61a78e492ee60c63ed8f2bb3a6a0072","en","2014-03-13 14:53:14","2015-01-03 17:27:55","","14.98.70.158","0","0000-00-00 00:00:00","","","","Medical School - Washington University School of Medicine, Residency - New York Medical College (Internal Medicine)\n","3","","Medical Center - Petron Division","American Board of Internal Medicine, Hematology (Internal Medicine)","","English, Spanish\n","1199SEIZ,\nAtnaZ,\nAmeChoice by UHealthcare ","ed3yadib14ckdiibo01c.jpg","ed3yadib14ckdiibo01c_thumb.jpg","","","","099-923-25-99","80.00","20","2","1","3","1","2015-12-31","1","0","We provide the supplies, using only the best shampoo (EarthBath) and equipment to serve your pets.\nWe have self-adjusting pet tubs, warm air force and cage dryers to make the wash as comfortable and convenient for you and your pet.\n\nCome and try out the 5 star wash with the 1 star price.\n\nDoesn’t man’s best friend deserve a five star treatment.","");



DROP TABLE IF EXISTS meda_email_templates;

CREATE TABLE `meda_email_templates` (
  `id` smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  `language_id` varchar(2) CHARACTER SET latin1 NOT NULL,
  `template_code` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `template_name` varchar(125) COLLATE utf8_unicode_ci NOT NULL,
  `template_subject` varchar(125) COLLATE utf8_unicode_ci NOT NULL,
  `template_content` text COLLATE utf8_unicode_ci NOT NULL,
  `is_system_template` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=70 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO meda_email_templates VALUES("1","en","new_account_created","Email for new patient or doctor","Your account has been created","Dear <b>{FIRST NAME} {LAST NAME}</b>!\n\nCongratulations on creating your new account.\n\nPlease keep this email for your records, as it contains an important information that you may need, should you ever encounter problems or forget your password.\n\nYour login: {USER NAME}\nYour password: {USER PASSWORD}\n\nYou may follow the link below to log into your account: <a href=\"{BASE URL}index.php?{ACCOUNT TYPE}=login\">Login</a>\n\nP.S. Remember, we will never sell your personal information or email address.\n\nEnjoy!\n-\nSincerely,\nCustomer Support","1");
INSERT INTO meda_email_templates VALUES("2","es","new_account_created","E-mail para el nuevo paciente o el médico","Tu cuenta ha sido creada","Estimado <b>{FIRST NAME} {LAST NAME}</b>!\n\nFelicitaciones por la creación de su nueva cuenta.\n\nPor favor, mantenga este e-mail para sus registros, ya que contiene una información importante que usted pueda necesitar, si surge algún problema u olvidas tu contraseña.\n\nUsted entrada: {USER NAME}\nUsted contraseña: {USER PASSWORD}\n\nPor favor siga el siguiente enlace para acceder a su cuenta: <a href=\"{BASE URL}index.php?{ACCOUNT TYPE}=login\">Iniciar Sesión</a>\n\nPD Recuerde, nosotros nunca venderemos su nombre o dirección de correo electrónico.\n\nDisfrute!\n-\nSinceramente,\nSoporte al cliente","1");
INSERT INTO meda_email_templates VALUES("3","de","new_account_created","E-Mail für neue Patient oder Arzt","Ihr Konto wurde erstellt","Liebe <b>{FIRST NAME} {LAST NAME}</b>!\n\nHerzlichen Glückwunsch zu Ihrem neuen Konto erstellen.\n\nBitte bewahren Sie diese E-Mail für Ihre Aufzeichnungen, da sie eine wichtige Information, die Sie benötigen, sollten Sie Probleme auftreten oder Ihr Passwort vergessen enthält.\n\nIhr Login: {USER NAME}\nIhr Passwort: {USER PASSWORD}\n\nSie können den folgenden Link in Ihren Account einloggen: <a href=\"{BASE URL}index.php?{ACCOUNT TYPE}=login\">Login</a>\n\nP.S. Denken Sie daran, wir werden nie verkaufen Ihren Namen oder E-Mail-Adresse.\n\nViel Spaß!\n-\nMit freundlichen Grüßen,\nCustomer Support","1");
INSERT INTO meda_email_templates VALUES("4","en","new_account_created_by_admin","New account created (by admin)","Your account has been created by administrator","Dear <b>{FIRST NAME} {LAST NAME}!</b>\n\nThe {WEB SITE} Admin has invited you to contribute to our site.\n\nPlease keep this email for your records, as it contains an important information that you may need, should you ever encounter problems or forget your password.\n\nYour login: {USER NAME}\nYour password: {USER PASSWORD}\n\nPlease follow the link below to log into your account: <a href=\"{BASE URL}index.php?{ACCOUNT TYPE}=login\">Login</a>\n\nEnjoy!\n-\nSincerely,\nAdministration","1");
INSERT INTO meda_email_templates VALUES("5","es","new_account_created_by_admin","Nueva cuenta creada (por admin)","Su cuenta ha sido creada por el administrador","Estimado <b>{FIRST NAME} {LAST NAME}</b>\n\nLa {WEB SITE} Admin te ha invitado a contribuir a nuestro sitio.\n\nPor favor, mantenga este e-mail para sus registros, ya que contiene una información importante que usted pueda necesitar, si surge algún problema u olvidas tu contraseña.\n\nUsted entrada: {USER NAME}\nUsted contraseña: {USER PASSWORD}\n\nPor favor siga el siguiente enlace para acceder a su cuenta: <a href=\"{BASE URL}index.php?{ACCOUNT TYPE}=login\">Iniciar Sesión</a>\n\nDisfrute!\n-\nAtentamente,\nAdministración","1");
INSERT INTO meda_email_templates VALUES("6","de","new_account_created_by_admin","Neues Konto erstellt (von admin)","Ihr Konto wurde vom Administrator erstellt wurde","Lieber <b>{FIRST NAME} {LAST NAME}!</b>\n\nDie {WEB SITE} Admin hat Sie eingeladen, auf unserer Website beitragen.\n\nBitte bewahren Sie diese E-Mail für Ihre Aufzeichnungen, da sie eine wichtige Information, die Sie benötigen, sollten Sie Probleme auftreten oder Ihr Passwort vergessen enthält.\n\nSie Login: {USER NAME}\nIhr Passwort: {USER PASSWORD}\n\nBitte folgen Sie den untenstehenden Link, um in Ihren Account einloggen: <a href=\"{BASE URL}index.php?{ACCOUNT TYPE}=login\">Login</a>\n\nViel Spaß!\n-\nMit freundlichen Grüßen,\nVerwaltung","1");
INSERT INTO meda_email_templates VALUES("7","en","new_account_created_confirm_by_email","Email for new patient or doctor (email confirmation required)","Your account has been created (confirmation required)","Dear <b>{FIRST NAME} {LAST NAME}</b>!\n\nCongratulations on creating your new account.\n\nPlease keep this email for your records, as it contains an important information that you may need, should you ever encounter problems or forget your password.\n\nYour login: {USER NAME}\nYour password: {USER PASSWORD}\n\nIn order to become authorized member, you will need to confirm your registration. You may follow the link below to reach the confirmation page: <a href=\"{BASE URL}index.php?{ACCOUNT TYPE}=confirm_registration&c={REGISTRATION CODE}\">Confirm Registration</a>\n\nP.S. Remember, we will never sell your personal information or email address.\n\nEnjoy!\n-\nSincerely,\nCustomer Support","1");
INSERT INTO meda_email_templates VALUES("8","es","new_account_created_confirm_by_email","E-mail para nuevo paciente o el médico (confirmación por correo electrónico es necesario)","Su cuenta ha sido creada (requiere confirmación por e-mail)","Estimado <b>{FIRST NAME} {LAST NAME}</b>!\n\nFelicitaciones por la creación de su nueva cuenta.\n\nPor favor, mantenga este e-mail para sus registros, ya que contiene una información importante que usted pueda necesitar, si surge algún problema u olvidas tu contraseña.\n\nUsted entrada: {USER NAME}\nUsted contraseña: {USER PASSWORD}\n\nPara convertirse en miembro autorizado, tendrá que confirmar su registro. Por favor siga el siguiente enlace para acceder a la página de confirmación: <a href=\"{BASE URL}index.php?{ACCOUNT TYPE}=confirm_registration&c={REGISTRATION CODE}\">Confirmar registro</a>\n\nPD Recuerde, nosotros nunca venderemos su nombre o dirección de correo electrónico.\n\nDisfrute!\n-\nSinceramente,\nSoporte al cliente","1");
INSERT INTO meda_email_templates VALUES("9","de","new_account_created_confirm_by_email","E-Mail für neue Patienten oder Arzt (E-Mail-Bestätigung erforderlich)","Ihr Konto wurde erstellt (Bestätigung erforderlich)","Liebe <b>{FIRST NAME} {LAST NAME}</b>!\n\nHerzlichen Glückwunsch zu Ihrem neuen Konto erstellen.\n\nBitte bewahren Sie diese E-Mail für Ihre Aufzeichnungen, da sie eine wichtige Information, die Sie benötigen, sollten Sie Probleme auftreten oder Ihr Passwort vergessen enthält.\n\nIhr Login: {USER NAME}\nIhr Passwort: {USER PASSWORD}\n\nUm Mitglied zu werden ermächtigt, müssen Sie Ihre Registrierung bestätigen. Sie können folgen Sie den untenstehenden Link, um die Bestätigungs-Seite zu erreichen: <a href=\"{BASE URL}index.php?{ACCOUNT TYPE}=confirm_registration&c={REGISTRATION CODE}\">Registrierung bestätigen</a>\n\nP.S. Denken Sie daran, wir werden nie verkaufen Ihren Namen oder E-Mail-Adresse.\n\nViel Spaß!\n-\nMit freundlichen Grüßen,\nCustomer Support","1");
INSERT INTO meda_email_templates VALUES("10","en","new_account_created_confirm_by_admin","Email for new patient or doctor (admin approval required)","Your account has been created (approval required)","Dear <b>{FIRST NAME} {LAST NAME}</b>!\n\nCongratulations on creating your new account.\n\nPlease keep this email for your records, as it contains an important information that you may need, should you ever encounter problems or forget your password.\n\nYour login: {USER NAME}\nYour password: {USER PASSWORD}\n\nAfter your registration will be approved by administrator,  you could log into your account with a following link: <a href=\"{BASE URL}index.php?{ACCOUNT TYPE}=login\">Login</a>\n\nP.S. Remember, we will never sell your name or email address.\n\nEnjoy!\n-\nSincerely,\nCustomer Support","1");
INSERT INTO meda_email_templates VALUES("11","es","new_account_created_confirm_by_admin","E-mail  para nuevo paciente o el médico (aprobación del administrador requerido)","Su cuenta ha sido creada (requiere aprobación)","Estimados <b>{FIRST NAME} {LAST NAME}</b>!\n\nFelicitaciones por la creación de su nueva cuenta.\n\nPor favor, mantenga este e-mail para sus registros, ya que contiene una información importante que usted pueda necesitar, si surge algún problema u olvidas tu contraseña.\n\nSu entrada: {USER NAME}\nSu contraseña: {USER PASSWORD}\n\nDespués de su registro será aprobado por el administrador, puede acceder a su cuenta con el siguiente enlace: <a href=\"{BASE URL}index.php?{ACCOUNT TYPE}=login\">Iniciar Sesión</a>\n\nPD Recuerde, nosotros nunca venderemos su nombre o dirección de correo electrónico.\n\nDisfrute!\n-\nAtentamente,\nAtención al cliente","1");
INSERT INTO meda_email_templates VALUES("12","de","new_account_created_confirm_by_admin","E-Mail für neue Patienten oder Arzt (admin Genehmigung erforderlich)","Ihr Konto wurde erstellt (Bestätigung erforderlich)","Liebe <b>{FIRST NAME} {LAST NAME}</b>!\n\nHerzlichen Glückwunsch zu Ihrem neuen Konto erstellen.\n\nBitte bewahren Sie diese E-Mail für Ihre Aufzeichnungen, da sie eine wichtige Information, die Sie benötigen, sollten Sie Probleme auftreten oder Ihr Passwort vergessen enthält.\n\nIhr Login: {USER NAME}\nIhr Passwort: {USER PASSWORD}\n\nNach Ihrer Anmeldung vom Administrator genehmigt werden, könnten Sie Ihr Konto mit folgenden Link anmelden: <a href=\"\n{BASE URL}index.php?{ACCOUNT TYPE}=login\">Login</a>\n\nP.S. Denken Sie daran, wir werden nie verkaufen Ihren Namen oder E-Mail-Adresse.\n\nViel Spaß!\n-\nMit freundlichen Grüßen,\nCustomer Support","1");
INSERT INTO meda_email_templates VALUES("13","de","new_account_created_notify_admin","Neues Konto erstellt wurde (benachrichtigen admin)","Neues Konto erstellt wurde","Hallo Admin!\n\nEin neuer {ACCOUNT TYPE} hat bei Ihnen vor Ort registriert wurde.\nDiese Email enthält einen Benutzer-Account Details:\n\nName: {FIRST NAME} {LAST NAME}\nE-Mail: {USER EMAIL}\nBenutzername: {USER NAME}\n\nP.S. Bitte überprüfen Sie, ob es nicht erforderlich, Ihre Zustimmung zur Aktivierung.","1");
INSERT INTO meda_email_templates VALUES("14","es","new_account_created_notify_admin","Nueva cuenta se ha creado (notificar admin)","Nueva cuenta se ha creado","Hola admin!\n\nUn nuevo {ACCOUNT TYPE} ha sido registrado en su sitio.\nEste correo electrónico contiene una información de la cuenta de usuario:\n\nNombre: {FIRST NAME} {LAST NAME}\nE-mail: {USER EMAIL}\nNombre de usuario: {USER NAME}\n\nPD Por favor, compruebe si no se requiere su aprobación para la activación.","1");
INSERT INTO meda_email_templates VALUES("15","en","new_account_created_notify_admin","New account has been created (notify admin)","New account has been created","Hello Admin!\n\nA new {ACCOUNT TYPE} has been registered at your site.\nThis email contains a user account details:\n\nName: {FIRST NAME} {LAST NAME}\nEmail: {USER EMAIL}\nUsername: {USER NAME}\n\nP.S. Please check if it doesn\'t require your approval for activation.","1");
INSERT INTO meda_email_templates VALUES("16","en","registration_approved_by_admin","Email for new user (registration was approved by admin)","Your registration has been approved","Dear <b>{FIRST NAME} {LAST NAME}!</b>\n\nCongratulations! This e-mail is to confirm that your registration at {WEB SITE} has been approved.\n\nYou can now login in to your account now.\n\nThanks for choosing {WEB SITE}.\n-\nSincerely,\nAdministration","1");
INSERT INTO meda_email_templates VALUES("17","es","registration_approved_by_admin","E-mail para el nuevo usuario (el registro fue aprobado por el administrador)","Su registro ha sido aprobado","Estimado <b>{FIRST NAME} {LAST NAME}!</b>\n\n¡Felicitaciones! Este e-mail es para confirmar que su inscripción en {WEB SITE} ha sido aprobado.\n\nAhora puede acceder a su cuenta ahora.\n\nGracias por elegir {WEB SITE}.\n-\nAtentamente,\nadministración","1");
INSERT INTO meda_email_templates VALUES("18","de","registration_approved_by_admin","E-Mail für neue Benutzer (Registrierung wurde von admin zugelassen)","Ihre Registrierung genehmigt wurde","Sehr geehrte <b>{FIRST NAME} {LAST NAME}!</b>\n\nHerzlichen Glückwunsch! Diese E-Mail ist zu bestätigen, dass Ihre Anmeldung bei {WEB SITE} genehmigt wurde.\n\nSie können jetzt in Ihr Konto jetzt einloggen.\n\nDanke für die Wahl {WEB SITE}.\n-\nMit freundlichen Grüßen,\nVerwaltung","1");
INSERT INTO meda_email_templates VALUES("19","en","password_forgotten","Email for patient, doctor or admin forgotten password","Forgotten Password","Hello <b>{USER NAME}</b>!\n\nYou or someone else asked for your login info on our site:\n{WEB SITE}\n\nYour Login Info:\n-\nUsername: {USER NAME}\nPassword: {USER PASSWORD}\n\n-\nBest regards,\n{WEB SITE}\n","1");
INSERT INTO meda_email_templates VALUES("20","es","password_forgotten","E-mail para el paciente, el médico o la contraseña de administrador olvidada","He olvidado la contraseña","Hola <b>{USER NAME}</b>!\n\nUsted o alguien más pide su información de acceso en nuestro sitio:\n{WEB SITE}\n\nSu usuario Info:\n-\nNombre de usuario: {USER NAME}\nContraseña: {USER PASSWORD}\n\n-\nSaludos cordiales,\n{WEB SITE}","1");
INSERT INTO meda_email_templates VALUES("21","de","password_forgotten","E-Mail für Patient, Arzt oder Admin Passwort vergessen","Passwort vergessen","Hallo <b>{USER NAME}</b>!\n\nSie oder jemand anderes baten um Ihre Login-Infos auf unserer Website:\n{WEB SITE}\n\nIhre Login-Infos:\n\nBenutzername: {USER NAME}\nPasswort: {USER PASSWORD}\n\n\nMit freundlichen Grüßen,\n{WEB SITE}\n","1");
INSERT INTO meda_email_templates VALUES("22","en","password_changed_by_admin","Password changed by admin","Your password has been changed","Hello <b>{FIRST NAME} {LAST NAME}</b>!\n\nYour password was changed by administrator of the site:\n{WEB SITE}\n\nHere your new login info:\n-\nUsername: {USER NAME} \nPassword: {USER PASSWORD}\n\n-\nBest regards,\nAdministration","1");
INSERT INTO meda_email_templates VALUES("23","es","password_changed_by_admin","Contraseña cambiada por admin","Su contraseña ha sido cambiada","Hola <b>{FIRST NAME} {LAST NAME}</b>!\n\nSu contraseña se ha cambiado por el administrador del sitio:\n{WEB SITE}\n\nAquí la información de su nuevo inicio de sesión:\n-\nNombre de usuario: {USER NAME} \nContraseña: {USER PASSWORD}\n\n-\nSaludos cordiales,\nAdministración","1");
INSERT INTO meda_email_templates VALUES("24","de","password_changed_by_admin","Kennwort von admin geändert","Ihr Passwort wurde geändert","Hallo <b>{FIRST NAME} {LAST NAME}</b>!\n\nIhr Passwort wurde durch den Administrator der Website geändert:\n{WEB SITE}\n\nHier werden Ihre neuen Login-Info:\n-\nBenutzername: {USER NAME} \nKennwort: {USER PASSWORD}\n\n-\nMit freundlichen Grüßen,\nVerwaltung","1");
INSERT INTO meda_email_templates VALUES("25","en","account_deleted_by_user","Account removed email (by patient or doctor)","Your account has been removed ","Dear {USER NAME}!\n\nYour account has been removed.\n\n-\nSincerely,\nCustomer Support","1");
INSERT INTO meda_email_templates VALUES("26","es","account_deleted_by_user","Cuenta eliminada de correo electrónico (por el paciente o el médico)","Su cuenta ha sido fue eliminado","Estimado {USER NAME}!\n\nSu cuenta ha sido eliminada.\n\n-\nAtentamente,\nAtención al cliente","1");
INSERT INTO meda_email_templates VALUES("27","de","account_deleted_by_user","Konto entfernt E-Mail (vom Patienten oder Arzt)","Ihr Konto wurde entfernt","Sehr geehrter {USER NAME}!\n\nIhr Konto wurde entfernt.\n\n-\nMit freundlichen Grüßen,\nCustomer Support","1");
INSERT INTO meda_email_templates VALUES("28","en","events_new_registration","Events - new member has registered (member copy)","You have been successfully registered to the event!","Dear <b>{FIRST NAME} {LAST NAME}</b>!\n\nCongratulations on registering to {EVENT}.\n\nPlease keep this email for your records, as it contains an important information that you may need.\n\n-\nBest Regards,\nAdministration","1");
INSERT INTO meda_email_templates VALUES("29","es","events_new_registration","Eventos - nuevo miembro se ha registrado (copia de miembro)","Se le ha registrado con éxito en el evento!","Estimado <b>{FIRST NAME} {LAST NAME}</b>!\n\nFelicitaciones por el registro de {EVENT}.\n\nPor favor, mantenga este e-mail para sus registros, ya que contiene una información importante que usted pueda necesitar.\n\n-\nSaludos cordiales,\nAdministración","1");
INSERT INTO meda_email_templates VALUES("30","de","events_new_registration","Veranstaltungen - neues Mitglied registriert hat (Mitglied Kopie)","Sie haben erfolgreich an der Veranstaltung angemeldet haben!","Lieber <b>{FIRST NAME} {LAST NAME}</b>!\n\nHerzlichen Glückwunsch zu der Registrierung auf {EVENT}.\n\nBitte bewahren Sie diese E-Mail für Ihre Aufzeichnungen, da sie eine wichtige Information, die Sie benötigen enthält.\n\n-\nMit besten Grüßen,\nVerwaltung","1");
INSERT INTO meda_email_templates VALUES("31","en","unsubscription_from_newsletter","Newsletter - member has unsubscribed (member copy)","You have been unsubscribed from the Newsletter","Hello!\n\nYou are receiving this email because you, or someone using this email address, unsubscribed from the Newsletter of {WEB SITE}\n\nYou can always restore your subscription, using the link below: \n<a href=\"{BASE URL}index.php?page=newsletter&task=pre_subscribe&email={USER EMAIL}\">Subscribe</a>\n\n-\nBest Regards,\nAdministration","1");
INSERT INTO meda_email_templates VALUES("32","es","unsubscription_from_newsletter","Newsletter - miembro ha dado de baja (copia miembros)","Se le ha cancelado la suscripción a la Newsletter","Hola!\n\nUsted está recibiendo este correo electrónico porque usted o alguien que use la siguiente dirección de correo electrónico, de baja de la Newsletter de {WEB SITE}\n\nSiempre podrá restaurar su suscripción, usando el siguiente enlace: <a href=\"{BASE URL}index.php?page=newsletter&task=pre_subscribe&email={USER EMAIL}\">Suscribir</a>\n\n-\nSaludos cordiales,\nadministración","1");
INSERT INTO meda_email_templates VALUES("33","de","unsubscription_from_newsletter","Newsletter - Mitglied hat sich abgemeldet (Mitglied Kopie)","Sie haben den Newsletter abbestellt worden","Hallo!\n\nSie erhalten diese E-Mail, weil Sie oder jemand mit dieser E-Mail-Adresse, von der Newsletter von {WEB SITE} abgemeldet\n\nSie können immer wieder Ihr Abonnement, über den Link unten: <a href=\"{BASE URL}index.php?page=newsletter&task=pre_subscribe&email={USER EMAIL}\">Zeichnen</a>\n\n-\nMit freundlichen Grüßen,\nVerwaltung","1");
INSERT INTO meda_email_templates VALUES("34","en","subscription_to_newsletter","Newsletter - new member has subscribed (member copy)","You have been subscribed to the Newsletter","Hello!\n\nYou are receiving this email because you, or someone using this email address, subscribed to the Newsletter of {WEB SITE}\n\nIf you do not wish to receive such emails in the future, please click this link: <a href=\"{BASE URL}index.php?page=newsletter&task=pre_unsubscribe&email={USER EMAIL}\">Unsubscribe</a>\n\n-\nBest Regards,\nAdministration","1");
INSERT INTO meda_email_templates VALUES("35","es","subscription_to_newsletter","Newsletter - nuevo miembro se ha suscrito (copia miembros)","Que se han suscrito al boletín de noticias","Hola!\n\nUsted está recibiendo este correo electrónico porque usted o alguien que use la siguiente dirección de correo electrónico, suscritas al boletín de noticias de {WEB SITE}\n\nSi usted no desea recibir dichos correos electrónicos en el futuro, por favor haga clic en este enlace: <a href=\"{BASE URL}index.php?page=newsletter&task=pre_unsubscribe&email={USER EMAIL}\">Cancelar la suscripción</a>\n\n-\nSaludos cordiales,\nadministración","1");
INSERT INTO meda_email_templates VALUES("36","de","subscription_to_newsletter","Newsletter - neues Mitglied abonniert hat (Mitglied Kopie)","Sie haben den Newsletter abonniert haben","Hallo!\n\nSie erhalten diese E-Mail, weil Sie oder jemand mit dieser E-Mail-Adresse, den Newsletter von {WEB SITE} abonniert\n\nWenn Sie nicht möchten, dass solche E-Mails in der Zukunft erhalten, klicken Sie bitte diesen Link: <a href=\"{BASE URL}index.php?page=newsletter&task=pre_unsubscribe&email={USER EMAIL}\">Abmelden</a>\n\n-\nMit freundlichen Grüßen,\nVerwaltung","1");
INSERT INTO meda_email_templates VALUES("37","en","new_appointment_confirm_by_email","New appointment (email confirmation required)","Your appointment has been reserved (confirmation required)","Dear <b>{FIRST NAME} {LAST NAME}</b>!\n\nYour appointment has been reserved, but it\'s not complete yet!\n\nIn order to complete this procedure, you have to confirm your appointment. You may follow the link below to access the confirmation page: <a href=\"{BASE URL}index.php?patient=confirm_appointment&n={APPOINTMENT NUMBER}\">Confirm Appointment</a>\n\n{APPOINTMENT DETAILS}\n\nP.S. Please keep this email for your records, as it contains an important information that you may need.\n\n-\nSincerely,\nCustomer Support","1");
INSERT INTO meda_email_templates VALUES("38","es","new_appointment_confirm_by_email","Nueva cita (se requiere confirmación por correo electrónico)","Su cita ha sido reservada (se requiere confirmación)","Estimado <b>{FIRST NAME} {LAST NAME}</b>!\n\nSu cita ha sido reservado, pero no es completa todavía!\n\nCon el fin de completar este procedimiento, usted tiene que confirmar su cita. Usted puede seguir el siguiente enlace para acceder a la página de confirmación: <a href=\"{BASE URL}index.php?patient=confirm_appointment&n={APPOINTMENT NUMBER}\">Confirmar Cita</a>\n\n{APPOINTMENT DETAILS}\n\nPD Por favor, mantenga este e-mail para sus registros, ya que contiene una información importante que usted puede necesitar.\n\n-\nAtentamente,\nAtención al cliente","1");
INSERT INTO meda_email_templates VALUES("39","de","new_appointment_confirm_by_email","Neuer Termin (E-Mail-Bestätigung erforderlich)","Ihr Termin reserviert wurde (Bestätigung erforderlich)","Sehr geehrte <b>{FIRST NAME} {LAST NAME}</b>!\n\nIhr Termin ist reserviert, aber es ist noch nicht fertig!\n\nUm dieses Verfahren abschließen zu können, müssen Sie Ihren Termin zu bestätigen. Sie können den folgenden Link, um die Bestätigungsseite kommen: <a href=\"{BASE URL}index.php?patient=confirm_appointment&n={APPOINTMENT NUMBER}\">Bestätigen Termin</a>\n\n{APPOINTMENT DETAILS}\n\nP.S. Bitte bewahren Sie diese E-Mail für Ihre Unterlagen, da sie eine wichtige Information, die Sie benötigen enthält.\n\n-\nMit freundlichen Grüßen,\nCustomer Support","1");
INSERT INTO meda_email_templates VALUES("40","en","new_appointment_confirm_by_admin_doctor","New appointment (admin/doctor approval required)","Your appointment has been reserved (approval required)","Dear <b>{FIRST NAME} {LAST NAME}</b>!\n\nYour appointment has been reserved, but it\'s not complete yet!\n\nOnce the administrator or doctor approves your request, you will be notified by e-mail, with confirmation of your appointment.\n\n{APPOINTMENT DETAILS}\n\nP.S. Please keep this email for your records, as it contains an important information that you may need.\n\n-\nSincerely,\nCustomer Support","1");
INSERT INTO meda_email_templates VALUES("41","es","new_appointment_confirm_by_admin_doctor","Nueva cita (de aprobación de admin/médico es necesario)","Su cita ha sido reservada (de aprobación es necesario)","Querido <b>{FIRST NAME} {LAST NAME}</b>!\n\nSu cita ha sido reservado, pero no es completa todavía!\n\nUna vez que el administrador o al médico apruebe su solicitud, usted será notificado por correo electrónico, con la confirmación de su cita.\n\n{APPOINTMENT DETAILS}\n\nPD Por favor, mantenga este e-mail para sus registros, ya que contiene una información importante que usted puede necesitar.\n\n-\nAtentamente,\nAtención al cliente","1");
INSERT INTO meda_email_templates VALUES("42","de","new_appointment_confirm_by_admin_doctor","Neuer Termin (admin/Arzt Genehmigung erforderlich)","Ihr Termin reserviert wurde (Genehmigung erforderlich)","Sehr geehrte <b>{FIRST NAME} {LAST NAME}</b>!\n\nIhr Termin ist reserviert, aber es ist noch nicht fertig!\n\nSobald der Administrator oder Arzt genehmigt Ihrer Anfrage, werden Sie per E-Mail benachrichtigt werden, mit der Bestätigung Ihrer Bestellung.\n\n{APPOINTMENT DETAILS}\n\nP.S. Bitte bewahren Sie diese E-Mail für Ihre Unterlagen, da sie eine wichtige Information, die Sie benötigen enthält.\n\n-\nMit freundlichen Grüßen,\nCustomer Support","1");
INSERT INTO meda_email_templates VALUES("43","de","new_appointment_accepted","Neuer Termin (genehmigt)","Ihr Termin wurde akzeptiert!","Sehr geehrte <b>{FIRST NAME} {LAST NAME}</b>!\n\nIhre Ernennung wurde akzeptiert und genehmigt!\n\n{APPOINTMENT DETAILS}\n\nP.S. Bitte bewahren Sie diese E-Mail für Ihre Unterlagen, da sie eine wichtige Information, die Sie benötigen enthält.\n\n-\nMit freundlichen Grüßen,\nCustomer Support","1");
INSERT INTO meda_email_templates VALUES("44","en","new_appointment_accepted","New appointment (approved)","Your appointment has been accepted!","Dear <b>{FIRST NAME} {LAST NAME}</b>!\n\nYour appointment has been accepted and approved!\n\n{APPOINTMENT DETAILS}\n\nP.S. Please keep this email for your records, as it contains an important information that you may need.\n\n-\nSincerely,\nCustomer Support","1");
INSERT INTO meda_email_templates VALUES("45","es","new_appointment_accepted","Nueva cita (aprobado)","Su nombramiento ha sido aceptado!","Estimado <b>{FIRST NAME} {LAST NAME}</b>!\n\nSu nombramiento ha sido aceptado y aprobado!\n\n{APPOINTMENT DETAILS}\n\nPD Por favor, mantenga este e-mail para sus registros, ya que contiene una información importante que usted pueda necesitar.\n\n-\nAtentamente,\nAtención al cliente","1");
INSERT INTO meda_email_templates VALUES("46","en","appointment_approved_by_administration","Appointment has been approved by administration","Your appointment has been approved by administration","Dear <b>{FIRST NAME} {LAST NAME}!</b>\n\nCongratulations! This e-mail is to confirm that your appointment has been approved.\n\n{APPOINTMENT DETAILS}\n\n-\nSincerely,\nAdministration","1");
INSERT INTO meda_email_templates VALUES("47","es","appointment_approved_by_administration","Nombramiento ha sido aprobado por administración","Su nombramiento ha sido aprobado por el administración","Estimado <b>{FIRST NAME} {LAST NAME}!</b>\n\n¡Felicitaciones! Este e-mail es para confirmar que su nombramiento ha sido aprobado.\n\n{APPOINTMENT DETAILS}\n\n-\nAtentamente,\nadministración","1");
INSERT INTO meda_email_templates VALUES("48","de","appointment_approved_by_administration","Termin ist von der Verwaltung genehmigt worden","Ihr Termin wurde durch die Verabreichung zugelassen","Sehr geehrte <b>{FIRST NAME} {LAST NAME}!</b>\n\nHerzlichen Glückwunsch! Diese E-Mail ist zu bestätigen, dass Sie Ihren Termin genehmigt worden ist.\n\n{APPOINTMENT DETAILS}\n\n-\nMit freundlichen Grüßen,\nVerwaltung","1");
INSERT INTO meda_email_templates VALUES("49","en","appointment_canceled","Appointment has been canceled","Your appointment has been canceled","Dear <b>{FIRST NAME} {LAST NAME}!</b>\n\nThis e-mail is to confirm that your appointment has been canceled. \n\n{APPOINTMENT DETAILS}\n\nFor more information, please contact us.\n\n-\nSincerely,\nAdministration\n","1");
INSERT INTO meda_email_templates VALUES("50","es","appointment_canceled","Cita ha sido cancelada","Su cita ha sido cancelada","Querido <b>{FIRST NAME} {LAST NAME}!</b>\n\nEste e-mail es para confirmar que su cita ha sido cancelada.\n\n{APPOINTMENT DETAILS}\n\nPara obtener más información, póngase en contacto con nosotros.\n\n-\nAtentamente,\nadministración","1");
INSERT INTO meda_email_templates VALUES("51","de","appointment_canceled","Termin wurde abgesagt","Ihr Termin wurde abgesagt","Sehr geehrte <b>{FIRST NAME} {LAST NAME}!</b>\n\nDiese E-Mail ist zu bestätigen, dass Sie Ihren Termin abgesagt wurde. \n\n{APPOINTMENT DETAILS}\n\nFür weitere Informationen, kontaktieren Sie uns bitte.\n\n-\nMit freundlichen Grüßen,\nVerwaltung","1");
INSERT INTO meda_email_templates VALUES("52","en","appointment_confirmed_by_email","Appointment has been confirmed","Your appointment has been confirmed","Dear <b>{FIRST NAME} {LAST NAME}</b>!\n\nYour appointment has been confirmed and approved!\n\n{APPOINTMENT DETAILS}\n\nP.S. Please keep this email for your records, as it contains an important information that you may need.\n\n-\nSincerely,\nCustomer Support","1");
INSERT INTO meda_email_templates VALUES("53","es","appointment_confirmed_by_email","Nombramiento ha sido confirmado","Su nombramiento ha sido confirmado","Querido <b>{FIRST NAME} {LAST NAME}</b>!\n\nSu nombramiento ha sido confirmado y aprobado!\n\n{APPOINTMENT DETAILS}\n\nPD Guarde este correo electrónico para su registro, ya que contiene una información importante que usted pueda necesitar.\n\n-\nAtentamente,\nAtención al cliente","1");
INSERT INTO meda_email_templates VALUES("54","de","appointment_confirmed_by_email","Termin ist bestätigt worden","Ihr Termin ist bestätigt worden","Sehr geehrte <b>{FIRST NAME} {LAST NAME}</b>!\n\nIhr Termin wurde bestätigt und genehmigt!\n\n{APPOINTMENT DETAILS}\n\nP.S. Bitte bewahren Sie diese E-Mail für Ihre Unterlagen, wie es eine wichtige Information, die Sie benötigen enthält.\n\n-\nMit freundlichen Grüßen,\nCustomer Support","1");
INSERT INTO meda_email_templates VALUES("55","en","arrival_reminder","Email arrival reminder for patient","Reminder for your appointment","Dear <b>{FIRST NAME} {LAST NAME}</b>!\n\nThis email is to remind you about following appointment:\n\n{APPOINTMENT DETAILS}\n\nP.S. Please keep this email for your records, as it contains an important information that you may need.\n\n-\nSincerely,\nCustomer Support","1");
INSERT INTO meda_email_templates VALUES("56","es","arrival_reminder","Email recordatorio llegada para el paciente","Recordatorio de la cita","Estimado <b>{FIRST NAME} {LAST NAME}</b>!\n\nEste correo electrónico es para recordarle acerca de seguir nombramiento:\n\n{APPOINTMENT DETAILS}\n\nPD Guarde este correo electrónico para su registro, ya que contiene una información importante que usted pueda necesitar.\n\n-\nAtentamente,\nAtención al cliente","1");
INSERT INTO meda_email_templates VALUES("57","de","arrival_reminder","Email Ankunft Erinnerung für Patienten","Erinnerung für den Termin","Lieber <b>{FIRST NAME} {LAST NAME}</b>!\n\nThis email is to remind you about following appointment:\n\n{APPOINTMENT DETAILS}\n\nP.S. Bitte bewahren Sie diese E-Mail für Ihre Unterlagen, wie es eine wichtige Information, die Sie benötigen enthält.\n\n-\nMit freundlichen Grüßen,\nCustomer Support","1");
INSERT INTO meda_email_templates VALUES("58","en","approval_reminder","Email approval reminder for patient/doctor","Reminder for appointment you have to approve","Dear <b>{FIRST NAME} {LAST NAME}</b>!\n\nThis email is to remind you have an appointment that has not yet been approved. It will be canceled if you don\'t approve it {HOURS} hours before the appointment time.\n\nTo perform this action <a href=\"{BASE URL}\">Click Here</a>\n\n{APPOINTMENT DETAILS}\n\nP.S. Please keep this email for your records, as it contains an important information that you may need.\n\n-\nSincerely,\nCustomer Support","1");
INSERT INTO meda_email_templates VALUES("59","es","approval_reminder","Email recordatorio aprobación por paciente/médico","Recordatorio de cita tienes que aprobar","Estimado <b>{FIRST NAME} {LAST NAME}</b>!\n\nEste correo electrónico es para recordarle que tiene una cita que aún no ha sido aprobado. Se cancelará si no lo aprueban {HOURS} horas antes de la hora de la cita.\n\nPara realizar esta acción <a href=\"{BASE URL}\">Haga clic aquí</a>\n\n{APPOINTMENT DETAILS}\n\nPD Guarde este correo electrónico para su registro, ya que contiene una información importante que usted pueda necesitar.\n\n-\nAtentamente,\nAtención al cliente","1");
INSERT INTO meda_email_templates VALUES("60","de","approval_reminder","Email Genehmigung Erinnerung für Patienten/Arzt","Erinnerung für Termin, den Sie haben, zu genehmigen","Lieber <b>{FIRST NAME} {LAST NAME}</b>!\n\nDiese E-Mail ist es, daran zu erinnern, Sie haben einen Termin, der noch nicht genehmigt worden. Es wird abgebrochen, wenn Sie nicht einverstanden sind es {HOURS} Stunden vor dem Termin werden.\n\nUm diese Aktion durchzuführen <a href=\"{BASE URL}\">Hier klicken</a>\n\n{APPOINTMENT DETAILS}\n\nP.S. Bitte bewahren Sie diese E-Mail für Ihre Unterlagen, wie es eine wichtige Information, die Sie benötigen enthält.\n\n-\nMit freundlichen Grüßen,\nCustomer Support","1");
INSERT INTO meda_email_templates VALUES("61","en","order_accepted_online","Email for online placed orders (not paid yet)","Your order has been accepted by the system!","Dear <b>{FIRST NAME} {LAST NAME}</b>!\n\nYour order #{ORDER NUMBER} has been accepted and will be processed shortly.\n\n{ORDER DETAILS}\n\nP.S. Please keep this email for your records, as it contains an important information that you may\nneed.\n\n-\nSincerely,\nCustomer Support","1");
INSERT INTO meda_email_templates VALUES("62","es","order_accepted_online","Email para pedidos en línea (aún sin pagar)","Su pedido ha sido aceptado por el sistema!","Estimado <b>{FIRST NAME} {LAST NAME}</b>!\n\nSu orden {ORDER NUMBER} ha sido aceptada y se procesará en breve.\n\n{ORDER DETAILS}\n\nPD Por favor, mantenga este e-mail para sus registros, ya que contiene una información importante que puede\nnecesitan.\n\n-\nAtentamente,\nAtención al cliente","1");
INSERT INTO meda_email_templates VALUES("63","de","order_accepted_online","Email für Online getätigte Bestellungen (noch nicht bezahlt)","Ihre Bestellung wurde vom System akzeptiert wurde!","Sehr geehrte <b>{FIRST NAME} {LAST NAME}</b>!\n\nIhre Bestellung {ORDER NUMBER} angenommen worden und wird in Kürze bearbeitet.\n\n{ORDER DETAILS}\n\nP.S. Bitte bewahren Sie diese E-Mail für Ihre Unterlagen, da sie eine wichtige Information enthält, dass Sie möglicherweise\nbenötigen.\n\n-\nMit freundlichen Grüßen,\nCustomer Support","1");
INSERT INTO meda_email_templates VALUES("64","de","order_paid","E-Mail für Bestellungen via Zahlungsabwicklung Systeme bezahlt","Ihre Bestellung wurde bezahlt und erhalten durch das System!","Sehr geehrte <b>{FIRST NAME} {LAST NAME}</b>!\n\nVielen Dank für Ihre Bestellung!\n\nIhre Bestellung {ORDER NUMBER} ist abgeschlossen!\n\n{ORDER DETAILS}\n\nP.S. Bitte bewahren Sie diese E-Mail für Ihre Unterlagen, da es eine wichtige Information, die Sie benötigen enthält.\n\n-\nMit freundlichen Grüßen,\nCustomer Support","1");
INSERT INTO meda_email_templates VALUES("65","en","order_paid","Email for orders paid via payment processing systems","Your order has been paid and received by the system!","Dear <b>{FIRST NAME} {LAST NAME}</b>!\n\nThank you for your order!\n\nYour order #{ORDER NUMBER} has been completed!\n\n{ORDER DETAILS}\n\nP.S. Please keep this email for your records, as it contains an important information that you may need.\n\n-\nSincerely,\nCustomer Support\n","1");
INSERT INTO meda_email_templates VALUES("66","es","order_paid","Email para los pedidos pagados a través de sistemas de procesamiento de pagos","Su pedido ha sido pagado y recibido por el sistema!","Estimado <b>{FIRST NAME} {LAST NAME}</b>!\n\nGracias por su pedido!\n\nSu {ORDER NUMBER} fin se ha terminado!\n\n{ORDER DETAILS}\n\nPD Por favor, mantenga este e-mail para sus registros, ya que contiene una información importante que usted pueda necesitar.\n\n-----------------------------\nAtentamente,\nAtención al cliente","1");
INSERT INTO meda_email_templates VALUES("67","en","test_template","Testing Email","Testing Email","Hello <b>{USER NAME}</b>!\n\nThis a testing email.\n\nBest regards,\n{WEB SITE}","0");
INSERT INTO meda_email_templates VALUES("68","es","test_template","Prueba de correo electrónico","Prueba de correo electrónico","Hola <b>{USER NAME}</b>!\n\nEsta es una prueba de correo electrónico.\n\nSaludos cordiales,\n{WEB SITE}","0");
INSERT INTO meda_email_templates VALUES("69","de","test_template","Testen E-Mail","Testen E-Mail","Hallo <b>{USER NAME}</b>!\n\nDies ist ein Test E-Mail.\n\nMit freundlichen Grüßen,\n{WEB SITE}","0");



DROP TABLE IF EXISTS meda_events_registered;

CREATE TABLE `meda_events_registered` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `event_id` int(10) unsigned NOT NULL DEFAULT '0',
  `first_name` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `last_name` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(70) COLLATE utf8_unicode_ci NOT NULL,
  `phone` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `message` text COLLATE utf8_unicode_ci NOT NULL,
  `date_registered` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;




DROP TABLE IF EXISTS meda_faq_categories;

CREATE TABLE `meda_faq_categories` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `priority_order` smallint(6) unsigned NOT NULL DEFAULT '0',
  `is_active` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO meda_faq_categories VALUES("1","Booking an Appointment","2","1");
INSERT INTO meda_faq_categories VALUES("2","Accounts","0","1");
INSERT INTO meda_faq_categories VALUES("3","Finding a Doctor","1","1");



DROP TABLE IF EXISTS meda_faq_category_items;

CREATE TABLE `meda_faq_category_items` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `category_id` int(10) unsigned NOT NULL DEFAULT '0',
  `faq_question` text COLLATE utf8_unicode_ci NOT NULL,
  `faq_answer` text COLLATE utf8_unicode_ci NOT NULL,
  `priority_order` smallint(6) unsigned NOT NULL DEFAULT '0',
  `is_active` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `category_id` (`category_id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO meda_faq_category_items VALUES("1","1","Do I need to register to search for an appointment?","No, you do not need an account to do a search. However, if you would like to book an appointment, you\'ll need to sign up for an account. It\'s painless and completely free.\n","0","1");
INSERT INTO meda_faq_category_items VALUES("2","1","How do I book an appointment on your site?","Search for a healthcare professional according to doctor\'s name or specialty, then click the appointment time that works best for you. Sign in or create an account and follow the on-screen instructions to confirm your appointment and continue to complete an appointment.","1","1");
INSERT INTO meda_faq_category_items VALUES("3","2","Why can\'t I sign in to my account?","There could be a couple of reasons why you can\'t sign in:\n\nYou\'ve typed the wrong username or password. \n<br><br>\n\nMake sure that you don\'t have the caps lock on. If you\'ve forgotten your password, reset it <a href=\"index.php?patient=password_forgotten\">here</a> (if you\'re a patient) and <a href=\"index.php?doctor=password_forgotten\">here</a> (if you\'re a doctor).\n<br><br>\n\nYou haven\'t activated your account yet. Check your email for the account verification message from our site, and click the link in the message to activate it. If you can\'t find the email, check your junk folder.","0","1");
INSERT INTO meda_faq_category_items VALUES("4","3","I know the name of the doctor that I want to see. How can I find them?","Type their name in the search bar located in the side column. If they have an account on our site, they will appear in the search results.","0","1");



DROP TABLE IF EXISTS meda_gallery_album_items;

CREATE TABLE `meda_gallery_album_items` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `album_code` varchar(8) COLLATE utf8_unicode_ci NOT NULL,
  `item_file` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `item_file_thumb` varchar(70) COLLATE utf8_unicode_ci NOT NULL,
  `priority_order` smallint(6) NOT NULL DEFAULT '0',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `album_code` (`album_code`),
  KEY `priority_order` (`priority_order`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO meda_gallery_album_items VALUES("1","gpeqklos","admin_home_page.png","admin_home_page_thumb.jpg","1","1");
INSERT INTO meda_gallery_album_items VALUES("2","gpeqklos","doctors_management.png","doctors_management_thumb.jpg","2","1");
INSERT INTO meda_gallery_album_items VALUES("3","gpeqklos","backup_installation.png","backup_installation_thumb.jpg","3","1");



DROP TABLE IF EXISTS meda_gallery_album_items_description;

CREATE TABLE `meda_gallery_album_items_description` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `gallery_album_item_id` int(10) unsigned NOT NULL DEFAULT '0',
  `language_id` varchar(2) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `album_code` (`gallery_album_item_id`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO meda_gallery_album_items_description VALUES("1","1","es","Panel de Administración - Página de inicio","");
INSERT INTO meda_gallery_album_items_description VALUES("2","1","en","Admin Panel - Home Page","");
INSERT INTO meda_gallery_album_items_description VALUES("3","1","de","Admin-Panel - Homepage","");
INSERT INTO meda_gallery_album_items_description VALUES("4","2","de","Galerie Verwaltung","");
INSERT INTO meda_gallery_album_items_description VALUES("5","2","es","Galería de Gestión","");
INSERT INTO meda_gallery_album_items_description VALUES("6","2","en","Gallery Management","");
INSERT INTO meda_gallery_album_items_description VALUES("7","3","en","Backup Installation","");
INSERT INTO meda_gallery_album_items_description VALUES("8","3","de","Backup-Installation","");
INSERT INTO meda_gallery_album_items_description VALUES("9","3","es","Instalación de Backup","");



DROP TABLE IF EXISTS meda_gallery_albums;

CREATE TABLE `meda_gallery_albums` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `album_code` varchar(8) COLLATE utf8_unicode_ci NOT NULL,
  `album_type` enum('images','video') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'images',
  `priority_order` smallint(6) NOT NULL DEFAULT '0',
  `is_active` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `is_active` (`is_active`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO meda_gallery_albums VALUES("1","gpeqklos","images","1","1");



DROP TABLE IF EXISTS meda_gallery_albums_description;

CREATE TABLE `meda_gallery_albums_description` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `gallery_album_id` int(10) unsigned NOT NULL DEFAULT '0',
  `language_id` varchar(2) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `language_id` (`language_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO meda_gallery_albums_description VALUES("1","1","de","Bildergalerie","Bildergalerie");
INSERT INTO meda_gallery_albums_description VALUES("2","1","es","Galería de imágenes","Galería de imágenes");
INSERT INTO meda_gallery_albums_description VALUES("3","1","en","Images Gallery","Images Gallery");



DROP TABLE IF EXISTS meda_insurances;

CREATE TABLE `meda_insurances` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `priority_order` smallint(6) unsigned NOT NULL DEFAULT '0',
  `is_active` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO meda_insurances VALUES("1","2","1");
INSERT INTO meda_insurances VALUES("2","3","1");
INSERT INTO meda_insurances VALUES("3","4","1");
INSERT INTO meda_insurances VALUES("4","1","1");
INSERT INTO meda_insurances VALUES("5","0","1");



DROP TABLE IF EXISTS meda_insurances_description;

CREATE TABLE `meda_insurances_description` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `insurance_id` int(10) unsigned NOT NULL DEFAULT '0',
  `language_id` varchar(2) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(125) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO meda_insurances_description VALUES("1","1","en","General","General insurance plan");
INSERT INTO meda_insurances_description VALUES("2","1","es","General","Plan de seguros generales");
INSERT INTO meda_insurances_description VALUES("3","1","de","Allgemein","Allgemeine Versicherung");
INSERT INTO meda_insurances_description VALUES("4","2","en","Medicaid","");
INSERT INTO meda_insurances_description VALUES("5","2","es","Medicaid","");
INSERT INTO meda_insurances_description VALUES("6","2","de","Medicaid","");
INSERT INTO meda_insurances_description VALUES("7","3","en","Helthcare","");
INSERT INTO meda_insurances_description VALUES("8","3","es","Helthcare","");
INSERT INTO meda_insurances_description VALUES("9","3","de","Helthcare","");
INSERT INTO meda_insurances_description VALUES("10","4","en","I\'ll choose my insurance later","");
INSERT INTO meda_insurances_description VALUES("11","4","es","Voy a elegir mi seguro más adelante","");
INSERT INTO meda_insurances_description VALUES("12","4","de","Ich werde später meine Versicherung wählen","");
INSERT INTO meda_insurances_description VALUES("13","5","en","I\'m paying for myself","");
INSERT INTO meda_insurances_description VALUES("14","5","es","Estoy pagando por mi mismo","");
INSERT INTO meda_insurances_description VALUES("15","5","de","Ich zahle für mich selbst","");



DROP TABLE IF EXISTS meda_languages;

CREATE TABLE `meda_languages` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `lang_name` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `lang_name_en` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `abbreviation` varchar(3) COLLATE utf8_unicode_ci NOT NULL,
  `lc_time_name` varchar(5) CHARACTER SET latin1 NOT NULL DEFAULT 'en_US',
  `lang_dir` varchar(3) CHARACTER SET latin1 NOT NULL DEFAULT 'ltr',
  `icon_image` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `priority_order` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `used_on` enum('front-end','back-end','global') CHARACTER SET latin1 NOT NULL DEFAULT 'global',
  `is_default` tinyint(1) NOT NULL DEFAULT '0',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO meda_languages VALUES("1","English","English","en","en_US","ltr","en.gif","1","global","1","1");



DROP TABLE IF EXISTS meda_membership_plans;

CREATE TABLE `meda_membership_plans` (
  `id` tinyint(3) NOT NULL AUTO_INCREMENT,
  `images_count` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `addresses_count` tinyint(1) unsigned NOT NULL DEFAULT '5',
  `price` decimal(10,2) unsigned NOT NULL DEFAULT '0.00',
  `duration` smallint(6) NOT NULL DEFAULT '1' COMMENT 'in days',
  `show_in_search` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `is_default` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `is_active` tinyint(1) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO meda_membership_plans VALUES("1","0","0","0.00","365","0","1","1");
INSERT INTO meda_membership_plans VALUES("2","1","1","50.00","720","1","0","1");
INSERT INTO meda_membership_plans VALUES("3","2","3","100.00","1825","1","0","1");
INSERT INTO meda_membership_plans VALUES("4","3","5","200.00","-1","1","0","1");



DROP TABLE IF EXISTS meda_membership_plans_description;

CREATE TABLE `meda_membership_plans_description` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `membership_plan_id` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `language_id` varchar(2) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'en',
  `name` varchar(125) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `membership_plan_id` (`membership_plan_id`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO meda_membership_plans_description VALUES("1","1","de","Frei","Kostenlos werben Plan. Dieser Plan garantiert eine minimale Funktionen, aber frei.");
INSERT INTO meda_membership_plans_description VALUES("2","1","es","Libre","Gratis plan de publicidad. Este plan ofrece una serie de características mínimas, pero libres.");
INSERT INTO meda_membership_plans_description VALUES("3","1","en","Free","Free membership plan. This plan offers a minimal features, but free.");
INSERT INTO meda_membership_plans_description VALUES("4","2","en","Bronze","A step up from free membership plan. More features available.");
INSERT INTO meda_membership_plans_description VALUES("5","2","es","Bronce","Un paso adelante sin plan de publicidad. Otras características disponibles.");
INSERT INTO meda_membership_plans_description VALUES("6","2","de","Bronze","Ein Schritt aus freien Werben Plan. Weitere Features zur Verfügung.");
INSERT INTO meda_membership_plans_description VALUES("7","3","en","Silver","More features and details are allowed and are listed higher in results.");
INSERT INTO meda_membership_plans_description VALUES("8","3","es","Plata","Más características y los detalles se les permite y se enumeran más alto en los resultados.");
INSERT INTO meda_membership_plans_description VALUES("9","3","de","Silber","Weitere Merkmale und Einzelheiten sind zulässig und werden in höheren Ergebnissen aufgelistet.");
INSERT INTO meda_membership_plans_description VALUES("10","4","en","Gold","This membership plan provides maximum features and benefits.");
INSERT INTO meda_membership_plans_description VALUES("11","4","es","Oro","Este plan de publicidad ofrece máximas prestaciones y beneficios.");
INSERT INTO meda_membership_plans_description VALUES("12","4","de","Gold","Dieses Werben Plan bietet ein Maximum an Funktionen und Vorteile.");



DROP TABLE IF EXISTS meda_menus;

CREATE TABLE `meda_menus` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `menu_code` varchar(10) CHARACTER SET latin1 NOT NULL,
  `language_id` varchar(2) CHARACTER SET latin1 NOT NULL,
  `menu_name` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `menu_placement` enum('','left','top','right','bottom','hidden') CHARACTER SET latin1 NOT NULL,
  `menu_order` tinyint(3) DEFAULT '1',
  `access_level` enum('public','registered') CHARACTER SET latin1 NOT NULL DEFAULT 'public',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO meda_menus VALUES("1","AWSERTVERT","en","General","left","1","public");
INSERT INTO meda_menus VALUES("2","AWSERTVERT","es","General","left","1","public");
INSERT INTO meda_menus VALUES("3","AWSERTVERT","de","Allgemeine","left","1","public");
INSERT INTO meda_menus VALUES("4","LE8W11HJ3Q","en","Help & Information","bottom","2","public");
INSERT INTO meda_menus VALUES("5","LE8W11HJ3Q","es","Ayuda e Información","bottom","2","public");
INSERT INTO meda_menus VALUES("6","LE8W11HJ3Q","de","Hilfe & Information","bottom","2","public");



DROP TABLE IF EXISTS meda_modules;

CREATE TABLE `meda_modules` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `name_const` varchar(20) CHARACTER SET latin1 NOT NULL,
  `description_const` varchar(30) CHARACTER SET latin1 NOT NULL,
  `icon_file` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `module_tables` varchar(255) CHARACTER SET latin1 NOT NULL,
  `dependent_modules` varchar(20) CHARACTER SET latin1 NOT NULL,
  `settings_page` varchar(30) CHARACTER SET latin1 NOT NULL,
  `settings_const` varchar(30) CHARACTER SET latin1 NOT NULL,
  `settings_access_by` varchar(50) CHARACTER SET latin1 NOT NULL,
  `management_page` varchar(125) CHARACTER SET latin1 NOT NULL,
  `management_const` varchar(125) CHARACTER SET latin1 NOT NULL,
  `management_access_by` varchar(50) CHARACTER SET latin1 NOT NULL,
  `is_installed` tinyint(1) NOT NULL DEFAULT '0',
  `is_system` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `show_on_dashboard` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `priority_order` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO meda_modules VALUES("1","pages","_PAGES","_MD_PAGES","pages.png","pages,menus","","","","owner,mainadmin","pages","_PAGE_EDIT_PAGES","owner,mainadmin","1","1","1","0");
INSERT INTO meda_modules VALUES("2","appointments","_APPOINTMENTS","_MD_APPOINTMENTS","appointments.png","appointments","","mod_appointments_settings","_APPOINTMENTS_SETTINGS","owner,mainadmin","mod_appointments_management","_APPOINTMENTS_MANAGEMENT","owner,mainadmin","1","1","1","1");
INSERT INTO meda_modules VALUES("3","doctors","_DOCTORS","_MD_DOCTORS","doctors.png","doctors","","mod_doctors_settings","_DOCTORS_SETTINGS","owner,mainadmin","","","","1","1","1","2");
INSERT INTO meda_modules VALUES("4","patients","_PATIENTS","_MD_PATIENTS","patients.png","patients","","mod_patients_settings","_PATIENTS_SETTINGS","owner,mainadmin","","","","1","0","0","3");
INSERT INTO meda_modules VALUES("5","payments","_PAYMENTS","_MD_PAYMENTS","payments.png","membershsip_plans,membershsip_plans_description,orders","","mod_payments_settings","_PAYMENTS_SETTINGS","owner,mainadmin","","","","1","0","1","4");
INSERT INTO meda_modules VALUES("6","contact_us","_CONTACT_US","_MD_CONTACT_US","contact_us.png","","","mod_contact_us_settings","_CONTACT_US_SETTINGS","owner,mainadmin","","","","1","0","0","5");
INSERT INTO meda_modules VALUES("7","comments","_COMMENTS","_MD_COMMENTS","comments.png","comments","","mod_comments_settings","_COMMENTS_SETTINGS","owner,mainadmin","mod_comments_management","_COMMENTS_MANAGEMENT","owner,mainadmin","1","0","0","6");
INSERT INTO meda_modules VALUES("8","gallery","_GALLERY","_MD_GALLERY","gallery.png","gallery_albums,gallery_images","","mod_gallery_settings","_GALLERY_SETTINGS","owner,mainadmin","mod_gallery_management","_GALLERY_MANAGEMENT","owner,mainadmin","1","0","0","7");
INSERT INTO meda_modules VALUES("9","banners","_BANNERS","_MD_BANNERS","banners.png","banners","","mod_banners_settings","_BANNERS_SETTINGS","owner,mainadmin","mod_banners_management","_BANNERS_MANAGEMENT","","1","0","0","8");
INSERT INTO meda_modules VALUES("10","news","_NEWS","_MD_NEWS","news.png","news,events_registered,news_subscribed","","mod_news_settings","_NEWS_SETTINGS","owner,mainadmin","mod_news_management,mod_news_subscribed","_NEWS_MANAGEMENT,_SUBSCRIPTION_MANAGEMENT","","1","0","0","9");
INSERT INTO meda_modules VALUES("11","faq","_FAQ","_MD_FAQ","faq.png","faq_categories,faq_category_items","","mod_faq_settings","_FAQ_SETTINGS","owner,mainadmin","mod_faq_management","_FAQ_MANAGEMENT","owner,mainadmin","1","0","0","10");
INSERT INTO meda_modules VALUES("12","google_maps","_GOOGLE_MAPS","_MD_GOOGLE_MAPS","google_maps.png","","","mod_google_maps_settings","_GOOGLE_MAPS_SETTINGS","owner,mainadmin","","","","1","0","0","11");
INSERT INTO meda_modules VALUES("13","reminder","_REMINDER","_MD_REMINDER","reminder.png","","","mod_reminder_settings","_REMINDER_SETTINGS","owner,mainadmin","","","","1","0","1","12");
INSERT INTO meda_modules VALUES("14","ratings","_RATINGS","_MD_RATINGS","ratings.png","ratings_items,ratings_users","","mod_ratings_settings","_RATINGS_SETTINGS","owner,mainadmin","","","","1","0","0","13");
INSERT INTO meda_modules VALUES("15","backup","_BACKUP_AND_RESTORE","_MD_BACKUP_AND_RESTORE","backup.png","","","mod_backup_installation","_BACKUP_INSTALLATION","owner","mod_backup_restore","_BACKUP_RESTORE","owner","1","0","0","14");



DROP TABLE IF EXISTS meda_modules_settings;

CREATE TABLE `meda_modules_settings` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `module_name` varchar(20) CHARACTER SET latin1 NOT NULL,
  `settings_key` varchar(40) CHARACTER SET latin1 NOT NULL,
  `settings_value` text COLLATE utf8_unicode_ci NOT NULL,
  `settings_name_const` varchar(40) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `settings_description_const` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `key_display_type` enum('string','email','numeric','unsigned float','integer','positive integer','unsigned integer','enum','yes/no','html size','text') CHARACTER SET latin1 NOT NULL,
  `key_is_required` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `key_display_source` varchar(255) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`id`),
  KEY `module_name` (`module_name`)
) ENGINE=MyISAM AUTO_INCREMENT=89 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO meda_modules_settings VALUES("1","appointments","is_active","yes","_MSN_APPOINTMENTS_IS_ACTIVE","_MS_APPOINTMENTS_IS_ACTIVE","yes/no","1","");
INSERT INTO meda_modules_settings VALUES("2","appointments","maximum_allowed_appointments","10","_MSN_MAXIMUM_ALLOWED_APPOINTMENTS","_MS_MAXIMUM_ALLOWED_APPOINTMENTS","positive integer","1","");
INSERT INTO meda_modules_settings VALUES("3","appointments","approval_required","by admin/doctor","_MSN_APPROVAL_REQUIRED","_MS_APPROVAL_REQUIRED","enum","1","automatic,by email,by admin/doctor");
INSERT INTO meda_modules_settings VALUES("4","appointments","delay_slots","2","_MSN_DELAY_SLOTS","_MS_DELAY_SLOTS","positive integer","1","");
INSERT INTO meda_modules_settings VALUES("5","appointments","send_notification_to_admin","yes","_MSN_SEND_APPT_NOTIF_TO_ADMIN","_MS_SEND_APPT_NOTIF_TO_ADMIN","yes/no","0","");
INSERT INTO meda_modules_settings VALUES("6","appointments","send_notification_to_doctor","yes","_MSN_SEND_APPT_NOTIF_TO_DOCTOR","_MS_SEND_APPT_NOTIF_TO_DOCTOR","yes/no","1","");
INSERT INTO meda_modules_settings VALUES("7","appointments","cancellation_period","12","_MSN_APPT_CANCELLATION_PERIOD","_MS_APPT_CANCELLATION_PERIOD","positive integer","1","");
INSERT INTO meda_modules_settings VALUES("8","appointments","schedules_access_level","public","_MSN_SCHEDULES_ACCESS_LEVEL","_MS_SCHEDULES_ACCESS_LEVEL","enum","1","public,registered");
INSERT INTO meda_modules_settings VALUES("9","appointments","page_size","20","_MSN_APPOINTMENTS_PAGE_SIZE","_MS_APPOINTMENTS_PAGE_SIZE","positive integer","1","");
INSERT INTO meda_modules_settings VALUES("10","appointments","allow_multiple_appointments","no","_MSN_ALLOW_MULTIPLE_APPOINTMENTS","_MS_ALLOW_MULTIPLE_APPOINTMENTS","yes/no","1","");
INSERT INTO meda_modules_settings VALUES("11","banners","is_active","yes","_MSN_BANNERS_IS_ACTIVE","_MS_BANNERS_IS_ACTIVE","yes/no","1","");
INSERT INTO meda_modules_settings VALUES("12","banners","rotation_type","slide show","_MSN_ROTATION_TYPE","_MS_ROTATION_TYPE","enum","0","random image,slide show");
INSERT INTO meda_modules_settings VALUES("13","banners","rotate_delay","7","_MSN_ROTATE_DELAY","_MS_ROTATE_DELAY","positive integer","1","");
INSERT INTO meda_modules_settings VALUES("14","banners","slideshow_caption_html","yes","_MSN_BANNERS_CAPTION_HTML","_MS_BANNERS_CAPTION_HTML","yes/no","1","");
INSERT INTO meda_modules_settings VALUES("15","comments","comments_allow","yes","_MSN_COMMENTS_ALLOW","_MS_COMMENTS_ALLOW","yes/no","1","");
INSERT INTO meda_modules_settings VALUES("16","comments","user_type","all","_MSN_USER_TYPE","_MS_USER_TYPE","enum","1","all,registered");
INSERT INTO meda_modules_settings VALUES("17","comments","comment_length","500","_MSN_COMMENTS_LENGTH","_MS_COMMENTS_LENGTH","positive integer","1","");
INSERT INTO meda_modules_settings VALUES("18","comments","image_verification_allow","yes","_MSN_IMAGE_VERIFICATION_ALLOW","_MS_IMAGE_VERIFICATION_ALLOW","yes/no","1","");
INSERT INTO meda_modules_settings VALUES("19","comments","page_size","20","_MSN_COMMENTS_PAGE_SIZE","_MS_COMMENTS_PAGE_SIZE","positive integer","1","");
INSERT INTO meda_modules_settings VALUES("20","comments","pre_moderation_allow","yes","_MSN_PRE_MODERATION_ALLOW","_MS_PRE_MODERATION_ALLOW","yes/no","1","");
INSERT INTO meda_modules_settings VALUES("21","comments","delete_pending_time","2","_MSN_DELETE_PENDING_TIME","_MS_DELETE_PENDING_TIME","enum","1","0,1,2,3,4,5,6,7,8,9,10,15,20,30,45,60,120,180");
INSERT INTO meda_modules_settings VALUES("22","contact_us","email","contact@yourdomain.com","_MSN_EMAIL","_MS_EMAIL","email","1","");
INSERT INTO meda_modules_settings VALUES("23","contact_us","key","{module:contact_us}","_MSN_CONTACT_US_KEY","_MS_CONTACT_US_KEY","enum","1","{module:contact_us}");
INSERT INTO meda_modules_settings VALUES("24","contact_us","is_send_delay","yes","_MSN_IS_SEND_DELAY","_MS_IS_SEND_DELAY","yes/no","1","");
INSERT INTO meda_modules_settings VALUES("25","contact_us","delay_length","20","_MSN_DELAY_LENGTH","_MS_DELAY_LENGTH","positive integer","0","");
INSERT INTO meda_modules_settings VALUES("26","contact_us","image_verification_allow","yes","_MSN_IMAGE_VERIFICATION_ALLOW","_MS_IMAGE_VERIFICATION_ALLOW","yes/no","0","");
INSERT INTO meda_modules_settings VALUES("27","doctors","key","{module:doctors}","_MSN_DOCTORS_KEY","_MS_DOCTORS_KEY","enum","1","{module:doctors}");
INSERT INTO meda_modules_settings VALUES("28","doctors","allow_login","yes","_MSN_ALLOW_DOCTORS_LOGIN","_MS_ALLOW_DOCTORS_LOGIN","yes/no","0","");
INSERT INTO meda_modules_settings VALUES("29","doctors","remember_me_allow","yes","_MSN_REMEMBER_ME","_MS_REMEMBER_ME","yes/no","1","");
INSERT INTO meda_modules_settings VALUES("30","doctors","allow_registration","yes","_MSN_ALLOW_DOCTORS_REGISTRATION","_MS_ALLOW_DOCTORS_REGISTRATION","yes/no","1","");
INSERT INTO meda_modules_settings VALUES("31","doctors","reg_confirmation","by admin","_MSN_REG_CONFIRMATION","_MS_REG_CONFIRMATION","enum","0","automatic,by email,by admin");
INSERT INTO meda_modules_settings VALUES("32","doctors","image_verification_allow","yes","_MSN_DOCTORS_IMAGE_VERIFICATION","_MS_DOCTORS_IMAGE_VERIFICATION","yes/no","1","");
INSERT INTO meda_modules_settings VALUES("33","doctors","admin_alert_new_registration","yes","_MSN_ALERT_ADMIN_NEW_REGISTRATION","_MS_ALERT_ADMIN_NEW_REGISTRATION","yes/no","1","");
INSERT INTO meda_modules_settings VALUES("34","doctors","allow_reset_passwords","yes","_MSN_ALLOW_DOCTORS_RESET_PASSWORDS","_MS_ALLOW_DOCTORS_RESET_PASSWORDS","yes/no","1","");
INSERT INTO meda_modules_settings VALUES("35","doctors","password_changing_by_admin","yes","_MSN_ADMIN_CHANGE_DOCTOR_PASSWORD","_MS_ADMIN_CHANGE_DOCTOR_PASSWORD","yes/no","1","");
INSERT INTO meda_modules_settings VALUES("36","doctors","allow_search_by_name","yes","_MSN_ALLOW_DOCTORS_SEARCH_NAME","_MS_ALLOW_DOCTORS_SEARCH_NAME","yes/no","1","");
INSERT INTO meda_modules_settings VALUES("37","doctors","allow_search_by_location","yes","_MSN_ALLOW_DOCTORS_SEARCH_LOCATION","_MS_ALLOW_DOCTORS_SEARCH_LOCATION","yes/no","1","");
INSERT INTO meda_modules_settings VALUES("38","doctors","watermark","no","_MSN_ADD_WATERMARK","_MS_ADD_WATERMARK","yes/no","1","");
INSERT INTO meda_modules_settings VALUES("39","doctors","watermark_text","","_MSN_WATERMARK_TEXT","_MS_WATERMARK_TEXT","string","0","");
INSERT INTO meda_modules_settings VALUES("40","faq","is_active","yes","_MSN_FAQ_IS_ACTIVE","_MS_FAQ_IS_ACTIVE","yes/no","1","");
INSERT INTO meda_modules_settings VALUES("41","gallery","image_gallery_type","lytebox","_MSN_IMAGE_GALLERY_TYPE","_MS_IMAGE_GALLERY_TYPE","enum","1","lytebox,rokbox");
INSERT INTO meda_modules_settings VALUES("42","gallery","video_gallery_type","rokbox","_MSN_VIDEO_GALLERY_TYPE","_MS_VIDEO_GALLERY_TYPE","enum","1","rokbox,videobox");
INSERT INTO meda_modules_settings VALUES("43","gallery","key","{module:gallery}","_MSN_GALLERY_KEY","_MS_GALLERY_KEY","enum","1","{module:gallery}");
INSERT INTO meda_modules_settings VALUES("44","gallery","album_icon_width","120px","_MSN_ALBUM_ICON_WIDTH","_MS_ALBUM_ICON_WIDTH","html size","1","");
INSERT INTO meda_modules_settings VALUES("45","gallery","album_icon_height","90px","_MSN_ALBUM_ICON_HEIGHT","_MS_ALBUM_ICON_HEIGHT","html size","1","");
INSERT INTO meda_modules_settings VALUES("46","gallery","albums_per_line","4","_MSN_ALBUMS_PER_LINE","_MS_ALBUMS_PER_LINE","positive integer","1","");
INSERT INTO meda_modules_settings VALUES("47","gallery","album_key","{module:album=CODE}","_MSN_ALBUM_KEY","_MS_ALBUM_KEY","enum","1","{module:album=CODE}");
INSERT INTO meda_modules_settings VALUES("48","gallery","wrapper","table","_MSN_GALLERY_WRAPPER","_MS_GALLERY_WRAPPER","enum","1","table,div");
INSERT INTO meda_modules_settings VALUES("49","gallery","show_items_count_in_album","yes","_MSN_ALBUM_ITEMS_COUNT","_MS_ALBUM_ITEMS_COUNT","yes/no","1","");
INSERT INTO meda_modules_settings VALUES("50","gallery","show_items_numeration_in_album","yes","_MSN_ALBUM_ITEMS_NUMERATION","_MS_ALBUM_ITEMS_NUMERATION","yes/no","1","");
INSERT INTO meda_modules_settings VALUES("51","google_maps","api_key","","_MSN_GOOGLE_MAPS_API_KEY","_MS_GOOGLE_MAPS_API_KEY","string","0","");
INSERT INTO meda_modules_settings VALUES("52","google_maps","map_width","480","_MSN_GOOGLE_MAP_WIDTH","_MS_GOOGLE_MAP_WIDTH","positive integer","1","");
INSERT INTO meda_modules_settings VALUES("53","google_maps","map_height","280","_MSN_GOOGLE_MAP_HEIGHT","_MS_GOOGLE_MAP_HEIGHT","positive integer","1","");
INSERT INTO meda_modules_settings VALUES("54","news","news_count","5","_MSN_NEWS_COUNT","_MS_NEWS_COUNT","positive integer","1","");
INSERT INTO meda_modules_settings VALUES("55","news","news_header_length","80","_MSN_NEWS_HEADER_LENGTH","_MS_NEWS_HEADER_LENGTH","positive integer","1","");
INSERT INTO meda_modules_settings VALUES("56","news","news_rss","yes","_MSN_NEWS_RSS","_MS_NEWS_RSS","yes/no","1","");
INSERT INTO meda_modules_settings VALUES("57","news","show_news_block","left side","_MSN_SHOW_NEWS_BLOCK","_MS_SHOW_NEWS_BLOCK","enum","1","no,left side,right side");
INSERT INTO meda_modules_settings VALUES("58","news","show_newsletter_subscribe_block","left side","_MSN_SHOW_NEWSLETTER_SUBSCRIBE_BLOCK","_MS_SHOW_NEWSLETTER_SUBSCRIBE_BLOCK","enum","1","no,left side,right side");
INSERT INTO meda_modules_settings VALUES("59","patients","allow_adding_by_admin","yes","_MSN_ALLOW_ADDING_BY_ADMIN","_MS_ALLOW_ADDING_BY_ADMIN","yes/no","1","");
INSERT INTO meda_modules_settings VALUES("60","patients","allow_login","yes","_MSN_ALLOW_PATIENTS_LOGIN","_MS_ALLOW_PATIENTS_LOGIN","yes/no","0","");
INSERT INTO meda_modules_settings VALUES("61","patients","remember_me_allow","yes","_MSN_REMEMBER_ME","_MS_REMEMBER_ME","yes/no","1","");
INSERT INTO meda_modules_settings VALUES("62","patients","allow_registration","yes","_MSN_ALLOW_PATIENTS_REGISTRATION","_MS_ALLOW_PATIENTS_REGISTRATION","yes/no","1","");
INSERT INTO meda_modules_settings VALUES("63","patients","reg_confirmation","by email","_MSN_REG_CONFIRMATION","_MS_REG_CONFIRMATION","enum","0","automatic,by email,by admin");
INSERT INTO meda_modules_settings VALUES("64","patients","image_verification_allow","yes","_MSN_PATIENTS_IMAGE_VERIFICATION","_MS_PATIENTS_IMAGE_VERIFICATION","yes/no","1","");
INSERT INTO meda_modules_settings VALUES("65","patients","admin_alert_new_registration","yes","_MS_ALERT_ADMIN_NEW_REGISTRATION","_MS_ALERT_ADMIN_NEW_REGISTRATION","yes/no","1","");
INSERT INTO meda_modules_settings VALUES("66","patients","allow_reset_passwords","yes","_MSN_ALLOW_PATIENTS_RESET_PASSWORDS","_MS_ALLOW_PATIENTS_RESET_PASSWORDS","yes/no","1","");
INSERT INTO meda_modules_settings VALUES("67","patients","password_changing_by_admin","yes","_MSN_ADMIN_CHANGE_PATIENT_PASSWORD","_MS_ADMIN_CHANGE_PATIENT_PASSWORD","yes/no","1","");
INSERT INTO meda_modules_settings VALUES("68","payments","is_active","yes","_MSN_PAYMENTS_ACTIVE","_MS_PAYMENTS_ACTIVE","yes/no","1","");
INSERT INTO meda_modules_settings VALUES("69","payments","payment_method_online","yes","_MSN_PAYMENT_METHOD_ONLINE","_MS_PAYMENT_METHOD_ONLINE","yes/no","1","");
INSERT INTO meda_modules_settings VALUES("70","payments","online_collect_credit_card","yes","_MSN_ONLINE_COLLECT_CREDIT_CARD","_MS_ONLINE_COLLECT_CREDIT_CARD","yes/no","0","");
INSERT INTO meda_modules_settings VALUES("71","payments","payment_method_paypal","yes","_MSN_PAYMENT_METHOD_PAYPAL","_MS_PAYMENT_METHOD_PAYPAL","yes/no","1","");
INSERT INTO meda_modules_settings VALUES("72","payments","paypal_email","paypal@yourdomain.com","_MSN_PAYPAL_EMAIL","_MS_PAYPAL_EMAIL","email","1","");
INSERT INTO meda_modules_settings VALUES("73","payments","payment_method_2co","yes","_MSN_PAYMENT_METHOD_2CO","_MS_PAYMENT_METHOD_2CO","yes/no","0","");
INSERT INTO meda_modules_settings VALUES("74","payments","two_checkout_vendor","Your Vendor ID","_MSN_TWO_CHECKOUT_VENDOR","_MS_TWO_CHECKOUT_VENDOR","string","1","");
INSERT INTO meda_modules_settings VALUES("75","payments","payment_method_authorize","yes","_MSN_PAYMENT_METHOD_AUTHORIZE","_MS_PAYMENT_METHOD_AUTHORIZE","yes/no","1","");
INSERT INTO meda_modules_settings VALUES("76","payments","authorize_login_id","Your Login ID","_MSN_AUTHORIZE_LOGIN_ID","_MS_AUTHORIZE_LOGIN_ID","string","1","");
INSERT INTO meda_modules_settings VALUES("77","payments","authorize_transaction_key","Your Transaction Key","_MSN_AUTHORIZE_TRANSACTION_KEY","_MS_AUTHORIZE_TRANSACTION_KEY","string","1","");
INSERT INTO meda_modules_settings VALUES("78","payments","default_payment_system","paypal","_MSN_DEFAULT_PAYMENT_SYSTEM","_MS_DEFAULT_PAYMENT_SYSTEM","enum","1","online,paypal,2co,authorize.net");
INSERT INTO meda_modules_settings VALUES("79","payments","vat_value","0","_MSN_VAT_VALUE","_MS_VAT_VALUE","unsigned float","0","");
INSERT INTO meda_modules_settings VALUES("80","payments","send_order_copy_to_admin","yes","_MSN_SEND_ORDER_COPY_TO_ADMIN","_MS_SEND_ORDER_COPY_TO_ADMIN","yes/no","0","");
INSERT INTO meda_modules_settings VALUES("81","payments","mode","REAL MODE","_MSN_PAYMENTS_MODE","_MS_PAYMENTS_MODE","enum","1","TEST MODE,REAL MODE");
INSERT INTO meda_modules_settings VALUES("82","payments","maximum_allowed_orders","10","_MSN_MAXIMUM_ALLOWED_ORDERS","_MS_MAXIMUM_ALLOWED_ORDERS","positive integer","1","");
INSERT INTO meda_modules_settings VALUES("83","ratings","user_type","registered","_MSN_RATINGS_USER_TYPE","_MS_RATINGS_USER_TYPE","enum","1","all,registered");
INSERT INTO meda_modules_settings VALUES("84","ratings","multiple_items_per_day","yes","_MSN_MULTIPLE_ITEMS_PER_DAY","_MS_MULTIPLE_ITEMS_PER_DAY","yes/no","1","");
INSERT INTO meda_modules_settings VALUES("85","reminder","type","email","_MSN_REMINDER_TYPE","_MS_REMINDER_TYPE","enum","1","email");
INSERT INTO meda_modules_settings VALUES("86","reminder","patient_arrival_reminder","24","_MSN_PATIENT_ARRIVAL_REMINDER","_MS_PATIENT_ARRIVAL_REMINDER","enum","1","1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,30,36,42,48,72");
INSERT INTO meda_modules_settings VALUES("87","reminder","doctor_confirm_reminder","24","_MSN_DOCTOR_CONFIRM_REMINDER","_MS_DOCTOR_CONFIRM_REMINDER","enum","1","1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,30,36,42,48,72");
INSERT INTO meda_modules_settings VALUES("88","reminder","patient_confirm_reminder","36","_MSN_PATIENT_CONFIRM_REMINDER","_MS_PATIENT_CONFIRM_REMINDER","enum","1","1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,30,36,42,48,72");



DROP TABLE IF EXISTS meda_news;

CREATE TABLE `meda_news` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `news_code` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `language_id` varchar(2) CHARACTER SET latin1 NOT NULL,
  `type` enum('news','events') CHARACTER SET latin1 NOT NULL DEFAULT 'news',
  `header_text` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `body_text` text COLLATE utf8_unicode_ci NOT NULL,
  `date_created` datetime NOT NULL,
  `is_active` tinyint(1) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `language_id` (`language_id`),
  KEY `type` (`type`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO meda_news VALUES("1","5unkq4sxk8","en","news","New version 3.0.0 of ApPHP Medical Appointment was released!","<p>The new version 3.0.0 of ApPHP Medical Appointment Pro is available for downloading. There are many additions and improvements in this version, also some bug fixed. You can review all recent changes <a href=\"http://www.apphp.com/php-medical-appointment/index.php?page=changelog#new\">here</a>.</p>","2014-03-13 18:52:53","1");
INSERT INTO meda_news VALUES("2","5unkq4sxk8","es","news","Nueva versión 3.0.0 de ApPHP Medical Appointment fue puesto en libertad!","<p>La nueva versión 3.0.0 de ApPHP Pro Cita Médica está disponible para su descarga. Hay muchas adiciones y mejoras en esta versión, también algún error corregido. Usted puede revisar todos los cambios recientes <a href=\"http://www.apphp.com/php-medical-appointment/index.php?page=changelog#new\">aquá</a>.</p>","2014-03-13 18:53:36","1");
INSERT INTO meda_news VALUES("3","5unkq4sxk8","de","news","Neue Version 3.0.0 von ApPHP Arzttermin wurde veröffentlicht!","<p>Die neue Version 3.0.0 des ApPHP Medical Appointment Pro steht zum Download bereit. Es gibt viele Erweiterungen und Verbesserungen in dieser Version auch einige Fehler behoben. Sie können überprüfen, die letzten Änderungen <a href=\"http://www.apphp.com/php-medical-appointment/index.php?page=changelog#new\">hier</a>.</p>","2014-03-13 18:53:59","1");



DROP TABLE IF EXISTS meda_news_subscribed;

CREATE TABLE `meda_news_subscribed` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `email` varchar(70) COLLATE utf8_unicode_ci NOT NULL,
  `date_subscribed` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;




DROP TABLE IF EXISTS meda_orders;

CREATE TABLE `meda_orders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_number` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `order_description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `order_price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `vat_percent` decimal(4,2) NOT NULL DEFAULT '0.00',
  `vat_fee` decimal(10,2) NOT NULL DEFAULT '0.00',
  `total_price` decimal(10,2) unsigned NOT NULL DEFAULT '0.00',
  `currency` varchar(3) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'USD',
  `membership_plan_id` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `doctor_id` int(11) NOT NULL DEFAULT '0',
  `transaction_number` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `created_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `payment_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `payment_type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0 - Online Order, 1 - PayPal, 2 - 2CO, 3 - Authorize.Net',
  `payment_method` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0 - Payment Company Account, 1 - Credit Card, 2 - E-Check',
  `coupon_number` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `discount_campaign_id` int(10) DEFAULT '0',
  `additional_info` text COLLATE utf8_unicode_ci NOT NULL,
  `cc_type` varchar(20) CHARACTER SET latin1 NOT NULL,
  `cc_holder_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `cc_number` varchar(50) CHARACTER SET latin1 NOT NULL,
  `cc_expires_month` varchar(2) CHARACTER SET latin1 NOT NULL,
  `cc_expires_year` varchar(4) CHARACTER SET latin1 NOT NULL,
  `cc_cvv_code` varchar(4) CHARACTER SET latin1 NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0 - preparing, 1 - pending, 2 - paid, 3 - completed, 4 - refunded',
  `status_changed` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `email_sent` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `payment_type` (`payment_method`),
  KEY `status` (`status`),
  KEY `membership_plan_id` (`membership_plan_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO meda_orders VALUES("1","ARAMAEV3VV","Doctor Membership Plan","200.00","0.00","0.00","200.00","USD","4","3","","2014-10-03 06:38:50","0000-00-00 00:00:00","0","0","","0","","","","","","","","0","0000-00-00 00:00:00","0");



DROP TABLE IF EXISTS meda_pages;

CREATE TABLE `meda_pages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `page_code` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `language_id` varchar(2) CHARACTER SET latin1 NOT NULL,
  `content_type` enum('article','link','') CHARACTER SET latin1 NOT NULL DEFAULT 'article',
  `link_url` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `link_target` enum('','_self','_blank') CHARACTER SET latin1 NOT NULL,
  `page_key` varchar(125) COLLATE utf8_unicode_ci DEFAULT NULL,
  `page_title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `page_text` text COLLATE utf8_unicode_ci,
  `menu_id` int(11) DEFAULT '0',
  `menu_link` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tag_title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `tag_keywords` text COLLATE utf8_unicode_ci NOT NULL,
  `tag_description` text COLLATE utf8_unicode_ci NOT NULL,
  `comments_allowed` tinyint(1) NOT NULL DEFAULT '0',
  `date_created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `finish_publishing` date NOT NULL DEFAULT '0000-00-00',
  `is_home` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `is_removed` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `is_published` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `is_system_page` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `system_page` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `show_in_search` tinyint(1) NOT NULL DEFAULT '1',
  `status_changed` datetime NOT NULL,
  `access_level` enum('public','registered') CHARACTER SET latin1 NOT NULL DEFAULT 'public',
  `priority_order` smallint(6) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `is_published` (`is_published`),
  KEY `is_removed` (`is_removed`),
  KEY `language_id` (`language_id`),
  KEY `comments_allowed` (`comments_allowed`)
) ENGINE=MyISAM AUTO_INCREMENT=31 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO meda_pages VALUES("1","rdcsjq1xuq","en","article","","_self","Welcome-to-ApPHP-Medical-Appointment","Welcome to ApPHP Medical Appointment!","<p><strong><img style=\"width: 128px; height: 128px;\" src=\"images/upload/health_care.png\" border=\"0\" alt=\"icon\" hspace=\"5\" align=\"left\" />ApPHP Medical Appointment Clinic</strong> is a full-service medical clinic with five Board Certified Family physicians, a Board Certified General/Gynecological Surgeon and four Board Certified mid-level providers (Physician’s Assistant &amp; Nurse Practitioners).<br /><br /><strong>Our Mission</strong><br />Our Clinic is a vital resource for this country and the surrounding area and provides state-of-the-art healthcare to improve our quality of life.</p>\n<p>Since 1981, the mission of the Our Foundation has been to promote and enhance the care available at the our Clinic by providing a vehicle whereby individuals and organizations can give gifts and memorials to fund current and ongoing needs. If you do not see the health-related web link, our contact information, brochure, news item or medical information you were hoping for on these pages, contact us at 123.456.7890 ext. 123 and she will be happy to help you track it down for you.</p>\n<h3>Electronic Health Records</h3>\n<p>To better manage the health needs of our patients, all three North Basin Medical Clinics use Electronic Health Records. To find out more about how this service works and the benefits to you, the patient, contact our Help Desk tel.: 1-800-123-45-67</p>\n<h3>Working Hours</h3>\n<p>Our Clinic is located on the Presidents Hospital Medical Campus at 100 North 3rd Street in our sity.<br /><br />Monday—Friday<br />9 am—5 pm<br /><br />Saturday <br />8 am—Noon<br /><br /></p>","0","","ApPHP Medical Appointment","php medical appointment","ApPHP Medical Appointment is an online doctor appointment PHP script.","1","0000-00-00 00:00:00","2014-01-13 16:41:12","0000-00-00","1","0","1","0","","1","2010-04-22 19:53:44","public","1");
INSERT INTO meda_pages VALUES("2","rdcsjq1xuq","es","article","","_self","Bienvenido-a-ApPHP-Medical-Appointment","Bienvenido a ApPHP Medical Appointment!","<p><strong><img style=\"width: 128px; height: 128px;\" src=\"images/upload/health_care.png\" border=\"0\" alt=\"icon\" hspace=\"5\" align=\"left\" />Clínica Médica ApPHP</strong> cita es una clínica de servicio completo con cinco médicos de familia Certificado por la Junta, un certificado por la Junta General / cirujano ginecológico y cuatro Certificado de nivel medio (asistente médico y enfermeras practicantes).<br /><br /><strong>Nuestra Misión</strong><br /> Nuestra clínica es un recurso vital para este país y la zona circundante y proporciona el estado de la técnica de salud para mejorar nuestra calidad de vida.</p>\n<p>Desde 1981, la misión de la Nuestra Fundación ha sido la de promover y mejorar la atención disponible en la nuestra Clínica, proporcionando un vehículo mediante el cual los individuos y las organizaciones pueden dar regalos y recuerdos para financiar las necesidades actuales y en curso. Si usted no ve la salud relacionados con el enlace web, nuestra información de contacto, folletos, noticia o información médica que usted esperaba en estas páginas, en contacto con nosotros en el 123.456.7890 ext. 123 y que estará encantado de ayudarle a localizar para usted.</p>\n<h3>Registros Electrónicos de Salud</h3>\n<p>Para manejar mejor las necesidades de salud de nuestros pacientes, los tres del Norte de la Cuenca Clínicas Médicas uso de registros electrónicos de salud. Para saber más sobre cómo funciona este servicio y los beneficios para usted, el paciente, en contacto con nuestro servicio de asistencia tel:. 1-800-123-45-67</p>\n<h3>Horas de trabajo</h3>\n<p>Nuestra clínica está ubicada en el Campus Médico del Hospital de Presidentes en 100 North 3rd Street en nuestro dad.<br /><br />Lunes - Viernes<br />9 a.m.-5 p.m.<br /><br />Sábado <br />8 am-mediodía<br /><br /></p>","0","","ApPHP Medical Appointment","php medical appointment","Nombramiento ApPHP médica es una cita en línea doctor script PHP.","0","0000-00-00 00:00:00","2014-01-13 16:41:24","0000-00-00","1","0","1","0","","1","2010-04-21 19:53:41","public","0");
INSERT INTO meda_pages VALUES("3","rdcsjq1xuq","de","article","","_self","Willkommen-auf-Medical-Appointment","Willkommen auf Medical Appointment!","<p><strong><img style=\"width: 128px; height: 128px;\" src=\"images/upload/health_care.png\" border=\"0\" alt=\"icon\" hspace=\"5\" align=\"left\" />ApPHP Medical Appointment Clinic</strong> ist ein Full-Service-medizinischen Klinik mit fünf Board Certified Hausärzte, ein Board Certified General / Gynäkologische Chirurgie und vier Board Certified Mid-Level-Provider (Arzthelferin &amp; Nurse Practitioners).<br /><br /><strong>Unsere Mission</strong><br />Unsere Klinik ist eine lebenswichtige Ressource für dieses Land und die Umgebung und bietet State-of-the-art im Gesundheitswesen, um unsere Lebensqualität zu verbessern.</p>\n<p>Seit 1981 hat die Mission der Stiftung war es, unsere Förderung und Stärkung der Pflege zur Verfügung an der unsere Klinik durch die Bereitstellung eines Fahrzeugs, wodurch Personen und Organisationen, Geschenke und Andenken geben können, um aktuelle und laufende Bedürfnisse zu finanzieren. Wenn Sie nicht sehen, der gesundheitsbezogenen Web-Link, unsere Kontaktdaten, eine Broschüre, eine Nachricht oder medizinische Informationen, die Sie für die auf diesen Seiten hofften, kontaktieren Sie uns unter 123.456.7890 ext. 123 und sie würden uns freuen, Ihnen helfen, sie aufspüren für Sie.</p>\n<h3>Electronic Health Records</h3>\n<p>Zur besseren Verwaltung der gesundheitlichen Bedürfnisse unserer Patienten verwenden alle drei Nordbecken Medizinische Kliniken Electronic Health Records. Wenn Sie mehr darüber, wie dieser Dienst funktioniert und die Vorteile für Sie als Patient, wenden Sie sich an unseren Help Desk Tel:. 1-800-123-45-67</p>\n<h3>Arbeitszeit</h3>\n<p>Unsere Klinik ist auf dem Präsidenten Hospital Medical Campus bei 100 North 3rd Street in unserer versität gelegen.<br /><br />Montag-Freitag<br />9.00 bis 05.00 Uhr<br /><br />Samstag <br />8 Uhr-Noon<br /><br /></p>","0","","ApPHP Medical Appointment","php medical appointment","ApPHP Arzttermin ist ein Online-Arzttermin PHP-Skript.","0","0000-00-00 00:00:00","2014-01-13 16:41:31","0000-00-00","1","0","1","0","","1","2010-04-22 19:53:44","public","1");
INSERT INTO meda_pages VALUES("4","0cinfj2dbs","en","article","","_self","About-Us","About Us","<p>{module:about_us}</p>","0","About Us","About Us | ApPHP Medical Appointment","php medical appointment","ApPHP Medical Appointment is an online doctor appointment PHP script.","0","2012-01-31 23:09:04","2014-03-13 18:31:03","0000-00-00","0","0","1","1","about_us","1","0000-00-00 00:00:00","public","3");
INSERT INTO meda_pages VALUES("5","0cinfj2dbs","es","article","","_self","Quiénes-somos","Quiénes somos","<p>{module:about_us}</p>","0","Quiénes somos","Quiénes somos | ApPHP Medical Appointment","php medical appointment","Nombramiento ApPHP médica es una cita en línea doctor script PHP.","0","2012-01-31 23:09:04","2014-03-13 18:32:14","0000-00-00","0","0","1","1","about_us","1","0000-00-00 00:00:00","public","3");
INSERT INTO meda_pages VALUES("6","0cinfj2dbs","de","article","","_self","Über-uns","Über uns","<p>{module:about_us}</p>","0","Über uns","Über uns | ApPHP Medical Appointment","php medical appointment","ApPHP Arzttermin ist ein Online-Arzttermin PHP-Skript.","0","2012-01-31 23:09:04","2014-03-13 18:33:15","0000-00-00","0","0","1","1","about_us","1","0000-00-00 00:00:00","public","3");
INSERT INTO meda_pages VALUES("7","0vc7nm71h4","en","article","","_self","Privacy-Policy-example","Privacy Policy (example)","<h3>1. Introduction</h3>\n<p>ApPHP Medical Appointment, Inc. (\"us\", \"we\" or \"ApPHP Medical Appointment\") is committed to respecting the privacy rights of our customers, visitors, and other users of our services (\"Services\") provided via this website (collectively, \"Site\"). We created this Site Privacy Policy (\"Privacy Policy\") to give you confidence as you visit and use the Site, and to demonstrate our commitment to fair information practices and the protection of privacy. This Privacy Policy is only applicable to the Site, and not to any other websites that you may be able to access from the Site or any website of our partners, each of which may have data collection, storage, and use practices and policies that differ materially from this Privacy Policy. Your use of the Site is governed by this Privacy Policy and the Terms of Use. If you are registering an account or using the Site on behalf of an individual or entity other than yourself, you represent that you are authorized by such individual or entity to accept this Privacy Policy on such individual\'s or entity\'s behalf.</p>\n<h3>2. Cookies</h3>\n<p>\"Cookies\" are small computer files that are transferred to your computer\'s hard drive that contain information such as user ID, user preferences, lists of pages visited and activities conducted while browsing the Site. At your option, expense and responsibility, you may block cookies or delete cookies from your hard drive. However, by disabling cookies, you may not have access to the entire set of features of the Site. Generally, we use \"cookies\" to customize your experience on our Site and to store your password so you do not have to re-enter it each time you visit the Site.</p>\n<p> </p>\n<h3>3. Confidentiality and Security</h3>\n<p>Except as otherwise provided in this Privacy Policy, we will keep your Personal Information private and will not share it with third parties, unless we believe in good faith that disclosure of your Personal Information or any other information we collect about you is necessary to: (1) comply with a court order or other legal process ; (2) protect the rights, property or safety of our web site or another party; (3) enforce our Terms of Use; or (4) respond to claims that any posting or other content violates the rights of third-parties.</p>\n<h3>4. Lost or Stolen Information</h3>\n<p>You must promptly notify us if your Contact Data is lost, stolen, or used without permission. In such an event, we will remove that Contact Data from your account and update our records accordingly.</p>\n<h3>5. Links to Other Websites</h3>\n<p>The Site contains links to third party websites to which we have no affiliation. We don\'t share your personal information with those websites and is not responsible for their privacy practices. Some web sites may have the look and feel of our Site. Please be aware that you may be on a different site and that this Privacy Policy only covers our Site. Should you decide to visit one of these third party websites, we suggest that you read its privacy policy.</p>","0","Privacy Policy","Privacy Policy | ApPHP Medical Appointment","php medical appointment","ApPHP Medical Appointment is an online doctor appointment PHP script.","0","2012-02-16 18:21:15","2014-03-13 18:31:25","0000-00-00","0","0","1","1","privacy_policy","1","0000-00-00 00:00:00","public","5");
INSERT INTO meda_pages VALUES("8","0vc7nm71h4","es","article","","_self","Política-de-Privacidad-ejemplo","Política de Privacidad (ejemplo)","<h3>1. Introducción</h3>\n<p>ApPHP Médica Nombramiento, Inc. (\"nosotros\", \"nosotros\" o \"Cita ApPHP médico\") se compromete a respetar los derechos de privacidad de nuestros clientes, visitantes y otros usuarios de nuestros servicios (\"Servicios\"), siempre a través de este sitio web (colectivamente, el \"Sitio\"). Hemos creado esta Política de Privacidad del Sitio (\"Política de Privacidad\") para darle confianza al visitar y utilizar el Sitio, y para demostrar nuestro compromiso con las prácticas justas de información y la protección de la intimidad. Esta política de privacidad sólo es aplicable al Sitio, y no a otros sitios web que usted puede ser capaz de acceder desde el Sitio o cualquier sitio web de nuestros socios, cada uno de ellos puede tener la recopilación de datos, almacenamiento y prácticas de uso y las políticas que difieren materialmente de esta Política de Privacidad. La utilización del Sitio se rige por esta Política de Privacidad y los Términos de uso. Si usted se está registrando una cuenta o utilizar el Sitio, en nombre de una persona o entidad que no sea usted, usted declara que está autorizado por dicha persona física o entidad a aceptar esta Política de Privacidad de dicha persona física o nombre de la entidad.</p>\n<h3>2. Galletas</h3>\n<p>Las \"cookies\" son pequeños archivos que se transfieren al disco duro de su computadora que contienen información como el ID de usuario, preferencias de los usuarios, listas de páginas visitadas y las actividades realizadas durante la navegación del sitio. A su elección, el gasto y la responsabilidad, puede bloquear las cookies o borrar las cookies de su disco duro. Sin embargo, mediante la desactivación de las cookies, no podrá tener acceso a todo el conjunto de elementos de la Web. Generalmente, utilizamos cookies para personalizar su experiencia en nuestro sitio y para almacenar su contraseña para que no tenga que volver a escribirla cada vez que visite el sitio.</p>\n<p> </p>\n<h3>3. Confidencialidad y Seguridad</h3>\n<p>Salvo disposición en contrario en esta Política de Privacidad, mantendremos su Información Personal en privado y no será compartida con terceros, a menos que creamos de buena fe que la divulgación de su información personal o cualquier otra información que recopilamos sobre usted es necesaria para: (1) cumplir con una orden judicial u otro proceso legal, (2) proteger los derechos, propiedad o seguridad de nuestro sitio web o de un tercero, (3) hacer cumplir nuestras Condiciones de Uso, o (4) responder a reclamos de que cualquier publicación o otro contenido viola los derechos de terceros.</p>\n<h3>4. La información perdida o robada</h3>\n<p>Usted deberá notificarnos si sus datos de contacto se ha perdido, robado o usado sin permiso. En tal caso, vamos a eliminar que los datos de contacto de su cuenta y actualizar sus datos de acuerdo.</p>\n<h3>5. Los enlaces a otros sitios web</h3>\n<p>El sitio contiene enlaces a sitios web de terceros a los que no tenemos ninguna afiliación. Nosotros no compartimos su información personal con estos sitios web y no es responsable de sus prácticas de privacidad. Algunos sitios web pueden tener la apariencia de nuestro sitio. Tenga en cuenta que usted puede estar en un sitio diferente y que esta política de privacidad sólo cubre nuestro sitio. Si usted decide visitar uno de estos sitios web de terceros, le sugerimos que lea su política de privacidad.</p>","0","Política de Privacidad","Política de Privacidad | ApPHP Medical Appointment","php medical appointment","Nombramiento ApPHP médica es una cita en línea doctor script PHP.","0","2012-02-16 18:21:15","2014-03-13 18:32:32","0000-00-00","0","0","1","1","privacy_policy","1","0000-00-00 00:00:00","public","5");
INSERT INTO meda_pages VALUES("9","0vc7nm71h4","de","article","","_self","Datenschutz-Beispiel","Datenschutz (Beispiel)","<h3>1. Einführung</h3>\n<p>ApPHP Arzttermin, Inc. (\"uns\", \"wir\" oder \"ApPHP Arzttermin\") wird zur Einhaltung der Privatsphäre unserer Kunden, Besucher und andere Nutzer unserer Dienste (\"Services\") bereitgestellt und über diese Website verpflichtet (zusammenfassend als \"Site\"). Wir haben diese Website Datenschutz (\"Privacy Policy\"), um Ihnen das Vertrauen, wie Sie und besuchen Sie die Website zu nutzen, und um unser Engagement für fairen Umgang mit Daten und den Schutz der Privatsphäre zu demonstrieren. Diese Datenschutzerklärung gilt nur für die Website und nicht für alle anderen Websites, die Sie in der Lage, von der Site oder einer anderen Website von unseren Partnern, von denen jede Datensammlung, Speicherung und Nutzung Praktiken und Politiken, die sich unterscheiden haben, Zugang wesentlich von dieser Datenschutzerklärung. Ihre Nutzung der Website wird von dieser Datenschutzrichtlinie und den Nutzungsbedingungen geregelt. Wenn Sie Registrierung eines Accounts oder der Nutzung der Website im Namen einer natürlichen oder juristischen Person außer Ihnen selbst erklären Sie, dass Sie durch eine solche natürliche oder juristische Person berechtigt, diesen Datenschutzrichtlinien, die auf individuelle oder juristische Person, im Namen annehmen.</p>\n<h3>2. Kekse</h3>\n<p>\"Cookies\" sind kleine Computerdateien, die auf Ihre Festplatte des Computers, die Informationen wie Benutzer-ID enthalten, übertragen werden, Benutzereinstellungen, besuchte Seiten und Listen von Aktivitäten durchgeführt, während Sie die Website. Auf Ihren Wunsch, Kosten und Verantwortung, können Sie Cookies blockieren oder löschen, Cookies von Ihrer Festplatte. Jedoch durch die Deaktivierung von Cookies, können Sie keinen Zugriff auf den gesamten Satz von Funktionen der Website. Im Allgemeinen verwenden wir \"Cookies\", um Ihre Erfahrung auf unserer Website anpassen und Ihr Kennwort zu speichern, so dass Sie nicht haben, um erneut eingeben bei jedem Besuch der Website.</p>\n<p> </p>\n<h3>3. Vertraulichkeit und Sicherheit</h3>\n<p>Sofern nicht anderweitig in dieser Datenschutzrichtlinie vorgesehen sind, werden Ihre persönlichen Daten vertraulich behandelt und nicht teilen Sie sie mit Dritten, sofern wir nicht in gutem Glauben, dass die Offenlegung Ihrer persönlichen Informationen oder jeder anderen von uns gesammelten Informationen über Sie ist notwendig, um zu glauben: (1) mit einer gerichtlichen Verfügung oder anderen rechtlichen Vorschriften nachzukommen, (2) die Rechte, das Eigentum oder die Sicherheit unserer Website oder einer anderen Partei, (3) Durchsetzung unserer Nutzungsbedingungen oder (4) auf Ansprüche, dass jeder Beitrag zu antworten oder anderer verletzt die Rechte Dritter.</p>\n<h3>4. Verlorene oder gestohlene Informationen</h3>\n<p>Sie müssen uns unverzüglich mitteilen, wenn Ihr Kontakt Daten verloren gehen, gestohlen, oder ohne Erlaubnis benutzt. In einem solchen Fall, werden wir diese Kontaktdaten aus Ihrem Konto zu entfernen und überarbeiten unsere Aufzeichnungen entsprechend.</p>\n<h3>5. Links zu anderen Websites</h3>\n<p>Die Site enthält Links zu externen Webseiten Dritter, auf die wir haben keine Verbindung. Wir teilen nicht Ihre persönlichen Daten an diese Websites und ist nicht verantwortlich für die Einhaltung der Datenschutzbestimmungen. Einige Websites können das Look and Feel unserer Website. Bitte beachten Sie, dass Sie möglicherweise auf einer anderen Website und dass diese Datenschutzrichtlinie nur für unsere Website sein. Sollten Sie sich entscheiden, eine dieser Websites Dritter zu besuchen, empfehlen wir Ihnen, die Datenschutzrichtlinie gelesen.</p>","0","Datenschutz","Datenschutz | ApPHP Medical Appointment","php medical appointment","ApPHP Arzttermin ist ein Online-Arzttermin PHP-Skript.","0","2012-02-16 18:21:15","2014-03-13 18:33:35","0000-00-00","0","0","1","1","privacy_policy","1","0000-00-00 00:00:00","public","5");
INSERT INTO meda_pages VALUES("10","sdsdsdsdsd","es","article","","_self","Instalación-de-ApPHP-Medical-Appointment","Instalación de ApPHP Medical Appointment","<div class=\"post\">\n<div><a name=\"Installation_of_PHP_Medical_Appointment\"></a>\n<p>(de la versión 2.0.0 o superior)</p>\n<p>Una instalación nueva de Cita Médica ApPHP es un proceso muy directa:</p>\n<a name=\"Step_1._Uncompressing_downloaded_file.\"></a>\n<h3><strong>Paso 1. Descomprimir el archivo descargado. </strong></h3>\n<hr />\nDescomprimir el archivo ApPHP cita médica. El archivo se creará un directorio llamado \"PHPMA_xxx\"\n<p> </p>\n<a name=\"Step_2._Uploading_files.\"></a>\n<h3><strong>Paso 2. Carga de archivos.</strong></h3>\n<hr />\nSube el contenido de esta carpeta (todos los archivos y directorios que incluye) a la raíz del documento (public_html, www, etc httpdocs) o con su médico-el nombramiento de directorio a través de FTP. Preste atención a NO usar las letras mayúsculas en el nombre de la carpeta (para usuarios de Linux).\n<p>por ejemplo:</p>\n<pre>public_html/</pre>\no\n<pre>public_html/{medical-appointment directory}/</pre>\n<p> </p>\n<a name=\"Step_3._Creating_database.\"></a>\n<h3><strong>Paso 3. Creación de base de datos.</strong></h3>\n<hr />\n<p>Usando el Panel de control de hosting, phpMyAdmin o cualquier otra herramienta, crear su base de datos y el usuario, y asignar a ese usuario a la base de datos. Anote el nombre de la base de datos, nombre de usuario y una contraseña para el procedimiento de instalación del sitio.</p>\n<p> </p>\n<a name=\"Step_4._Settings_and_access_rights.\"></a>\n<h3><strong>Paso 4. Configuración y derechos de acceso.</strong></h3>\n<hr />\n<p>4.1 Compruebe los permisos de acceso a las imágenes / uploads / y wysiwyg / addons / Biblioteca de Imágenes /. Usted tiene que configurar los derechos de 755 en estas carpetas. También puedes ver si el script está disponible para cambiar los permisos para incluir / carpeta. Si no es así - establecer manualmente 777 derechos a esta carpeta y volver de nuevo a 755 después de la instalación se ha completado.<br /><br />4.2 Si ejecuta Cita Médica ApPHP en IIS, lo que tiene que permitir el modo de reescritura para Windows. Para ello, abra el archivo <strong>httpd.conf</strong> y descomentar las siguientes líneas (quitar el final # s):</p>\n<pre>#LoadModule rewrite_module modules/mod_rewrite.so<br />#AddModule mod_rewrite.c</pre>\n<p> </p>\n<p> </p>\n<a name=\"Step_5._Running_install_file.\"></a>\n<h3><strong>Paso 5. Ejecutar el archivo install.php.</strong></h3>\n<hr />\n<p>Ahora se puede ejecutar el archivo install.php. Para ello, abra un navegador y escriba en la barra de direcciones</p>\n<pre>{www.mydomain.com}/install.php</pre>\nor\n<pre>{www.mydomain.com}/{medical-appointment directory}/install.php</pre>\n<br />Siga las instrucciones en la pantalla. Se le pedirá que introduzca: base de datos host, nombre de base de datos, nombre de usuario y contraseña. También es necesario introducir nombre de usuario admin y la contraseña de administrador, que se utiliza para obtener acceso al área de administración del sitio.\n<p> </p>\n<p> </p>\n<a name=\"Step_6._Deleting_install_files.\"></a>\n<h3><strong>Paso 6. Eliminar archivos de instalación.</strong></h3>\n<hr />\n<p>Después de la instalación usted recibirá un mensaje de advertencia adecuada y para eliminar el archivo install.php y install /. Por razones de seguridad, por favor borre inmediatamente.</p>\n<p> </p>\nFelicitaciones, ahora tiene una cita médica ApPHP instalado!</div>\n</div>","2","Instalación","Instalación | ApPHP Medical Appointment","php medical appointment","Nombramiento ApPHP médica es una cita en línea doctor script PHP.","0","0000-00-00 00:00:00","2014-03-13 17:47:26","0000-00-00","0","0","1","0","","1","0000-00-00 00:00:00","public","0");
INSERT INTO meda_pages VALUES("11","sdsdsdsdsd","de","article","","_self","Installation-von-ApPHP-Medical-Appointment","Installation von ApPHP Medical Appointment","<div class=\"post\">\n<div><a name=\"Installation_of_PHP_Medical_Appointment\"></a>\n<p>(für Version 2.0.0 oder höher)</p>\n<p>Eine Neuinstallation von ApPHP Arzttermin ist ein sehr geradlinig Prozess:</p>\n<a name=\"Step_1._Uncompressing_downloaded_file.\"></a>\n<h3><strong>Schritt 1. Dekomprimieren der heruntergeladenen Datei.</strong></h3>\n<hr />\n<p>Entpacken Sie die ApPHP Arzttermin Skript-Archiv. Das Archiv wird ein Verzeichnis namens \"PHPMA_xxx\"</p>\n<a name=\"Step_2._Uploading_files.\"></a>\n<h3><strong>Schritt 2. Hochladen von Dateien.</strong></h3>\n<hr />\n<p>Laden Sie den Inhalt dieses Ordners (alle Dateien und Verzeichnisse, es umfasst), um Ihre Dokumenten-Root (public_html, www, httpdocs etc.) oder Ihre medizinische Termin-Verzeichnis per FTP. Achten Sie NICHT verwenden, die Großbuchstaben im Namen des Ordners (für Linux-Anwender).</p>\n<p>zum Beispiel:</p>\n<pre>public_html/</pre>\n<span style=\"font-family: \'Courier New\';\">oder</span>\n<pre>public_html/{medical-appointment directory}/ <br /> </pre>\n<a name=\"Step_3._Creating_database.\"></a>\n<h3><strong>Schritt 3. Erstellen Datenbank.</strong></h3>\n<hr />\n<p>Mit Ihrem Hosting Control Panel, phpMyAdmin oder einem anderen Tool, erstellen Sie Ihre Datenbank und Benutzer, und weisen Sie diesen Benutzer in der Datenbank. Notieren Sie den Namen der Datenbank, den Benutzernamen und Kennwort für die Installation vor Ort Verfahren.</p>\n<a name=\"Step_4._Settings_and_access_rights.\"></a>\n<h3><strong>Schritt 4. Einstellungen und Zugriffsrechte.</strong></h3>\n<hr />\n<p>4.1. Überprüfen Sie die Zugriffsberechtigungen auf <strong>images/uploads/</strong> und <strong>wysiwyg/addons/imagelibrary/</strong>. Sie haben die Einrichtung 755 Rechte auf diese Ordner. Prüfen Sie auch, ob Ihr Skript zur Verfügung steht, um Berechtigungen zu ändern / Ordner gehören. Wenn nicht - manuell einstellen 777 Rechte auf dem Ordner auf und schickt sie zurück auf 755, nachdem die Installation abgeschlossen wurde.<br /><br />4.2. Wenn Sie ApPHP Arzttermin auf IIS laufen, müssen Sie Rewrite-Modus für Windows zu ermöglichen. Um dies zu tun, öffnen Sie die Datei httpd.conf und kommentieren Sie die folgenden Zeilen (entfernen Sie die hintere #s):</p>\n<pre>#LoadModule rewrite_module modules/mod_rewrite.so<br />#AddModule mod_rewrite.c <br />  </pre>\n<a name=\"Step_5._Running_install_file.\"></a>\n<h3><strong>Schritt 5. Running install.php.</strong></h3>\n<hr />\n<p><span style=\"font-family: \'Courier New\';\">Jetzt können Sie install.php-Datei. Um dies zu tun, öffnen Sie einen Browser und geben Address Bar</span></p>\n<pre>{www.mydomain.com}/install.php</pre>\noder\n<pre>{www.mydomain.com}/{medical-appointment directory}/install.php<br /></pre>\n<br />Befolgen Sie die Anweisungen auf dem Bildschirm. Sie werden aufgefordert, einzugeben: Datenbank-Host, Datenbankname, Benutzername und Passwort. Auch müssen Sie Administrator-Benutzernamen und Admin-Passwort, mit dem der Zugriff auf Administrationsbereich der Website erhalten werden geben. <br /> <a name=\"Step_6._Deleting_install_files.\"></a>\n<h3><strong>Schritt 6. Löschen von Installationsdateien.</strong></h3>\n<hr />\n<p>Nach erfolgreicher Installation erhalten Sie eine entsprechende Meldung und Warnung an die install.php Datei zu entfernen und zu installieren / Verzeichnis. Aus Sicherheitsgründen, bitte löschen Sie sie sofort.</p>\nHerzlichen Glückwunsch, Sie haben jetzt ApPHP Arzttermin installiert!</div>\n</div>","3","Installation","Installation | ApPHP Medical Appointment","php medical appointment","ApPHP Arzttermin ist ein Online-Arzttermin PHP-Skript.","0","0000-00-00 00:00:00","2014-03-13 17:48:29","0000-00-00","0","0","1","0","","1","0000-00-00 00:00:00","public","0");
INSERT INTO meda_pages VALUES("12","sdsdsdsdsd","en","article","","_self","Installation-of-ApPHP-Medical-Appointment","Installation of ApPHP Medical Appointment","<div class=\"post\"><a name=\"Installation_of_PHP_Medical_Appointment\"></a>\n<p>(for version 2.0.0 or above)</p>\n<p>A new installation of ApPHP Medical Appointment is a very straight forward process:</p>\n<a name=\"Step_1._Uncompressing_downloaded_file.\"></a>\n<h3><strong>Step 1. Uncompressing downloaded file.</strong> \n<hr />\n</h3>\n<p>Uncompress the ApPHP Medical Appointment script archive. The archive will create a directory called \"PHPMA_xxx\"</p>\n<a name=\"Step_2._Uploading_files.\"></a>\n<h3><strong>Step 2. Uploading files.</strong> \n<hr />\n</h3>\n<p>Upload content of this folder (all files and directories it includes) to your document root (public_html, www, httpdocs etc.) or your medical-appointment directory using FTP. Pay attention to DON\'T use the capital letters in the name of the folder (for Linux users).</p>\n<p>For example:</p>\n<div>\n<pre>public_html/</pre>\n</div>\n<div>or</div>\n<div>\n<pre>public_html/{medical-appointment directory}/</pre>\n</div>\n<p> </p>\n<a name=\"Step_3._Creating_database.\"></a>\n<h3><strong>Step 3. Creating database.</strong> \n<hr />\n</h3>\n<p>Using your hosting Control Panel, phpMyAdmin or another tool, create your database and user, and assign that user to the database. Write down the name of the database, username, and password for the site installation procedure.</p>\n<a name=\"Step_4._Settings_and_access_rights.\"></a>\n<h3><strong>Step 4. Settings and access rights.</strong> \n<hr />\n</h3>\n<p>4.1. Check access permissions to <strong>images/uploads/</strong> and <strong>wysiwyg/addons/imagelibrary/</strong>. You have to set up 755 rights to these folders. Also check if your script is available to change permissions to <strong>include/</strong> folder. If not - set manually 777 rights to this folder and return them back to 755 after the installation was completed.<br /><br />4.2. If you run ApPHP Medical Appointment on IIS, you have to allow rewrite mode for Windows. To do this, open the <strong>httpd.conf</strong> file and uncomment the following lines (remove the trailing #s):</p>\n<div>\n<pre>#LoadModule rewrite_module modules/mod_rewrite.so<br />#AddModule mod_rewrite.c<br /> </pre>\n</div>\n<a name=\"Step_5._Running_install_file.\"></a>\n<h3><strong>Step 5. Running install.php file.</strong> \n<hr />\n</h3>\n<p>Now you can run install.php file. To do this, open a browser and type in Address Bar</p>\n<div>\n<pre>{www.mydomain.com}/install.php</pre>\n</div>\n<div>or</div>\n<div>\n<pre>{www.mydomain.com}/{medical-appointment directory}/install.php</pre>\n</div>\n<br />\n<div>Follow instructions on the screen. You will be asked to enter: database host, database name, username and password. Also you need to enter admin username and admin password, that will be used to get access to administration area of the site.</div>\n<a name=\"Step_6._Deleting_install_files.\"></a>\n<h3><strong>Step 6. Deleting installation files.</strong> \n<hr />\n</h3>\n<p>After successful installation you will get an appropriate message and warning to remove install.php file and install/ directory. For security reasons, please delete them immediately.</p>\n<p> </p>\n<div>Congratulations, you now have ApPHP Medical Appointment installed!</div>\n</div>","1","Installation","Installation | ApPHP Medical Appointment","php medical appointment","ApPHP Medical Appointment is an online doctor appointment PHP script.","0","0000-00-00 00:00:00","2014-03-13 17:46:14","0000-00-00","0","1","0","0","","1","2014-09-16 06:27:26","public","0");
INSERT INTO meda_pages VALUES("13","mwsipvfgel","de","article","","_self","Kontakt","Kontakt","<p>Bitte benutzen Sie das folgende Formular Kontakt mit uns auf:<br /><br />{module:contact_us}</p>","0","Kontakt","Kontakt | ApPHP Medical Appointment","php medical appointment","ApPHP Arzttermin ist ein Online-Arzttermin PHP-Skript.","0","0000-00-00 00:00:00","2014-03-13 18:33:23","0000-00-00","0","0","1","1","contact_us","1","0000-00-00 00:00:00","public","4");
INSERT INTO meda_pages VALUES("14","mwsipvfgel","en","article","","_self","Contact-Us","Contact Us","<p>Please use the form below to contact us:</p>\n<p>{module:contact_us}</p>","0","Contact Us","Contact Us | ApPHP Medical Appointment","php medical appointment","ApPHP Medical Appointment is an online doctor appointment PHP script.","0","0000-00-00 00:00:00","2014-03-13 18:31:15","0000-00-00","0","0","1","1","contact_us","1","0000-00-00 00:00:00","public","4");
INSERT INTO meda_pages VALUES("15","mwsipvfgel","es","article","","_self","Contáctenos","Contáctenos","<p>Por favor, utilice el siguiente formulario para contactar con nosotros:<br /><br />{module:contact_us}</p>","0","Contáctenos","Contáctenos | ApPHP Medical Appointment","php medical appointment","Nombramiento ApPHP médica es una cita en línea doctor script PHP.","0","0000-00-00 00:00:00","2014-03-13 18:32:23","0000-00-00","0","0","1","1","contact_us","1","0000-00-00 00:00:00","public","4");
INSERT INTO meda_pages VALUES("16","swedcfrtyu","en","article","","_self","Gallery","Gallery","<p>This is our gallery:</p>\n<p>{module:gallery}<br /><br /></p>","0","Gallery","Gallery | ApPHP Medical Appointment","php medical appointment","ApPHP Medical Appointment is an online doctor appointment PHP script.","0","0000-00-00 00:00:00","2014-03-13 18:30:41","0000-00-00","0","0","1","1","gallery","1","0000-00-00 00:00:00","public","1");
INSERT INTO meda_pages VALUES("17","swedcfrtyu","es","article","","_self","Gallery","Gallery","<p>Esta es nuestra galería:<br /><br />{module:gallery}</p>","0","Gallery","Gallery | ApPHP Medical Appointment","php medical appointment","Nombramiento ApPHP médica es una cita en línea doctor script PHP.","0","0000-00-00 00:00:00","2014-03-13 18:31:57","0000-00-00","0","0","1","1","gallery","1","0000-00-00 00:00:00","public","1");
INSERT INTO meda_pages VALUES("18","swedcfrtyu","de","article","","_self","Gallery","Gallery","<p>Dies ist unsere Galerie:<br /><br />{module:gallery}</p>","0","Gallery","Gallery | ApPHP Medical Appointment","php medical appointment","ApPHP Arzttermin ist ein Online-Arzttermin PHP-Skript.","0","0000-00-00 00:00:00","2014-03-13 18:32:53","0000-00-00","0","0","1","1","gallery","1","0000-00-00 00:00:00","public","1");
INSERT INTO meda_pages VALUES("19","99fnhie8in","en","article","","_self","Page-with-comments","Page with comments","<p>This an example of page with comments. <br />You may leave your comments here:</p>","1","Page with comments","Page with comments | ApPHP Medical Appointment","php medical appointment","ApPHP Medical Appointment is an online doctor appointment PHP script.","1","0000-00-00 00:00:00","2014-03-13 17:46:28","0000-00-00","0","1","0","0","","1","2014-09-16 06:27:28","public","3");
INSERT INTO meda_pages VALUES("20","99fnhie8in","es","article","","_self","Página-con-comentarios","Página con comentarios","<P>Este ejemplo de una página con comentarios.<BR>Usted puede dejar aquí sus comentarios:</P>","2","Página con comentarios","ApPHP Medical Appointment","php medical appointment","Nombramiento ApPHP médica es una cita en línea doctor script PHP.","1","0000-00-00 00:00:00","2012-02-05 23:37:18","0000-00-00","0","0","1","0","","1","0000-00-00 00:00:00","public","3");
INSERT INTO meda_pages VALUES("21","99fnhie8in","de","article","","_self","Seite-mit-Kommentaren","Seite mit Kommentaren","<p>Dies ist ein Beispiel der Seite mit Kommentaren.<br />Sie können Ihre Kommentare hier hinterlassen:</p>","3","Seite mit Kommentaren","Kommentaren | ApPHP Medical Appointment","php medical appointment","ApPHP Arzttermin ist ein Online-Arzttermin PHP-Skript.","1","0000-00-00 00:00:00","2014-03-13 17:48:42","0000-00-00","0","0","1","0","","1","0000-00-00 00:00:00","public","3");
INSERT INTO meda_pages VALUES("22","j8hevfivri","en","article","","_self","Terms-and-Conditions-Sample","Terms and Conditions Sample","<h3>Website usage terms and conditions - sample template</h3>\n<p>Welcome to our website. If you continue to browse and use this website, you are agreeing to comply with and be bound by the following terms and conditions of use, which together with our privacy policy govern [business name]\'s relationship with you in relation to this website. If you disagree with any part of these terms and conditions, please do not use our website.</p>\n<p>The term \"[business name]\" or \"us\" or \"we\" refers to the owner of the website whose registered office is [address]. Our company registration number is [company registration number and place of registration]. The term \"you\" refers to the user or viewer of our website.</p>\n<p>The use of this website is subject to the following terms of use:</p>\n<ul>\n<li>The content of the pages of this website is for your general information and use only. It is subject to change without notice. </li>\n<li>Neither we nor any third parties provide any warranty or guarantee as to the accuracy, timeliness, performance, completeness or suitability of the information and materials found or offered on this website for any particular purpose. You acknowledge that such information and materials may contain inaccuracies or errors and we expressly exclude liability for any such inaccuracies or errors to the fullest extent permitted by law. </li>\n<li>Your use of any information or materials on this website is entirely at your own risk, for which we shall not be liable. It shall be your own responsibility to ensure that any products, services or information available through this website meet your specific requirements. </li>\n<li>This website contains material which is owned by or licensed to us. This material includes, but is not limited to, the design, layout, look, appearance and graphics. Reproduction is prohibited other than in accordance with the copyright notice, which forms part of these terms and conditions. </li>\n<li>All trademarks reproduced in this website, which are not the property of, or licensed to the operator, are acknowledged on the website. </li>\n<li>Unauthorised use of this website may give rise to a claim for damages and/or be a criminal offence. </li>\n<li>From time to time, this website may also include links to other websites. These links are provided for your convenience to provide further information. They do not signify that we endorse the website(s). We have no responsibility for the content of the linked website(s). </li>\n<li>Your use of this website and any dispute arising out of such use of the website is subject to the laws of England, Northern Ireland, Scotland and Wales.</li>\n</ul>","0","Terms and Conditions","Terms and Conditions | ApPHP Medical Appointment","php medical appointment","ApPHP Medical Appointment is an online doctor appointment PHP script.","0","2011-03-22 16:36:17","2014-03-13 18:30:31","0000-00-00","0","0","1","1","terms_and_conditions","1","0000-00-00 00:00:00","public","0");
INSERT INTO meda_pages VALUES("23","j8hevfivri","es","article","","_self","Términos-y-Condiciones","Términos y Condiciones","<h2>Términos y Condiciones de muestra</h2>\n<h3>Términos del sitio web de uso y condiciones - plantilla de ejemplo</h3>\n<p>Bienvenido a nuestro sitio web. Si continúa navegando y utilizando este sitio web, usted acepta cumplir y estar obligado por los siguientes términos y condiciones de uso, que junto con nuestra política de privacidad gobiernan la relación de las empresas [nombre] \'s con usted en relación a este sitio web. Si no está de acuerdo con alguna parte de estos términos y condiciones, por favor no utilice nuestro sitio web.</p>\n<p>El término \"[nombre de la empresa]\" o \"nosotros\" se refiere a la titular del sitio web cuyo domicilio social es [dirección]. Nuestro número de registro de la empresa es [número de registro de la empresa y lugar de registro]. El término \"usted\" se refiere al usuario o visitante de nuestro sitio web.</p>\n<p>El uso de este sitio web está sujeta a las siguientes condiciones de uso:</p>\n<ul>\n<li>El contenido de las páginas de este sitio web es para su información y uso general. Está sujeto a cambios sin previo aviso. </li>\n<li>Ni nosotros ni ningún tercero ofrece ninguna garantía en cuanto a la exactitud, puntualidad, rendimiento, integridad o adecuación de la información y los materiales encontrados u ofrecidos en este sitio para cualquier propósito en particular. Usted reconoce que dicha información y materiales pueden contener inexactitudes o errores y expreso excluimos la responsabilidad por cualquier inexactitud o errores en la máxima medida permitida por la ley. </li>\n<li>El uso de cualquier información o materiales contenidos en este sitio web es bajo su propio riesgo, para lo cual no se hace responsable. Será su responsabilidad para garantizar que cualquier producto, servicio o información disponible a través de este sitio Web a sus necesidades específicas. </li>\n<li>Este sitio web contiene material que es propiedad de o licenciadas a nosotros. Este material incluye, pero no limitado a, el diseño, el diseño, apariencia y gráficos. La reproducción está prohibida salvo de conformidad con la nota de copyright, que forma parte de estos términos y condiciones. </li>\n<li>Todas las marcas reproducidas en esta página web, que no son propiedad de, o con licencia para el operador, se reconoció en la página web. </li>\n<li>El uso no autorizado de este sitio web puede dar lugar a una reclamación por daños y perjuicios y/o constituir un delito. </li>\n<li>De vez en cuando, este sitio web puede incluir enlaces a otros sitios web. Estos vínculos se proporcionan para su conveniencia para proporcionar más información. Esto no significa que estamos de acuerdo con el sitio web (s). No tenemos ninguna responsabilidad sobre el contenido del sitio web vinculado (s). </li>\n<li>El uso de este sitio web y cualquier disputa que surja de ese uso de la página web está sujeto a las leyes de Inglaterra, Irlanda del Norte, Escocia y Gales.</li>\n</ul>","0","Términos y Condiciones","Términos y Condiciones | ApPHP Medical Appointment","php medical appointment","Nombramiento ApPHP médica es una cita en línea doctor script PHP.","0","2011-03-22 16:36:17","2014-03-13 18:31:47","0000-00-00","0","0","1","1","terms_and_conditions","1","0000-00-00 00:00:00","public","0");
INSERT INTO meda_pages VALUES("24","j8hevfivri","de","article","","_self","Allgemeine-Geschäftsbedingungen","Allgemeine Geschäftsbedingungen","<h2>AGB Sample</h2>\n<h3>Website-Nutzung Geschäftsbedingungen - Mustervorlage</h3>\n<p>Willkommen auf unserer Website. Wenn Sie zu durchsuchen und weiter die Nutzung dieser Website erklären Sie sich zur Einhaltung und durch die folgenden Bedingungen verwenden, die zusammen mit unserer Datenschutzerklärung regieren [Firmenname]\'s Beziehung mit Ihnen in Zusammenhang mit dieser Website gebunden werden. Wenn Sie mit irgendeinem Teil dieser Bedingungen und Konditionen nicht einverstanden sind, benutzen Sie bitte nicht unsere Website.</p>\n<p>Der Begriff \"[Firmenname]\" oder \"uns\" oder \"wir\" bezieht sich auf die Eigentümer der Website Sitz [Adresse]. Unsere Firma Registriernummer ist [Registernummer und Ort der Eintragung]. Der Begriff \"Sie\" bezieht sich auf den Benutzer oder Betrachter unserer Website.</p>\n<p>Die Nutzung dieser Website unterliegt den folgenden Nutzungsbedingungen:</p>\n<ul>\n<li>Der Inhalt der Seiten dieser Website dient der allgemeinen Information und Verwendung. Es ist jederzeit ohne vorherige Ankündigung ändern. </li>\n<li>Weder wir noch Dritte eine Gewähr oder Garantie für die Richtigkeit, Aktualität, Leistung, Vollständigkeit oder Angemessenheit der Informationen und Materialien angeboten oder auf dieser Website für irgendeinen bestimmten Zweck. Sie bestätigen, dass solche Informationen und Materialien Ungenauigkeiten oder Fehler enthalten, und wir schließen ausdrücklich jede Haftung für derartige Ungenauigkeiten oder Fehler, die, soweit dies gesetzlich zulässig. </li>\n<li>Ihre Nutzung der Informationen oder Materialien auf dieser Website erfolgt auf eigene Gefahr, für die wir nicht haftbar gemacht werden. Es ist Ihre eigene Verantwortung sicherzustellen, dass alle Produkte, Dienstleistungen oder Informationen über diese Website erhältlich Ihren spezifischen Anforderungen gerecht werden. </li>\n<li>Diese Website enthält Material, das Eigentum oder lizenziert für uns. Dieses Material beinhaltet, ist aber nicht beschränkt auf das Design, Layout, Aussehen, Erscheinungsbild und Grafiken. Reproduktion ist verboten, ausgenommen in Übereinstimmung mit den Copyright-Vermerk, der Teil dieser Bedingungen und Konditionen Formen. </li>\n<li>Alle Warenzeichen auf dieser Website reproduziert, die nicht Eigentum von oder lizenziert für den Betreiber sind auf der Website bestätigt. </li>\n<li>Unerlaubte Benutzung dieser Website können zu einem Anspruch auf Schadensersatz und/oder eine Straftat. </li>\n<li>Von Zeit zu Zeit kann diese Website auch Links zu anderen Websites. Diese Links sind für Ihre Bequemlichkeit für ergänzende Auskünfte zur Verfügung gestellt. Sie bedeuten nicht, dass wir die Website (s) zu billigen. Wir haben keine Verantwortung für den Inhalt der verlinkten Website (s). </li>\n<li>Ihre Nutzung dieser Website und alle Streitigkeiten aus solchen Nutzung der Website unterliegt den Gesetzen von England, Nordirland, Schottland und Wales.</li>\n</ul>","0","Bedingungen","Bedingungen | ApPHP Medical Appointment","php medical appointment","ApPHP Arzttermin ist ein Online-Arzttermin PHP-Skript.","0","2011-03-22 16:36:17","2014-03-13 18:32:44","0000-00-00","0","0","1","1","terms_and_conditions","1","0000-00-00 00:00:00","public","0");
INSERT INTO meda_pages VALUES("25","92agzvkcxo","en","article","","_self","Search","Search","<p>&lt;script type=\"text/javascript\"&gt;var maJsHost = \"http://sun.ingagemd.com/\";var maJsKey = \"cgx1fos0yc\";var maJsWidth = \"215\";var maJsHeight = \"220\";document.write(unescape(\'%3Cscript src=\"\' + maJsHost + \'widgets/ipanel-left/main.js\" type=\"text/javascript\"%3E%3C/script%3E\'));&lt;/script&gt;</p>\n<p><span style=\"color: #222222; font-family: arial, verdana, sans-serif;\">\n<script type=\"text/javascript\">// <![CDATA[\nvar maJsHost = \"http://sun.ingagemd.com/\";var maJsKey = \"cgx1fos0yc\";var maJsWidth = \"215\";var maJsHeight = \"220\";document.write(unescape(\'%3Cscript src=\"\' + maJsHost + \'widgets/ipanel-left/main.js\" type=\"text/javascript\"%3E%3C/script%3E\'));\n// ]]></script>\n</span></p>","0","Search","Our Staff | ApPHP Medical Appointment","php medical appointment","ApPHP Medical Appointment is an online doctor appointment PHP script.","0","2012-02-23 18:30:28","2015-01-03 18:23:28","0000-00-00","0","0","1","1","Search","1","0000-00-00 00:00:00","public","2");
INSERT INTO meda_pages VALUES("26","92agzvkcxo","es","article","","_self","Nuestro-Personal","Nuestro Personal","<p><span style=\"color: #222222; font-family: arial, verdana, sans-serif;\">{module:doctors}</span></p>","0","Nuestro Personal","Nuestro Personal | ApPHP Medical Appointment","php medical appointment","Nombramiento ApPHP médica es una cita en línea doctor script PHP.","0","2012-02-23 18:30:28","2014-03-13 18:32:05","0000-00-00","0","0","1","1","our_staff","1","0000-00-00 00:00:00","public","2");
INSERT INTO meda_pages VALUES("27","92agzvkcxo","de","article","","_self","Unsere-Mitarbeiter","Unsere Mitarbeiter","<p> </p>\n<p><span style=\"color: #222222; font-family: arial, verdana, sans-serif;\">{module:doctors}</span></p>","0","Unsere Mitarbeiter","Unsere Mitarbeiter | ApPHP Medical Appointment","php medical appointment","ApPHP Arzttermin ist ein Online-Arzttermin PHP-Skript.","0","2012-02-23 18:30:28","2014-03-13 18:33:03","0000-00-00","0","0","1","1","our_staff","1","0000-00-00 00:00:00","public","2");
INSERT INTO meda_pages VALUES("28","gvvz3r2k9s","en","article","","_self","Frequently-Asked-Questions","Frequently Asked Questions","<p><span><span>{module:faq}</span></span></p>","1","FAQ","FAQ | ApPHP Medical Appointment","php medical appointment","ApPHP Medical Appointment is an online doctor appointment PHP script.","0","2014-01-26 15:47:35","2014-03-13 17:46:46","0000-00-00","0","1","0","0","","1","2014-09-16 06:51:51","public","6");
INSERT INTO meda_pages VALUES("29","gvvz3r2k9s","es","article","","_self","Preguntas-más-frecuentes","Preguntas más frecuentes","<p><span>{module:faq}</span></p>","2","FAQ","FAQ | ApPHP Medical Appointment","php medical appointment","ApPHP Medical Appointment is an online doctor appointment PHP script.","0","2014-01-26 15:47:35","2014-03-13 17:48:08","0000-00-00","0","0","1","0","","1","0000-00-00 00:00:00","public","6");
INSERT INTO meda_pages VALUES("30","gvvz3r2k9s","de","article","","_self","Häufig-gestellte-Fragen","Häufig gestellte Fragen","<p><span>{module:faq}</span></p>","3","FAQ","FAQ | ApPHP Medical Appointment","php medical appointment","ApPHP Medical Appointment is an online doctor appointment PHP script.","0","2014-01-26 15:47:35","2014-03-13 17:48:51","0000-00-00","0","0","1","0","","1","0000-00-00 00:00:00","public","6");



DROP TABLE IF EXISTS meda_patient_groups;

CREATE TABLE `meda_patient_groups` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO meda_patient_groups VALUES("1","General","General purpose only");



DROP TABLE IF EXISTS meda_patients;

CREATE TABLE `meda_patients` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `group_id` int(10) unsigned NOT NULL DEFAULT '0',
  `first_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `last_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `gender` enum('m','f') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'm',
  `birth_date` date NOT NULL DEFAULT '0000-00-00',
  `company` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `b_address` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `b_address_2` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `b_city` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `b_state` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `b_country` varchar(2) COLLATE utf8_unicode_ci NOT NULL,
  `b_zipcode` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `phone` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `fax` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(70) COLLATE utf8_unicode_ci NOT NULL,
  `url` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `user_name` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `user_password` varchar(50) CHARACTER SET latin1 NOT NULL,
  `preferred_language` varchar(2) CHARACTER SET latin1 NOT NULL,
  `date_created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_lastlogin` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `registered_from_ip` varchar(15) CHARACTER SET latin1 NOT NULL,
  `last_logged_ip` varchar(15) CHARACTER SET latin1 NOT NULL DEFAULT '000.000.000.000',
  `email_notifications` tinyint(1) NOT NULL DEFAULT '0',
  `notification_status_changed` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `is_active` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0 - registration pending, 1 - active customer',
  `is_removed` tinyint(1) NOT NULL DEFAULT '0',
  `comments` text CHARACTER SET utf8 NOT NULL,
  `registration_code` varchar(20) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`id`),
  KEY `b_country` (`b_country`),
  KEY `status` (`is_active`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO meda_patients VALUES("1","0","Sunny","Chevli","m","1987-03-28","","123","","Surat","GJ","IN","395003","","","sunnychevli@gmail.com","","sunnychevli","e10adc3949ba59abbe56e057f20f883e","en","2014-09-17 06:23:31","2015-01-02 17:22:23","::1","12.71.53.98","1","0000-00-00 00:00:00","1","0","","");
INSERT INTO meda_patients VALUES("2","0","srini","vas","m","0000-00-00","ABC Pet Grooming","4205 Mowry ave","","Frmeont","CA","US","","","","srinione@gmail.com","","srinione","6c3a13a68375e52335ce66e9ea2ceafc","en","2015-01-03 09:52:41","2015-01-03 18:30:38","24.23.222.158","24.23.222.158","1","0000-00-00 00:00:00","1","0","","");



DROP TABLE IF EXISTS meda_privileges;

CREATE TABLE `meda_privileges` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `code` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO meda_privileges VALUES("1","add_menus","Add Menus","Add Menus on the site");
INSERT INTO meda_privileges VALUES("2","edit_menus","Edit Menus","Edit Menus on the site");
INSERT INTO meda_privileges VALUES("3","delete_menus","Delete Menus","Delete Menus from the site");
INSERT INTO meda_privileges VALUES("4","add_pages","Add Pages","Add Pages on the site");
INSERT INTO meda_privileges VALUES("5","edit_pages","Edit Pages","Edit Pages on the site");
INSERT INTO meda_privileges VALUES("6","delete_pages","Delete Pages","Delete Pages from the site");



DROP TABLE IF EXISTS meda_ratings_items;

CREATE TABLE `meda_ratings_items` (
  `item` varchar(200) NOT NULL DEFAULT '',
  `totalrate` int(10) NOT NULL DEFAULT '0',
  `nrrates` int(9) NOT NULL DEFAULT '1',
  PRIMARY KEY (`item`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;




DROP TABLE IF EXISTS meda_ratings_users;

CREATE TABLE `meda_ratings_users` (
  `day` int(2) DEFAULT NULL,
  `rater` varchar(15) DEFAULT NULL,
  `item` varchar(200) NOT NULL DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=utf8;




DROP TABLE IF EXISTS meda_role_privileges;

CREATE TABLE `meda_role_privileges` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `role_id` int(5) NOT NULL,
  `privilege_id` int(5) NOT NULL,
  `is_active` tinyint(1) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO meda_role_privileges VALUES("1","1","1","1");
INSERT INTO meda_role_privileges VALUES("2","1","2","1");
INSERT INTO meda_role_privileges VALUES("3","1","3","1");
INSERT INTO meda_role_privileges VALUES("4","1","4","1");
INSERT INTO meda_role_privileges VALUES("5","1","5","1");
INSERT INTO meda_role_privileges VALUES("6","1","6","1");
INSERT INTO meda_role_privileges VALUES("7","2","1","1");
INSERT INTO meda_role_privileges VALUES("8","2","2","1");
INSERT INTO meda_role_privileges VALUES("9","2","3","1");
INSERT INTO meda_role_privileges VALUES("10","2","4","1");
INSERT INTO meda_role_privileges VALUES("11","2","5","1");
INSERT INTO meda_role_privileges VALUES("12","2","6","1");
INSERT INTO meda_role_privileges VALUES("13","3","1","0");
INSERT INTO meda_role_privileges VALUES("14","3","2","1");
INSERT INTO meda_role_privileges VALUES("15","3","3","0");
INSERT INTO meda_role_privileges VALUES("16","3","4","0");
INSERT INTO meda_role_privileges VALUES("17","3","5","1");
INSERT INTO meda_role_privileges VALUES("18","3","6","0");



DROP TABLE IF EXISTS meda_roles;

CREATE TABLE `meda_roles` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `code` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO meda_roles VALUES("1","owner","Site Owner","Site Owner is the owner of the site, has all privileges and could not be removed.\n");
INSERT INTO meda_roles VALUES("2","mainadmin","Main Admin","The \"Main Administrator\" user has top privileges like Site Owner and may be removed only by him.");
INSERT INTO meda_roles VALUES("3","admin","Simple Admin","The \"Simple Admin\" is required to assist the Main Admins, has different privileges and may be created by Site Owner or Main Admins.");



DROP TABLE IF EXISTS meda_schedule_timeblocks;

CREATE TABLE `meda_schedule_timeblocks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `schedule_id` int(11) NOT NULL DEFAULT '0',
  `doctor_address_id` int(10) unsigned NOT NULL DEFAULT '0',
  `week_day` enum('1','2','3','4','5','6','7') CHARACTER SET latin1 NOT NULL DEFAULT '1',
  `time_from` time NOT NULL DEFAULT '00:00:00',
  `time_to` time NOT NULL DEFAULT '00:00:00',
  `time_slots` varchar(3) CHARACTER SET latin1 NOT NULL DEFAULT '15',
  PRIMARY KEY (`id`),
  KEY `schedule_id` (`schedule_id`)
) ENGINE=MyISAM AUTO_INCREMENT=43 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO meda_schedule_timeblocks VALUES("1","1","0","2","08:00:00","14:00:00","15");
INSERT INTO meda_schedule_timeblocks VALUES("2","1","0","2","15:00:00","20:00:00","20");
INSERT INTO meda_schedule_timeblocks VALUES("3","1","0","3","08:30:00","15:00:00","15");
INSERT INTO meda_schedule_timeblocks VALUES("4","1","0","5","08:00:00","14:00:00","15");
INSERT INTO meda_schedule_timeblocks VALUES("5","1","0","4","10:00:00","12:00:00","20");
INSERT INTO meda_schedule_timeblocks VALUES("6","1","0","6","16:00:00","21:00:00","15");
INSERT INTO meda_schedule_timeblocks VALUES("7","2","0","2","09:00:00","15:00:00","15");
INSERT INTO meda_schedule_timeblocks VALUES("8","2","0","3","09:30:00","17:00:00","20");
INSERT INTO meda_schedule_timeblocks VALUES("9","2","0","5","08:00:00","13:00:00","30");
INSERT INTO meda_schedule_timeblocks VALUES("10","2","0","6","09:00:00","15:00:00","15");
INSERT INTO meda_schedule_timeblocks VALUES("11","3","0","2","07:30:00","14:00:00","15");
INSERT INTO meda_schedule_timeblocks VALUES("12","3","0","2","15:00:00","18:00:00","20");
INSERT INTO meda_schedule_timeblocks VALUES("13","3","0","3","08:00:00","14:00:00","15");
INSERT INTO meda_schedule_timeblocks VALUES("14","3","0","4","15:00:00","20:00:00","15");
INSERT INTO meda_schedule_timeblocks VALUES("15","3","0","5","08:00:00","14:00:00","15");
INSERT INTO meda_schedule_timeblocks VALUES("16","3","0","6","08:00:00","15:00:00","15");
INSERT INTO meda_schedule_timeblocks VALUES("17","4","0","2","09:00:00","14:00:00","15");
INSERT INTO meda_schedule_timeblocks VALUES("18","4","0","2","16:00:00","20:00:00","20");
INSERT INTO meda_schedule_timeblocks VALUES("19","4","0","3","10:00:00","17:00:00","15");
INSERT INTO meda_schedule_timeblocks VALUES("20","4","0","4","09:00:00","15:00:00","15");
INSERT INTO meda_schedule_timeblocks VALUES("21","4","0","5","10:00:00","17:00:00","15");
INSERT INTO meda_schedule_timeblocks VALUES("22","4","0","6","08:00:00","12:00:00","15");
INSERT INTO meda_schedule_timeblocks VALUES("23","5","0","2","08:00:00","16:00:00","15");
INSERT INTO meda_schedule_timeblocks VALUES("24","5","0","4","09:00:00","14:00:00","15");
INSERT INTO meda_schedule_timeblocks VALUES("25","5","0","4","16:00:00","19:00:00","15");
INSERT INTO meda_schedule_timeblocks VALUES("26","5","0","5","12:00:00","20:00:00","15");
INSERT INTO meda_schedule_timeblocks VALUES("27","5","0","6","09:00:00","17:00:00","15");
INSERT INTO meda_schedule_timeblocks VALUES("42","8","6","5","10:00:00","18:00:00","20");
INSERT INTO meda_schedule_timeblocks VALUES("38","8","6","2","08:00:00","15:00:00","20");
INSERT INTO meda_schedule_timeblocks VALUES("39","8","6","3","09:00:00","15:00:00","20");
INSERT INTO meda_schedule_timeblocks VALUES("40","8","6","4","09:00:00","16:00:00","20");
INSERT INTO meda_schedule_timeblocks VALUES("41","8","6","6","09:00:00","18:00:00","20");



DROP TABLE IF EXISTS meda_schedules;

CREATE TABLE `meda_schedules` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `doctor_id` int(10) unsigned NOT NULL DEFAULT '0',
  `date_from` date NOT NULL,
  `date_to` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `doctor_id` (`doctor_id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO meda_schedules VALUES("1","2012 Winter - Spring","1","2012-01-10","2012-05-31");
INSERT INTO meda_schedules VALUES("2","2012 Summer - Autumn","1","2012-06-01","2012-11-30");
INSERT INTO meda_schedules VALUES("3","2012 - Winter","1","2012-12-01","2015-02-28");
INSERT INTO meda_schedules VALUES("4","2012 Half-Year #1","2","2012-01-01","2012-05-31");
INSERT INTO meda_schedules VALUES("5","2012 Half-Year #2","2","2012-06-01","2015-12-31");
INSERT INTO meda_schedules VALUES("8","General","3","2012-09-20","2015-12-31");



DROP TABLE IF EXISTS meda_search_wordlist;

CREATE TABLE `meda_search_wordlist` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `word_text` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `word_count` int(10) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `word_text` (`word_text`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;




DROP TABLE IF EXISTS meda_settings;

CREATE TABLE `meda_settings` (
  `id` smallint(6) NOT NULL,
  `template` varchar(32) CHARACTER SET latin1 NOT NULL,
  `ssl_mode` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0 - no, 1 - entire site, 2 - admin, 3 - patient,doctor & payment modules',
  `seo_urls` tinyint(1) NOT NULL DEFAULT '1',
  `date_format` varchar(10) CHARACTER SET latin1 NOT NULL DEFAULT 'dd/mm/yyyy',
  `time_format` varchar(5) CHARACTER SET latin1 NOT NULL DEFAULT '24',
  `price_format` enum('european','american') CHARACTER SET latin1 NOT NULL,
  `time_zone` varchar(5) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `week_start_day` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `admin_email` varchar(70) COLLATE utf8_unicode_ci NOT NULL,
  `mailer` varchar(20) CHARACTER SET latin1 NOT NULL DEFAULT 'php_mail_standard',
  `mailer_type` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `mailer_wysiwyg_type` enum('none','tinymce') CHARACTER SET latin1 NOT NULL DEFAULT 'none',
  `smtp_auth` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `smtp_secure` enum('ssl','tls','no') CHARACTER SET latin1 NOT NULL DEFAULT 'ssl',
  `smtp_host` varchar(70) COLLATE utf8_unicode_ci NOT NULL,
  `smtp_port` varchar(6) COLLATE utf8_unicode_ci NOT NULL,
  `smtp_username` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `smtp_password` varchar(50) CHARACTER SET latin1 NOT NULL,
  `wysiwyg_type` enum('none','tinymce') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'tinymce',
  `rss_feed` tinyint(1) NOT NULL DEFAULT '1',
  `rss_feed_type` enum('rss1','rss2','atom') CHARACTER SET latin1 NOT NULL DEFAULT 'rss1',
  `rss_last_ids` varchar(100) CHARACTER SET latin1 NOT NULL,
  `is_offline` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `caching_allowed` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `cache_lifetime` tinyint(3) unsigned NOT NULL DEFAULT '5' COMMENT 'in minutes',
  `offline_message` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `google_rank` varchar(2) CHARACTER SET latin1 NOT NULL,
  `alexa_rank` varchar(12) CHARACTER SET latin1 NOT NULL,
  `cron_type` enum('batch','non-batch','stop') CHARACTER SET latin1 NOT NULL DEFAULT 'non-batch',
  `cron_run_last_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `cron_run_period` enum('minute','hour') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'minute',
  `cron_run_period_value` smallint(6) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO meda_settings VALUES("0","sun","0","0","mm/dd/yyyy","am/pm","american","-8","1","info@yourdomain.com","php","php_mail_standard","none","1","ssl","","","","","tinymce","1","rss1","1","0","0","5","Our website is currently offline for maintenance. Please visit us later.","-1","0","non-batch","2015-01-03 18:24:00","hour","24");



DROP TABLE IF EXISTS meda_site_description;

CREATE TABLE `meda_site_description` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `language_id` varchar(2) CHARACTER SET latin1 NOT NULL,
  `header_text` text COLLATE utf8_unicode_ci NOT NULL,
  `slogan_text` text COLLATE utf8_unicode_ci NOT NULL,
  `footer_text` text COLLATE utf8_unicode_ci NOT NULL,
  `tag_title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `tag_description` text COLLATE utf8_unicode_ci NOT NULL,
  `tag_keywords` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO meda_site_description VALUES("1","en","PetDaddy","PetGrooming and Sitters","IngageMd © <a class=\"footer_link\" href=\"http://www.apphp.com/php-medical-appointment/index.php\">IngageMd</a>","IngageMd Medical Appointment","IngageMd","IngageMd");



DROP TABLE IF EXISTS meda_social_networks;

CREATE TABLE `meda_social_networks` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `code` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `url` varchar(150) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO meda_social_networks VALUES("1","digg","Digg","");
INSERT INTO meda_social_networks VALUES("2","dribbble","Dribbble","");
INSERT INTO meda_social_networks VALUES("3","facebook","Facebook","");
INSERT INTO meda_social_networks VALUES("4","flickr","Flickr","");
INSERT INTO meda_social_networks VALUES("5","googleplus","Google+","");
INSERT INTO meda_social_networks VALUES("6","linkedin","LinkedIn","");
INSERT INTO meda_social_networks VALUES("7","myspace","MySpace","");
INSERT INTO meda_social_networks VALUES("8","reddit","Reddit","");
INSERT INTO meda_social_networks VALUES("9","tumblr","Tumblr","");
INSERT INTO meda_social_networks VALUES("10","twitter","Twitter","");
INSERT INTO meda_social_networks VALUES("11","vimeo","Vimeo","");
INSERT INTO meda_social_networks VALUES("12","youtube","YouTube","");



DROP TABLE IF EXISTS meda_specialities;

CREATE TABLE `meda_specialities` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `is_active` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=39 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO meda_specialities VALUES("38","1");
INSERT INTO meda_specialities VALUES("37","1");
INSERT INTO meda_specialities VALUES("36","1");
INSERT INTO meda_specialities VALUES("35","1");



DROP TABLE IF EXISTS meda_specialities_description;

CREATE TABLE `meda_specialities_description` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `speciality_id` int(10) NOT NULL DEFAULT '0',
  `language_id` varchar(2) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(70) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=107 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO meda_specialities_description VALUES("104","36","en","Dog Walkers","");
INSERT INTO meda_specialities_description VALUES("105","37","en","Dog Sitter","");
INSERT INTO meda_specialities_description VALUES("106","38","en","Dog Training","");
INSERT INTO meda_specialities_description VALUES("103","35","en","Pet Grooming","");



DROP TABLE IF EXISTS meda_states;

CREATE TABLE `meda_states` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `country_id` smallint(6) unsigned NOT NULL DEFAULT '0',
  `abbrv` varchar(3) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(70) COLLATE utf8_unicode_ci NOT NULL,
  `is_active` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `priority_order` smallint(6) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `country_id` (`country_id`)
) ENGINE=MyISAM AUTO_INCREMENT=104 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO meda_states VALUES("1","223","AL","Alabama","1","1");
INSERT INTO meda_states VALUES("2","223","AK","Alaska","1","2");
INSERT INTO meda_states VALUES("3","223","AZ","Arizona","1","3");
INSERT INTO meda_states VALUES("4","223","AR","Arkansas","1","4");
INSERT INTO meda_states VALUES("5","223","CA","California","1","5");
INSERT INTO meda_states VALUES("6","223","CO","Colorado","1","6");
INSERT INTO meda_states VALUES("7","223","CT","Connecticut","1","7");
INSERT INTO meda_states VALUES("8","223","DE","Delaware","1","8");
INSERT INTO meda_states VALUES("9","223","DC","District of Columbia","1","9");
INSERT INTO meda_states VALUES("10","223","FL","Florida","1","10");
INSERT INTO meda_states VALUES("11","223","GA","Georgia","1","11");
INSERT INTO meda_states VALUES("12","223","HI","Hawaii","1","12");
INSERT INTO meda_states VALUES("13","223","ID","Idaho","1","13");
INSERT INTO meda_states VALUES("14","223","IL","Illinois","1","14");
INSERT INTO meda_states VALUES("15","223","IN","Indiana","1","15");
INSERT INTO meda_states VALUES("16","223","IA","Iowa","1","16");
INSERT INTO meda_states VALUES("17","223","KS","Kansas","1","17");
INSERT INTO meda_states VALUES("18","223","KY","Kentucky","1","18");
INSERT INTO meda_states VALUES("19","223","LA","Louisiana","1","19");
INSERT INTO meda_states VALUES("20","223","ME","Maine","1","20");
INSERT INTO meda_states VALUES("21","223","MD","Maryland","1","21");
INSERT INTO meda_states VALUES("22","223","MA","Massachusetts","1","22");
INSERT INTO meda_states VALUES("23","223","MI","Michigan","1","22");
INSERT INTO meda_states VALUES("24","223","MN","Minnesota","1","23");
INSERT INTO meda_states VALUES("25","223","MS","Mississippi","1","25");
INSERT INTO meda_states VALUES("26","223","MT","Montana","1","27");
INSERT INTO meda_states VALUES("27","223","MO","Missouri","1","26");
INSERT INTO meda_states VALUES("28","223","NE","Nebraska","1","28");
INSERT INTO meda_states VALUES("29","223","NV","Nevada","1","29");
INSERT INTO meda_states VALUES("30","223","NH","New Hampshire","1","30");
INSERT INTO meda_states VALUES("31","223","NJ","New Jersey","1","31");
INSERT INTO meda_states VALUES("32","223","NM","New Mexico","1","32");
INSERT INTO meda_states VALUES("33","223","NY","New York","1","33");
INSERT INTO meda_states VALUES("34","223","NC","North Carolina","1","34");
INSERT INTO meda_states VALUES("35","223","ND","North Dakota","1","35");
INSERT INTO meda_states VALUES("36","223","OH","Ohio","1","36");
INSERT INTO meda_states VALUES("37","223","OK","Oklahoma","1","37");
INSERT INTO meda_states VALUES("38","223","OR","Oregon","1","38");
INSERT INTO meda_states VALUES("39","223","PA","Pennsylvania","1","39");
INSERT INTO meda_states VALUES("40","223","RI","Rhode Island","1","40");
INSERT INTO meda_states VALUES("41","223","SC","South Carolina","1","41");
INSERT INTO meda_states VALUES("42","223","SD","South Dakota","1","42");
INSERT INTO meda_states VALUES("43","223","TN","Tennessee","1","43");
INSERT INTO meda_states VALUES("44","223","TX","Texas","1","44");
INSERT INTO meda_states VALUES("45","223","UT","Utah","1","45");
INSERT INTO meda_states VALUES("46","223","VT","Vermont","1","46");
INSERT INTO meda_states VALUES("47","223","VA","Virginia","1","47");
INSERT INTO meda_states VALUES("48","223","WA","Washington","1","48");
INSERT INTO meda_states VALUES("49","223","WV","West Virginia","1","49");
INSERT INTO meda_states VALUES("50","223","WI","Wisconsin","1","50");
INSERT INTO meda_states VALUES("51","223","WY","Wyoming","1","51");
INSERT INTO meda_states VALUES("52","13","NSW","New South Wales","1","1");
INSERT INTO meda_states VALUES("53","13","QLD","Queensland","1","2");
INSERT INTO meda_states VALUES("54","13","SA","South Australia","1","3");
INSERT INTO meda_states VALUES("55","13","TAS","Tasmania","1","4");
INSERT INTO meda_states VALUES("56","13","VIC","Victoria","1","5");
INSERT INTO meda_states VALUES("57","13","WA","Western Australia","1","6");
INSERT INTO meda_states VALUES("58","39","AB","Alberta","1","1");
INSERT INTO meda_states VALUES("59","39","BC","British Columbia","1","2");
INSERT INTO meda_states VALUES("60","39","ON","Ontario","1","6");
INSERT INTO meda_states VALUES("61","39","QC","Quebec","1","8");
INSERT INTO meda_states VALUES("62","39","NS","Nova Scotia","1","5");
INSERT INTO meda_states VALUES("63","39","NB","New Brunswick","1","4");
INSERT INTO meda_states VALUES("64","39","MB","Manitoba","1","3");
INSERT INTO meda_states VALUES("65","39","PE","Prince Edward Island","1","7");
INSERT INTO meda_states VALUES("66","39","SK","Saskatchewan","1","9");
INSERT INTO meda_states VALUES("67","39","NL","Newfoundland and Labrador","1","10");
INSERT INTO meda_states VALUES("68","99","AP","Andhra Pradesh","1","0");
INSERT INTO meda_states VALUES("69","99","AR","Arunachal Pradesh","1","1");
INSERT INTO meda_states VALUES("70","99","AS","Assam","1","2");
INSERT INTO meda_states VALUES("71","99","BR","Bihar","1","3");
INSERT INTO meda_states VALUES("72","99","CG","Chhattisgarh","1","4");
INSERT INTO meda_states VALUES("73","99","GA","Goa","1","5");
INSERT INTO meda_states VALUES("74","99","GJ","Gujarat","1","6");
INSERT INTO meda_states VALUES("75","99","GJ","Gujarat","1","7");
INSERT INTO meda_states VALUES("76","99","HR","Haryana","1","8");
INSERT INTO meda_states VALUES("77","99","HP","Himachal Pradesh","1","9");
INSERT INTO meda_states VALUES("78","99","JK","Jammu & Kashmir","1","10");
INSERT INTO meda_states VALUES("79","99","JH","Jharkhand","1","11");
INSERT INTO meda_states VALUES("80","99","KA","Karnataka","1","12");
INSERT INTO meda_states VALUES("81","99","KL","Kerala","1","13");
INSERT INTO meda_states VALUES("82","99","MP","Madhya Pradesh","1","14");
INSERT INTO meda_states VALUES("83","99","MH","Maharashtra","1","15");
INSERT INTO meda_states VALUES("84","99","MN","Manipur","1","16");
INSERT INTO meda_states VALUES("85","99","ML","Meghalaya","1","17");
INSERT INTO meda_states VALUES("86","99","MZ","Mizoram","1","18");
INSERT INTO meda_states VALUES("87","99","NL","Nagaland","1","19");
INSERT INTO meda_states VALUES("88","99","OR","Odisha","1","20");
INSERT INTO meda_states VALUES("89","99","PB","Punjab","1","21");
INSERT INTO meda_states VALUES("90","99","RJ","Rajasthan","1","22");
INSERT INTO meda_states VALUES("91","99","SK","Sikkim","1","23");
INSERT INTO meda_states VALUES("92","99","TN","Tamil Nadu","1","24");
INSERT INTO meda_states VALUES("93","99","TR","Tripura","1","25");
INSERT INTO meda_states VALUES("94","99","UT","Uttarakhand","1","26");
INSERT INTO meda_states VALUES("95","99","UP","Uttar Pradesh","1","27");
INSERT INTO meda_states VALUES("96","99","WB","West Bengal","1","28");
INSERT INTO meda_states VALUES("97","99","AN","Andaman & Nicobar","1","29");
INSERT INTO meda_states VALUES("98","99","CH","Chandigarh","1","30");
INSERT INTO meda_states VALUES("99","99","DN","Dadra and Nagar Haveli","1","31");
INSERT INTO meda_states VALUES("100","99","DD","Daman & Diu","1","32");
INSERT INTO meda_states VALUES("101","99","DL","Delhi","1","33");
INSERT INTO meda_states VALUES("102","99","LD","Lakshadweep","1","34");
INSERT INTO meda_states VALUES("103","99","PY","Puducherry","1","35");



DROP TABLE IF EXISTS meda_timeoffs;

CREATE TABLE `meda_timeoffs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `doctor_id` int(10) unsigned NOT NULL DEFAULT '0',
  `date_from` date NOT NULL DEFAULT '0000-00-00',
  `time_from` time NOT NULL DEFAULT '00:00:00',
  `date_to` date NOT NULL DEFAULT '0000-00-00',
  `time_to` time NOT NULL DEFAULT '00:00:00',
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO meda_timeoffs VALUES("1","1","2013-05-01","00:50:00","2013-06-23","09:00:00","Vacations");



DROP TABLE IF EXISTS meda_visit_reasons;

CREATE TABLE `meda_visit_reasons` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `priority_order` smallint(6) unsigned NOT NULL DEFAULT '0',
  `is_active` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO meda_visit_reasons VALUES("14","0","1");
INSERT INTO meda_visit_reasons VALUES("13","0","1");
INSERT INTO meda_visit_reasons VALUES("12","0","1");
INSERT INTO meda_visit_reasons VALUES("15","0","1");
INSERT INTO meda_visit_reasons VALUES("16","0","1");
INSERT INTO meda_visit_reasons VALUES("17","0","1");
INSERT INTO meda_visit_reasons VALUES("18","0","1");
INSERT INTO meda_visit_reasons VALUES("19","0","1");
INSERT INTO meda_visit_reasons VALUES("20","0","1");
INSERT INTO meda_visit_reasons VALUES("21","1","1");



DROP TABLE IF EXISTS meda_visit_reasons_description;

CREATE TABLE `meda_visit_reasons_description` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `visit_reason_id` int(10) unsigned NOT NULL DEFAULT '0',
  `language_id` varchar(2) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(125) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=44 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO meda_visit_reasons_description VALUES("41","19","en","Flea & tick application*");
INSERT INTO meda_visit_reasons_description VALUES("40","18","en","Teeth brushing");
INSERT INTO meda_visit_reasons_description VALUES("39","17","en","Nail services");
INSERT INTO meda_visit_reasons_description VALUES("38","16","en","Puppy Groom");
INSERT INTO meda_visit_reasons_description VALUES("37","15","en","Puppy Bath");
INSERT INTO meda_visit_reasons_description VALUES("36","14","en","Pet Expressions");
INSERT INTO meda_visit_reasons_description VALUES("35","13","en","Dog Groom");
INSERT INTO meda_visit_reasons_description VALUES("34","12","en","Dog Bath");
INSERT INTO meda_visit_reasons_description VALUES("43","21","en","15-minute brushing");
INSERT INTO meda_visit_reasons_description VALUES("42","20","en","Oxygen-infused bath with shampoo & blow dry");



DROP TABLE IF EXISTS meda_vocabulary;

CREATE TABLE `meda_vocabulary` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `language_id` varchar(3) CHARACTER SET latin1 NOT NULL,
  `key_value` varchar(50) CHARACTER SET latin1 NOT NULL,
  `key_text` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `voc_item` (`language_id`,`key_value`),
  KEY `language_id` (`language_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3625 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO meda_vocabulary VALUES("1","en","_2CO_NOTICE","2CheckOut.com Inc. (Ohio, USA) is an authorized retailer for goods and services.");
INSERT INTO meda_vocabulary VALUES("2","es","_2CO_NOTICE","2CheckOut.com Inc. (Ohio, EE.UU.) es un vendedor autorizado de bienes y servicios.");
INSERT INTO meda_vocabulary VALUES("3","de","_2CO_NOTICE","2CheckOut.com Inc. (Ohio, USA) is an authorized retailer for goods and services.");
INSERT INTO meda_vocabulary VALUES("4","en","_2CO_ORDER","2CO Order");
INSERT INTO meda_vocabulary VALUES("5","es","_2CO_ORDER","2CO Orden");
INSERT INTO meda_vocabulary VALUES("6","de","_2CO_ORDER","2CO Order");
INSERT INTO meda_vocabulary VALUES("7","en","_ABBREVIATION","Abbreviation");
INSERT INTO meda_vocabulary VALUES("8","es","_ABBREVIATION","Abreviación");
INSERT INTO meda_vocabulary VALUES("9","de","_ABBREVIATION","Abkürzung");
INSERT INTO meda_vocabulary VALUES("10","en","_ABOUT","About");
INSERT INTO meda_vocabulary VALUES("11","es","_ABOUT","Sobre");
INSERT INTO meda_vocabulary VALUES("12","de","_ABOUT","Über");
INSERT INTO meda_vocabulary VALUES("13","en","_ACCESS","Access");
INSERT INTO meda_vocabulary VALUES("14","es","_ACCESS","Acceso");
INSERT INTO meda_vocabulary VALUES("15","de","_ACCESS","Zugang");
INSERT INTO meda_vocabulary VALUES("16","en","_ACCESSIBLE_BY","Accessible By");
INSERT INTO meda_vocabulary VALUES("17","es","_ACCESSIBLE_BY","Accesible en");
INSERT INTO meda_vocabulary VALUES("18","de","_ACCESSIBLE_BY","Erreichbar mit");
INSERT INTO meda_vocabulary VALUES("19","en","_ACCOUNTS","Accounts");
INSERT INTO meda_vocabulary VALUES("20","es","_ACCOUNTS","Cuentas");
INSERT INTO meda_vocabulary VALUES("21","de","_ACCOUNTS","Konten");
INSERT INTO meda_vocabulary VALUES("22","en","_ACCOUNTS_MANAGEMENT","Accounts");
INSERT INTO meda_vocabulary VALUES("23","es","_ACCOUNTS_MANAGEMENT","Gestión de Cuentas");
INSERT INTO meda_vocabulary VALUES("24","de","_ACCOUNTS_MANAGEMENT","Konten");
INSERT INTO meda_vocabulary VALUES("25","en","_ACCOUNT_CREATED_CONF_BY_ADMIN_MSG","Your account has been successfully created! In a few minutes you should receive an email, containing the details of your account. <br><br> After approval your registration by administrator, you will be able to log into your account.");
INSERT INTO meda_vocabulary VALUES("26","es","_ACCOUNT_CREATED_CONF_BY_ADMIN_MSG","Su cuenta ha sido creada con éxito! En pocos minutos, usted debe recibir un correo electrónico, que contiene los detalles de su cuenta. <br> Después de la aprobación de su registro por el administrador, usted será capaz de acceder a su cuenta.");
INSERT INTO meda_vocabulary VALUES("27","de","_ACCOUNT_CREATED_CONF_BY_ADMIN_MSG","Ihr Konto wurde erfolgreich erstellt! In wenigen Minuten sollten Sie eine E-Mail mit den Angaben von Ihrem Konto. <br> Nach der Genehmigung Ihrer Registrierung durch den Administrator, werden Sie in der Lage, in Ihrem Konto anmelden.");
INSERT INTO meda_vocabulary VALUES("28","en","_ACCOUNT_CREATED_CONF_BY_EMAIL_MSG","Your account has been successfully created! In a few minutes you should receive an email, containing the details of your registration. <br><br> Complete this registration, using the confirmation code that is sent to the provided email address, and you will be able to log into your account.");
INSERT INTO meda_vocabulary VALUES("29","es","_ACCOUNT_CREATED_CONF_BY_EMAIL_MSG","Su cuenta ha sido creada con éxito! En pocos minutos, usted debe recibir un correo electrónico, que contiene los detalles de su registro. <br><br> completar este registro, utilizando el código de confirmación que fue enviado a la dirección de correo electrónico proporcionado, y que será capaz de acceder a su cuenta.");
INSERT INTO meda_vocabulary VALUES("30","de","_ACCOUNT_CREATED_CONF_BY_EMAIL_MSG","Ihr Konto wurde erfolgreich erstellt! In wenigen Minuten sollten Sie eine E-Mail mit den Angaben Ihrer Registrierung. <br><br> füllen Sie dieses Anmeldeformular mit den Bestätigungs-Code, dass die angegebene E-Mail-Adresse gesendet wurde, und du wirst in der Lage sein in Ihrem Konto anmelden.");
INSERT INTO meda_vocabulary VALUES("31","en","_ACCOUNT_CREATED_NON_CONFIRM_LINK","Click <a href=index.php?_ACCOUNT_=login>here</a> to proceed.");
INSERT INTO meda_vocabulary VALUES("32","es","_ACCOUNT_CREATED_NON_CONFIRM_LINK","Haga clic <a href=index.php?_ACCOUNT_=login>aquí</a> para continuar.");
INSERT INTO meda_vocabulary VALUES("33","de","_ACCOUNT_CREATED_NON_CONFIRM_LINK","Klicken Sie <a href=index.php?_ACCOUNT_=login>hier</a>, um fortzufahren.");
INSERT INTO meda_vocabulary VALUES("34","en","_ACCOUNT_CREATED_NON_CONFIRM_MSG","Your account has been successfully created! For your convenience in a few minutes you will receive an email, containing the details of your registration (no confirmation required). <br><br>You may log into your account now.");
INSERT INTO meda_vocabulary VALUES("35","es","_ACCOUNT_CREATED_NON_CONFIRM_MSG","Su cuenta ha sido creada con éxito! Para su comodidad, en pocos minutos recibirá un correo electrónico, que contiene los datos de su inscripción (no se requiere confirmación). <br><br> Usted puede acceder a su cuenta ahora.");
INSERT INTO meda_vocabulary VALUES("36","de","_ACCOUNT_CREATED_NON_CONFIRM_MSG","Ihr Konto wurde erfolgreich erstellt! Für Ihre Bequemlichkeit in wenigen Minuten erhalten Sie eine E-Mail mit den Angaben der Anmeldung (keine Bestätigung erforderlich). <br><br> Sie können in Ihrem Konto jetzt anmelden.");
INSERT INTO meda_vocabulary VALUES("37","en","_ACCOUNT_CREATE_MSG","This registration process requires confirmation via email! <br>Please fill out the form below with correct information.");
INSERT INTO meda_vocabulary VALUES("38","es","_ACCOUNT_CREATE_MSG","Este proceso de registro requiere la confirmación por correo electrónico! <br> Por favor, rellene el siguiente formulario con la información correcta.");
INSERT INTO meda_vocabulary VALUES("39","de","_ACCOUNT_CREATE_MSG","Diese Registrierung erfordert eine Bestätigung per E-Mail! <br> Bitte füllen Sie das untenstehende Formular mit korrekten Informationen.");
INSERT INTO meda_vocabulary VALUES("40","en","_ACCOUNT_DETAILS","Account Details");
INSERT INTO meda_vocabulary VALUES("41","es","_ACCOUNT_DETAILS","Detalles de la cuenta");
INSERT INTO meda_vocabulary VALUES("42","de","_ACCOUNT_DETAILS","Kontodetails");
INSERT INTO meda_vocabulary VALUES("43","en","_ACCOUNT_PANEL","Account Panel");
INSERT INTO meda_vocabulary VALUES("44","es","_ACCOUNT_PANEL","Cuenta de Grupo");
INSERT INTO meda_vocabulary VALUES("45","de","_ACCOUNT_PANEL","Konto-Panel");
INSERT INTO meda_vocabulary VALUES("46","en","_ACCOUNT_TYPE","Account type");
INSERT INTO meda_vocabulary VALUES("47","es","_ACCOUNT_TYPE","Tipo de cuenta");
INSERT INTO meda_vocabulary VALUES("48","de","_ACCOUNT_TYPE","Kontotyp");
INSERT INTO meda_vocabulary VALUES("49","en","_ACCOUNT_WAS_CREATED","Your account has been created");
INSERT INTO meda_vocabulary VALUES("50","es","_ACCOUNT_WAS_CREATED","Tu cuenta ha sido creada");
INSERT INTO meda_vocabulary VALUES("51","de","_ACCOUNT_WAS_CREATED","Ihr Konto wurde erstellt");
INSERT INTO meda_vocabulary VALUES("52","en","_ACCOUNT_WAS_DELETED","Your account has been successfully removed! In seconds, you will be automatically redirected to the homepage.");
INSERT INTO meda_vocabulary VALUES("53","es","_ACCOUNT_WAS_DELETED","Su cuenta se ha eliminado correctamente! En cuestión de segundos, se le redirigirá automáticamente a la página principal.");
INSERT INTO meda_vocabulary VALUES("54","de","_ACCOUNT_WAS_DELETED","Ihr Konto wurde erfolgreich entfernt! Innerhalb von Sekunden werden Sie automatisch auf die Startseite umgeleitet.");
INSERT INTO meda_vocabulary VALUES("55","en","_ACCOUNT_WAS_UPDATED","Your account has been successfully updated!");
INSERT INTO meda_vocabulary VALUES("56","es","_ACCOUNT_WAS_UPDATED","Su cuenta ha sido actualizada con éxito!");
INSERT INTO meda_vocabulary VALUES("57","de","_ACCOUNT_WAS_UPDATED","Ihr Konto wurde erfolgreich aktualisiert!");
INSERT INTO meda_vocabulary VALUES("58","en","_ACCOUT_CREATED_CONF_LINK","Already confirmed your registration? Click <a href=index.php?_ACCOUNT_=login>here</a> to proceed.");
INSERT INTO meda_vocabulary VALUES("59","es","_ACCOUT_CREATED_CONF_LINK","Ya confirmaron su registro? Haga clic <a href=index.php?_ACCOUNT_=login>aquí</a> para continuar.");
INSERT INTO meda_vocabulary VALUES("60","de","_ACCOUT_CREATED_CONF_LINK","Bereits bestätigt Ihre Registrierung? Klicken Sie <a href=index.php?_ACCOUNT_=login>hier</a>, um fortzufahren.");
INSERT INTO meda_vocabulary VALUES("61","en","_ACTIONS","Action");
INSERT INTO meda_vocabulary VALUES("62","es","_ACTIONS","Acción");
INSERT INTO meda_vocabulary VALUES("63","de","_ACTIONS","Aktion");
INSERT INTO meda_vocabulary VALUES("64","en","_ACTIONS_WORD","Action");
INSERT INTO meda_vocabulary VALUES("65","es","_ACTIONS_WORD","Acción");
INSERT INTO meda_vocabulary VALUES("66","de","_ACTIONS_WORD","Aktion");
INSERT INTO meda_vocabulary VALUES("67","en","_ACTION_REQUIRED","ACTION REQUIRED");
INSERT INTO meda_vocabulary VALUES("68","es","_ACTION_REQUIRED","MEDIDAS QUE SE SOLICITAN");
INSERT INTO meda_vocabulary VALUES("69","de","_ACTION_REQUIRED","MASSNAHMEN ERFORDERLICH");
INSERT INTO meda_vocabulary VALUES("70","en","_ACTIVATION_EMAIL_ALREADY_SENT","The activation email is already sent to your email. Please try again later.");
INSERT INTO meda_vocabulary VALUES("71","es","_ACTIVATION_EMAIL_ALREADY_SENT","El email de activación ya fue enviado a su correo electrónico. Por favor, inténtelo de nuevo más tarde.");
INSERT INTO meda_vocabulary VALUES("72","de","_ACTIVATION_EMAIL_ALREADY_SENT","Die Aktivierung per E-Mail wurde bereits auf Ihre E-Mail geschickt. Bitte versuchen Sie es später erneut.");
INSERT INTO meda_vocabulary VALUES("73","en","_ACTIVATION_EMAIL_WAS_SENT","An email has been sent to _EMAIL_ with an activation key. Please check your mail to complete registration.");
INSERT INTO meda_vocabulary VALUES("74","es","_ACTIVATION_EMAIL_WAS_SENT","Un correo electrónico ha sido enviado a _EMAIL_ con una clave de activación. Por favor, revise su correo para completar el registro.");
INSERT INTO meda_vocabulary VALUES("75","de","_ACTIVATION_EMAIL_WAS_SENT","Eine Email wurde an _EMAIL_ wurde mit einem Aktivierungsschlüssel gesendet. Bitte überprüfen Sie Ihre E-Mail um die Registrierung abzuschließen.");
INSERT INTO meda_vocabulary VALUES("76","en","_ACTIVE","Active");
INSERT INTO meda_vocabulary VALUES("77","es","_ACTIVE","Activo");
INSERT INTO meda_vocabulary VALUES("78","de","_ACTIVE","Aktiv");
INSERT INTO meda_vocabulary VALUES("79","en","_ADDING_OPERATION_COMPLETED","The adding operation completed successfully!");
INSERT INTO meda_vocabulary VALUES("80","es","_ADDING_OPERATION_COMPLETED","La operación terminó con éxito agregando!");
INSERT INTO meda_vocabulary VALUES("81","de","_ADDING_OPERATION_COMPLETED","Die Zugabe Vorgang wurde erfolgreich abgeschlossen!");
INSERT INTO meda_vocabulary VALUES("82","en","_ADDITIONAL_DEGREE","Additional Degree");
INSERT INTO meda_vocabulary VALUES("83","es","_ADDITIONAL_DEGREE","Grado adicional");
INSERT INTO meda_vocabulary VALUES("84","de","_ADDITIONAL_DEGREE","Zusätzliche Studien");
INSERT INTO meda_vocabulary VALUES("85","en","_ADDITIONAL_INFO","Additional Info");
INSERT INTO meda_vocabulary VALUES("86","es","_ADDITIONAL_INFO","Información adicional");
INSERT INTO meda_vocabulary VALUES("87","de","_ADDITIONAL_INFO","Zusätzliche Informationen");
INSERT INTO meda_vocabulary VALUES("88","en","_ADDITIONAL_MODULES","Additional Modules");
INSERT INTO meda_vocabulary VALUES("89","es","_ADDITIONAL_MODULES","Módulos adicionales");
INSERT INTO meda_vocabulary VALUES("90","de","_ADDITIONAL_MODULES","Zusätzliche Module");
INSERT INTO meda_vocabulary VALUES("91","en","_ADDRESS","Address");
INSERT INTO meda_vocabulary VALUES("92","es","_ADDRESS","Dirección");
INSERT INTO meda_vocabulary VALUES("93","de","_ADDRESS","Adresse");
INSERT INTO meda_vocabulary VALUES("94","en","_ADDRESSES","Addresses");
INSERT INTO meda_vocabulary VALUES("95","es","_ADDRESSES","Direcciones");
INSERT INTO meda_vocabulary VALUES("96","de","_ADDRESSES","Adressen");
INSERT INTO meda_vocabulary VALUES("97","en","_ADDRESSES_COUNT","Addresses Count");
INSERT INTO meda_vocabulary VALUES("98","es","_ADDRESSES_COUNT","Cuentan Direcciones");
INSERT INTO meda_vocabulary VALUES("99","de","_ADDRESSES_COUNT","Adressen zählen");
INSERT INTO meda_vocabulary VALUES("100","en","_ADDRESSES_DEFAULT_ALERT","Remember! To allow the system to retrieve latitude and longitude automatically - leave appropriate fields empty.");
INSERT INTO meda_vocabulary VALUES("101","es","_ADDRESSES_DEFAULT_ALERT","¡Recuerde! Para permitir que el sistema para recuperar automáticamente latitud y longitud - dejar campos apropiados vacío.");
INSERT INTO meda_vocabulary VALUES("102","de","_ADDRESSES_DEFAULT_ALERT","Erinnern Sie sich! Damit das System die Längen-und Breitengrade automatisch abrufen - lassen entsprechenden Felder leer.");
INSERT INTO meda_vocabulary VALUES("103","en","_ADDRESS_2","Address (line 2)");
INSERT INTO meda_vocabulary VALUES("104","es","_ADDRESS_2","Dirección (línea 2)");
INSERT INTO meda_vocabulary VALUES("105","de","_ADDRESS_2","Adresse (Zeile 2)");
INSERT INTO meda_vocabulary VALUES("106","en","_ADDRESS_EMPTY_ALERT","Address cannot be empty! Please re-enter.");
INSERT INTO meda_vocabulary VALUES("107","es","_ADDRESS_EMPTY_ALERT","La dirección no puede estar vacío! Por favor, vuelva a entrar.");
INSERT INTO meda_vocabulary VALUES("108","de","_ADDRESS_EMPTY_ALERT","Adresse darf nicht leer sein! Bitte erneut eingeben.");
INSERT INTO meda_vocabulary VALUES("109","en","_ADD_NEW","Add New");
INSERT INTO meda_vocabulary VALUES("110","es","_ADD_NEW","Agregar nuevo");
INSERT INTO meda_vocabulary VALUES("111","de","_ADD_NEW","Neu hinzufügen");
INSERT INTO meda_vocabulary VALUES("112","en","_ADD_NEW_MENU","Add New Menu");
INSERT INTO meda_vocabulary VALUES("113","es","_ADD_NEW_MENU","Añadir un nuevo menú");
INSERT INTO meda_vocabulary VALUES("114","de","_ADD_NEW_MENU","Schreibe Neues Menü");
INSERT INTO meda_vocabulary VALUES("115","en","_ADD_TO_MENU","Add to Menu");
INSERT INTO meda_vocabulary VALUES("116","es","_ADD_TO_MENU","Añadir al menú");
INSERT INTO meda_vocabulary VALUES("117","de","_ADD_TO_MENU","Ins Menü");
INSERT INTO meda_vocabulary VALUES("118","en","_ADMIN","Admin");
INSERT INTO meda_vocabulary VALUES("119","es","_ADMIN","Administración");
INSERT INTO meda_vocabulary VALUES("120","de","_ADMIN","Admin");
INSERT INTO meda_vocabulary VALUES("121","en","_ADMINISTRATOR_ONLY","Administrator Only");
INSERT INTO meda_vocabulary VALUES("122","es","_ADMINISTRATOR_ONLY","Administrador con permiso de");
INSERT INTO meda_vocabulary VALUES("123","de","_ADMINISTRATOR_ONLY","Nur Administrator");
INSERT INTO meda_vocabulary VALUES("124","en","_ADMINS","Admins");
INSERT INTO meda_vocabulary VALUES("125","es","_ADMINS","Administradores");
INSERT INTO meda_vocabulary VALUES("126","de","_ADMINS","Admins");
INSERT INTO meda_vocabulary VALUES("127","en","_ADMINS_AND_PATIENTS","Patients & Admins");
INSERT INTO meda_vocabulary VALUES("128","es","_ADMINS_AND_PATIENTS","Los pacientes y Administradores");
INSERT INTO meda_vocabulary VALUES("129","de","_ADMINS_AND_PATIENTS","Patienten & Admins");
INSERT INTO meda_vocabulary VALUES("130","en","_ADMINS_DOCTORS_AND_PATIENTS","Admins, Doctors & Patients");
INSERT INTO meda_vocabulary VALUES("131","es","_ADMINS_DOCTORS_AND_PATIENTS","Admins, Médicos y Pacientes");
INSERT INTO meda_vocabulary VALUES("132","de","_ADMINS_DOCTORS_AND_PATIENTS","Admins, Ärzte & Patienten");
INSERT INTO meda_vocabulary VALUES("133","en","_ADMINS_MANAGEMENT","Admins Management");
INSERT INTO meda_vocabulary VALUES("134","es","_ADMINS_MANAGEMENT","Administradores de Gestión de");
INSERT INTO meda_vocabulary VALUES("135","de","_ADMINS_MANAGEMENT","Administratoren Management");
INSERT INTO meda_vocabulary VALUES("136","en","_ADMIN_COPY","admin copy");
INSERT INTO meda_vocabulary VALUES("137","es","_ADMIN_COPY","copia administrador");
INSERT INTO meda_vocabulary VALUES("138","de","_ADMIN_COPY","Admin Kopie");
INSERT INTO meda_vocabulary VALUES("139","en","_ADMIN_DOCTOR_APPROVAL_REQUIRED","admin or doctor approval required");
INSERT INTO meda_vocabulary VALUES("140","es","_ADMIN_DOCTOR_APPROVAL_REQUIRED","administración o la aprobación del médico necesario");
INSERT INTO meda_vocabulary VALUES("141","de","_ADMIN_DOCTOR_APPROVAL_REQUIRED","Admin oder Arzt Genehmigung erforderlich");
INSERT INTO meda_vocabulary VALUES("142","en","_ADMIN_EMAIL","Admin Email");
INSERT INTO meda_vocabulary VALUES("143","es","_ADMIN_EMAIL","Admin Email");
INSERT INTO meda_vocabulary VALUES("144","de","_ADMIN_EMAIL","Admin E-Mail");
INSERT INTO meda_vocabulary VALUES("145","en","_ADMIN_EMAIL_ALERT","This email is used as \'From\' address for the system email notifications. Make sure, that you write here a valid email address based on domain of your site");
INSERT INTO meda_vocabulary VALUES("146","es","_ADMIN_EMAIL_ALERT","Este correo electrónico se utiliza como dirección \'De\' para las notificaciones del sistema de correo electrónico. Asegúrese de que usted escribe aquí una dirección válida de correo electrónico basado en dominio de su sitio");
INSERT INTO meda_vocabulary VALUES("147","de","_ADMIN_EMAIL_ALERT","Diese E-Mail wird als \'Von\'-Adresse für das System E-Mail-Benachrichtigungen verwendet. Stellen Sie sicher, dass Sie hier geben Sie eine gültige E-Mail-Adresse auf Domain Ihrer Website basiert");
INSERT INTO meda_vocabulary VALUES("148","en","_ADMIN_EMAIL_EXISTS_ALERT","Administrator with such email already exists! Please choose another.");
INSERT INTO meda_vocabulary VALUES("149","es","_ADMIN_EMAIL_EXISTS_ALERT","Administrador de correo electrónico ya existe! Por favor, elija otra.");
INSERT INTO meda_vocabulary VALUES("150","de","_ADMIN_EMAIL_EXISTS_ALERT","Administrator mit solchen E-Mail ist bereits vorhanden! Bitte wählen Sie einen anderen.");
INSERT INTO meda_vocabulary VALUES("151","en","_ADMIN_EMAIL_IS_EMPTY","Admin email must not be empty! Please re-enter.");
INSERT INTO meda_vocabulary VALUES("152","es","_ADMIN_EMAIL_IS_EMPTY","Administrador de correo electrónico no debe estar vacía! Por favor, vuelva a entrar.");
INSERT INTO meda_vocabulary VALUES("153","de","_ADMIN_EMAIL_IS_EMPTY","Admin E-Mail darf nicht leer sein! Bitte erneut eingeben.");
INSERT INTO meda_vocabulary VALUES("154","en","_ADMIN_EMAIL_WRONG","Admin email in wrong format! Please re-enter.");
INSERT INTO meda_vocabulary VALUES("155","es","_ADMIN_EMAIL_WRONG","Administrador de correo electrónico en formato incorrecto! Por favor, vuelva a entrar.");
INSERT INTO meda_vocabulary VALUES("156","de","_ADMIN_EMAIL_WRONG","Admin E-Mail in falsche Format! Bitte erneut eingeben.");
INSERT INTO meda_vocabulary VALUES("157","en","_ADMIN_FOLDER_CREATION_ERROR","Failed to create folder for this author in <b>images/upload/</b> directory. For stable work of the script please create this folder manually.");
INSERT INTO meda_vocabulary VALUES("158","es","_ADMIN_FOLDER_CREATION_ERROR","No se pudo crear la carpeta para este autor en <b>images/upload/</b> directorio. Para el trabajo estable de la secuencia de comandos por favor crear esta carpeta de forma manual.");
INSERT INTO meda_vocabulary VALUES("159","de","_ADMIN_FOLDER_CREATION_ERROR","Fehler beim Ordner zu diesem Autor in <b>images/upload/</b> Verzeichnis. Für eine stabile Arbeit des Skripts erstellen Sie bitte diesen Ordner manuell.");
INSERT INTO meda_vocabulary VALUES("160","en","_ADMIN_LOGIN","Admin Login");
INSERT INTO meda_vocabulary VALUES("161","es","_ADMIN_LOGIN","Admin Login");
INSERT INTO meda_vocabulary VALUES("162","de","_ADMIN_LOGIN","Admin Login");
INSERT INTO meda_vocabulary VALUES("163","en","_ADMIN_MAILER_ALERT","Select which mailer you prefer to use for the delivery of site emails.");
INSERT INTO meda_vocabulary VALUES("164","es","_ADMIN_MAILER_ALERT","Seleccione el programa de correo que usted prefiere utilizar para la entrega de mensajes de correo electrónico del sitio.");
INSERT INTO meda_vocabulary VALUES("165","de","_ADMIN_MAILER_ALERT","Wählen Sie die Mailer Sie für die Zustellung von E-Mails vor Ort bevorzugen.");
INSERT INTO meda_vocabulary VALUES("166","en","_ADMIN_PANEL","Admin Panel");
INSERT INTO meda_vocabulary VALUES("167","es","_ADMIN_PANEL","Panel de Administración");
INSERT INTO meda_vocabulary VALUES("168","de","_ADMIN_PANEL","Admin-Panel");
INSERT INTO meda_vocabulary VALUES("169","en","_ADVANCED","Advanced");
INSERT INTO meda_vocabulary VALUES("170","es","_ADVANCED","Avanzada");
INSERT INTO meda_vocabulary VALUES("171","de","_ADVANCED","Fortgeschrittene");
INSERT INTO meda_vocabulary VALUES("172","en","_AFTER","After");
INSERT INTO meda_vocabulary VALUES("173","es","_AFTER","Después");
INSERT INTO meda_vocabulary VALUES("174","de","_AFTER","Nach");
INSERT INTO meda_vocabulary VALUES("175","en","_AGREE_CONF_TEXT","I have read and AGREE with Terms & Conditions");
INSERT INTO meda_vocabulary VALUES("176","es","_AGREE_CONF_TEXT","He leído y de acuerdo con Términos y Condiciones");
INSERT INTO meda_vocabulary VALUES("177","de","_AGREE_CONF_TEXT","Ich habe gelesen und akzeptiere AGB");
INSERT INTO meda_vocabulary VALUES("178","en","_ALBUM","Album");
INSERT INTO meda_vocabulary VALUES("179","es","_ALBUM","Álbum");
INSERT INTO meda_vocabulary VALUES("180","de","_ALBUM","Album");
INSERT INTO meda_vocabulary VALUES("181","en","_ALBUM_CODE","Album Code");
INSERT INTO meda_vocabulary VALUES("182","es","_ALBUM_CODE","Album Código");
INSERT INTO meda_vocabulary VALUES("183","de","_ALBUM_CODE","Album Code");
INSERT INTO meda_vocabulary VALUES("184","en","_ALBUM_NAME","Album Name");
INSERT INTO meda_vocabulary VALUES("185","es","_ALBUM_NAME","Nombre del álbum");
INSERT INTO meda_vocabulary VALUES("186","de","_ALBUM_NAME","Albumname");
INSERT INTO meda_vocabulary VALUES("187","en","_ALERT_REQUIRED_FILEDS","Items marked with an asterisk (<span class=mandatory_star>*</span>) are required");
INSERT INTO meda_vocabulary VALUES("188","es","_ALERT_REQUIRED_FILEDS","Los elementos marcados con un asterisco (<span class=mandatory_star>*</span>) son obligatorios");
INSERT INTO meda_vocabulary VALUES("189","de","_ALERT_REQUIRED_FILEDS","Felder mit einem Sternchen (<span class=mandatory_star>*</span>) sind erforderlich");
INSERT INTO meda_vocabulary VALUES("190","en","_ALL","All");
INSERT INTO meda_vocabulary VALUES("191","es","_ALL","Todo");
INSERT INTO meda_vocabulary VALUES("192","de","_ALL","Alle");
INSERT INTO meda_vocabulary VALUES("193","en","_ALLOW","Allow");
INSERT INTO meda_vocabulary VALUES("194","es","_ALLOW","Permitir");
INSERT INTO meda_vocabulary VALUES("195","de","_ALLOW","Erlauben");
INSERT INTO meda_vocabulary VALUES("196","en","_ALLOW_COMMENTS","Allow Comments");
INSERT INTO meda_vocabulary VALUES("197","es","_ALLOW_COMMENTS","Permitir comentarios");
INSERT INTO meda_vocabulary VALUES("198","de","_ALLOW_COMMENTS","Kommentare zulassen");
INSERT INTO meda_vocabulary VALUES("199","en","_ALL_SPECIALITIES","all specialities");
INSERT INTO meda_vocabulary VALUES("200","es","_ALL_SPECIALITIES","todas las especialidades");
INSERT INTO meda_vocabulary VALUES("201","de","_ALL_SPECIALITIES","Alle Fach");
INSERT INTO meda_vocabulary VALUES("202","en","_ALREADY_HAVE_APPOINTMENT","You already have an appointment to doctor: _DOCTOR_ at _DATE_! <br>Please choose another date or <a href=index.php?patient=my_appointments>cancel</a> a previous appointment to book another one.");
INSERT INTO meda_vocabulary VALUES("203","es","_ALREADY_HAVE_APPOINTMENT","Usted ya tiene una cita con el médico: _DOCTOR_ en _DATE_! <br>Por favor, elija otro día o <a href=index.php?patient=my_appointments>Cancelar </a> una cita previa para reservar otro.");
INSERT INTO meda_vocabulary VALUES("204","de","_ALREADY_HAVE_APPOINTMENT","Sie haben bereits einen Termin für den Arzt: _DOCTOR_ bei _DATE_! <br>Bitte wählen Sie einen anderen Tag oder <a href=index.php?patient=my_appointments>abbrechen</a> einen früheren Termin vereinbaren, um ein anderes zu buchen.");
INSERT INTO meda_vocabulary VALUES("205","en","_ALREADY_LOGGED","You are already logged in!");
INSERT INTO meda_vocabulary VALUES("206","es","_ALREADY_LOGGED","Usted ya está registrado!");
INSERT INTO meda_vocabulary VALUES("207","de","_ALREADY_LOGGED","Sie sind bereits angemeldet!");
INSERT INTO meda_vocabulary VALUES("208","en","_AMOUNT","Amount");
INSERT INTO meda_vocabulary VALUES("209","es","_AMOUNT","Cantidad");
INSERT INTO meda_vocabulary VALUES("210","de","_AMOUNT","Betrag");
INSERT INTO meda_vocabulary VALUES("211","en","_ANSWER","Answer");
INSERT INTO meda_vocabulary VALUES("212","es","_ANSWER","Respuesta");
INSERT INTO meda_vocabulary VALUES("213","de","_ANSWER","Antwort");
INSERT INTO meda_vocabulary VALUES("214","en","_APPLY","Apply");
INSERT INTO meda_vocabulary VALUES("215","es","_APPLY","Aplicar");
INSERT INTO meda_vocabulary VALUES("216","de","_APPLY","Anwenden");
INSERT INTO meda_vocabulary VALUES("217","en","_APPLY_TO_ALL_LANGUAGES","Apply to all languages");
INSERT INTO meda_vocabulary VALUES("218","es","_APPLY_TO_ALL_LANGUAGES","Se aplican a todos los idiomas");
INSERT INTO meda_vocabulary VALUES("219","de","_APPLY_TO_ALL_LANGUAGES","Gelten für alle Sprachen");
INSERT INTO meda_vocabulary VALUES("220","en","_APPLY_TO_ALL_PAGES","Apply changes to all pages");
INSERT INTO meda_vocabulary VALUES("221","es","_APPLY_TO_ALL_PAGES","Aplicar cambios a todas las páginas");
INSERT INTO meda_vocabulary VALUES("222","de","_APPLY_TO_ALL_PAGES","Ünderungen für alle Seiten");
INSERT INTO meda_vocabulary VALUES("223","en","_APPOINTMENTS","Appointments");
INSERT INTO meda_vocabulary VALUES("224","es","_APPOINTMENTS","Citas");
INSERT INTO meda_vocabulary VALUES("225","de","_APPOINTMENTS","Ausstattung");
INSERT INTO meda_vocabulary VALUES("226","en","_APPOINTMENTS_AWAITING_APPROVAL_ALERT","There are _COUNT_ appointment/s awaiting your moderation. Click <a href=\'_HREF_\'>here</a> for review.");
INSERT INTO meda_vocabulary VALUES("227","es","_APPOINTMENTS_AWAITING_APPROVAL_ALERT","Hay citas _COUNT_ esperan su moderación. Haga clic <a href=\'_HREF_\'>aquí</a> para su revisión.");
INSERT INTO meda_vocabulary VALUES("228","de","_APPOINTMENTS_AWAITING_APPROVAL_ALERT","Es gibt _COUNT_ Termine auf Ihren Maßen. Klicken Sie <a href=\'_HREF_\'>hier</a> für die Überprüfung.");
INSERT INTO meda_vocabulary VALUES("229","en","_APPOINTMENTS_MANAGEMENT","Appointments Management");
INSERT INTO meda_vocabulary VALUES("230","es","_APPOINTMENTS_MANAGEMENT","Nombramientos de directivos");
INSERT INTO meda_vocabulary VALUES("231","de","_APPOINTMENTS_MANAGEMENT","Termine verwalten");
INSERT INTO meda_vocabulary VALUES("232","en","_APPOINTMENTS_SETTINGS","Appointments Settings");
INSERT INTO meda_vocabulary VALUES("233","es","_APPOINTMENTS_SETTINGS","Citas Configuración");
INSERT INTO meda_vocabulary VALUES("234","de","_APPOINTMENTS_SETTINGS","Termine Einstellungen");
INSERT INTO meda_vocabulary VALUES("235","en","_APPOINTMENT_ALREADY_BOOKED_ALERT","You have already booked this appointment! You cannot book it again.");
INSERT INTO meda_vocabulary VALUES("236","es","_APPOINTMENT_ALREADY_BOOKED_ALERT","Usted ya ha reservado esta cita! No se puede reservar de nuevo.");
INSERT INTO meda_vocabulary VALUES("237","de","_APPOINTMENT_ALREADY_BOOKED_ALERT","Sie haben bereits diesen Termin gebucht! Sie können nicht buchen Sie es erneut.");
INSERT INTO meda_vocabulary VALUES("238","en","_APPOINTMENT_APPROVED_BY_ADMINISTRATION","Appointment has been approved");
INSERT INTO meda_vocabulary VALUES("239","es","_APPOINTMENT_APPROVED_BY_ADMINISTRATION","Nombramiento ha sido aprobado");
INSERT INTO meda_vocabulary VALUES("240","de","_APPOINTMENT_APPROVED_BY_ADMINISTRATION","Termin genehmigt wurde");
INSERT INTO meda_vocabulary VALUES("241","en","_APPOINTMENT_ASSIGNED_TO_ADMIN_ALERT","Appointment has been assigned to admin! Click <b>Book Now</b> button to proceed.");
INSERT INTO meda_vocabulary VALUES("242","es","_APPOINTMENT_ASSIGNED_TO_ADMIN_ALERT","Nombramiento ha asignado a Admin! Haga clic <b>Reserve ahora</b> para continuar.");
INSERT INTO meda_vocabulary VALUES("243","de","_APPOINTMENT_ASSIGNED_TO_ADMIN_ALERT","Termin zugewiesen wurde an den Admin! Klicken Sie auf <b>Jetzt buchen</b>, um fortzufahren.");
INSERT INTO meda_vocabulary VALUES("244","en","_APPOINTMENT_ASSIGNED_TO_ADMIN_MSG","This appointment is assigned to administrator.");
INSERT INTO meda_vocabulary VALUES("245","es","_APPOINTMENT_ASSIGNED_TO_ADMIN_MSG","Este nombramiento se asigna al administrador.");
INSERT INTO meda_vocabulary VALUES("246","de","_APPOINTMENT_ASSIGNED_TO_ADMIN_MSG","Dieser Termin wird dem Administrator zugeordnet.");
INSERT INTO meda_vocabulary VALUES("247","en","_APPOINTMENT_ASSIGNED_TO_PATIENT_ALERT","Appointment has been assigned to a selected patient! Click <b>Book Now</b> button to proceed.");
INSERT INTO meda_vocabulary VALUES("248","es","_APPOINTMENT_ASSIGNED_TO_PATIENT_ALERT","Nombramiento haya sido asignado a un paciente seleccionado! Haga clic <b>Reserve Ahora</b> para continuar.");
INSERT INTO meda_vocabulary VALUES("249","de","_APPOINTMENT_ASSIGNED_TO_PATIENT_ALERT","Termin hat zu einem ausgewählten Patienten zugeordnet! Klicken Sie auf <b>Jetzt buchen</b>, um fortzufahren.");
INSERT INTO meda_vocabulary VALUES("250","en","_APPOINTMENT_ASSIGNED_TO_PATIENT_MSG","This appointment is assigned to patient: _PATIENT_.");
INSERT INTO meda_vocabulary VALUES("251","es","_APPOINTMENT_ASSIGNED_TO_PATIENT_MSG","Este nombramiento se asigna al paciente: _PATIENT_.");
INSERT INTO meda_vocabulary VALUES("252","de","_APPOINTMENT_ASSIGNED_TO_PATIENT_MSG","Diese Ernennung ist mit Patienten zugeordnet: _PATIENT_.");
INSERT INTO meda_vocabulary VALUES("253","en","_APPOINTMENT_CANCELED_BY_ADMINISTRATION","Appointment has been canceled");
INSERT INTO meda_vocabulary VALUES("254","es","_APPOINTMENT_CANCELED_BY_ADMINISTRATION","Cita ha sido cancelada");
INSERT INTO meda_vocabulary VALUES("255","de","_APPOINTMENT_CANCELED_BY_ADMINISTRATION","Termin wurde abgesagt");
INSERT INTO meda_vocabulary VALUES("256","en","_APPOINTMENT_CONFIRMATION","Appointment Confirmation");
INSERT INTO meda_vocabulary VALUES("257","es","_APPOINTMENT_CONFIRMATION","Nombramiento de confirmación");
INSERT INTO meda_vocabulary VALUES("258","de","_APPOINTMENT_CONFIRMATION","Terminbestätigung");
INSERT INTO meda_vocabulary VALUES("259","en","_APPOINTMENT_DELETE_IN_PAST_ALERT","You cannot delete appointments in the past!");
INSERT INTO meda_vocabulary VALUES("260","es","_APPOINTMENT_DELETE_IN_PAST_ALERT","No se puede eliminar citas en el pasado!");
INSERT INTO meda_vocabulary VALUES("261","de","_APPOINTMENT_DELETE_IN_PAST_ALERT","Können nicht gelöscht werden Termine in der Vergangenheit!");
INSERT INTO meda_vocabulary VALUES("262","en","_APPOINTMENT_DETAILS","Appointment Details");
INSERT INTO meda_vocabulary VALUES("263","es","_APPOINTMENT_DETAILS","Detalles de la cita");
INSERT INTO meda_vocabulary VALUES("264","de","_APPOINTMENT_DETAILS","Details zum Termin");
INSERT INTO meda_vocabulary VALUES("265","en","_APPOINTMENT_INFO","Appointment Info");
INSERT INTO meda_vocabulary VALUES("266","es","_APPOINTMENT_INFO","Nombramiento Info");
INSERT INTO meda_vocabulary VALUES("267","de","_APPOINTMENT_INFO","Ernennung info");
INSERT INTO meda_vocabulary VALUES("268","en","_APPOINTMENT_NUMBER","Appointment Number");
INSERT INTO meda_vocabulary VALUES("269","es","_APPOINTMENT_NUMBER","Nombramiento Número");
INSERT INTO meda_vocabulary VALUES("270","de","_APPOINTMENT_NUMBER","Termin Nummer");
INSERT INTO meda_vocabulary VALUES("271","en","_APPOINTMENT_SIGNIN_ALERT","To complete this appointment you must be logged in as a patient");
INSERT INTO meda_vocabulary VALUES("272","es","_APPOINTMENT_SIGNIN_ALERT","Para completar esta cita usted debe estar registrado como un paciente");
INSERT INTO meda_vocabulary VALUES("273","de","_APPOINTMENT_SIGNIN_ALERT","Um diesen Termin abzuschließen, müssen Sie sich als Patient angemeldet sein.");
INSERT INTO meda_vocabulary VALUES("274","en","_APPOINTMENT_SUCCESS_BOOKED","Thank you! Your appointment has been successfully booked.");
INSERT INTO meda_vocabulary VALUES("275","es","_APPOINTMENT_SUCCESS_BOOKED","¡Gracias! Su cita ha sido exitosamente reservado.");
INSERT INTO meda_vocabulary VALUES("276","de","_APPOINTMENT_SUCCESS_BOOKED","Vielen Dank! Ihre Ernennung wurde erfolgreich gebucht.");
INSERT INTO meda_vocabulary VALUES("277","en","_APPOINTMENT_WITH_DOCTOR","Appointment with a doctor");
INSERT INTO meda_vocabulary VALUES("278","es","_APPOINTMENT_WITH_DOCTOR","Cita con un médico");
INSERT INTO meda_vocabulary VALUES("279","de","_APPOINTMENT_WITH_DOCTOR","Termin mit einem Arzt");
INSERT INTO meda_vocabulary VALUES("280","en","_APPROVAL_TIME_EXPIRED","Approval period has expired");
INSERT INTO meda_vocabulary VALUES("281","es","_APPROVAL_TIME_EXPIRED","Aprobación período ha expirado");
INSERT INTO meda_vocabulary VALUES("282","de","_APPROVAL_TIME_EXPIRED","Zulassung abgelaufen");
INSERT INTO meda_vocabulary VALUES("283","en","_APPROVE","Approve");
INSERT INTO meda_vocabulary VALUES("284","es","_APPROVE","Aprobar");
INSERT INTO meda_vocabulary VALUES("285","de","_APPROVE","Genehmigen");
INSERT INTO meda_vocabulary VALUES("286","en","_APPROVED","Approved");
INSERT INTO meda_vocabulary VALUES("287","es","_APPROVED","Aprobado");
INSERT INTO meda_vocabulary VALUES("288","de","_APPROVED","Genehmigt");
INSERT INTO meda_vocabulary VALUES("289","en","_APPT_CONFIRMED_ALREADY_MSG","Your appointment has already been confirmed! <br><br>Click <a href=\'index.php?patient=my_appointments\'>here</a> to continue.");
INSERT INTO meda_vocabulary VALUES("290","es","_APPT_CONFIRMED_ALREADY_MSG","Su nombramiento ya se ha confirmado! <br><br>Haga clic <a href=\'index.php?patient=my_appointments\'>aquí</a> para continuar.");
INSERT INTO meda_vocabulary VALUES("291","de","_APPT_CONFIRMED_ALREADY_MSG","Ihr Termin ist bereits bestätigt! <br><br>Klicken Sie <a href=\'index.php?patient=my_appointments\'>hier</a>, um fortzufahren.");
INSERT INTO meda_vocabulary VALUES("292","en","_APPT_CONFIRMED_SUCCESS_MSG","Thank you for confirming your appointment. We look forward to seeing you soon. <br>To see your current appointments please click <a href=\'index.php?patient=my_appointments\'>here</a>.");
INSERT INTO meda_vocabulary VALUES("293","es","_APPT_CONFIRMED_SUCCESS_MSG","Gracias por confirmar su cita. Esperamos verle pronto. <br>Para ver las citas actuales por favor haga clic en <a href=\'index.php?patient=my_appointments\'>aquí</a>.");
INSERT INTO meda_vocabulary VALUES("294","de","_APPT_CONFIRMED_SUCCESS_MSG","Danke für die Bestätigung Ihres Termins. Wir freuen uns, Sie bald zu sehen. <br>Um Ihre aktuellen Termine sehen klicken Sie bitte <a href=\'index.php?patient=my_appointments\'>hier</a>.");
INSERT INTO meda_vocabulary VALUES("295","en","_APPT_CREATED_CONF_BY_ADMIN_MSG","Your appointment has been successfully reserved, but it\'s not complete yet! An email with details of your request is sent to your email address. We\'ll notify you after administrator will approve your appointment.");
INSERT INTO meda_vocabulary VALUES("296","es","_APPT_CREATED_CONF_BY_ADMIN_MSG","Su cita ha sido exitosamente reservados, pero no es completa todavía! Un correo electrónico con los detalles de su solicitud fue enviada a su dirección de correo electrónico. Le notificaremos de administrador después de se apruebe su nombramiento.");
INSERT INTO meda_vocabulary VALUES("297","de","_APPT_CREATED_CONF_BY_ADMIN_MSG","Ihre Ernennung wurde erfolgreich reserviert, aber es ist noch nicht fertig! Eine E-Mail mit Angabe Ihrer Anfrage wurde an Ihre E-Mail-Adresse gesendet. Wir benachrichtigen Sie nach Ihrem Termin Administrator genehmigt werden.");
INSERT INTO meda_vocabulary VALUES("298","en","_APPT_CREATED_CONF_BY_EMAIL_MSG","Your appointment has been successfully reserved, but it\'s not complete yet! Within a few minutes, you will receive by email a request to confirm your appointment.");
INSERT INTO meda_vocabulary VALUES("299","es","_APPT_CREATED_CONF_BY_EMAIL_MSG","Su cita ha sido exitosamente reservados, pero no es completa todavía! A los pocos minutos, usted recibirá por correo electrónico una solicitud para confirmar su cita.");
INSERT INTO meda_vocabulary VALUES("300","de","_APPT_CREATED_CONF_BY_EMAIL_MSG","Ihre Ernennung wurde erfolgreich reserviert, aber es ist noch nicht fertig! Innerhalb weniger Minuten erhalten Sie per E-Mail eine Anfrage an Ihren Termin zu bestätigen.");
INSERT INTO meda_vocabulary VALUES("301","en","_APRIL","April");
INSERT INTO meda_vocabulary VALUES("302","es","_APRIL","Abril");
INSERT INTO meda_vocabulary VALUES("303","de","_APRIL","April");
INSERT INTO meda_vocabulary VALUES("304","en","_ARRIVAL_REMINDER_SENT","Arrival Reminder Sent");
INSERT INTO meda_vocabulary VALUES("305","es","_ARRIVAL_REMINDER_SENT","Recordatorio de llegada enviado");
INSERT INTO meda_vocabulary VALUES("306","de","_ARRIVAL_REMINDER_SENT","Ankunft Mahnung");
INSERT INTO meda_vocabulary VALUES("307","en","_ARTICLE","Article");
INSERT INTO meda_vocabulary VALUES("308","es","_ARTICLE","Artículo");
INSERT INTO meda_vocabulary VALUES("309","de","_ARTICLE","Artikel");
INSERT INTO meda_vocabulary VALUES("310","en","_ARTICLE_ID","Article ID");
INSERT INTO meda_vocabulary VALUES("311","es","_ARTICLE_ID","Id. de artículo");
INSERT INTO meda_vocabulary VALUES("312","de","_ARTICLE_ID","Artikel-ID");
INSERT INTO meda_vocabulary VALUES("313","en","_ASSIGN_PATIENT","Assign Patient");
INSERT INTO meda_vocabulary VALUES("314","es","_ASSIGN_PATIENT","Asigne Paciente");
INSERT INTO meda_vocabulary VALUES("315","de","_ASSIGN_PATIENT","Weisen Patienten");
INSERT INTO meda_vocabulary VALUES("316","en","_AT_TIME","at");
INSERT INTO meda_vocabulary VALUES("317","es","_AT_TIME","en");
INSERT INTO meda_vocabulary VALUES("318","de","_AT_TIME","bei");
INSERT INTO meda_vocabulary VALUES("319","en","_AUGUST","August");
INSERT INTO meda_vocabulary VALUES("320","es","_AUGUST","Agosto");
INSERT INTO meda_vocabulary VALUES("321","de","_AUGUST","August");
INSERT INTO meda_vocabulary VALUES("322","en","_AUTHENTICATION","Authentication");
INSERT INTO meda_vocabulary VALUES("323","es","_AUTHENTICATION","Autenticación");
INSERT INTO meda_vocabulary VALUES("324","de","_AUTHENTICATION","Authentifizierung");
INSERT INTO meda_vocabulary VALUES("325","en","_AUTHORIZE_NET_NOTICE","The Authorize.Net payment gateway service provider.");
INSERT INTO meda_vocabulary VALUES("326","es","_AUTHORIZE_NET_NOTICE","El pago Authorize.Net portal de proveedores de servicios.");
INSERT INTO meda_vocabulary VALUES("327","de","_AUTHORIZE_NET_NOTICE","Die Authorize.Net Payment Gateway Service Provider.");
INSERT INTO meda_vocabulary VALUES("328","en","_AUTHORIZE_NET_ORDER","Authorize.Net Order");
INSERT INTO meda_vocabulary VALUES("329","es","_AUTHORIZE_NET_ORDER","Authorize.Net Orden");
INSERT INTO meda_vocabulary VALUES("330","de","_AUTHORIZE_NET_ORDER","Authorize.Net Auftrag");
INSERT INTO meda_vocabulary VALUES("331","en","_AWARDS_AND_PUBLICATIONS","Awards and Publications");
INSERT INTO meda_vocabulary VALUES("332","es","_AWARDS_AND_PUBLICATIONS","Premios y Publicaciones");
INSERT INTO meda_vocabulary VALUES("333","de","_AWARDS_AND_PUBLICATIONS","Auszeichnungen und Publikationen");
INSERT INTO meda_vocabulary VALUES("334","en","_BACKUP","Backup");
INSERT INTO meda_vocabulary VALUES("335","es","_BACKUP","Reserva");
INSERT INTO meda_vocabulary VALUES("336","de","_BACKUP","Backup");
INSERT INTO meda_vocabulary VALUES("337","en","_BACKUPS_EXISTING","Existing Backups");
INSERT INTO meda_vocabulary VALUES("338","es","_BACKUPS_EXISTING","Copias de seguridad existentes");
INSERT INTO meda_vocabulary VALUES("339","de","_BACKUPS_EXISTING","Vorhandene Backups");
INSERT INTO meda_vocabulary VALUES("340","en","_BACKUP_AND_RESTORE","Backup & Restore");
INSERT INTO meda_vocabulary VALUES("341","es","_BACKUP_AND_RESTORE","Backup & Restore");
INSERT INTO meda_vocabulary VALUES("342","de","_BACKUP_AND_RESTORE","Backup & Restore");
INSERT INTO meda_vocabulary VALUES("343","en","_BACKUP_CHOOSE_MSG","Choose a backup from the list below");
INSERT INTO meda_vocabulary VALUES("344","es","_BACKUP_CHOOSE_MSG","Elija una copia de seguridad de la siguiente lista");
INSERT INTO meda_vocabulary VALUES("345","de","_BACKUP_CHOOSE_MSG","Wählen Sie ein Backup von der Liste unten");
INSERT INTO meda_vocabulary VALUES("346","en","_BACKUP_DELETE_ALERT","Are you sure you want to delete this backup?");
INSERT INTO meda_vocabulary VALUES("347","es","_BACKUP_DELETE_ALERT","¿Estás seguro de que quieres eliminar esta copia de seguridad?");
INSERT INTO meda_vocabulary VALUES("348","de","_BACKUP_DELETE_ALERT","Sind Sie sicher, dass Sie diese Sicherung löschen?");
INSERT INTO meda_vocabulary VALUES("349","en","_BACKUP_EMPTY_MSG","No existing backups found.");
INSERT INTO meda_vocabulary VALUES("350","es","_BACKUP_EMPTY_MSG","No hay copias de seguridad todavía.");
INSERT INTO meda_vocabulary VALUES("351","de","_BACKUP_EMPTY_MSG","Keine vorhandenen Backups gefunden.");
INSERT INTO meda_vocabulary VALUES("352","en","_BACKUP_EMPTY_NAME_ALERT","Name of backup file cannot be empty! Please re-enter.");
INSERT INTO meda_vocabulary VALUES("353","es","_BACKUP_EMPTY_NAME_ALERT","Nombre del archivo de copia de seguridad no puede estar vacío! Por favor, vuelva a entrar.");
INSERT INTO meda_vocabulary VALUES("354","de","_BACKUP_EMPTY_NAME_ALERT","Namen der Backup-Datei darf nicht leer sein! Bitte geben Sie erneut.");
INSERT INTO meda_vocabulary VALUES("355","en","_BACKUP_EXECUTING_ERROR","An error occurred while backup the system! Please check write permissions to backup folder or try again later.");
INSERT INTO meda_vocabulary VALUES("356","es","_BACKUP_EXECUTING_ERROR","Ha ocurrido un error mientras copia de seguridad del sistema! Por favor, compruebe los permisos de escritura a la copia de seguridad de carpetas o inténtelo de nuevo más tarde.");
INSERT INTO meda_vocabulary VALUES("357","de","_BACKUP_EXECUTING_ERROR","Fehler beim Backup des Systems! Bitte überprüfen Sie Schreibzugriff auf Backup-Ordner oder versuchen Sie es später erneut.");
INSERT INTO meda_vocabulary VALUES("358","en","_BACKUP_INSTALLATION","Backup Installation");
INSERT INTO meda_vocabulary VALUES("359","es","_BACKUP_INSTALLATION","Instalación de copia de seguridad");
INSERT INTO meda_vocabulary VALUES("360","de","_BACKUP_INSTALLATION","Backup-Installation");
INSERT INTO meda_vocabulary VALUES("361","en","_BACKUP_RESTORE","Backup Restore");
INSERT INTO meda_vocabulary VALUES("362","es","_BACKUP_RESTORE","Restaurar copia de seguridad");
INSERT INTO meda_vocabulary VALUES("363","de","_BACKUP_RESTORE","Backup wiederherstellen");
INSERT INTO meda_vocabulary VALUES("364","en","_BACKUP_RESTORE_ALERT","Are you sure you want to restore this backup");
INSERT INTO meda_vocabulary VALUES("365","es","_BACKUP_RESTORE_ALERT","¿Estás seguro de que desea restaurar esta copia de seguridad");
INSERT INTO meda_vocabulary VALUES("366","de","_BACKUP_RESTORE_ALERT","Sind Sie sicher, dass Sie diese Sicherung wiederherstellen");
INSERT INTO meda_vocabulary VALUES("367","en","_BACKUP_RESTORE_NOTE","Remember: this action will rewrite all your current settings!");
INSERT INTO meda_vocabulary VALUES("368","es","_BACKUP_RESTORE_NOTE","Recuerde: esta acción volverá a escribir todos los valores actuales!");
INSERT INTO meda_vocabulary VALUES("369","de","_BACKUP_RESTORE_NOTE","Denken Sie daran: diese Aktion werden alle aktuellen Einstellungen neu zu schreiben!");
INSERT INTO meda_vocabulary VALUES("370","en","_BACKUP_RESTORING_ERROR","An error occurred while restoring file! Please try again later.");
INSERT INTO meda_vocabulary VALUES("371","es","_BACKUP_RESTORING_ERROR","Se produjo un error mientras se restaura el archivo! Por favor, inténtelo de nuevo más tarde.");
INSERT INTO meda_vocabulary VALUES("372","de","_BACKUP_RESTORING_ERROR","Fehler beim Wiederherstellen-Datei! Bitte versuchen Sie es später erneut.");
INSERT INTO meda_vocabulary VALUES("373","en","_BACKUP_WAS_CREATED","Backup _FILE_NAME_ has been successfully created.");
INSERT INTO meda_vocabulary VALUES("374","es","_BACKUP_WAS_CREATED","_FILE_NAME_ De copia de seguridad se ha creado correctamente.");
INSERT INTO meda_vocabulary VALUES("375","de","_BACKUP_WAS_CREATED","Backup _FILE_NAME_ wurde erfolgreich erstellt.");
INSERT INTO meda_vocabulary VALUES("376","en","_BACKUP_WAS_DELETED","Backup _FILE_NAME_ has been successfully deleted.");
INSERT INTO meda_vocabulary VALUES("377","es","_BACKUP_WAS_DELETED","_FILE_NAME_ De copia de seguridad ha sido borrado.");
INSERT INTO meda_vocabulary VALUES("378","de","_BACKUP_WAS_DELETED","Backup _FILE_NAME_ wurde erfolgreich gelöscht.");
INSERT INTO meda_vocabulary VALUES("379","en","_BACKUP_WAS_RESTORED","Backup _FILE_NAME_ has been successfully restored.");
INSERT INTO meda_vocabulary VALUES("380","es","_BACKUP_WAS_RESTORED","_FILE_NAME_ De copia de seguridad fue restaurado con éxito.");
INSERT INTO meda_vocabulary VALUES("381","de","_BACKUP_WAS_RESTORED","Backup _FILE_NAME_ wurde erfolgreich wiederhergestellt.");
INSERT INTO meda_vocabulary VALUES("382","en","_BACKUP_YOUR_INSTALLATION","Backup your current Installation");
INSERT INTO meda_vocabulary VALUES("383","es","_BACKUP_YOUR_INSTALLATION","Copia de seguridad de la instalación actual");
INSERT INTO meda_vocabulary VALUES("384","de","_BACKUP_YOUR_INSTALLATION","Sichern Sie Ihre aktuelle Installation");
INSERT INTO meda_vocabulary VALUES("385","en","_BACK_TO_ADMIN_PANEL","Back to Admin Panel");
INSERT INTO meda_vocabulary VALUES("386","es","_BACK_TO_ADMIN_PANEL","Volver al panel de administración");
INSERT INTO meda_vocabulary VALUES("387","de","_BACK_TO_ADMIN_PANEL","Zurück zu Admin Panel");
INSERT INTO meda_vocabulary VALUES("388","en","_BACK_TO_LOGIN","Back to login");
INSERT INTO meda_vocabulary VALUES("389","es","_BACK_TO_LOGIN","Volver a la entrada");
INSERT INTO meda_vocabulary VALUES("390","de","_BACK_TO_LOGIN","Zurück zum Login");
INSERT INTO meda_vocabulary VALUES("391","en","_BANNERS","Banners");
INSERT INTO meda_vocabulary VALUES("392","es","_BANNERS","Banners");
INSERT INTO meda_vocabulary VALUES("393","de","_BANNERS","Banner");
INSERT INTO meda_vocabulary VALUES("394","en","_BANNERS_MANAGEMENT","Banners Management");
INSERT INTO meda_vocabulary VALUES("395","es","_BANNERS_MANAGEMENT","Banners de Gestión");
INSERT INTO meda_vocabulary VALUES("396","de","_BANNERS_MANAGEMENT","Banner-Management");
INSERT INTO meda_vocabulary VALUES("397","en","_BANNERS_SETTINGS","Banners Settings");
INSERT INTO meda_vocabulary VALUES("398","es","_BANNERS_SETTINGS","Banners Configuración");
INSERT INTO meda_vocabulary VALUES("399","de","_BANNERS_SETTINGS","Banner-Einstellungen");
INSERT INTO meda_vocabulary VALUES("400","en","_BANNER_IMAGE","Banner Image");
INSERT INTO meda_vocabulary VALUES("401","es","_BANNER_IMAGE","Banner Imagen");
INSERT INTO meda_vocabulary VALUES("402","de","_BANNER_IMAGE","Banner Image");
INSERT INTO meda_vocabulary VALUES("403","en","_BAN_ITEM","Ban Item");
INSERT INTO meda_vocabulary VALUES("404","es","_BAN_ITEM","Venta de artículo");
INSERT INTO meda_vocabulary VALUES("405","de","_BAN_ITEM","Ban Posten");
INSERT INTO meda_vocabulary VALUES("406","en","_BAN_LIST","Ban List");
INSERT INTO meda_vocabulary VALUES("407","es","_BAN_LIST","Lista de prohibición");
INSERT INTO meda_vocabulary VALUES("408","de","_BAN_LIST","Ban Liste");
INSERT INTO meda_vocabulary VALUES("409","en","_BEFORE","Before");
INSERT INTO meda_vocabulary VALUES("410","es","_BEFORE","Antes");
INSERT INTO meda_vocabulary VALUES("411","de","_BEFORE","Vorher");
INSERT INTO meda_vocabulary VALUES("412","en","_BILLING_ADDRESS","Billing Address");
INSERT INTO meda_vocabulary VALUES("413","es","_BILLING_ADDRESS","Dirección de facturación");
INSERT INTO meda_vocabulary VALUES("414","de","_BILLING_ADDRESS","Rechnungsadresse");
INSERT INTO meda_vocabulary VALUES("415","en","_BILLING_INFORMATION","Billing Information");
INSERT INTO meda_vocabulary VALUES("416","es","_BILLING_INFORMATION","Información de facturación");
INSERT INTO meda_vocabulary VALUES("417","de","_BILLING_INFORMATION","Informationen zur Abrechnung");
INSERT INTO meda_vocabulary VALUES("418","en","_BIRTH_DATE","Birth Date");
INSERT INTO meda_vocabulary VALUES("419","es","_BIRTH_DATE","Fecha de nacimiento");
INSERT INTO meda_vocabulary VALUES("420","de","_BIRTH_DATE","Geburtsdatum");
INSERT INTO meda_vocabulary VALUES("421","en","_BIRTH_DATE_VALID_ALERT","Birth date has been entered in wrong format! Please re-enter.");
INSERT INTO meda_vocabulary VALUES("422","es","_BIRTH_DATE_VALID_ALERT","Fecha de nacimiento fue inscrita en un formato incorrecto! Por favor, vuelva a entrar.");
INSERT INTO meda_vocabulary VALUES("423","de","_BIRTH_DATE_VALID_ALERT","Geburtsdatum war im falschen Format eingegeben! Bitte erneut eingeben.");
INSERT INTO meda_vocabulary VALUES("424","en","_BLUE","Blue");
INSERT INTO meda_vocabulary VALUES("425","es","_BLUE","Azul");
INSERT INTO meda_vocabulary VALUES("426","de","_BLUE","Blue");
INSERT INTO meda_vocabulary VALUES("427","en","_BOARD_CERTIFICATIONS","Board Certifications");
INSERT INTO meda_vocabulary VALUES("428","es","_BOARD_CERTIFICATIONS","Certificaciones de la Junta");
INSERT INTO meda_vocabulary VALUES("429","de","_BOARD_CERTIFICATIONS","Foren-Zertifizierungen");
INSERT INTO meda_vocabulary VALUES("430","en","_BOOKING_APPOINTMENT_ERROR","An error occurred while trying to book this appointment! Please try again later.");
INSERT INTO meda_vocabulary VALUES("431","es","_BOOKING_APPOINTMENT_ERROR","Se produjo un error al tratar de reservar a esta cita! Por favor, inténtelo de nuevo más tarde.");
INSERT INTO meda_vocabulary VALUES("432","de","_BOOKING_APPOINTMENT_ERROR","Ein Fehler beim Versuch, diesen Termin zu buchen! Bitte versuchen Sie es später erneut.");
INSERT INTO meda_vocabulary VALUES("433","en","_BOOK_NOW","Book Now");
INSERT INTO meda_vocabulary VALUES("434","es","_BOOK_NOW","Reservar ahora");
INSERT INTO meda_vocabulary VALUES("435","de","_BOOK_NOW","Jetzt buchen");
INSERT INTO meda_vocabulary VALUES("436","en","_BOTTOM","Bottom");
INSERT INTO meda_vocabulary VALUES("437","es","_BOTTOM","Inferior");
INSERT INTO meda_vocabulary VALUES("438","de","_BOTTOM","Boden");
INSERT INTO meda_vocabulary VALUES("439","en","_BROWSE_IN_CALENDAR","Browse in Calendar");
INSERT INTO meda_vocabulary VALUES("440","es","_BROWSE_IN_CALENDAR","Busque en el calendario");
INSERT INTO meda_vocabulary VALUES("441","de","_BROWSE_IN_CALENDAR","Stöbern Sie in Kalender");
INSERT INTO meda_vocabulary VALUES("442","en","_BUTTON_BACK","Back");
INSERT INTO meda_vocabulary VALUES("443","es","_BUTTON_BACK","Espalda");
INSERT INTO meda_vocabulary VALUES("444","de","_BUTTON_BACK","Zurück");
INSERT INTO meda_vocabulary VALUES("445","en","_BUTTON_CANCEL","Cancel");
INSERT INTO meda_vocabulary VALUES("446","es","_BUTTON_CANCEL","Cancelar");
INSERT INTO meda_vocabulary VALUES("447","de","_BUTTON_CANCEL","Abbrechen");
INSERT INTO meda_vocabulary VALUES("448","en","_BUTTON_CHANGE","Change");
INSERT INTO meda_vocabulary VALUES("449","es","_BUTTON_CHANGE","Cambiar");
INSERT INTO meda_vocabulary VALUES("450","de","_BUTTON_CHANGE","Ündern");
INSERT INTO meda_vocabulary VALUES("451","en","_BUTTON_CHANGE_PASSWORD","Change Password");
INSERT INTO meda_vocabulary VALUES("452","es","_BUTTON_CHANGE_PASSWORD","Cambiar Contraseña");
INSERT INTO meda_vocabulary VALUES("453","de","_BUTTON_CHANGE_PASSWORD","Passwort ändern");
INSERT INTO meda_vocabulary VALUES("454","en","_BUTTON_CREATE","Create");
INSERT INTO meda_vocabulary VALUES("455","es","_BUTTON_CREATE","Crear");
INSERT INTO meda_vocabulary VALUES("456","de","_BUTTON_CREATE","Erstellen");
INSERT INTO meda_vocabulary VALUES("457","en","_BUTTON_LOGIN","Login");
INSERT INTO meda_vocabulary VALUES("458","es","_BUTTON_LOGIN","Login");
INSERT INTO meda_vocabulary VALUES("459","de","_BUTTON_LOGIN","Login");
INSERT INTO meda_vocabulary VALUES("460","en","_BUTTON_LOGOUT","Logout");
INSERT INTO meda_vocabulary VALUES("461","es","_BUTTON_LOGOUT","Cerrar sesión");
INSERT INTO meda_vocabulary VALUES("462","de","_BUTTON_LOGOUT","Abmelden");
INSERT INTO meda_vocabulary VALUES("463","en","_BUTTON_RESET","Reset");
INSERT INTO meda_vocabulary VALUES("464","es","_BUTTON_RESET","Perdí");
INSERT INTO meda_vocabulary VALUES("465","de","_BUTTON_RESET","Reset");
INSERT INTO meda_vocabulary VALUES("466","en","_BUTTON_REWRITE","Rewrite Vocabulary");
INSERT INTO meda_vocabulary VALUES("467","es","_BUTTON_REWRITE","Vuelva a escribir Vocabulario");
INSERT INTO meda_vocabulary VALUES("468","de","_BUTTON_REWRITE","Rewrite Wortschatz");
INSERT INTO meda_vocabulary VALUES("469","en","_BUTTON_SAVE_CHANGES","Save Changes");
INSERT INTO meda_vocabulary VALUES("470","es","_BUTTON_SAVE_CHANGES","Guardar cambios");
INSERT INTO meda_vocabulary VALUES("471","de","_BUTTON_SAVE_CHANGES","Ünderungen speichern");
INSERT INTO meda_vocabulary VALUES("472","en","_BUTTON_UPDATE","Update");
INSERT INTO meda_vocabulary VALUES("473","es","_BUTTON_UPDATE","Actualizar");
INSERT INTO meda_vocabulary VALUES("474","de","_BUTTON_UPDATE","Update");
INSERT INTO meda_vocabulary VALUES("475","en","_BUY_NOW","Buy Now");
INSERT INTO meda_vocabulary VALUES("476","es","_BUY_NOW","¡Cómpralo ya!");
INSERT INTO meda_vocabulary VALUES("477","de","_BUY_NOW","Jetzt kaufen");
INSERT INTO meda_vocabulary VALUES("478","en","_CACHE_LIFETIME","Cache Lifetime");
INSERT INTO meda_vocabulary VALUES("479","es","_CACHE_LIFETIME","Cache de por vida");
INSERT INTO meda_vocabulary VALUES("480","de","_CACHE_LIFETIME","Cache Lifetime");
INSERT INTO meda_vocabulary VALUES("481","en","_CACHING","Caching");
INSERT INTO meda_vocabulary VALUES("482","es","_CACHING","Caché");
INSERT INTO meda_vocabulary VALUES("483","de","_CACHING","Caching");
INSERT INTO meda_vocabulary VALUES("484","en","_CANCELED","Canceled");
INSERT INTO meda_vocabulary VALUES("485","es","_CANCELED","cancelado");
INSERT INTO meda_vocabulary VALUES("486","de","_CANCELED","storniert");
INSERT INTO meda_vocabulary VALUES("487","en","_CANCELED_BY_ADMINISTRATION","Canceled by administration");
INSERT INTO meda_vocabulary VALUES("488","es","_CANCELED_BY_ADMINISTRATION","Cancelado por la administración");
INSERT INTO meda_vocabulary VALUES("489","de","_CANCELED_BY_ADMINISTRATION","Abgebrochen durch Verabreichung");
INSERT INTO meda_vocabulary VALUES("490","en","_CANCELED_BY_PATIENT","Canceled by patient");
INSERT INTO meda_vocabulary VALUES("491","es","_CANCELED_BY_PATIENT","Cancelado por el paciente");
INSERT INTO meda_vocabulary VALUES("492","de","_CANCELED_BY_PATIENT","Von Patienten abgebrochen");
INSERT INTO meda_vocabulary VALUES("493","en","_CAN_USE_TAGS_MSG","You can use some HTML tags, such as");
INSERT INTO meda_vocabulary VALUES("494","es","_CAN_USE_TAGS_MSG","Puede utilizar las etiquetas HTML, como");
INSERT INTO meda_vocabulary VALUES("495","de","_CAN_USE_TAGS_MSG","Sie können einige HTML-Tags wie");
INSERT INTO meda_vocabulary VALUES("496","en","_CATEGORIES","Categories");
INSERT INTO meda_vocabulary VALUES("497","es","_CATEGORIES","Categorías");
INSERT INTO meda_vocabulary VALUES("498","de","_CATEGORIES","Kategorien");
INSERT INTO meda_vocabulary VALUES("499","en","_CATEGORIES_MANAGEMENT","Categories Management");
INSERT INTO meda_vocabulary VALUES("500","es","_CATEGORIES_MANAGEMENT","Categorías de Manejo");
INSERT INTO meda_vocabulary VALUES("501","de","_CATEGORIES_MANAGEMENT","Kategorien Management");
INSERT INTO meda_vocabulary VALUES("502","en","_CATEGORY","Category");
INSERT INTO meda_vocabulary VALUES("503","es","_CATEGORY","Categoría");
INSERT INTO meda_vocabulary VALUES("504","de","_CATEGORY","Kategorie");
INSERT INTO meda_vocabulary VALUES("505","en","_CATEGORY_DESCRIPTION","Category Description");
INSERT INTO meda_vocabulary VALUES("506","es","_CATEGORY_DESCRIPTION","Categoría Descripción");
INSERT INTO meda_vocabulary VALUES("507","de","_CATEGORY_DESCRIPTION","Kategorie Beschreibung");
INSERT INTO meda_vocabulary VALUES("508","en","_CC_CARD_HOLDER_NAME_EMPTY","No card holder\'s name provided! Please re-enter.");
INSERT INTO meda_vocabulary VALUES("509","es","_CC_CARD_HOLDER_NAME_EMPTY","No Nombre del titular de la tarjeta siempre! Por favor, vuelva a introducir.");
INSERT INTO meda_vocabulary VALUES("510","de","_CC_CARD_HOLDER_NAME_EMPTY","No Name des Karteninhabers versehen! Bitte erneut eingeben.");
INSERT INTO meda_vocabulary VALUES("511","en","_CC_CARD_INVALID_FORMAT","Credit card number has invalid format! Please re-enter.");
INSERT INTO meda_vocabulary VALUES("512","es","_CC_CARD_INVALID_FORMAT","Número de tarjeta de crédito tiene un formato válido! Por favor, vuelva a entrar.");
INSERT INTO meda_vocabulary VALUES("513","de","_CC_CARD_INVALID_FORMAT","Kreditkarten-Nummer hat ungültiges Format! Bitte erneut eingeben.");
INSERT INTO meda_vocabulary VALUES("514","en","_CC_CARD_INVALID_NUMBER","Credit card number is invalid! Please re-enter.");
INSERT INTO meda_vocabulary VALUES("515","es","_CC_CARD_INVALID_NUMBER","Número de tarjeta de crédito no es válido! Por favor, vuelva a entrar.");
INSERT INTO meda_vocabulary VALUES("516","de","_CC_CARD_INVALID_NUMBER","Kreditkarten-Nummer ist ungültig! Bitte erneut eingeben.");
INSERT INTO meda_vocabulary VALUES("517","en","_CC_CARD_NO_CVV_NUMBER","No CVV Code provided! Please re-enter.");
INSERT INTO meda_vocabulary VALUES("518","es","_CC_CARD_NO_CVV_NUMBER","No Código CVV siempre! Por favor, vuelva a entrar.");
INSERT INTO meda_vocabulary VALUES("519","de","_CC_CARD_NO_CVV_NUMBER","Keine CVV-Code zur Verfügung gestellt! Bitte erneut eingeben.");
INSERT INTO meda_vocabulary VALUES("520","en","_CC_CARD_WRONG_EXPIRE_DATE","Credit card expiry date is wrong! Please re-enter.");
INSERT INTO meda_vocabulary VALUES("521","es","_CC_CARD_WRONG_EXPIRE_DATE","Tarjeta de crédito fecha de caducidad está mal! Por favor, vuelva a entrar.");
INSERT INTO meda_vocabulary VALUES("522","de","_CC_CARD_WRONG_EXPIRE_DATE","Kreditkarte Verfallsdatum ist falsch! Bitte erneut eingeben.");
INSERT INTO meda_vocabulary VALUES("523","en","_CC_CARD_WRONG_LENGTH","Credit card number has a wrong length! Please re-enter.");
INSERT INTO meda_vocabulary VALUES("524","es","_CC_CARD_WRONG_LENGTH","Número de tarjeta de crédito es la longitud del mal! Por favor, vuelva a entrar.");
INSERT INTO meda_vocabulary VALUES("525","de","_CC_CARD_WRONG_LENGTH","Kreditkarten-Nummer falsch ist lang! Bitte erneut eingeben.");
INSERT INTO meda_vocabulary VALUES("526","en","_CC_NO_CARD_NUMBER","No card number provided! Please re-enter.");
INSERT INTO meda_vocabulary VALUES("527","es","_CC_NO_CARD_NUMBER","No hay número de tarjeta de siempre! Por favor, vuelva a introducir.");
INSERT INTO meda_vocabulary VALUES("528","de","_CC_NO_CARD_NUMBER","Keine Kartennummer zur Verfügung gestellt! Bitte erneut eingeben.");
INSERT INTO meda_vocabulary VALUES("529","en","_CC_NO_CARD_NUMBER_PROVIDED","No card number provided! Please re-enter.");
INSERT INTO meda_vocabulary VALUES("530","es","_CC_NO_CARD_NUMBER_PROVIDED","No hay número de tarjeta de siempre! Por favor, vuelva a entrar.");
INSERT INTO meda_vocabulary VALUES("531","de","_CC_NO_CARD_NUMBER_PROVIDED","Keine Kartennummer zur Verfügung gestellt! Bitte erneut eingeben.");
INSERT INTO meda_vocabulary VALUES("532","en","_CC_UNKNOWN_CARD_TYPE","Unknown card type! Please re-enter.");
INSERT INTO meda_vocabulary VALUES("533","es","_CC_UNKNOWN_CARD_TYPE","Tipo de tarjeta desconocido! Por favor, vuelva a entrar.");
INSERT INTO meda_vocabulary VALUES("534","de","_CC_UNKNOWN_CARD_TYPE","Unknown Karte Typ! Bitte erneut eingeben.");
INSERT INTO meda_vocabulary VALUES("535","en","_CHANGES_SAVED","Changes were saved.");
INSERT INTO meda_vocabulary VALUES("536","es","_CHANGES_SAVED","Los cambios se salvaron.");
INSERT INTO meda_vocabulary VALUES("537","de","_CHANGES_SAVED","Ünderungen wurden gespeichert.");
INSERT INTO meda_vocabulary VALUES("538","en","_CHANGES_WERE_SAVED","Changes were successfully saved!");
INSERT INTO meda_vocabulary VALUES("539","es","_CHANGES_WERE_SAVED","Los cambios se han guardado correctamente!");
INSERT INTO meda_vocabulary VALUES("540","de","_CHANGES_WERE_SAVED","Ünderungen wurden erfolgreich gespeichert!");
INSERT INTO meda_vocabulary VALUES("541","en","_CHANGE_ORDER","Change Order");
INSERT INTO meda_vocabulary VALUES("542","es","_CHANGE_ORDER","Cambiar el orden de");
INSERT INTO meda_vocabulary VALUES("543","de","_CHANGE_ORDER","Auftrag ändern");
INSERT INTO meda_vocabulary VALUES("544","en","_CHANGE_PATIENT","Change Patient");
INSERT INTO meda_vocabulary VALUES("545","es","_CHANGE_PATIENT","Cambie Paciente");
INSERT INTO meda_vocabulary VALUES("546","de","_CHANGE_PATIENT","Patient ändern");
INSERT INTO meda_vocabulary VALUES("547","en","_CHANGE_YOUR_PASSWORD","Change your password");
INSERT INTO meda_vocabulary VALUES("548","es","_CHANGE_YOUR_PASSWORD","Cambie su contraseña");
INSERT INTO meda_vocabulary VALUES("549","de","_CHANGE_YOUR_PASSWORD","Ündern Sie Ihr Passwort");
INSERT INTO meda_vocabulary VALUES("550","en","_CHECKOUT","Checkout");
INSERT INTO meda_vocabulary VALUES("551","es","_CHECKOUT","Caja");
INSERT INTO meda_vocabulary VALUES("552","de","_CHECKOUT","Kasse");
INSERT INTO meda_vocabulary VALUES("553","en","_CHOOSE_AVAILABLE_PLANS_NOTICE","Your current plan is _PLAN_NAME_. You may choose available plans to upgrade it.");
INSERT INTO meda_vocabulary VALUES("554","es","_CHOOSE_AVAILABLE_PLANS_NOTICE","Su plan actual es _PLAN_NAME_. Usted puede elegir los planes disponibles para actualizarlo.");
INSERT INTO meda_vocabulary VALUES("555","de","_CHOOSE_AVAILABLE_PLANS_NOTICE","Ihre aktuelle Plan ist _PLAN_NAME_. Sie können Pläne zur Verfügung, es zu aktualisieren wählen.");
INSERT INTO meda_vocabulary VALUES("556","en","_CITY","City");
INSERT INTO meda_vocabulary VALUES("557","es","_CITY","Ciudad");
INSERT INTO meda_vocabulary VALUES("558","de","_CITY","City");
INSERT INTO meda_vocabulary VALUES("559","en","_CITY_EMPTY_ALERT","City cannot be empty! Please re-enter.");
INSERT INTO meda_vocabulary VALUES("560","es","_CITY_EMPTY_ALERT","Ciudad no puede estar vacío! Por favor, vuelva a entrar.");
INSERT INTO meda_vocabulary VALUES("561","de","_CITY_EMPTY_ALERT","City darf nicht leer sein! Bitte erneut eingeben.");
INSERT INTO meda_vocabulary VALUES("562","en","_CLEANED","Cleaned");
INSERT INTO meda_vocabulary VALUES("563","es","_CLEANED","Limpiar");
INSERT INTO meda_vocabulary VALUES("564","de","_CLEANED","Gereinigt");
INSERT INTO meda_vocabulary VALUES("565","en","_CLEAN_CACHE","Clean Cache");
INSERT INTO meda_vocabulary VALUES("566","es","_CLEAN_CACHE","Borrar caché");
INSERT INTO meda_vocabulary VALUES("567","de","_CLEAN_CACHE","Cache löschen");
INSERT INTO meda_vocabulary VALUES("568","en","_CLICK_TO_EDIT","Click to edit");
INSERT INTO meda_vocabulary VALUES("569","es","_CLICK_TO_EDIT","Haga clic para editar");
INSERT INTO meda_vocabulary VALUES("570","de","_CLICK_TO_EDIT","Klicken Sie zum Bearbeiten");
INSERT INTO meda_vocabulary VALUES("571","en","_CLICK_TO_SELECT","Click To Select");
INSERT INTO meda_vocabulary VALUES("572","es","_CLICK_TO_SELECT","Haga clic para seleccionar");
INSERT INTO meda_vocabulary VALUES("573","de","_CLICK_TO_SELECT","Klicken Sie auf das");
INSERT INTO meda_vocabulary VALUES("574","en","_CLICK_TO_VIEW","Click to view");
INSERT INTO meda_vocabulary VALUES("575","es","_CLICK_TO_VIEW","Haga clic para ver");
INSERT INTO meda_vocabulary VALUES("576","de","_CLICK_TO_VIEW","Klicken Sie zur Ansicht");
INSERT INTO meda_vocabulary VALUES("577","en","_CLINIC_DESCRIPTION","Clinic Description");
INSERT INTO meda_vocabulary VALUES("578","es","_CLINIC_DESCRIPTION","Descripción clínica");
INSERT INTO meda_vocabulary VALUES("579","de","_CLINIC_DESCRIPTION","Clinic Beschreibung");
INSERT INTO meda_vocabulary VALUES("580","en","_CLINIC_INFO","Clinic Info");
INSERT INTO meda_vocabulary VALUES("581","es","_CLINIC_INFO","Información clínica");
INSERT INTO meda_vocabulary VALUES("582","de","_CLINIC_INFO","Klinik-Info");
INSERT INTO meda_vocabulary VALUES("583","en","_CLINIC_MANAGEMENT","Clinic Management");
INSERT INTO meda_vocabulary VALUES("584","es","_CLINIC_MANAGEMENT","Gestión Clínica");
INSERT INTO meda_vocabulary VALUES("585","de","_CLINIC_MANAGEMENT","Klinik-Management");
INSERT INTO meda_vocabulary VALUES("586","en","_CLOSE","Close");
INSERT INTO meda_vocabulary VALUES("587","es","_CLOSE","Cerrar");
INSERT INTO meda_vocabulary VALUES("588","de","_CLOSE","Schließen");
INSERT INTO meda_vocabulary VALUES("589","en","_CLOSE_META_TAGS","Close META tags");
INSERT INTO meda_vocabulary VALUES("590","es","_CLOSE_META_TAGS","Cerrar etiquetas META");
INSERT INTO meda_vocabulary VALUES("591","de","_CLOSE_META_TAGS","Schließen Sie META-Tags");
INSERT INTO meda_vocabulary VALUES("592","en","_CODE","Code");
INSERT INTO meda_vocabulary VALUES("593","es","_CODE","Código");
INSERT INTO meda_vocabulary VALUES("594","de","_CODE","Code");
INSERT INTO meda_vocabulary VALUES("595","en","_COLLAPSE_PANEL","Collapse navigation panel");
INSERT INTO meda_vocabulary VALUES("596","es","_COLLAPSE_PANEL","Colapso del panel de navegación");
INSERT INTO meda_vocabulary VALUES("597","de","_COLLAPSE_PANEL","Collapse Navigationsleiste");
INSERT INTO meda_vocabulary VALUES("598","en","_COMMENTS","Comments");
INSERT INTO meda_vocabulary VALUES("599","es","_COMMENTS","Comentarios");
INSERT INTO meda_vocabulary VALUES("600","de","_COMMENTS","Kommentare");
INSERT INTO meda_vocabulary VALUES("601","en","_COMMENTS_AWAITING_MODERATION_ALERT","There are _COUNT_ comment/s awaiting your moderation. Click <a href=\'index.php?admin=mod_comments_management\'>here</a> for review.");
INSERT INTO meda_vocabulary VALUES("602","es","_COMMENTS_AWAITING_MODERATION_ALERT","Hay comentarios _COUNT_ en espera de su moderación. Haga clic <a href=\'index.php?admin=mod_comments_management\'>aquí</a> para su revisión.");
INSERT INTO meda_vocabulary VALUES("603","de","_COMMENTS_AWAITING_MODERATION_ALERT","Es gibt _COUNT_ Kommentare Erwartung Ihrer Moderation. Klicken Sie <a href=\'index.php?admin=mod_comments_management\'>hier</a> für eine Bewertung.");
INSERT INTO meda_vocabulary VALUES("604","en","_COMMENTS_LINK","Comments (_COUNT_)");
INSERT INTO meda_vocabulary VALUES("605","es","_COMMENTS_LINK","Comentarios (_COUNT_)");
INSERT INTO meda_vocabulary VALUES("606","de","_COMMENTS_LINK","Kommentare (_COUNT_)");
INSERT INTO meda_vocabulary VALUES("607","en","_COMMENTS_MANAGEMENT","Comments Management");
INSERT INTO meda_vocabulary VALUES("608","es","_COMMENTS_MANAGEMENT","Comentarios de Gestión");
INSERT INTO meda_vocabulary VALUES("609","de","_COMMENTS_MANAGEMENT","Kommentare Management");
INSERT INTO meda_vocabulary VALUES("610","en","_COMMENTS_SETTINGS","Comments Settings");
INSERT INTO meda_vocabulary VALUES("611","es","_COMMENTS_SETTINGS","Comentarios Configuración");
INSERT INTO meda_vocabulary VALUES("612","de","_COMMENTS_SETTINGS","Kommentare Einstellungen");
INSERT INTO meda_vocabulary VALUES("613","en","_COMMENT_DELETED_SUCCESS","Your comment has been successfully deleted.");
INSERT INTO meda_vocabulary VALUES("614","es","_COMMENT_DELETED_SUCCESS","Su comentario ha sido borrado.");
INSERT INTO meda_vocabulary VALUES("615","de","_COMMENT_DELETED_SUCCESS","Dein Kommentar wurde erfolgreich gelöscht.");
INSERT INTO meda_vocabulary VALUES("616","en","_COMMENT_LENGTH_ALERT","The length of comment must be less than _LENGTH_ characters!");
INSERT INTO meda_vocabulary VALUES("617","es","_COMMENT_LENGTH_ALERT","La longitud de los comentarios debe ser inferior a _LENGTH_ personajes!");
INSERT INTO meda_vocabulary VALUES("618","de","_COMMENT_LENGTH_ALERT","Die Länge der Kommentar muss kleiner sein als _LENGTH_ Zeichen!");
INSERT INTO meda_vocabulary VALUES("619","en","_COMMENT_POSTED_SUCCESS","Your comment has been successfully posted!");
INSERT INTO meda_vocabulary VALUES("620","es","_COMMENT_POSTED_SUCCESS","Tu comentario ha sido enviado con éxito!");
INSERT INTO meda_vocabulary VALUES("621","de","_COMMENT_POSTED_SUCCESS","Your comment has been successfully posted!");
INSERT INTO meda_vocabulary VALUES("622","en","_COMMENT_SUBMITTED_SUCCESS","Your comment has been successfully submitted and will be posted after administrator\'s review!");
INSERT INTO meda_vocabulary VALUES("623","es","_COMMENT_SUBMITTED_SUCCESS","Tu comentario ha sido enviado correctamente y será publicado después de la revisión del administrador!");
INSERT INTO meda_vocabulary VALUES("624","de","_COMMENT_SUBMITTED_SUCCESS","Dein Kommentar wurde Erfolgreich übermittelt und WIRD nach Administrator-Beitrag gepostet Werden!");
INSERT INTO meda_vocabulary VALUES("625","en","_COMMENT_TEXT","Comment text");
INSERT INTO meda_vocabulary VALUES("626","es","_COMMENT_TEXT","Comentario de texto");
INSERT INTO meda_vocabulary VALUES("627","de","_COMMENT_TEXT","Kommentieren Text");
INSERT INTO meda_vocabulary VALUES("628","en","_COMPANY","Company");
INSERT INTO meda_vocabulary VALUES("629","es","_COMPANY","Compañía");
INSERT INTO meda_vocabulary VALUES("630","de","_COMPANY","Gesellschaft");
INSERT INTO meda_vocabulary VALUES("631","en","_COMPLETED","Completed");
INSERT INTO meda_vocabulary VALUES("632","es","_COMPLETED","Completado");
INSERT INTO meda_vocabulary VALUES("633","de","_COMPLETED","Fertiggestellt");
INSERT INTO meda_vocabulary VALUES("634","en","_CONFIRMATION_CODE","Confirmation Code");
INSERT INTO meda_vocabulary VALUES("635","es","_CONFIRMATION_CODE","Código de confirmación");
INSERT INTO meda_vocabulary VALUES("636","de","_CONFIRMATION_CODE","Bestätigungs-Code");
INSERT INTO meda_vocabulary VALUES("637","en","_CONFIRMED_ALREADY_MSG","Your account has already been confirmed! <br><br>Click <a href=\'index.php?_ACCOUNT_=login\'>here</a> to continue");
INSERT INTO meda_vocabulary VALUES("638","es","_CONFIRMED_ALREADY_MSG","Su cuenta ha sido ya confirmado!<br><br>Haga clic <a href=\'index.php?_ACCOUNT_=login\'>aquí</a> para continuar.");
INSERT INTO meda_vocabulary VALUES("639","de","_CONFIRMED_ALREADY_MSG","Ihr Konto wurde bereits bestätigt! <br><br>Klicken Sie <a href=\'index.php?_ACCOUNT_=login\'>hier</a>, um fortzufahren.");
INSERT INTO meda_vocabulary VALUES("640","en","_CONFIRMED_SUCCESS_MSG","Thank you for confirming your registration! <br>You may now log into your account. Click <a href=\'index.php?_ACCOUNT_=login\'>here</a> to proceed.");
INSERT INTO meda_vocabulary VALUES("641","es","_CONFIRMED_SUCCESS_MSG","Gracias por confirmar su inscripción! <br>Ahora puede acceder a su cuenta. Haga clic <a href=\'index.php?_ACCOUNT_=login\'>aquí</a> para continuar.");
INSERT INTO meda_vocabulary VALUES("642","de","_CONFIRMED_SUCCESS_MSG","Vielen Dank für Ihre Anmeldung bestätigt! <br>Sie können jetzt in Ihr Konto einloggen. Klicken Sie <a href=\'index.php?_ACCOUNT_=login\'>hier</a>, um fortzufahren.");
INSERT INTO meda_vocabulary VALUES("643","en","_CONFIRM_PASSWORD","Confirm Password");
INSERT INTO meda_vocabulary VALUES("644","es","_CONFIRM_PASSWORD","confirmar contraseña");
INSERT INTO meda_vocabulary VALUES("645","de","_CONFIRM_PASSWORD","Kennwort bestätigen");
INSERT INTO meda_vocabulary VALUES("646","en","_CONFIRM_REMINDER_SENT","Confirm Reminder Sent");
INSERT INTO meda_vocabulary VALUES("647","es","_CONFIRM_REMINDER_SENT","Confirme recordatorio enviado");
INSERT INTO meda_vocabulary VALUES("648","de","_CONFIRM_REMINDER_SENT","Bestätigen Mahnung");
INSERT INTO meda_vocabulary VALUES("649","en","_CONFIRM_TERMS_CONDITIONS","You must to confirm you agree with our Terms & Conditions!");
INSERT INTO meda_vocabulary VALUES("650","es","_CONFIRM_TERMS_CONDITIONS","Usted debe confirmar que está de acuerdo con nuestros términos y condiciones!");
INSERT INTO meda_vocabulary VALUES("651","de","_CONFIRM_TERMS_CONDITIONS","Sie müssen bestätigen, dass Sie sich mit unseren AGB!");
INSERT INTO meda_vocabulary VALUES("652","en","_CONF_PASSWORD_IS_EMPTY","Confirm Password cannot be empty!");
INSERT INTO meda_vocabulary VALUES("653","es","_CONF_PASSWORD_IS_EMPTY","Confirmar contraseña no puede estar vacío!");
INSERT INTO meda_vocabulary VALUES("654","de","_CONF_PASSWORD_IS_EMPTY","Kennwort bestätigen können nicht leer sein!");
INSERT INTO meda_vocabulary VALUES("655","en","_CONF_PASSWORD_MATCH","Password must be match with Confirm Password");
INSERT INTO meda_vocabulary VALUES("656","es","_CONF_PASSWORD_MATCH","La contraseña debe tener partido con Confirmar contraseña");
INSERT INTO meda_vocabulary VALUES("657","de","_CONF_PASSWORD_MATCH","Das Passwort muss übereinstimmen mit Kennwort bestätigen werden");
INSERT INTO meda_vocabulary VALUES("658","en","_CONTACT","Contact");
INSERT INTO meda_vocabulary VALUES("659","es","_CONTACT","Contacto");
INSERT INTO meda_vocabulary VALUES("660","de","_CONTACT","Kontakt");
INSERT INTO meda_vocabulary VALUES("661","en","_CONTACTUS_DEFAULT_EMAIL_ALERT","You have to change default email address for Contact Us module. Click <a href=\'index.php?admin=mod_contact_us_settings\'>here</a> to proceed.");
INSERT INTO meda_vocabulary VALUES("662","es","_CONTACTUS_DEFAULT_EMAIL_ALERT","Tienes que cambiar la dirección de correo electrónico predeterminado para Contáctenos módulo. Haga clic <a href=\'index.php?admin=mod_contact_us_settings\'>aquí</a> para continuar.");
INSERT INTO meda_vocabulary VALUES("663","de","_CONTACTUS_DEFAULT_EMAIL_ALERT","Sie haben zum ursprünglichen E-Mail-Adresse für Kontakt-Modul ändern. Klicken Sie <a href=\'index.php?admin=mod_contact_us_settings\'>hier</a>, um fortzufahren.");
INSERT INTO meda_vocabulary VALUES("664","en","_CONTACT_INFORMATION","Contact Information");
INSERT INTO meda_vocabulary VALUES("665","es","_CONTACT_INFORMATION","Información de contacto");
INSERT INTO meda_vocabulary VALUES("666","de","_CONTACT_INFORMATION","Kontakt Information");
INSERT INTO meda_vocabulary VALUES("667","en","_CONTACT_US","Contact us");
INSERT INTO meda_vocabulary VALUES("668","es","_CONTACT_US","Contáctenos");
INSERT INTO meda_vocabulary VALUES("669","de","_CONTACT_US","Kontaktieren Sie uns");
INSERT INTO meda_vocabulary VALUES("670","en","_CONTACT_US_ALREADY_SENT","Your message has been already sent. Please try again later or wait _WAIT_ seconds.");
INSERT INTO meda_vocabulary VALUES("671","es","_CONTACT_US_ALREADY_SENT","Tu mensaje ha sido enviado ya. Por favor, inténtelo de nuevo más tarde o esperar _WAIT_ segundos.");
INSERT INTO meda_vocabulary VALUES("672","de","_CONTACT_US_ALREADY_SENT","Ihre Nachricht wurde bereits gesendet. Bitte versuchen Sie es später noch einmal oder warten _WAIT_ Sekunden.");
INSERT INTO meda_vocabulary VALUES("673","en","_CONTACT_US_EMAIL_SENT","Thank you for contacting us! Your message has been successfully sent.");
INSERT INTO meda_vocabulary VALUES("674","es","_CONTACT_US_EMAIL_SENT","Gracias por contactar con nosotros! Su mensaje ha sido enviado con éxito.");
INSERT INTO meda_vocabulary VALUES("675","de","_CONTACT_US_EMAIL_SENT","Vielen Dank für Ihre Kontaktaufnahme! Ihre Nachricht wurde erfolgreich versendet.");
INSERT INTO meda_vocabulary VALUES("676","en","_CONTACT_US_SETTINGS","Contact Us Settings");
INSERT INTO meda_vocabulary VALUES("677","es","_CONTACT_US_SETTINGS","Contacte con nosotros ajustes");
INSERT INTO meda_vocabulary VALUES("678","de","_CONTACT_US_SETTINGS","Kontakt Einstellungen");
INSERT INTO meda_vocabulary VALUES("679","en","_CONTENT_TYPE","Content Type");
INSERT INTO meda_vocabulary VALUES("680","es","_CONTENT_TYPE","Tipo de contenido");
INSERT INTO meda_vocabulary VALUES("681","de","_CONTENT_TYPE","Content-Typ");
INSERT INTO meda_vocabulary VALUES("682","en","_COORDINATES_UPDATE_ERROR","Coordinates of address (latitude and longitude) have not been updated! Please check you entered a valid address information.");
INSERT INTO meda_vocabulary VALUES("683","es","_COORDINATES_UPDATE_ERROR","Las coordenadas de dirección (latitud y longitud) no han sido actualizados! Por favor, compruebe que ha introducido una dirección válida de información.");
INSERT INTO meda_vocabulary VALUES("684","de","_COORDINATES_UPDATE_ERROR","Koordinaten der Adresse (Breitengrad und Längengrad) wurden nicht aktualisiert! Bitte überprüfen Sie Ihre gültige Adresse Informationen.");
INSERT INTO meda_vocabulary VALUES("685","en","_COPY_TO_OTHER_LANGS","Copy to other languages");
INSERT INTO meda_vocabulary VALUES("686","es","_COPY_TO_OTHER_LANGS","Copiar a otros idiomas");
INSERT INTO meda_vocabulary VALUES("687","de","_COPY_TO_OTHER_LANGS","Kopieren in andere Sprachen");
INSERT INTO meda_vocabulary VALUES("688","en","_COUNTRIES","Countries");
INSERT INTO meda_vocabulary VALUES("689","es","_COUNTRIES","Países");
INSERT INTO meda_vocabulary VALUES("690","de","_COUNTRIES","Länder");
INSERT INTO meda_vocabulary VALUES("691","en","_COUNTRIES_MANAGEMENT","Countries Management");
INSERT INTO meda_vocabulary VALUES("692","es","_COUNTRIES_MANAGEMENT","Los países de Gestión");
INSERT INTO meda_vocabulary VALUES("693","de","_COUNTRIES_MANAGEMENT","Länder Management");
INSERT INTO meda_vocabulary VALUES("694","en","_COUNTRY","Country");
INSERT INTO meda_vocabulary VALUES("695","es","_COUNTRY","País");
INSERT INTO meda_vocabulary VALUES("696","de","_COUNTRY","Land");
INSERT INTO meda_vocabulary VALUES("697","en","_COUNTRY_EMPTY_ALERT","Country cannot be empty! Please re-enter.");
INSERT INTO meda_vocabulary VALUES("698","es","_COUNTRY_EMPTY_ALERT","País no puede estar vacío! Por favor, vuelva a entrar.");
INSERT INTO meda_vocabulary VALUES("699","de","_COUNTRY_EMPTY_ALERT","Land darf nicht leer sein! Bitte erneut eingeben.");
INSERT INTO meda_vocabulary VALUES("700","en","_CREATED_BY","Created By");
INSERT INTO meda_vocabulary VALUES("701","es","_CREATED_BY","Creado por");
INSERT INTO meda_vocabulary VALUES("702","de","_CREATED_BY","Erstellt von");
INSERT INTO meda_vocabulary VALUES("703","en","_CREATED_DATE","Date Created");
INSERT INTO meda_vocabulary VALUES("704","es","_CREATED_DATE","Fecha de creación");
INSERT INTO meda_vocabulary VALUES("705","de","_CREATED_DATE","Erstellungsdatum");
INSERT INTO meda_vocabulary VALUES("706","en","_CREATE_ACCOUNT","Create account");
INSERT INTO meda_vocabulary VALUES("707","es","_CREATE_ACCOUNT","Crear cuenta");
INSERT INTO meda_vocabulary VALUES("708","de","_CREATE_ACCOUNT","Konto erstellen");
INSERT INTO meda_vocabulary VALUES("709","en","_CREATE_ACCOUNT_NOTE","NOTE: <br>We recommend that your password should be at least 6 characters long and should be different from your username.<br><br>Your e-mail address must be valid. We use e-mail for communication purposes (order notifications, etc). Therefore, it is essential to provide a valid e-mail address to be able to use our services correctly.<br><br>All your private data is confidential. We will never sell, exchange or market it in any way. For further information on the responsibilities of both parts, you may refer to us.");
INSERT INTO meda_vocabulary VALUES("710","es","_CREATE_ACCOUNT_NOTE","NOTA: MedlinePlus");
INSERT INTO meda_vocabulary VALUES("711","de","_CREATE_ACCOUNT_NOTE","Hinweis: <br>Wir empfehlen, dass Sie Ihr Passwort sollte mindestens 6 Zeichen lang sein und sollte sich von Ihren Benutzernamen ein. <br><br>Ihre E-Mail-Adresse muss gültig sein. Wir verwenden E-Mail zur Kommunikation (um Benachrichtigungen, usw.). Daher ist es unerlässlich, eine gültige E-Mail-Adresse angeben zu können, unsere Dienstleistungen richtig zu verwenden. <br><br>Alle Ihre persönlichen Daten werden vertraulich behandelt. Wir werden niemals verkaufen, tauschen oder Markt in irgendeiner Weise. Für weitere Informationen über die Aufgaben der beiden Teile, können Sie auf uns verweisen.");
INSERT INTO meda_vocabulary VALUES("712","en","_CREATE_APPOINTMENT","Make an Appointment");
INSERT INTO meda_vocabulary VALUES("713","es","_CREATE_APPOINTMENT","Haga una cita");
INSERT INTO meda_vocabulary VALUES("714","de","_CREATE_APPOINTMENT","Termin vereinbaren");
INSERT INTO meda_vocabulary VALUES("715","en","_CREATING_ACCOUNT_ERROR","An error occurred while creating your account! Please try again later or send information about this error to administration of the site.");
INSERT INTO meda_vocabulary VALUES("716","es","_CREATING_ACCOUNT_ERROR","Se produjo un error al crear su cuenta! Por favor, inténtelo de nuevo más tarde o enviar información sobre este error a la administración del sitio.");
INSERT INTO meda_vocabulary VALUES("717","de","_CREATING_ACCOUNT_ERROR","Fehler beim Erstellen Ihres Kontos! Bitte versuchen Sie es später noch einmal oder senden Sie Informationen zu diesem Fehler zur Verwaltung der Website.");
INSERT INTO meda_vocabulary VALUES("718","en","_CREATING_NEW_ACCOUNT","Creating new account");
INSERT INTO meda_vocabulary VALUES("719","es","_CREATING_NEW_ACCOUNT","Crear cuenta nueva");
INSERT INTO meda_vocabulary VALUES("720","de","_CREATING_NEW_ACCOUNT","Erstellen neues Konto");
INSERT INTO meda_vocabulary VALUES("721","en","_CREDIT_CARD","Credit Card");
INSERT INTO meda_vocabulary VALUES("722","es","_CREDIT_CARD","Tarjeta de Crédito");
INSERT INTO meda_vocabulary VALUES("723","de","_CREDIT_CARD","Kreditkarte");
INSERT INTO meda_vocabulary VALUES("724","en","_CREDIT_CARD_EXPIRES","Expires");
INSERT INTO meda_vocabulary VALUES("725","es","_CREDIT_CARD_EXPIRES","Expira");
INSERT INTO meda_vocabulary VALUES("726","de","_CREDIT_CARD_EXPIRES","Ablauf");
INSERT INTO meda_vocabulary VALUES("727","en","_CREDIT_CARD_HOLDER_NAME","Card Holder\'s Name");
INSERT INTO meda_vocabulary VALUES("728","es","_CREDIT_CARD_HOLDER_NAME","Nombre del titular");
INSERT INTO meda_vocabulary VALUES("729","de","_CREDIT_CARD_HOLDER_NAME","Name des Karteninhabers");
INSERT INTO meda_vocabulary VALUES("730","en","_CREDIT_CARD_NUMBER","Credit Card Number");
INSERT INTO meda_vocabulary VALUES("731","es","_CREDIT_CARD_NUMBER","Número de tarjeta");
INSERT INTO meda_vocabulary VALUES("732","de","_CREDIT_CARD_NUMBER","Nummer der Kreditkarte");
INSERT INTO meda_vocabulary VALUES("733","en","_CREDIT_CARD_TYPE","Credit Card Type");
INSERT INTO meda_vocabulary VALUES("734","es","_CREDIT_CARD_TYPE","Tarjeta de Crédito");
INSERT INTO meda_vocabulary VALUES("735","de","_CREDIT_CARD_TYPE","Art der Kreditkarte");
INSERT INTO meda_vocabulary VALUES("736","en","_CRONJOB_HTACCESS_BLOCK","To block remote access to cron.php, in the server&#039;s .htaccess file or vhost configuration file add this section:");
INSERT INTO meda_vocabulary VALUES("737","es","_CRONJOB_HTACCESS_BLOCK","Para bloquear el acceso remoto a cron.php, en el archivo del servidor htaccess o archivo de configuración de host virtual agregar esta sección.:");
INSERT INTO meda_vocabulary VALUES("738","de","_CRONJOB_HTACCESS_BLOCK","So blockieren Sie den Remotezugriff auf cron.php, in der Server-htaccess-Datei oder vhost Konfigurationsdatei hinzuzufügen diesem Abschnitt.:");
INSERT INTO meda_vocabulary VALUES("739","en","_CRONJOB_NOTICE","Cron jobs allow you to automate certain commands or scripts on your site.<br /><br />ApPHP Medical Appointment may need to periodically run cron.php to perform some important operations. The recommended way to run cron.php is to set up a cronjob if you run a Unix/Linux server. If for any reason you can&#039;t run a cronjob on your server, you can choose the Non-batch option below to have cron.php run by ApPHP Medical Appointment itself: in this case cron.php will be run each time someone access your home page. <br /><br />Example of Batch Cron job command: <b>php &#36;HOME/public_html/cron.php >/dev/null 2>&1</b>");
INSERT INTO meda_vocabulary VALUES("740","es","_CRONJOB_NOTICE","Puestos de trabajo de cron le permiten automatizar ciertos comandos o scripts en su sitio.<br /><br />ApPHP Medical Appointment que tenga que ejecutar periódicamente cron.php para realizar algunas operaciones importantes. La manera recomendada de ejecutar cron.php es la creación de un cronjob si ejecuta un servidor Unix/Linux. Si por alguna razón usted no puede ejecutar una tarea programada en el servidor, usted puede elegir la opción para no tener lotes a continuación ejecutar cron.php por ApPHP Medical Appointment en sí: en este caso cron.php se ejecuta cada vez que alguien de su acceso página de inicio. <br /><br />Ejemplo de comando de proceso por lotes Cron: <b>php &#36;HOME/public_html/cron.php >/dev/null 2>&1</b>");
INSERT INTO meda_vocabulary VALUES("741","de","_CRONJOB_NOTICE","Cron-Jobs können Sie bestimmte Befehle oder Skripte auf Ihrer Website zu automatisieren.<br /><br />ApPHP Medical Appointment müssen regelmäßig ausgeführt cron.php einige wichtige Operationen durchführen. Die empfohlene Methode, cron.php ausgeführt wird, ein Cronjob, wenn Sie eine Unix / Linux-Server laufen. Wenn Sie aus irgendeinem Grund nicht ausführen können einen Cronjob auf Ihrem Server, können Sie die Non-Batch-Option aus, um cron.php laufen durch ApPHP Medical Appointment selbst haben: in diesem Fall cron.php wird jedes Mal jemand Zugriff ausgeführt werden Ihre Home Page. <br /> <br /> Beispiel Batch Cron-Job Befehl: <b>php &#36;HOME/public_html/cron.php >/dev/null 2>&1</b>");
INSERT INTO meda_vocabulary VALUES("742","en","_CRON_JOBS","Cron Jobs");
INSERT INTO meda_vocabulary VALUES("743","es","_CRON_JOBS","Cron Jobs");
INSERT INTO meda_vocabulary VALUES("744","de","_CRON_JOBS","Cron Jobs");
INSERT INTO meda_vocabulary VALUES("745","en","_CURRENCIES","Currencies");
INSERT INTO meda_vocabulary VALUES("746","es","_CURRENCIES","Monedas");
INSERT INTO meda_vocabulary VALUES("747","de","_CURRENCIES","Währungen");
INSERT INTO meda_vocabulary VALUES("748","en","_CURRENCIES_DEFAULT_ALERT","Remember! After you change the default currency:<br>- Edit exchange rate to each currency manually (relatively to the new default currency)<br>- Redefine prices for all rooms in the new currency.");
INSERT INTO meda_vocabulary VALUES("749","es","_CURRENCIES_DEFAULT_ALERT","¡Recuerde! Después de cambiar la moneda por defecto: <br> - Editar tipo de cambio de cada moneda de forma manual (relativamente a la moneda por defecto nuevo) <br> - Redefinir los precios de todas las habitaciones en la nueva moneda.");
INSERT INTO meda_vocabulary VALUES("750","de","_CURRENCIES_DEFAULT_ALERT","Denken Sie daran! Nachdem Sie die Standardwährung: <br> - Edit Wechselkurs jeder Währung manuell (relativ zum neuen Standard-Währung) <br> - Definieren Sie die Preise für alle Zimmer in der neuen Währung.");
INSERT INTO meda_vocabulary VALUES("751","en","_CURRENCIES_MANAGEMENT","Currencies Management");
INSERT INTO meda_vocabulary VALUES("752","es","_CURRENCIES_MANAGEMENT","Monedas de Gestión");
INSERT INTO meda_vocabulary VALUES("753","de","_CURRENCIES_MANAGEMENT","Währungen Management");
INSERT INTO meda_vocabulary VALUES("754","en","_CURRENCY","Currency");
INSERT INTO meda_vocabulary VALUES("755","es","_CURRENCY","Moneda");
INSERT INTO meda_vocabulary VALUES("756","de","_CURRENCY","Währung");
INSERT INTO meda_vocabulary VALUES("757","en","_CUSTOMER","Customer");
INSERT INTO meda_vocabulary VALUES("758","es","_CUSTOMER","Cliente");
INSERT INTO meda_vocabulary VALUES("759","de","_CUSTOMER","Kunde");
INSERT INTO meda_vocabulary VALUES("760","en","_CUSTOMERS","Customers");
INSERT INTO meda_vocabulary VALUES("761","es","_CUSTOMERS","Clientes");
INSERT INTO meda_vocabulary VALUES("762","de","_CUSTOMERS","Kunden");
INSERT INTO meda_vocabulary VALUES("763","en","_CUSTOMERS_MANAGEMENT","Customers Management");
INSERT INTO meda_vocabulary VALUES("764","es","_CUSTOMERS_MANAGEMENT","Gestión de Clientes");
INSERT INTO meda_vocabulary VALUES("765","de","_CUSTOMERS_MANAGEMENT","Kunden-Management");
INSERT INTO meda_vocabulary VALUES("766","en","_CUSTOMERS_SETTINGS","Customers Settings");
INSERT INTO meda_vocabulary VALUES("767","es","_CUSTOMERS_SETTINGS","Configuración de los clientes de");
INSERT INTO meda_vocabulary VALUES("768","de","_CUSTOMERS_SETTINGS","Kunden Können");
INSERT INTO meda_vocabulary VALUES("769","en","_CUSTOMER_LOGIN","Customer Login");
INSERT INTO meda_vocabulary VALUES("770","es","_CUSTOMER_LOGIN","Login Cliente");
INSERT INTO meda_vocabulary VALUES("771","de","_CUSTOMER_LOGIN","Kunden-Login");
INSERT INTO meda_vocabulary VALUES("772","en","_CVV_CODE","CVV Code");
INSERT INTO meda_vocabulary VALUES("773","es","_CVV_CODE","CVV Código");
INSERT INTO meda_vocabulary VALUES("774","de","_CVV_CODE","CVV-Code");
INSERT INTO meda_vocabulary VALUES("775","en","_DASHBOARD","Dashboard");
INSERT INTO meda_vocabulary VALUES("776","es","_DASHBOARD","Salpicadero");
INSERT INTO meda_vocabulary VALUES("777","de","_DASHBOARD","Armaturenbrett");
INSERT INTO meda_vocabulary VALUES("778","en","_DATE","Date");
INSERT INTO meda_vocabulary VALUES("779","es","_DATE","Fecha");
INSERT INTO meda_vocabulary VALUES("780","de","_DATE","Datum");
INSERT INTO meda_vocabulary VALUES("781","en","_DATETIME_PRICE_FORMAT","Datetime & Price");
INSERT INTO meda_vocabulary VALUES("782","es","_DATETIME_PRICE_FORMAT","De fecha y hora y Precio");
INSERT INTO meda_vocabulary VALUES("783","de","_DATETIME_PRICE_FORMAT","Datetime & Preis");
INSERT INTO meda_vocabulary VALUES("784","en","_DATE_AND_TIME_SETTINGS","Date & Time Settings");
INSERT INTO meda_vocabulary VALUES("785","es","_DATE_AND_TIME_SETTINGS","De fecha y hora");
INSERT INTO meda_vocabulary VALUES("786","de","_DATE_AND_TIME_SETTINGS","Datum & Zeit-Einstellungen");
INSERT INTO meda_vocabulary VALUES("787","en","_DATE_CREATED","Date Created");
INSERT INTO meda_vocabulary VALUES("788","es","_DATE_CREATED","Fecha de creación");
INSERT INTO meda_vocabulary VALUES("789","de","_DATE_CREATED","Erstellungsdatum");
INSERT INTO meda_vocabulary VALUES("790","en","_DATE_FORMAT","Date Format");
INSERT INTO meda_vocabulary VALUES("791","es","_DATE_FORMAT","Formato de fecha");
INSERT INTO meda_vocabulary VALUES("792","de","_DATE_FORMAT","Datumsformat");
INSERT INTO meda_vocabulary VALUES("793","en","_DATE_MODIFIED","Date Modified");
INSERT INTO meda_vocabulary VALUES("794","es","_DATE_MODIFIED","Fecha de modificación");
INSERT INTO meda_vocabulary VALUES("795","de","_DATE_MODIFIED","Ünderungsdatum");
INSERT INTO meda_vocabulary VALUES("796","en","_DATE_PUBLISHED","Date Published");
INSERT INTO meda_vocabulary VALUES("797","es","_DATE_PUBLISHED","Fecha de publicación");
INSERT INTO meda_vocabulary VALUES("798","de","_DATE_PUBLISHED","Veröffentlichungsdatum");
INSERT INTO meda_vocabulary VALUES("799","en","_DATE_SUBSCRIBED","Date Subscribed");
INSERT INTO meda_vocabulary VALUES("800","es","_DATE_SUBSCRIBED","Fecha de suscripción");
INSERT INTO meda_vocabulary VALUES("801","de","_DATE_SUBSCRIBED","Datum Gezeichnetes");
INSERT INTO meda_vocabulary VALUES("802","en","_DAY","day");
INSERT INTO meda_vocabulary VALUES("803","es","_DAY","día");
INSERT INTO meda_vocabulary VALUES("804","de","_DAY","tag");
INSERT INTO meda_vocabulary VALUES("805","en","_DAYS","days");
INSERT INTO meda_vocabulary VALUES("806","es","_DAYS","días");
INSERT INTO meda_vocabulary VALUES("807","de","_DAYS","tage");
INSERT INTO meda_vocabulary VALUES("808","en","_DAYS_UC","Days");
INSERT INTO meda_vocabulary VALUES("809","es","_DAYS_UC","Días");
INSERT INTO meda_vocabulary VALUES("810","de","_DAYS_UC","Tage");
INSERT INTO meda_vocabulary VALUES("811","en","_DECEMBER","December");
INSERT INTO meda_vocabulary VALUES("812","es","_DECEMBER","Diciembre");
INSERT INTO meda_vocabulary VALUES("813","de","_DECEMBER","Dezember");
INSERT INTO meda_vocabulary VALUES("814","en","_DECIMALS","Decimals");
INSERT INTO meda_vocabulary VALUES("815","es","_DECIMALS","Decimales");
INSERT INTO meda_vocabulary VALUES("816","de","_DECIMALS","Dezimalstellen");
INSERT INTO meda_vocabulary VALUES("817","en","_DEFAULT","Default");
INSERT INTO meda_vocabulary VALUES("818","es","_DEFAULT","Predeterminado");
INSERT INTO meda_vocabulary VALUES("819","de","_DEFAULT","Standardmäßig");
INSERT INTO meda_vocabulary VALUES("820","en","_DEFAULT_CURRENCY_DELETE_ALERT","You cannot delete default currency!");
INSERT INTO meda_vocabulary VALUES("821","es","_DEFAULT_CURRENCY_DELETE_ALERT","No se puede eliminar la moneda por defecto!");
INSERT INTO meda_vocabulary VALUES("822","de","_DEFAULT_CURRENCY_DELETE_ALERT","Sie können nicht löschen Standardwährung!");
INSERT INTO meda_vocabulary VALUES("823","en","_DEFAULT_EMAIL_ALERT","You have to change default email address for site administrator. Click <a href=\'index.php?admin=settings&tabid=1_4\'>here</a> to proceed.");
INSERT INTO meda_vocabulary VALUES("824","es","_DEFAULT_EMAIL_ALERT","Tienes que cambiar la dirección de correo electrónico predeterminado para el administrador. Haga clic <a href=\'index.php?admin=settings&tabid=1_4\'>aquí</a> para continuar.");
INSERT INTO meda_vocabulary VALUES("825","de","_DEFAULT_EMAIL_ALERT","Sie haben zum ursprünglichen E-Mail-Adresse für den Administrator ändern. Klicken Sie <a href=\'index.php?admin=settings&tabid=1_4\'>hier</a>, um fortzufahren.");
INSERT INTO meda_vocabulary VALUES("826","en","_DEFAULT_LANG_DELETE_ALERT","You cannot delete default language!");
INSERT INTO meda_vocabulary VALUES("827","es","_DEFAULT_LANG_DELETE_ALERT","No se puede eliminar el idioma por defecto!");
INSERT INTO meda_vocabulary VALUES("828","de","_DEFAULT_LANG_DELETE_ALERT","Sie können die Standardsprache nicht löschen!");
INSERT INTO meda_vocabulary VALUES("829","en","_DEFAULT_OWN_EMAIL_ALERT","You have to change your own email address. Click <a href=\'index.php?admin=my_account\'>here</a> to proceed.");
INSERT INTO meda_vocabulary VALUES("830","es","_DEFAULT_OWN_EMAIL_ALERT","Usted tiene que cambiar su dirección de correo electrónico propia. Haga clic <a href=\'index.php?admin=my_account\'>aquí</a> para continuar.");
INSERT INTO meda_vocabulary VALUES("831","de","_DEFAULT_OWN_EMAIL_ALERT","Sie müssen Ihre eigene E-Mail-Adresse ändern. Klicken Sie <a href=\'index.php?admin=my_account\'>hier</a>, um fortzufahren.");
INSERT INTO meda_vocabulary VALUES("832","en","_DEFAULT_PRICE_PER_VISIT","Default Price per Visit");
INSERT INTO meda_vocabulary VALUES("833","es","_DEFAULT_PRICE_PER_VISIT","Por defecto Precio por visita");
INSERT INTO meda_vocabulary VALUES("834","de","_DEFAULT_PRICE_PER_VISIT","Default Preis pro Besuch");
INSERT INTO meda_vocabulary VALUES("835","en","_DEFAULT_TEMPLATE","Default Template");
INSERT INTO meda_vocabulary VALUES("836","es","_DEFAULT_TEMPLATE","Plantilla predeterminada");
INSERT INTO meda_vocabulary VALUES("837","de","_DEFAULT_TEMPLATE","Standardvorlage");
INSERT INTO meda_vocabulary VALUES("838","en","_DEFAULT_VISIT_DURATION","Default Visit Duration");
INSERT INTO meda_vocabulary VALUES("839","es","_DEFAULT_VISIT_DURATION","Default duración de la visita");
INSERT INTO meda_vocabulary VALUES("840","de","_DEFAULT_VISIT_DURATION","Standard Besuchsdauer");
INSERT INTO meda_vocabulary VALUES("841","en","_DEGREE","Degree");
INSERT INTO meda_vocabulary VALUES("842","es","_DEGREE","Grado");
INSERT INTO meda_vocabulary VALUES("843","de","_DEGREE","Grad");
INSERT INTO meda_vocabulary VALUES("844","en","_DELETE_WARNING_COMMON","Are you sure you want to delete this record?");
INSERT INTO meda_vocabulary VALUES("845","es","_DELETE_WARNING_COMMON","¿Estás seguro de que desea eliminar este registro?");
INSERT INTO meda_vocabulary VALUES("846","de","_DELETE_WARNING_COMMON","Sie sind sicher, dass Sie diesen Datensatz wirklich löschen?");
INSERT INTO meda_vocabulary VALUES("847","en","_DELETE_WORD","Delete");
INSERT INTO meda_vocabulary VALUES("848","es","_DELETE_WORD","Borrar");
INSERT INTO meda_vocabulary VALUES("849","de","_DELETE_WORD","Löschen");
INSERT INTO meda_vocabulary VALUES("850","en","_DELETING_ACCOUNT_ERROR","An error occurred while deleting your account! Please try again later or send email about this issue to administration of the site.");
INSERT INTO meda_vocabulary VALUES("851","es","_DELETING_ACCOUNT_ERROR","Se produjo un error al eliminar su cuenta! Por favor, inténtelo de nuevo más tarde o envíe un correo electrónico acerca de este problema a la administración del sitio.");
INSERT INTO meda_vocabulary VALUES("852","de","_DELETING_ACCOUNT_ERROR","Ein Fehler beim Löschen Sie verändern! Bitte versuchen Sie es später noch einmal oder schicken Sie zu diesem Thema zur Verwaltung der Website.");
INSERT INTO meda_vocabulary VALUES("853","en","_DELETING_OPERATION_COMPLETED","Deleting operation has been successfully completed!");
INSERT INTO meda_vocabulary VALUES("854","es","_DELETING_OPERATION_COMPLETED","Eliminación de la operación se completó con éxito!");
INSERT INTO meda_vocabulary VALUES("855","de","_DELETING_OPERATION_COMPLETED","Löschen ist erfolgreich abgeschlossen!");
INSERT INTO meda_vocabulary VALUES("856","en","_DESCRIPTION","Description");
INSERT INTO meda_vocabulary VALUES("857","es","_DESCRIPTION","Descripción");
INSERT INTO meda_vocabulary VALUES("858","de","_DESCRIPTION","Beschreibung");
INSERT INTO meda_vocabulary VALUES("859","en","_DISABLED","disabled");
INSERT INTO meda_vocabulary VALUES("860","es","_DISABLED","discapacitado");
INSERT INTO meda_vocabulary VALUES("861","de","_DISABLED","behindert");
INSERT INTO meda_vocabulary VALUES("862","en","_DISPLAY_ON","Display on");
INSERT INTO meda_vocabulary VALUES("863","es","_DISPLAY_ON","Pantalla en la");
INSERT INTO meda_vocabulary VALUES("864","de","_DISPLAY_ON","Anzeige");
INSERT INTO meda_vocabulary VALUES("865","en","_DOCTOR","Doctor");
INSERT INTO meda_vocabulary VALUES("866","es","_DOCTOR","Médico");
INSERT INTO meda_vocabulary VALUES("867","de","_DOCTOR","Doktor");
INSERT INTO meda_vocabulary VALUES("868","en","_DOCTORS","Doctors");
INSERT INTO meda_vocabulary VALUES("869","es","_DOCTORS","Los médicos");
INSERT INTO meda_vocabulary VALUES("870","de","_DOCTORS","Ärzte");
INSERT INTO meda_vocabulary VALUES("871","en","_DOCTORS_AWAITING_MODERATION_ALERT","There are _COUNT_ doctor/s awaiting approval of registration. Click <a href=\'index.php?admin=doctors_management\'>here</a> for review.");
INSERT INTO meda_vocabulary VALUES("872","es","_DOCTORS_AWAITING_MODERATION_ALERT","Hay _COUNT_ médico/s en espera de su aprobación. Haga clic <a href=\'index.php?admin=doctors_management\'>aquí</a> para su revisión.");
INSERT INTO meda_vocabulary VALUES("873","de","_DOCTORS_AWAITING_MODERATION_ALERT","Es gibt _COUNT_ Arzt/e Erwartung Ihrer Zustimmung. Klicken Sie <a href=\'index.php?admin=doctors_management\'>hier</a> für die Überprüfung.");
INSERT INTO meda_vocabulary VALUES("874","en","_DOCTORS_MANAGEMENT","Doctors Management");
INSERT INTO meda_vocabulary VALUES("875","es","_DOCTORS_MANAGEMENT","Gestión de los médicos");
INSERT INTO meda_vocabulary VALUES("876","de","_DOCTORS_MANAGEMENT","Ärzte-Management");
INSERT INTO meda_vocabulary VALUES("877","en","_DOCTORS_SETTINGS","Doctors Settings");
INSERT INTO meda_vocabulary VALUES("878","es","_DOCTORS_SETTINGS","Médicos Configuración");
INSERT INTO meda_vocabulary VALUES("879","de","_DOCTORS_SETTINGS","Ärzte Einstellungen");
INSERT INTO meda_vocabulary VALUES("880","en","_DOCTORS_SPECIALITIES","Doctor\'s specialities");
INSERT INTO meda_vocabulary VALUES("881","es","_DOCTORS_SPECIALITIES","Especialidades médicas");
INSERT INTO meda_vocabulary VALUES("882","de","_DOCTORS_SPECIALITIES","Ärztliche Spezialitäten");
INSERT INTO meda_vocabulary VALUES("883","en","_DOCTOR_ADD_ADDRESSES_ALERT","Currently you have no addresses added in your profile. To add addresses click here <a href=_HREF_>here</a>.");
INSERT INTO meda_vocabulary VALUES("884","es","_DOCTOR_ADD_ADDRESSES_ALERT","Actualmente no tiene direcciones añadidas en su perfil. Para agregar direcciones clic aquí <a href=_HREF_>aquí</a>.");
INSERT INTO meda_vocabulary VALUES("885","de","_DOCTOR_ADD_ADDRESSES_ALERT","Derzeit haben Sie keine Adressen in Ihrem Profil hinzugefügt. Um Adressen hinzufügen, klicken Sie bitte hier <a href=_HREF_>hier</a>.");
INSERT INTO meda_vocabulary VALUES("886","en","_DOCTOR_ADD_IMAGES_ALERT","Currently you have no images in profile gallery. To add images click here <a href=_HREF_>here</a>.");
INSERT INTO meda_vocabulary VALUES("887","es","_DOCTOR_ADD_IMAGES_ALERT","Actualmente no tiene imágenes en la galería perfil. Para añadir más imágenes haz clic aquí <a href=_HREF_>aquí</a>.");
INSERT INTO meda_vocabulary VALUES("888","de","_DOCTOR_ADD_IMAGES_ALERT","Derzeit haben Sie noch keine Bilder im Profil Galerie. Um weitere Bilder hinzufügen, klicken Sie bitte hier <a href=_HREF_>hier</a>.");
INSERT INTO meda_vocabulary VALUES("889","en","_DOCTOR_ARRIVAL_REMINDER_EMAIL","Doctor Arrival Reminder Email");
INSERT INTO meda_vocabulary VALUES("890","es","_DOCTOR_ARRIVAL_REMINDER_EMAIL","Llegada doctor recordatorio por correo electrónico");
INSERT INTO meda_vocabulary VALUES("891","de","_DOCTOR_ARRIVAL_REMINDER_EMAIL","Doktor Ankunft Reminder Email");
INSERT INTO meda_vocabulary VALUES("892","en","_DOCTOR_COPY","doctor copy");
INSERT INTO meda_vocabulary VALUES("893","es","_DOCTOR_COPY","médico copia");
INSERT INTO meda_vocabulary VALUES("894","de","_DOCTOR_COPY","Arzt Kopie");
INSERT INTO meda_vocabulary VALUES("895","en","_DOCTOR_DETAILS","Doctor Detail");
INSERT INTO meda_vocabulary VALUES("896","es","_DOCTOR_DETAILS","Detalle doctor");
INSERT INTO meda_vocabulary VALUES("897","de","_DOCTOR_DETAILS","Doktor Detail");
INSERT INTO meda_vocabulary VALUES("898","en","_DOCTOR_INFO","Doctor Info");
INSERT INTO meda_vocabulary VALUES("899","es","_DOCTOR_INFO","Médico Información");
INSERT INTO meda_vocabulary VALUES("900","de","_DOCTOR_INFO","Doktor Info");
INSERT INTO meda_vocabulary VALUES("901","en","_DOCTOR_LOGIN","Doctor Login");
INSERT INTO meda_vocabulary VALUES("902","es","_DOCTOR_LOGIN","Doctor en Sesión");
INSERT INTO meda_vocabulary VALUES("903","de","_DOCTOR_LOGIN","Doktor Anmelden");
INSERT INTO meda_vocabulary VALUES("904","en","_DOCTOR_MAX_ADDRESSES_ALERT","You have reached the maximum number of allowed addresses for this doctor (according to selected membership plan).");
INSERT INTO meda_vocabulary VALUES("905","es","_DOCTOR_MAX_ADDRESSES_ALERT","Has alcanzado el número máximo de direcciones permitidas para este médico (según el plan de membresía seleccionada).");
INSERT INTO meda_vocabulary VALUES("906","de","_DOCTOR_MAX_ADDRESSES_ALERT","Sie haben die maximale Anzahl der erlaubten Adressen für diesen Arzt (nach ausgewählten Mitgliedschaft Plan) erreicht.");
INSERT INTO meda_vocabulary VALUES("907","en","_DOCTOR_MAX_IMAGES_ALERT","You have reached the maximum number of allowed images for this doctor (according to selected membership plan).");
INSERT INTO meda_vocabulary VALUES("908","es","_DOCTOR_MAX_IMAGES_ALERT","Has alcanzado el número máximo permitido de las imágenes de este médico (según el plan de membresía seleccionada).");
INSERT INTO meda_vocabulary VALUES("909","de","_DOCTOR_MAX_IMAGES_ALERT","Sie haben die maximale Anzahl der erlaubten Bilder für diesen Arzt (nach ausgewählten Mitgliedschaft Plan) erreicht.");
INSERT INTO meda_vocabulary VALUES("910","en","_DOCTOR_MEMBERSHIP_PLANS","Doctor Membership Plans");
INSERT INTO meda_vocabulary VALUES("911","es","_DOCTOR_MEMBERSHIP_PLANS","Planes de Afiliación Médico");
INSERT INTO meda_vocabulary VALUES("912","de","_DOCTOR_MEMBERSHIP_PLANS","Doktor Mitgliedschaft Pläne");
INSERT INTO meda_vocabulary VALUES("913","en","_DOCTOR_MISSING_SPECIALITIES_ALERT","You still have not added specialities to your profile. We recommend to add at least one speciality to allow patients to see your profile in the search results. Click <a href=\'_HREF_\'>here</a> to proceed.");
INSERT INTO meda_vocabulary VALUES("914","es","_DOCTOR_MISSING_SPECIALITIES_ALERT","¿Todavía no has añadido especialidades a tu perfil. Se recomienda agregar al menos una especialidad para que los pacientes puedan ver su perfil en los resultados de búsqueda. Haga clic en <a href=\'_HREF_\'> aquí </ a> añadir.");
INSERT INTO meda_vocabulary VALUES("915","de","_DOCTOR_MISSING_SPECIALITIES_ALERT","Sie haben noch nicht zu Ihrem Profil hinzugefügt Spezialitäten. Wir empfehlen, mindestens eine Spezialität in den Patienten ermöglichen, Ihr Profil in den Suchergebnissen angezeigt. Klicken Sie hier, <a href=\'_HREF_\'> </ a> hinzufügen.");
INSERT INTO meda_vocabulary VALUES("916","en","_DOCTOR_NAME_EMPTY_ALERT","Doctor name cannot be empty! Please enter doctor name and try again.");
INSERT INTO meda_vocabulary VALUES("917","es","_DOCTOR_NAME_EMPTY_ALERT","Nombre del médico no puede estar vacío! Por favor, introduzca el nombre del médico y vuelva a intentarlo.");
INSERT INTO meda_vocabulary VALUES("918","de","_DOCTOR_NAME_EMPTY_ALERT","Doktor Name darf nicht leer sein! Bitte geben Sie Namen und Arzt versuchen Sie es erneut.");
INSERT INTO meda_vocabulary VALUES("919","en","_DOCTOR_NOTES","Doctor Notes");
INSERT INTO meda_vocabulary VALUES("920","es","_DOCTOR_NOTES","Las notas del doctor");
INSERT INTO meda_vocabulary VALUES("921","de","_DOCTOR_NOTES","Doktor Hinweise");
INSERT INTO meda_vocabulary VALUES("922","en","_DOCTOR_PHONES","Doctor Phones");
INSERT INTO meda_vocabulary VALUES("923","es","_DOCTOR_PHONES","Móviles Doctor");
INSERT INTO meda_vocabulary VALUES("924","de","_DOCTOR_PHONES","Doktor Handys");
INSERT INTO meda_vocabulary VALUES("925","en","_DOCTOR_PROFILE_INACTIVE","This doctor\'s profile is inactive.");
INSERT INTO meda_vocabulary VALUES("926","es","_DOCTOR_PROFILE_INACTIVE","El perfil de este médico está inactivo.");
INSERT INTO meda_vocabulary VALUES("927","de","_DOCTOR_PROFILE_INACTIVE","Das Profil dieses Arztes ist inaktiv.");
INSERT INTO meda_vocabulary VALUES("928","en","_DOCTOR_SPECIALITY","Doctor\'s Speciality");
INSERT INTO meda_vocabulary VALUES("929","es","_DOCTOR_SPECIALITY","Especialidad del médico");
INSERT INTO meda_vocabulary VALUES("930","de","_DOCTOR_SPECIALITY","Ärztliche Speciality");
INSERT INTO meda_vocabulary VALUES("931","en","_DOCTOR_TIME_OVERLAPPING_ALERT","This period of time (fully or partially) is already chosen for selected doctor! Please re-enter.");
INSERT INTO meda_vocabulary VALUES("932","es","_DOCTOR_TIME_OVERLAPPING_ALERT","Este período de tiempo (total o parcialmente) fue elegido ya para el médico seleccionado! Por favor, vuelva a introducir.");
INSERT INTO meda_vocabulary VALUES("933","de","_DOCTOR_TIME_OVERLAPPING_ALERT","Dieser Zeitraum (vollständig oder teilweise) bereits für ausgewählte Arzt gewählt! Bitte erneut eingeben.");
INSERT INTO meda_vocabulary VALUES("934","en","_DOCTOR_UPGRADE_MEMBERSHIP_ALERT","Currently your profile is not available for search. To make it visible for your patients you have to upgrade your membership plan. Click here <a href=_HREF_>here</a> to proceed.");
INSERT INTO meda_vocabulary VALUES("935","es","_DOCTOR_UPGRADE_MEMBERSHIP_ALERT","Actualmente su perfil no está disponible en esta categoría. Para hacerla visible para sus pacientes que tienen que actualizar su plan de membresía. Haga clic aquí <a href=_HREF_>aquí</a> para continuar.");
INSERT INTO meda_vocabulary VALUES("936","de","_DOCTOR_UPGRADE_MEMBERSHIP_ALERT","Aktuell Ihr Profil ist auf der Suche nach nicht zur Verfügung. Um es für Ihre Patienten Sie Ihre Mitgliedschaft Plan Upgrade haben sichtbar zu machen. Klicken Sie hier <a href=_HREF_>hier</a>, um fortzufahren.");
INSERT INTO meda_vocabulary VALUES("937","en","_DOWN","Down");
INSERT INTO meda_vocabulary VALUES("938","es","_DOWN","Abajo");
INSERT INTO meda_vocabulary VALUES("939","de","_DOWN","Nach unten");
INSERT INTO meda_vocabulary VALUES("940","en","_DOWNLOAD","Download");
INSERT INTO meda_vocabulary VALUES("941","es","_DOWNLOAD","Descargar");
INSERT INTO meda_vocabulary VALUES("942","de","_DOWNLOAD","Herunterladen");
INSERT INTO meda_vocabulary VALUES("943","en","_DURATION","Duration");
INSERT INTO meda_vocabulary VALUES("944","es","_DURATION","Duración");
INSERT INTO meda_vocabulary VALUES("945","de","_DURATION","Dauer");
INSERT INTO meda_vocabulary VALUES("946","en","_DURATION_OF_VISIT","Duration of visit");
INSERT INTO meda_vocabulary VALUES("947","es","_DURATION_OF_VISIT","Duración de la visita");
INSERT INTO meda_vocabulary VALUES("948","de","_DURATION_OF_VISIT","Dauer des Besuchs");
INSERT INTO meda_vocabulary VALUES("949","en","_EDIT_MENUS","Edit Menus");
INSERT INTO meda_vocabulary VALUES("950","es","_EDIT_MENUS","Editar los menús");
INSERT INTO meda_vocabulary VALUES("951","de","_EDIT_MENUS","Bearbeiten-Menüs");
INSERT INTO meda_vocabulary VALUES("952","en","_EDIT_MY_ACCOUNT","Edit My Account");
INSERT INTO meda_vocabulary VALUES("953","es","_EDIT_MY_ACCOUNT","Editar mi cuenta");
INSERT INTO meda_vocabulary VALUES("954","de","_EDIT_MY_ACCOUNT","Mein Konto bearbeiten");
INSERT INTO meda_vocabulary VALUES("955","en","_EDIT_MY_ADDRESSES","Edit My Addresses");
INSERT INTO meda_vocabulary VALUES("956","es","_EDIT_MY_ADDRESSES","Editar mis direcciones");
INSERT INTO meda_vocabulary VALUES("957","de","_EDIT_MY_ADDRESSES","Bearbeiten meine Adressen");
INSERT INTO meda_vocabulary VALUES("958","en","_EDIT_PAGE","Edit Page");
INSERT INTO meda_vocabulary VALUES("959","es","_EDIT_PAGE","Editar página");
INSERT INTO meda_vocabulary VALUES("960","de","_EDIT_PAGE","Seite bearbeiten");
INSERT INTO meda_vocabulary VALUES("961","en","_EDIT_WORD","Edit");
INSERT INTO meda_vocabulary VALUES("962","es","_EDIT_WORD","Editar");
INSERT INTO meda_vocabulary VALUES("963","de","_EDIT_WORD","Bearbeiten");
INSERT INTO meda_vocabulary VALUES("964","en","_EDUCATION","Education");
INSERT INTO meda_vocabulary VALUES("965","es","_EDUCATION","Educación");
INSERT INTO meda_vocabulary VALUES("966","de","_EDUCATION","Bildung");
INSERT INTO meda_vocabulary VALUES("967","en","_EMAIL","Email");
INSERT INTO meda_vocabulary VALUES("968","es","_EMAIL","E-mail");
INSERT INTO meda_vocabulary VALUES("969","de","_EMAIL","E-Mail");
INSERT INTO meda_vocabulary VALUES("970","en","_EMAILS_SENT_ERROR","An error occurred while sending emails or there are no emails to be sent! Please try again later.");
INSERT INTO meda_vocabulary VALUES("971","es","_EMAILS_SENT_ERROR","Se produjo un error al enviar correos electrónicos o no hay mensajes de correo electrónico para ser enviados! Por favor, inténtelo de nuevo más tarde.");
INSERT INTO meda_vocabulary VALUES("972","de","_EMAILS_SENT_ERROR","Fehler beim Versenden von Emails oder es sind keine E-Mails gesendet werden! Bitte versuchen Sie es später erneut.");
INSERT INTO meda_vocabulary VALUES("973","en","_EMAILS_SUCCESSFULLY_SENT","Status: _SENT_ emails from _TOTAL_ were successfully sent!");
INSERT INTO meda_vocabulary VALUES("974","es","_EMAILS_SUCCESSFULLY_SENT","Estado: mensajes de correo electrónico _SENT_ de _TOTAL_ fueron enviados con éxito!");
INSERT INTO meda_vocabulary VALUES("975","de","_EMAILS_SUCCESSFULLY_SENT","Status: _SENT_ E-Mails von _TOTAL_ waren erfolgreich verschickt!");
INSERT INTO meda_vocabulary VALUES("976","en","_EMAIL_ADDRESS","E-mail address");
INSERT INTO meda_vocabulary VALUES("977","es","_EMAIL_ADDRESS","E-mail address");
INSERT INTO meda_vocabulary VALUES("978","de","_EMAIL_ADDRESS","E-Mail-Adresse");
INSERT INTO meda_vocabulary VALUES("979","en","_EMAIL_BLOCKED","Your email is blocked! To resolve this problem, please contact the site administrator.");
INSERT INTO meda_vocabulary VALUES("980","es","_EMAIL_BLOCKED","Tu email fue bloqueado! Para resolver este problema, póngase en contacto con el administrador del sitio.");
INSERT INTO meda_vocabulary VALUES("981","de","_EMAIL_BLOCKED","Ihre E-Mail wurde geblockt! Um dieses Problem zu lösen, wenden Sie sich bitte an den Administrator.");
INSERT INTO meda_vocabulary VALUES("982","en","_EMAIL_CONFIRMATION_REQUIRED","email confirmation required");
INSERT INTO meda_vocabulary VALUES("983","es","_EMAIL_CONFIRMATION_REQUIRED","requiere confirmación por correo electrónico");
INSERT INTO meda_vocabulary VALUES("984","de","_EMAIL_CONFIRMATION_REQUIRED","E-Mail-Bestätigung erforderlich");
INSERT INTO meda_vocabulary VALUES("985","en","_EMAIL_EMPTY_ALERT","Email cannot be empty! Please re-enter.");
INSERT INTO meda_vocabulary VALUES("986","es","_EMAIL_EMPTY_ALERT","El correo electrónico no puede estar vacía! Por favor, vuelva a entrar.");
INSERT INTO meda_vocabulary VALUES("987","de","_EMAIL_EMPTY_ALERT","E-Mail darf nicht leer sein! Bitte neu eingeben.");
INSERT INTO meda_vocabulary VALUES("988","en","_EMAIL_FIELDS_EMPTY_ALERT","Subject or message cannot be empty! Please re-enter.");
INSERT INTO meda_vocabulary VALUES("989","es","_EMAIL_FIELDS_EMPTY_ALERT","Asunto o el mensaje no puede estar vacío! Por favor, vuelva a entrar.");
INSERT INTO meda_vocabulary VALUES("990","de","_EMAIL_FIELDS_EMPTY_ALERT","Betreff oder Nachricht kann nicht leer sein! Bitte erneut eingeben.");
INSERT INTO meda_vocabulary VALUES("991","en","_EMAIL_FROM","Email Address (From)");
INSERT INTO meda_vocabulary VALUES("992","es","_EMAIL_FROM","Dirección de correo electrónico (De)");
INSERT INTO meda_vocabulary VALUES("993","de","_EMAIL_FROM","E-Mail Adresse (Von)");
INSERT INTO meda_vocabulary VALUES("994","en","_EMAIL_IS_WRONG","Please enter a valid email address.");
INSERT INTO meda_vocabulary VALUES("995","es","_EMAIL_IS_WRONG","Por favor, introduzca una dirección de correo electrónico válida.");
INSERT INTO meda_vocabulary VALUES("996","de","_EMAIL_IS_WRONG","Bitte geben Sie eine gültige Email-Adresse.");
INSERT INTO meda_vocabulary VALUES("997","en","_EMAIL_NOTIFICATION","Email notification");
INSERT INTO meda_vocabulary VALUES("998","es","_EMAIL_NOTIFICATION","Notificación de E-Mail");
INSERT INTO meda_vocabulary VALUES("999","de","_EMAIL_NOTIFICATION","Email Anmeldung");
INSERT INTO meda_vocabulary VALUES("1000","en","_EMAIL_NOT_EXISTS","This e-mail account does not exist in the system! Please re-enter.");
INSERT INTO meda_vocabulary VALUES("1001","es","_EMAIL_NOT_EXISTS","Esta cuenta de correo electrónico no existe en el sistema! Por favor, vuelva a entrar.");
INSERT INTO meda_vocabulary VALUES("1002","de","_EMAIL_NOT_EXISTS","Diese E-Mail-Konto nicht im System vorhanden! Bitte neu eingeben.");
INSERT INTO meda_vocabulary VALUES("1003","en","_EMAIL_SETTINGS","Email Settings");
INSERT INTO meda_vocabulary VALUES("1004","es","_EMAIL_SETTINGS","Configuración del correo electrónico");
INSERT INTO meda_vocabulary VALUES("1005","de","_EMAIL_SETTINGS","E-Mail-Einstellungen");
INSERT INTO meda_vocabulary VALUES("1006","en","_EMAIL_SUCCESSFULLY_SENT","Email has been successfully sent!");
INSERT INTO meda_vocabulary VALUES("1007","es","_EMAIL_SUCCESSFULLY_SENT","El correo electrónico fue enviado con éxito!");
INSERT INTO meda_vocabulary VALUES("1008","de","_EMAIL_SUCCESSFULLY_SENT","E-Mail wurde erfolgreich gesendet!");
INSERT INTO meda_vocabulary VALUES("1009","en","_EMAIL_TEMPLATES","Email Templates");
INSERT INTO meda_vocabulary VALUES("1010","es","_EMAIL_TEMPLATES","Plantillas de correo");
INSERT INTO meda_vocabulary VALUES("1011","de","_EMAIL_TEMPLATES","E-Mail-Vorlagen");
INSERT INTO meda_vocabulary VALUES("1012","en","_EMAIL_TEMPLATES_EDITOR","Email Templates Editor");
INSERT INTO meda_vocabulary VALUES("1013","es","_EMAIL_TEMPLATES_EDITOR","Plantillas de correo electrónico del editor");
INSERT INTO meda_vocabulary VALUES("1014","de","_EMAIL_TEMPLATES_EDITOR","E-Mail-Editor");
INSERT INTO meda_vocabulary VALUES("1015","en","_EMAIL_TO","Email Address (To)");
INSERT INTO meda_vocabulary VALUES("1016","es","_EMAIL_TO","Correo electrónico (Para)");
INSERT INTO meda_vocabulary VALUES("1017","de","_EMAIL_TO","E-Mail Adresse (To)");
INSERT INTO meda_vocabulary VALUES("1018","en","_EMAIL_VALID_ALERT","Please enter a valid email address!");
INSERT INTO meda_vocabulary VALUES("1019","es","_EMAIL_VALID_ALERT","Por favor, introduzca una dirección válida de correo electrónico!");
INSERT INTO meda_vocabulary VALUES("1020","de","_EMAIL_VALID_ALERT","Bitte geben Sie eine gültige E-Mail Adresse!");
INSERT INTO meda_vocabulary VALUES("1021","en","_EMPTY","Empty");
INSERT INTO meda_vocabulary VALUES("1022","es","_EMPTY","Vaciar");
INSERT INTO meda_vocabulary VALUES("1023","de","_EMPTY","Leere");
INSERT INTO meda_vocabulary VALUES("1024","en","_EMPTY_PATIENT_NAME_ALERT","The patient name is empty! Please enter a patient name for searching or click Set Admin button to assign administrator to this appointment.");
INSERT INTO meda_vocabulary VALUES("1025","es","_EMPTY_PATIENT_NAME_ALERT","El nombre del paciente está vacía! Por favor ingrese el nombre del paciente para la búsqueda o haga clic en el botón Set Admin para asignar el administrador de este nombramiento.");
INSERT INTO meda_vocabulary VALUES("1026","de","_EMPTY_PATIENT_NAME_ALERT","Der Patientenname ist leer! Bitte geben Sie eine Patientennamen für die Suche oder klicken Sie auf Admin-Taste, um diesen Termin Administrator zuweisen.");
INSERT INTO meda_vocabulary VALUES("1027","en","_ENTER_CONFIRMATION_CODE","Enter Confirmation Code");
INSERT INTO meda_vocabulary VALUES("1028","es","_ENTER_CONFIRMATION_CODE","Ingrese el código de confirmación");
INSERT INTO meda_vocabulary VALUES("1029","de","_ENTER_CONFIRMATION_CODE","Geben Sie Bestätigungs-Code");
INSERT INTO meda_vocabulary VALUES("1030","en","_ENTER_EMAIL_ADDRESS","(Please enter <i>ONLY real</i> email address)");
INSERT INTO meda_vocabulary VALUES("1031","es","_ENTER_EMAIL_ADDRESS","(Por favor, introduzca <i>sólo real</i> dirección de correo electrónico)");
INSERT INTO meda_vocabulary VALUES("1032","de","_ENTER_EMAIL_ADDRESS","(Bitte geben Sie <i>nur echte</i> E-Mail-Adresse)");
INSERT INTO meda_vocabulary VALUES("1033","en","_ENTIRE_SITE","Entire Site");
INSERT INTO meda_vocabulary VALUES("1034","es","_ENTIRE_SITE","Todo el sitio web");
INSERT INTO meda_vocabulary VALUES("1035","de","_ENTIRE_SITE","Die ganze Site");
INSERT INTO meda_vocabulary VALUES("1036","en","_EVENTS","Events");
INSERT INTO meda_vocabulary VALUES("1037","es","_EVENTS","Eventos");
INSERT INTO meda_vocabulary VALUES("1038","de","_EVENTS","Veranstaltungen");
INSERT INTO meda_vocabulary VALUES("1039","en","_EVENTS_NEW_USER_REGISTERED","Events - new user has been registered");
INSERT INTO meda_vocabulary VALUES("1040","es","_EVENTS_NEW_USER_REGISTERED","Eventos - nuevo usuario se ha registrado");
INSERT INTO meda_vocabulary VALUES("1041","de","_EVENTS_NEW_USER_REGISTERED","Events - neuen Benutzer registriert wurde");
INSERT INTO meda_vocabulary VALUES("1042","en","_EVENT_REGISTRATION_COMPLETED","Thank you for your interest! You have just successfully registered to this event.");
INSERT INTO meda_vocabulary VALUES("1043","es","_EVENT_REGISTRATION_COMPLETED","Gracias por tu interés! Usted acaba de éxito registrado para este evento.");
INSERT INTO meda_vocabulary VALUES("1044","de","_EVENT_REGISTRATION_COMPLETED","Vielen Dank für Ihr Interesse! Sie haben gerade erfolgreich auf dieses Ereignis registriert.");
INSERT INTO meda_vocabulary VALUES("1045","en","_EVENT_USER_ALREADY_REGISTERED","Member with such email is already registered to this event! Please re-enter.");
INSERT INTO meda_vocabulary VALUES("1046","es","_EVENT_USER_ALREADY_REGISTERED","Miembro con el correo electrónico como ya estaba registrado a este evento! Por favor, vuelva a introducir.");
INSERT INTO meda_vocabulary VALUES("1047","de","_EVENT_USER_ALREADY_REGISTERED","Mitglied mit solchen E-Mail wurde bereits auf dieses Ereignis registriert! Bitte erneut eingeben.");
INSERT INTO meda_vocabulary VALUES("1048","en","_EXPAND_PANEL","Expand navigation panel");
INSERT INTO meda_vocabulary VALUES("1049","es","_EXPAND_PANEL","Ampliar el panel de navegación");
INSERT INTO meda_vocabulary VALUES("1050","de","_EXPAND_PANEL","Erweitern Navigationsleiste");
INSERT INTO meda_vocabulary VALUES("1051","en","_EXPERIENCE","Experience");
INSERT INTO meda_vocabulary VALUES("1052","es","_EXPERIENCE","Experiencia");
INSERT INTO meda_vocabulary VALUES("1053","de","_EXPERIENCE","Erfahrung");
INSERT INTO meda_vocabulary VALUES("1054","en","_EXPIRED","Expired");
INSERT INTO meda_vocabulary VALUES("1055","es","_EXPIRED","Caducado");
INSERT INTO meda_vocabulary VALUES("1056","de","_EXPIRED","Abgelaufen");
INSERT INTO meda_vocabulary VALUES("1057","en","_EXPIRES","Expires");
INSERT INTO meda_vocabulary VALUES("1058","es","_EXPIRES","Expira");
INSERT INTO meda_vocabulary VALUES("1059","de","_EXPIRES","Ablauf");
INSERT INTO meda_vocabulary VALUES("1060","en","_EXPORT","Export");
INSERT INTO meda_vocabulary VALUES("1061","es","_EXPORT","Exportación");
INSERT INTO meda_vocabulary VALUES("1062","de","_EXPORT","Export");
INSERT INTO meda_vocabulary VALUES("1063","en","_FAQ","FAQ");
INSERT INTO meda_vocabulary VALUES("1064","es","_FAQ","Preguntas frecuentes");
INSERT INTO meda_vocabulary VALUES("1065","de","_FAQ","Häufig gestellte Fragen");
INSERT INTO meda_vocabulary VALUES("1066","en","_FAQ_MANAGEMENT","FAQ Management");
INSERT INTO meda_vocabulary VALUES("1067","es","_FAQ_MANAGEMENT","Preguntas de Gestión");
INSERT INTO meda_vocabulary VALUES("1068","de","_FAQ_MANAGEMENT","FAQ-Management");
INSERT INTO meda_vocabulary VALUES("1069","en","_FAQ_SETTINGS","FAQ Settings");
INSERT INTO meda_vocabulary VALUES("1070","es","_FAQ_SETTINGS","Configuración del FAQ");
INSERT INTO meda_vocabulary VALUES("1071","de","_FAQ_SETTINGS","FAQ Einstellungen");
INSERT INTO meda_vocabulary VALUES("1072","en","_FAX","Fax");
INSERT INTO meda_vocabulary VALUES("1073","es","_FAX","Fax");
INSERT INTO meda_vocabulary VALUES("1074","de","_FAX","Fax");
INSERT INTO meda_vocabulary VALUES("1075","en","_FEBRUARY","February");
INSERT INTO meda_vocabulary VALUES("1076","es","_FEBRUARY","Febrero");
INSERT INTO meda_vocabulary VALUES("1077","de","_FEBRUARY","Februar");
INSERT INTO meda_vocabulary VALUES("1078","en","_FEMALE","Female");
INSERT INTO meda_vocabulary VALUES("1079","es","_FEMALE","Femenino");
INSERT INTO meda_vocabulary VALUES("1080","de","_FEMALE","Weiblich");
INSERT INTO meda_vocabulary VALUES("1081","en","_FIELD_CANNOT_BE_EMPTY","Field _FIELD_ cannot be empty! Please re-enter.");
INSERT INTO meda_vocabulary VALUES("1082","es","_FIELD_CANNOT_BE_EMPTY","Campo _FIELD_ no puede estar vacía! Por favor, vuelva a entrar.");
INSERT INTO meda_vocabulary VALUES("1083","de","_FIELD_CANNOT_BE_EMPTY","Feld _FIELD_ darf nicht leer sein! Bitte neu eingeben.");
INSERT INTO meda_vocabulary VALUES("1084","en","_FIELD_LENGTH_ALERT","The length of the field _FIELD_ must be less than _LENGTH_ characters! Please re-enter.");
INSERT INTO meda_vocabulary VALUES("1085","es","_FIELD_LENGTH_ALERT","La longitud de la _FIELD_ campo debe ser inferior a _LENGTH_ personajes! Por favor, vuelva a entrar.");
INSERT INTO meda_vocabulary VALUES("1086","de","_FIELD_LENGTH_ALERT","Die länge des feldes _FIELD_ muss kleiner sein als _LENGTH_ zeichen! Bitte erneut eingeben.");
INSERT INTO meda_vocabulary VALUES("1087","en","_FIELD_LENGTH_EXCEEDED","_FIELD_ has exceeded the maximum allowed size: _LENGTH_ characters! Please re-enter.");
INSERT INTO meda_vocabulary VALUES("1088","es","_FIELD_LENGTH_EXCEEDED","_FIELD_ ha superado el tamaño máximo permitido: _LENGTH_ personajes! Por favor, vuelva a entrar.");
INSERT INTO meda_vocabulary VALUES("1089","de","_FIELD_LENGTH_EXCEEDED","_LENGTH_ Zeichen: _FIELD_ hat die maximal zulässige Größe überschritten! Bitte erneut eingeben.");
INSERT INTO meda_vocabulary VALUES("1090","en","_FIELD_MIN_LENGTH_ALERT","The length of the field _FIELD_ cannot  be less than _LENGTH_ characters! Please re-enter.");
INSERT INTO meda_vocabulary VALUES("1091","es","_FIELD_MIN_LENGTH_ALERT","La longitud de la _FIELD_ campo no puede ser inferior a _LENGTH_ personajes! Por favor, vuelva a entrar.");
INSERT INTO meda_vocabulary VALUES("1092","de","_FIELD_MIN_LENGTH_ALERT","Die Länge des Feldes _FIELD_ kann nicht kleiner sein als _LENGTH_ Zeichen! Bitte erneut eingeben.");
INSERT INTO meda_vocabulary VALUES("1093","en","_FIELD_MUST_BE_ALPHA","_FIELD_ must be an alphabetic value! Please re-enter.");
INSERT INTO meda_vocabulary VALUES("1094","es","_FIELD_MUST_BE_ALPHA","Valor _FIELD_ debe ser alfabético! Por favor, vuelva a entrar.");
INSERT INTO meda_vocabulary VALUES("1095","de","_FIELD_MUST_BE_ALPHA","_FIELD_ muss alphabetische wert sein! Bitte erneut eingeben.");
INSERT INTO meda_vocabulary VALUES("1096","en","_FIELD_MUST_BE_ALPHA_NUMERIC","_FIELD_ must be an alphanumeric value! Please re-enter.");
INSERT INTO meda_vocabulary VALUES("1097","es","_FIELD_MUST_BE_ALPHA_NUMERIC","Valor _FIELD_ debe ser alfanumérico! Por favor, vuelva a entrar.");
INSERT INTO meda_vocabulary VALUES("1098","de","_FIELD_MUST_BE_ALPHA_NUMERIC","_FIELD_ muss alphanumerischen wert sein! Bitte erneut eingeben.");
INSERT INTO meda_vocabulary VALUES("1099","en","_FIELD_MUST_BE_BOOLEAN","Field _FIELD_ value must be \'yes\' or \'no\'! Please re-enter.");
INSERT INTO meda_vocabulary VALUES("1100","es","_FIELD_MUST_BE_BOOLEAN","Campo de valor _FIELD_ debe ser \'yes\' o \'no\'! Por favor, vuelva a entrar.");
INSERT INTO meda_vocabulary VALUES("1101","de","_FIELD_MUST_BE_BOOLEAN","Field _FIELD_ wert muss \'Ja\' oder \'Nein\'! Bitte erneut eingeben.");
INSERT INTO meda_vocabulary VALUES("1102","en","_FIELD_MUST_BE_DATE","_FIELD_ must be in valid date format! Please re-enter.");
INSERT INTO meda_vocabulary VALUES("1103","es","_FIELD_MUST_BE_DATE","_FIELD_ debe estar en formato de fecha válido! Por favor, vuelva a entrar.");
INSERT INTO meda_vocabulary VALUES("1104","de","_FIELD_MUST_BE_DATE","_FIELD_ müssen in gültigen Datum-Format! Bitte erneut eingeben.");
INSERT INTO meda_vocabulary VALUES("1105","en","_FIELD_MUST_BE_EMAIL","_FIELD_ must be in valid email format! Please re-enter.");
INSERT INTO meda_vocabulary VALUES("1106","es","_FIELD_MUST_BE_EMAIL","_FIELD_ debe estar en formato de correo electrónico válida! Por favor, vuelva a entrar.");
INSERT INTO meda_vocabulary VALUES("1107","de","_FIELD_MUST_BE_EMAIL","_FIELD_ müssen gültige E-Mail-Format sein! Bitte erneut eingeben.");
INSERT INTO meda_vocabulary VALUES("1108","en","_FIELD_MUST_BE_FLOAT","Field _FIELD_ must be a float number value! Please re-enter.");
INSERT INTO meda_vocabulary VALUES("1109","es","_FIELD_MUST_BE_FLOAT","Campo _FIELD_ debe ser el valor flotante número! Por favor, vuelva a entrar.");
INSERT INTO meda_vocabulary VALUES("1110","de","_FIELD_MUST_BE_FLOAT","Field _FIELD_ muss floatzahl wert! Bitte erneut eingeben.");
INSERT INTO meda_vocabulary VALUES("1111","en","_FIELD_MUST_BE_FLOAT_POSITIVE","Field _FIELD_ must be a positive float number value! Please re-enter.");
INSERT INTO meda_vocabulary VALUES("1112","es","_FIELD_MUST_BE_FLOAT_POSITIVE","Campo _FIELD_ debe ser un valor positivo número flotan! Por favor, vuelva a entrar.");
INSERT INTO meda_vocabulary VALUES("1113","de","_FIELD_MUST_BE_FLOAT_POSITIVE","Field _FIELD_ müssen positive fließkommazahl wert sein! Bitte erneut eingeben.");
INSERT INTO meda_vocabulary VALUES("1114","en","_FIELD_MUST_BE_INT","Field _FIELD_ must be an integer value! Please re-enter.");
INSERT INTO meda_vocabulary VALUES("1115","es","_FIELD_MUST_BE_INT","_FIELD_ Campo debe ser un valor entero! Por favor, vuelva a entrar.");
INSERT INTO meda_vocabulary VALUES("1116","de","_FIELD_MUST_BE_INT","Feld _FIELD_ muss ein ganzzahliger Wert sein! Bitte erneut eingeben.");
INSERT INTO meda_vocabulary VALUES("1117","en","_FIELD_MUST_BE_IP_ADDRESS","_FIELD_ must be a valid IP Address! Please re-enter.");
INSERT INTO meda_vocabulary VALUES("1118","es","_FIELD_MUST_BE_IP_ADDRESS","_FIELD_ Debe ser una dirección IP válida! Por favor, vuelva a entrar.");
INSERT INTO meda_vocabulary VALUES("1119","de","_FIELD_MUST_BE_IP_ADDRESS","_FIELD_ muss eine gültige IP-Adresse! Bitte erneut eingeben.");
INSERT INTO meda_vocabulary VALUES("1120","en","_FIELD_MUST_BE_NUMERIC","Field _FIELD_ must be a numeric value! Please re-enter.");
INSERT INTO meda_vocabulary VALUES("1121","es","_FIELD_MUST_BE_NUMERIC","Campo _FIELD_ valor debe ser numérico! Por favor, vuelva a entrar.");
INSERT INTO meda_vocabulary VALUES("1122","de","_FIELD_MUST_BE_NUMERIC","Field _FIELD_ muss numerischer Wert sein! Bitte erneut eingeben.");
INSERT INTO meda_vocabulary VALUES("1123","en","_FIELD_MUST_BE_NUMERIC_POSITIVE","Field _FIELD_ must be a positive numeric value! Please re-enter.");
INSERT INTO meda_vocabulary VALUES("1124","es","_FIELD_MUST_BE_NUMERIC_POSITIVE","Campo _FIELD_ debe ser el valor numérico positivo! Por favor, vuelva a entrar.");
INSERT INTO meda_vocabulary VALUES("1125","de","_FIELD_MUST_BE_NUMERIC_POSITIVE","Field _FIELD_ müssen positive numerischer wert sein! Bitte erneut eingeben.");
INSERT INTO meda_vocabulary VALUES("1126","en","_FIELD_MUST_BE_PASSWORD","_FIELD_ must be 6 characters at least and consist of letters and digits! Please re-enter.");
INSERT INTO meda_vocabulary VALUES("1127","es","_FIELD_MUST_BE_PASSWORD","_FIELD_ Debe ser de 6 caracteres como mínimo y se componen de letras y dígitos! Por favor, vuelva a entrar.");
INSERT INTO meda_vocabulary VALUES("1128","de","_FIELD_MUST_BE_PASSWORD","_FIELD_ muss 6 zeichen lang sein und mindestens bestehen aus buchstaben und ziffern! Bitte erneut eingeben.");
INSERT INTO meda_vocabulary VALUES("1129","en","_FIELD_MUST_BE_POSITIVE_INT","Field _FIELD_ must be a positive integer value! Please re-enter.");
INSERT INTO meda_vocabulary VALUES("1130","es","_FIELD_MUST_BE_POSITIVE_INT","Campo _FIELD_ debe ser un valor entero positivo! Por favor, vuelva a entrar.");
INSERT INTO meda_vocabulary VALUES("1131","de","_FIELD_MUST_BE_POSITIVE_INT","Field _FIELD_ müssen positive ganze zahl sein! Bitte erneut eingeben.");
INSERT INTO meda_vocabulary VALUES("1132","en","_FIELD_MUST_BE_SIZE_VALUE","Field _FIELD_ must be a valid HTML size property in \'px\', \'pt\', \'em\' or \'%\' units! Please re-enter.");
INSERT INTO meda_vocabulary VALUES("1133","es","_FIELD_MUST_BE_SIZE_VALUE","_FIELD_ Campo debe ser una propiedad válida tamaño HTML en \'px\', \'pt\', \'em\' o \'%\' unidades! Por favor, vuelva a introducir.");
INSERT INTO meda_vocabulary VALUES("1134","de","_FIELD_MUST_BE_SIZE_VALUE","Feld _FIELD_ muss ein gültiger HTML size-Eigenschaft in \'px\', \'pt\', \'em\' oder \'%\' -Einheiten werden! Bitte erneut eingeben.");
INSERT INTO meda_vocabulary VALUES("1135","en","_FIELD_MUST_BE_TEXT","_FIELD_ value must be a text! Please re-enter.");
INSERT INTO meda_vocabulary VALUES("1136","es","_FIELD_MUST_BE_TEXT","_FIELD_ Valor debe ser un texto! Por favor, vuelva a entrar.");
INSERT INTO meda_vocabulary VALUES("1137","de","_FIELD_MUST_BE_TEXT","_FIELD_ wert muss ein text sein! Bitte erneut eingeben.");
INSERT INTO meda_vocabulary VALUES("1138","en","_FIELD_MUST_BE_UNSIGNED_FLOAT","Field _FIELD_ must be an unsigned float value! Please re-enter.");
INSERT INTO meda_vocabulary VALUES("1139","es","_FIELD_MUST_BE_UNSIGNED_FLOAT","Campo _FIELD_ debe ser valor flotante sin firmar! Por favor, vuelva a entrar.");
INSERT INTO meda_vocabulary VALUES("1140","de","_FIELD_MUST_BE_UNSIGNED_FLOAT","Field _FIELD_ muss unsigned Float-Wert sein! Bitte erneut eingeben.");
INSERT INTO meda_vocabulary VALUES("1141","en","_FIELD_MUST_BE_UNSIGNED_INT","Field _FIELD_ must be an unsigned integer value! Please re-enter.");
INSERT INTO meda_vocabulary VALUES("1142","es","_FIELD_MUST_BE_UNSIGNED_INT","_FIELD_ Campo debe ser un valor entero sin signo! Por favor, vuelva a entrar.");
INSERT INTO meda_vocabulary VALUES("1143","de","_FIELD_MUST_BE_UNSIGNED_INT","Feld _FIELD_ muss unsigned Integer-Wert sein! Bitte erneut eingeben.");
INSERT INTO meda_vocabulary VALUES("1144","en","_FIELD_VALUE_EXCEEDED","_FIELD_ has exceeded the maximum allowed value _MAX_! Please re-enter.");
INSERT INTO meda_vocabulary VALUES("1145","es","_FIELD_VALUE_EXCEEDED","_FIELD_ ha superado el valor máximo permitido _MAX_! Por favor, vuelva a entrar.");
INSERT INTO meda_vocabulary VALUES("1146","de","_FIELD_VALUE_EXCEEDED","_FIELD_ Hat die maximal zulässige Wert überschritten _MAX_! Bitte erneut eingeben.");
INSERT INTO meda_vocabulary VALUES("1147","en","_FIELD_VALUE_MINIMUM","_FIELD_ value should not be less then _MIN_! Please re-enter.");
INSERT INTO meda_vocabulary VALUES("1148","es","_FIELD_VALUE_MINIMUM","_FIELD_ valor no debe ser inferior a _MIN_! Por favor, vuelva a entrar.");
INSERT INTO meda_vocabulary VALUES("1149","de","_FIELD_VALUE_MINIMUM","_FIELD_ Wert sollte nicht weniger als _MIN_ werden! Bitte erneut eingeben.");
INSERT INTO meda_vocabulary VALUES("1150","en","_FILED_UNIQUE_VALUE_ALERT","The field _FIELD_ accepts only unique values - please re-enter!");
INSERT INTO meda_vocabulary VALUES("1151","es","_FILED_UNIQUE_VALUE_ALERT","El _FIELD_ campo sólo acepta valores únicos - por favor vuelva a entrar!");
INSERT INTO meda_vocabulary VALUES("1152","de","_FILED_UNIQUE_VALUE_ALERT","Das feld _FIELD_ akzeptiert nur eindeutige werte - bitte erneut eingeben!");
INSERT INTO meda_vocabulary VALUES("1153","en","_FILE_DELETING_ERROR","An error occurred while deleting file! Please try again later.");
INSERT INTO meda_vocabulary VALUES("1154","es","_FILE_DELETING_ERROR","Se produjo un error al eliminar el archivo! Por favor, inténtelo de nuevo más tarde.");
INSERT INTO meda_vocabulary VALUES("1155","de","_FILE_DELETING_ERROR","Fehler beim löschen der datei! Bitte versuchen sie es später erneut.");
INSERT INTO meda_vocabulary VALUES("1156","en","_FILTER_BY","Filter by");
INSERT INTO meda_vocabulary VALUES("1157","es","_FILTER_BY","Filtrar por");
INSERT INTO meda_vocabulary VALUES("1158","de","_FILTER_BY","Filtern nach");
INSERT INTO meda_vocabulary VALUES("1159","en","_FIND_DOCTORS","Find Doctors");
INSERT INTO meda_vocabulary VALUES("1160","es","_FIND_DOCTORS","Encontrar médicos");
INSERT INTO meda_vocabulary VALUES("1161","de","_FIND_DOCTORS","Finden Sie Ärzte");
INSERT INTO meda_vocabulary VALUES("1162","en","_FIND_DOCTOR_BY_LOCATION","Search by Location");
INSERT INTO meda_vocabulary VALUES("1163","es","_FIND_DOCTOR_BY_LOCATION","Buscar por ubicación");
INSERT INTO meda_vocabulary VALUES("1164","de","_FIND_DOCTOR_BY_LOCATION","Suche nach Ort");
INSERT INTO meda_vocabulary VALUES("1165","en","_FIND_DOCTOR_BY_NAME","Search by Name");
INSERT INTO meda_vocabulary VALUES("1166","es","_FIND_DOCTOR_BY_NAME","Búsqueda por Nombre");
INSERT INTO meda_vocabulary VALUES("1167","de","_FIND_DOCTOR_BY_NAME","Suche nach Name");
INSERT INTO meda_vocabulary VALUES("1168","en","_FIND_DOCTOR_BY_SPECIALITY","Find a Doctor by Speciality");
INSERT INTO meda_vocabulary VALUES("1169","es","_FIND_DOCTOR_BY_SPECIALITY","Encuentre un Doctor por Especialidad");
INSERT INTO meda_vocabulary VALUES("1170","de","_FIND_DOCTOR_BY_SPECIALITY","Einen Arzt suchen nach Fachgebiet");
INSERT INTO meda_vocabulary VALUES("1171","en","_FINISH_PUBLISHING","Finish Publishing");
INSERT INTO meda_vocabulary VALUES("1172","es","_FINISH_PUBLISHING","Finalizar publicación");
INSERT INTO meda_vocabulary VALUES("1173","de","_FINISH_PUBLISHING","Finish Publishing");
INSERT INTO meda_vocabulary VALUES("1174","en","_FIRST_NAME","First Name");
INSERT INTO meda_vocabulary VALUES("1175","es","_FIRST_NAME","Nombre");
INSERT INTO meda_vocabulary VALUES("1176","de","_FIRST_NAME","Vorname");
INSERT INTO meda_vocabulary VALUES("1177","en","_FIRST_NAME_EMPTY_ALERT","First Name cannot be empty! Please re-enter.");
INSERT INTO meda_vocabulary VALUES("1178","es","_FIRST_NAME_EMPTY_ALERT","Nombre no puede estar vacío! Por favor, vuelva a entrar.");
INSERT INTO meda_vocabulary VALUES("1179","de","_FIRST_NAME_EMPTY_ALERT","Vorname darf nicht leer sein! Bitte erneut eingeben.");
INSERT INTO meda_vocabulary VALUES("1180","en","_FIRST_VISIT","First Visit");
INSERT INTO meda_vocabulary VALUES("1181","es","_FIRST_VISIT","Primera Visita");
INSERT INTO meda_vocabulary VALUES("1182","de","_FIRST_VISIT","Erster Besuch");
INSERT INTO meda_vocabulary VALUES("1183","en","_FOOTER_IS_EMPTY","Footer cannot be empty! Please re-enter.");
INSERT INTO meda_vocabulary VALUES("1184","es","_FOOTER_IS_EMPTY","Pie de página no puede estar vacía! Por favor, vuelva a entrar.");
INSERT INTO meda_vocabulary VALUES("1185","de","_FOOTER_IS_EMPTY","Footer darf nicht leer sein! Bitte erneut eingeben.");
INSERT INTO meda_vocabulary VALUES("1186","en","_FORCE_SSL","Force SSL");
INSERT INTO meda_vocabulary VALUES("1187","es","_FORCE_SSL","Fuerza SSL");
INSERT INTO meda_vocabulary VALUES("1188","de","_FORCE_SSL","Force-SSL");
INSERT INTO meda_vocabulary VALUES("1189","en","_FORCE_SSL_ALERT","Force site access to always occur under SSL (https) for selected areas. You or site visitors will not be able to access selected areas under non-ssl. Note, you must have SSL enabled on your server to make this option works.");
INSERT INTO meda_vocabulary VALUES("1190","es","_FORCE_SSL_ALERT","Acceso Fuerza del sitio que se produzca siempre bajo SSL (https) para las áreas seleccionadas. Usted o visitantes del sitio no será capaz de acceder a las áreas seleccionadas en virtud de que no sea SSL. Tenga en cuenta, debe tener habilitado SSL en el servidor para que esta opción funcione.");
INSERT INTO meda_vocabulary VALUES("1191","de","_FORCE_SSL_ALERT","Force-Website Zugriff auf immer unter SSL (https) treten für ausgewählte Bereiche. Sie oder Website-Besucher nicht in der Lage zu ausgewählten Bereichen unter Nicht-SSL-Zugang. Beachten Sie, müssen Sie SSL-fähigen auf Ihrem Server haben, damit diese Option funktioniert.");
INSERT INTO meda_vocabulary VALUES("1192","en","_FORGOT_PASSWORD","Forgot your password?");
INSERT INTO meda_vocabulary VALUES("1193","es","_FORGOT_PASSWORD","¿Has olvidado tu contraseña");
INSERT INTO meda_vocabulary VALUES("1194","de","_FORGOT_PASSWORD","Passwort vergessen?");
INSERT INTO meda_vocabulary VALUES("1195","en","_FORM","Form");
INSERT INTO meda_vocabulary VALUES("1196","es","_FORM","Forma");
INSERT INTO meda_vocabulary VALUES("1197","de","_FORM","Formular");
INSERT INTO meda_vocabulary VALUES("1198","en","_FOR_DOCTOR","for doctor");
INSERT INTO meda_vocabulary VALUES("1199","es","_FOR_DOCTOR","indicaciones para el médico");
INSERT INTO meda_vocabulary VALUES("1200","de","_FOR_DOCTOR","für den Arzt");
INSERT INTO meda_vocabulary VALUES("1201","en","_FOR_ME","Me");
INSERT INTO meda_vocabulary VALUES("1202","es","_FOR_ME","me");
INSERT INTO meda_vocabulary VALUES("1203","de","_FOR_ME","mir");
INSERT INTO meda_vocabulary VALUES("1204","en","_FOR_PATIENT","for patient");
INSERT INTO meda_vocabulary VALUES("1205","es","_FOR_PATIENT","para el paciente");
INSERT INTO meda_vocabulary VALUES("1206","de","_FOR_PATIENT","für Patienten");
INSERT INTO meda_vocabulary VALUES("1207","en","_FOR_WHOM","For Whom");
INSERT INTO meda_vocabulary VALUES("1208","es","_FOR_WHOM","Por quién");
INSERT INTO meda_vocabulary VALUES("1209","de","_FOR_WHOM","Für die");
INSERT INTO meda_vocabulary VALUES("1210","en","_FRIDAY","Friday");
INSERT INTO meda_vocabulary VALUES("1211","es","_FRIDAY","viernes");
INSERT INTO meda_vocabulary VALUES("1212","de","_FRIDAY","Freitag");
INSERT INTO meda_vocabulary VALUES("1213","en","_FROM_TIME","From Time");
INSERT INTO meda_vocabulary VALUES("1214","es","_FROM_TIME","De Tiempo");
INSERT INTO meda_vocabulary VALUES("1215","de","_FROM_TIME","Von Zeit");
INSERT INTO meda_vocabulary VALUES("1216","en","_GALLERY","Gallery");
INSERT INTO meda_vocabulary VALUES("1217","es","_GALLERY","Galería");
INSERT INTO meda_vocabulary VALUES("1218","de","_GALLERY","Galerie");
INSERT INTO meda_vocabulary VALUES("1219","en","_GALLERY_MANAGEMENT","Gallery Management");
INSERT INTO meda_vocabulary VALUES("1220","es","_GALLERY_MANAGEMENT","Galería de Gestión");
INSERT INTO meda_vocabulary VALUES("1221","de","_GALLERY_MANAGEMENT","Galerie Verwaltung");
INSERT INTO meda_vocabulary VALUES("1222","en","_GALLERY_SETTINGS","Gallery Settings");
INSERT INTO meda_vocabulary VALUES("1223","es","_GALLERY_SETTINGS","Configuración de la Galería");
INSERT INTO meda_vocabulary VALUES("1224","de","_GALLERY_SETTINGS","Galerie-Einstellungen");
INSERT INTO meda_vocabulary VALUES("1225","en","_GENDER","Gender");
INSERT INTO meda_vocabulary VALUES("1226","es","_GENDER","Género");
INSERT INTO meda_vocabulary VALUES("1227","de","_GENDER","Geschlecht");
INSERT INTO meda_vocabulary VALUES("1228","en","_GENERAL","General");
INSERT INTO meda_vocabulary VALUES("1229","es","_GENERAL","General");
INSERT INTO meda_vocabulary VALUES("1230","de","_GENERAL","Generell");
INSERT INTO meda_vocabulary VALUES("1231","en","_GENERAL_INFO","General Info");
INSERT INTO meda_vocabulary VALUES("1232","es","_GENERAL_INFO","Información General");
INSERT INTO meda_vocabulary VALUES("1233","de","_GENERAL_INFO","Allgemeine Infos");
INSERT INTO meda_vocabulary VALUES("1234","en","_GENERAL_SETTINGS","General Settings");
INSERT INTO meda_vocabulary VALUES("1235","es","_GENERAL_SETTINGS","Configuración general");
INSERT INTO meda_vocabulary VALUES("1236","de","_GENERAL_SETTINGS","Allgemeine Einstellungen");
INSERT INTO meda_vocabulary VALUES("1237","en","_GENERATE","Generate");
INSERT INTO meda_vocabulary VALUES("1238","es","_GENERATE","Generar");
INSERT INTO meda_vocabulary VALUES("1239","de","_GENERATE","Erzeugen");
INSERT INTO meda_vocabulary VALUES("1240","en","_GLOBAL","Global");
INSERT INTO meda_vocabulary VALUES("1241","es","_GLOBAL","Mundial");
INSERT INTO meda_vocabulary VALUES("1242","de","_GLOBAL","Global");
INSERT INTO meda_vocabulary VALUES("1243","en","_GO","Go");
INSERT INTO meda_vocabulary VALUES("1244","es","_GO","Ir");
INSERT INTO meda_vocabulary VALUES("1245","de","_GO","Gehen");
INSERT INTO meda_vocabulary VALUES("1246","en","_GOOGLE_MAPS","Google Maps");
INSERT INTO meda_vocabulary VALUES("1247","es","_GOOGLE_MAPS","Google Maps");
INSERT INTO meda_vocabulary VALUES("1248","de","_GOOGLE_MAPS","Google Maps");
INSERT INTO meda_vocabulary VALUES("1249","en","_GOOGLE_MAPS_API_NOT_SET","Google Maps API Key is empty or has incorrect value! Please define a valid key in Modules &raquo; Google Maps Settings");
INSERT INTO meda_vocabulary VALUES("1250","es","_GOOGLE_MAPS_API_NOT_SET","Google Maps API Key está vacío o tiene un valor incorrecto! Por favor, defina una clave válida en los Módulos &raquo; Configuración de Google Maps");
INSERT INTO meda_vocabulary VALUES("1251","de","_GOOGLE_MAPS_API_NOT_SET","Google Maps API Key ist leer oder hat falschen Wert! Bitte definieren Sie einen gültigen Schlüssel in Module &raquo; Google Maps Einstellungen");
INSERT INTO meda_vocabulary VALUES("1252","en","_GOOGLE_MAPS_SETTINGS","Google Maps Settings");
INSERT INTO meda_vocabulary VALUES("1253","es","_GOOGLE_MAPS_SETTINGS","Configuración de Google Maps");
INSERT INTO meda_vocabulary VALUES("1254","de","_GOOGLE_MAPS_SETTINGS","Google Maps Einstellungen");
INSERT INTO meda_vocabulary VALUES("1255","en","_GRAY","Gray");
INSERT INTO meda_vocabulary VALUES("1256","es","_GRAY","Gray");
INSERT INTO meda_vocabulary VALUES("1257","de","_GRAY","Grau");
INSERT INTO meda_vocabulary VALUES("1258","en","_GROUP","Group");
INSERT INTO meda_vocabulary VALUES("1259","es","_GROUP","Grupo");
INSERT INTO meda_vocabulary VALUES("1260","de","_GROUP","Gruppe");
INSERT INTO meda_vocabulary VALUES("1261","en","_GROUP_NAME","Group Name");
INSERT INTO meda_vocabulary VALUES("1262","es","_GROUP_NAME","Nombre del grupo");
INSERT INTO meda_vocabulary VALUES("1263","de","_GROUP_NAME","Name der Gruppe");
INSERT INTO meda_vocabulary VALUES("1264","en","_HAVE_VISITED_DOCTOR_BEFORE","Have you visited this doctor before?");
INSERT INTO meda_vocabulary VALUES("1265","es","_HAVE_VISITED_DOCTOR_BEFORE","¿Ha visitado este doctor antes?");
INSERT INTO meda_vocabulary VALUES("1266","de","_HAVE_VISITED_DOCTOR_BEFORE","Haben Sie diese bereits besucht Arzt vor?");
INSERT INTO meda_vocabulary VALUES("1267","en","_HDR_FOOTER_TEXT","Footer Text");
INSERT INTO meda_vocabulary VALUES("1268","es","_HDR_FOOTER_TEXT","Pie de página de texto");
INSERT INTO meda_vocabulary VALUES("1269","de","_HDR_FOOTER_TEXT","Fußzeilentext");
INSERT INTO meda_vocabulary VALUES("1270","en","_HDR_HEADER_TEXT","Header Text");
INSERT INTO meda_vocabulary VALUES("1271","es","_HDR_HEADER_TEXT","Texto de la cabecera");
INSERT INTO meda_vocabulary VALUES("1272","de","_HDR_HEADER_TEXT","Kopftext");
INSERT INTO meda_vocabulary VALUES("1273","en","_HDR_SLOGAN_TEXT","Slogan");
INSERT INTO meda_vocabulary VALUES("1274","es","_HDR_SLOGAN_TEXT","Eslogan");
INSERT INTO meda_vocabulary VALUES("1275","de","_HDR_SLOGAN_TEXT","Slogan");
INSERT INTO meda_vocabulary VALUES("1276","en","_HDR_TEMPLATE","Template");
INSERT INTO meda_vocabulary VALUES("1277","es","_HDR_TEMPLATE","Plantilla");
INSERT INTO meda_vocabulary VALUES("1278","de","_HDR_TEMPLATE","Vorlage");
INSERT INTO meda_vocabulary VALUES("1279","en","_HDR_TEXT_DIRECTION","Text Direction");
INSERT INTO meda_vocabulary VALUES("1280","es","_HDR_TEXT_DIRECTION","Dirección del texto");
INSERT INTO meda_vocabulary VALUES("1281","de","_HDR_TEXT_DIRECTION","Textrichtung");
INSERT INTO meda_vocabulary VALUES("1282","en","_HEADER","Header");
INSERT INTO meda_vocabulary VALUES("1283","es","_HEADER","Encabezado");
INSERT INTO meda_vocabulary VALUES("1284","de","_HEADER","Kopfzeile");
INSERT INTO meda_vocabulary VALUES("1285","en","_HEADERS_AND_FOOTERS","Headers & Footers");
INSERT INTO meda_vocabulary VALUES("1286","es","_HEADERS_AND_FOOTERS","Encabezados y pies de página");
INSERT INTO meda_vocabulary VALUES("1287","de","_HEADERS_AND_FOOTERS","Kopf-und Fußzeilen");
INSERT INTO meda_vocabulary VALUES("1288","en","_HEADER_IS_EMPTY","Header cannot be empty! Please re-enter.");
INSERT INTO meda_vocabulary VALUES("1289","es","_HEADER_IS_EMPTY","Encabezado no puede estar vacía! Por favor, vuelva a entrar.");
INSERT INTO meda_vocabulary VALUES("1290","de","_HEADER_IS_EMPTY","Header können nicht leer sein! Bitte erneut eingeben.");
INSERT INTO meda_vocabulary VALUES("1291","en","_HIDDEN","Hidden");
INSERT INTO meda_vocabulary VALUES("1292","es","_HIDDEN","Oculto");
INSERT INTO meda_vocabulary VALUES("1293","de","_HIDDEN","Versteckt");
INSERT INTO meda_vocabulary VALUES("1294","en","_HIDE","Hide");
INSERT INTO meda_vocabulary VALUES("1295","es","_HIDE","Ocultar");
INSERT INTO meda_vocabulary VALUES("1296","de","_HIDE","Verbergen");
INSERT INTO meda_vocabulary VALUES("1297","en","_HOME","Home");
INSERT INTO meda_vocabulary VALUES("1298","es","_HOME","Inicio");
INSERT INTO meda_vocabulary VALUES("1299","de","_HOME","Startseite");
INSERT INTO meda_vocabulary VALUES("1300","en","_HOME_PAGE_WELCOME_TEXT","<p>Welcome to Administrator Control Panel that allows you add, edit or delete site content. With this Administrator Control Panel you can easy manage patients and perform a full site management.</p>\n<p><b>&#8226;</b> There are some modules for you: Backup & Restore, News. Installation or un-installation of them is possible from <a href=\'index.php?admin=modules\'>Modules Menu</a>.</p>\n<p><b>&#8226;</b> In <a href=\'index.php?admin=languages\'>Languages Menu</a> you may add/remove language or change language settings and edit your vocabulary (the words and phrases, used by the system).</p>\n<p><b>&#8226;</b> <a href=\'index.php?admin=settings\'>Settings Menu</a> allows you to define important settings for the site.</p>\n<p><b>&#8226;</b> In <a href=\'index.php?admin=my_account\'>My Account</a> there is a possibility to change your info.</p>\n<p><b>&#8226;</b> <a href=\'index.php?admin=menus\'>Menus</a> and <a href=\'index.php?admin=pages\'>Pages Management</a> are designed for creating and managing menus, links and pages.</p>\n<p><b>&#8226;</b> <a href=\'index.php?admin=mass_mail\'>Mass Email</a> feature allows you to send emails to your users or admins from Admin Panel.</p>");
INSERT INTO meda_vocabulary VALUES("1301","es","_HOME_PAGE_WELCOME_TEXT","<p>Bienvenido al Administrador del panel de control que le permite agregar, editar o eliminar contenido del sitio. Con este Panel de Control del Administrador usted puede fácilmente administrar los usuarios, los pedidos y realizar una gestión completa del sitio.</p>\n<p><b>&#8226;</b> Hay algunos módulos para usted: Copia de seguridad y restauración, Noticias. La instalación o desinstalación de ellos es posible a partir de <a href=\'index.php?admin=modules\'>módulos de menú</a>.</p>\n<p><b>&#8226;</b> En <a href=\'index.php?admin=languages\'>Idiomas del menú</a> puede agregar o quitar idioma o cambiar la configuración de idioma y modificar su vocabulario (las palabras y frases utilizadas por el sistema).</p>\n<p><b>&#8226;</b> <a href=\'index.php?admin=settings\'>Configuración del menú</a> le permite definir opciones importantes para el sitio.</p>\n<p><b>&#8226;</b> En <a href=\'index.php?admin=my_account\'>Mi Cuenta</a> existe la posibilidad de cambiar su información.</p>\n<p><b>&#8226;</b> <a href=\'index.php?admin=menus\'>Los menús</a> y la <a href=\'index.php?admin=pages\'>gestión de páginas</a> están diseñadas para crear y manejar los menús, enlaces y páginas.</p>\n<p><b>&#8226;</b> <a href=\'index.php?admin=mass_mail\'>Correo electrónico masivo</a> característica le permite enviar correos electrónicos a los usuarios o administradores del Panel de Administración.</p>");
INSERT INTO meda_vocabulary VALUES("1302","de","_HOME_PAGE_WELCOME_TEXT","<p>Willkommen auf dem Administrator Control Panel, mit dem Sie hinzufügen, bearbeiten oder löschen Website-Content. Mit dieser Administrator Control Panel können Sie einfach verwalten Benutzer, Aufträge und führen Sie eine vollständige Bauleitung.</p>\n<p><b>&#8226;</b> Es gibt einige Module für Sie: Backup &amp Restore, News. Installation oder Deinstallation von ihnen ist von möglichen <a href=\'index.php?admin=modules\'>Module Menü</a>.</p> \n<p><b>&#8226;</b> Im <a href=\'index.php?admin=languages\'>Menü Sprachen</a> können Sie Hinzufügen / Entfernen von Sprache oder Sprache ändern und bearbeiten können Sie Ihren Wortschatz (die Wörter und Sätze, verwendet von den).</p>\n<p><b>&#8226;</b> <a href=\'index.php?admin=settings\'>Menü &quotEinstellungen&quot</a> können Sie vor Ort definieren wichtigen Einstellungen für die.</p>\n<p><b>&#8226;</b> In <a href=\'index.php?admin=my_account\'>Mein Konto</a> gibt es eine Möglichkeit, um Informationen ändern Sie.</p>\n<p><b>&#8226;</b> <a href=\'index.php?admin=menus\'>Menüs</a> und <a href=\'index.php?admin=pages\'>Seiten-Management</a> sind Seiten speziell für die Erstellung und Verwaltung Menüs, Links und.</p>\n<p><b>&#8226;</b> <a href=\'index.php?admin=mass_mail\'>Mass E-Mail</a> -Funktion ermöglicht es Ihnen, Panel Emails an Ihre Benutzer oder Administratoren von Admin.</p>");
INSERT INTO meda_vocabulary VALUES("1303","en","_HOSPITAL_AFFILIATIONS","Hospital Affiliations");
INSERT INTO meda_vocabulary VALUES("1304","es","_HOSPITAL_AFFILIATIONS","Afiliaciones del hospital");
INSERT INTO meda_vocabulary VALUES("1305","de","_HOSPITAL_AFFILIATIONS","Krankenhaus Mitgliedschaften");
INSERT INTO meda_vocabulary VALUES("1306","en","_HOUR","Hour");
INSERT INTO meda_vocabulary VALUES("1307","es","_HOUR","Hora");
INSERT INTO meda_vocabulary VALUES("1308","de","_HOUR","Stunde");
INSERT INTO meda_vocabulary VALUES("1309","en","_HOURS","hours");
INSERT INTO meda_vocabulary VALUES("1310","es","_HOURS","horas");
INSERT INTO meda_vocabulary VALUES("1311","de","_HOURS","Stunden");
INSERT INTO meda_vocabulary VALUES("1312","en","_ICON_IMAGE","Icon Image");
INSERT INTO meda_vocabulary VALUES("1313","es","_ICON_IMAGE","Imagen de icono");
INSERT INTO meda_vocabulary VALUES("1314","de","_ICON_IMAGE","Icon Bild");
INSERT INTO meda_vocabulary VALUES("1315","en","_IMAGE","Image");
INSERT INTO meda_vocabulary VALUES("1316","es","_IMAGE","Imagen");
INSERT INTO meda_vocabulary VALUES("1317","de","_IMAGE","Bild");
INSERT INTO meda_vocabulary VALUES("1318","en","_IMAGES","Images");
INSERT INTO meda_vocabulary VALUES("1319","es","_IMAGES","Imágenes");
INSERT INTO meda_vocabulary VALUES("1320","de","_IMAGES","Bilder");
INSERT INTO meda_vocabulary VALUES("1321","en","_IMAGES_COUNT","Images Count");
INSERT INTO meda_vocabulary VALUES("1322","es","_IMAGES_COUNT","Imágenes cuentan");
INSERT INTO meda_vocabulary VALUES("1323","de","_IMAGES_COUNT","Bilder zählen");
INSERT INTO meda_vocabulary VALUES("1324","en","_IMAGE_SIZE","image size");
INSERT INTO meda_vocabulary VALUES("1325","es","_IMAGE_SIZE","tamaño de la imagen");
INSERT INTO meda_vocabulary VALUES("1326","de","_IMAGE_SIZE","Bildgröße");
INSERT INTO meda_vocabulary VALUES("1327","en","_IMAGE_VERIFICATION","Image verification");
INSERT INTO meda_vocabulary VALUES("1328","es","_IMAGE_VERIFICATION","Imagen de verificación");
INSERT INTO meda_vocabulary VALUES("1329","de","_IMAGE_VERIFICATION","Bildüberprüfung");
INSERT INTO meda_vocabulary VALUES("1330","en","_IMAGE_VERIFY_EMPTY","You must enter image verification code!");
INSERT INTO meda_vocabulary VALUES("1331","es","_IMAGE_VERIFY_EMPTY","Debe introducir el código de verificación de la imagen!");
INSERT INTO meda_vocabulary VALUES("1332","de","_IMAGE_VERIFY_EMPTY","Sie müssen bild verifizierungscode!");
INSERT INTO meda_vocabulary VALUES("1333","en","_INCOME","Income");
INSERT INTO meda_vocabulary VALUES("1334","es","_INCOME","Ingresos");
INSERT INTO meda_vocabulary VALUES("1335","de","_INCOME","Einkommen");
INSERT INTO meda_vocabulary VALUES("1336","en","_INSTALL","Install");
INSERT INTO meda_vocabulary VALUES("1337","es","_INSTALL","Instale");
INSERT INTO meda_vocabulary VALUES("1338","de","_INSTALL","Installieren");
INSERT INTO meda_vocabulary VALUES("1339","en","_INSTALLED","Installed");
INSERT INTO meda_vocabulary VALUES("1340","es","_INSTALLED","Instalado");
INSERT INTO meda_vocabulary VALUES("1341","de","_INSTALLED","Installierte");
INSERT INTO meda_vocabulary VALUES("1342","en","_INSTALL_PHP_EXISTS","File <b>install.php</b> and/or directory <b>install/</b> still exist. For security reasons please remove them immediately!");
INSERT INTO meda_vocabulary VALUES("1343","es","_INSTALL_PHP_EXISTS","Archivo <b>install.php</b> y/o directorio <b>instalar/</b> siguen existiendo. Por razones de seguridad por favor, elimine de inmediato!");
INSERT INTO meda_vocabulary VALUES("1344","de","_INSTALL_PHP_EXISTS","Datei <b>install.php</b> und/oder direkt <b>installieren</b> noch existieren. Aus Sicherheitsgründen ziehen Sie bitte sofort!");
INSERT INTO meda_vocabulary VALUES("1345","en","_INSURANCE","Insurance");
INSERT INTO meda_vocabulary VALUES("1346","es","_INSURANCE","Seguro");
INSERT INTO meda_vocabulary VALUES("1347","de","_INSURANCE","Versicherung");
INSERT INTO meda_vocabulary VALUES("1348","en","_INSURANCES","Insurances");
INSERT INTO meda_vocabulary VALUES("1349","es","_INSURANCES","Seguros");
INSERT INTO meda_vocabulary VALUES("1350","de","_INSURANCES","Versicherungen");
INSERT INTO meda_vocabulary VALUES("1351","en","_INSURANCES_ACCEPTED","Insurances Accepted");
INSERT INTO meda_vocabulary VALUES("1352","es","_INSURANCES_ACCEPTED","Seguros Aceptados");
INSERT INTO meda_vocabulary VALUES("1353","de","_INSURANCES_ACCEPTED","Versicherungen Accepted");
INSERT INTO meda_vocabulary VALUES("1354","en","_INSURANCES_MANAGEMENT","Insurances Management");
INSERT INTO meda_vocabulary VALUES("1355","es","_INSURANCES_MANAGEMENT","Gestión de los Seguros");
INSERT INTO meda_vocabulary VALUES("1356","de","_INSURANCES_MANAGEMENT","Versicherungen-Management");
INSERT INTO meda_vocabulary VALUES("1357","en","_INTEGRATION","Integration");
INSERT INTO meda_vocabulary VALUES("1358","es","_INTEGRATION","Integración");
INSERT INTO meda_vocabulary VALUES("1359","de","_INTEGRATION","Integration");
INSERT INTO meda_vocabulary VALUES("1360","en","_INTEGRATION_MESSAGE","Copy the code below and put it in the appropriate place of your web site to get a <b>Appointments</b> block.");
INSERT INTO meda_vocabulary VALUES("1361","es","_INTEGRATION_MESSAGE","Copie el código abajo y lo puso en el lugar correspondiente de su sitio web para obtener una disponibilidad <b>Nombramientos</b> bloque.");
INSERT INTO meda_vocabulary VALUES("1362","de","_INTEGRATION_MESSAGE","Kopieren Sie den Code unten ein und legte es an der entsprechenden Stelle Ihrer Website, um eine <b>Ausstattung</b>-Block zu bekommen.");
INSERT INTO meda_vocabulary VALUES("1363","en","_INVALID_FILE_SIZE","Invalid file size: _FILE_SIZE_ (max. allowed: _MAX_ALLOWED_)");
INSERT INTO meda_vocabulary VALUES("1364","es","_INVALID_FILE_SIZE","Tamaño de archivo no válido: _FILE_SIZE_ (máximo permitido: _MAX_ALLOWED_)");
INSERT INTO meda_vocabulary VALUES("1365","de","_INVALID_FILE_SIZE","Ungültige Dateigröße: _FILE_SIZE_ (max. erlaubt: _MAX_ALLOWED_)");
INSERT INTO meda_vocabulary VALUES("1366","en","_INVALID_IMAGE_FILE_TYPE","Uploaded file is not a valid image! Please re-enter.");
INSERT INTO meda_vocabulary VALUES("1367","es","_INVALID_IMAGE_FILE_TYPE","El archivo cargado no es una imagen válida! Por favor, vuelva a entrar.");
INSERT INTO meda_vocabulary VALUES("1368","de","_INVALID_IMAGE_FILE_TYPE","Hochgeladene Datei ist kein gültiges Bild! Bitte geben Sie erneut.");
INSERT INTO meda_vocabulary VALUES("1369","en","_INVOICE","Invoice");
INSERT INTO meda_vocabulary VALUES("1370","es","_INVOICE","Factura");
INSERT INTO meda_vocabulary VALUES("1371","de","_INVOICE","Rechnung");
INSERT INTO meda_vocabulary VALUES("1372","en","_INVOICE_SENT_SUCCESS","The invoice has been successfully sent!");
INSERT INTO meda_vocabulary VALUES("1373","es","_INVOICE_SENT_SUCCESS","La factura ha sido enviado con éxito!");
INSERT INTO meda_vocabulary VALUES("1374","de","_INVOICE_SENT_SUCCESS","Die Rechnung wurde erfolgreich gesendet!");
INSERT INTO meda_vocabulary VALUES("1375","en","_IP_ADDRESS","IP Address");
INSERT INTO meda_vocabulary VALUES("1376","es","_IP_ADDRESS","Dirección IP");
INSERT INTO meda_vocabulary VALUES("1377","de","_IP_ADDRESS","IP-Adresse");
INSERT INTO meda_vocabulary VALUES("1378","en","_IP_ADDRESS_BLOCKED","Your IP Address is blocked! To resolve this problem, please contact the site administrator.");
INSERT INTO meda_vocabulary VALUES("1379","es","_IP_ADDRESS_BLOCKED","Su dirección IP es bloqueada! Para resolver este problema, póngase en contacto con el administrador del sitio.");
INSERT INTO meda_vocabulary VALUES("1380","de","_IP_ADDRESS_BLOCKED","Ihre IP Adresse blockiert! Um dieses Problem zu lösen, wenden Sie sich bitte an den Administrator.");
INSERT INTO meda_vocabulary VALUES("1381","en","_IS_DEFAULT","Is default");
INSERT INTO meda_vocabulary VALUES("1382","es","_IS_DEFAULT","Es la opción predeterminada");
INSERT INTO meda_vocabulary VALUES("1383","de","_IS_DEFAULT","Ist standardmäßig");
INSERT INTO meda_vocabulary VALUES("1384","en","_ITEMS","Items");
INSERT INTO meda_vocabulary VALUES("1385","es","_ITEMS","Artículos");
INSERT INTO meda_vocabulary VALUES("1386","de","_ITEMS","Artikel");
INSERT INTO meda_vocabulary VALUES("1387","en","_I_EXISTING_PATIENT","I\'m an existing patient of this practice");
INSERT INTO meda_vocabulary VALUES("1388","es","_I_EXISTING_PATIENT","I\'m un paciente existente de esta práctica");
INSERT INTO meda_vocabulary VALUES("1389","de","_I_EXISTING_PATIENT","Ich bin ein bestehender Patient von dieser Praxis");
INSERT INTO meda_vocabulary VALUES("1390","en","_I_NEW_PATIENT","I\'m a new patient");
INSERT INTO meda_vocabulary VALUES("1391","es","_I_NEW_PATIENT","Soy un nuevo paciente");
INSERT INTO meda_vocabulary VALUES("1392","de","_I_NEW_PATIENT","Ich bin ein neuer Patient");
INSERT INTO meda_vocabulary VALUES("1393","en","_JANUARY","January");
INSERT INTO meda_vocabulary VALUES("1394","es","_JANUARY","Enero");
INSERT INTO meda_vocabulary VALUES("1395","de","_JANUARY","Januar");
INSERT INTO meda_vocabulary VALUES("1396","en","_JULY","July");
INSERT INTO meda_vocabulary VALUES("1397","es","_JULY","Julio");
INSERT INTO meda_vocabulary VALUES("1398","de","_JULY","Juli");
INSERT INTO meda_vocabulary VALUES("1399","en","_JUNE","June");
INSERT INTO meda_vocabulary VALUES("1400","es","_JUNE","Junio");
INSERT INTO meda_vocabulary VALUES("1401","de","_JUNE","Juni");
INSERT INTO meda_vocabulary VALUES("1402","en","_KEY","Key");
INSERT INTO meda_vocabulary VALUES("1403","es","_KEY","Llave");
INSERT INTO meda_vocabulary VALUES("1404","de","_KEY","Schlüssel");
INSERT INTO meda_vocabulary VALUES("1405","en","_KEYWORDS","Keywords");
INSERT INTO meda_vocabulary VALUES("1406","es","_KEYWORDS","Palabras clave");
INSERT INTO meda_vocabulary VALUES("1407","de","_KEYWORDS","Stichwort");
INSERT INTO meda_vocabulary VALUES("1408","en","_KEY_DISPLAY_TYPE","Key display type");
INSERT INTO meda_vocabulary VALUES("1409","es","_KEY_DISPLAY_TYPE","Tipo de pantalla Key");
INSERT INTO meda_vocabulary VALUES("1410","de","_KEY_DISPLAY_TYPE","Key Display-Typ");
INSERT INTO meda_vocabulary VALUES("1411","en","_LANGUAGE","Language");
INSERT INTO meda_vocabulary VALUES("1412","es","_LANGUAGE","Habla");
INSERT INTO meda_vocabulary VALUES("1413","de","_LANGUAGE","Sprache");
INSERT INTO meda_vocabulary VALUES("1414","en","_LANGUAGES","Languages");
INSERT INTO meda_vocabulary VALUES("1415","es","_LANGUAGES","Idiomas");
INSERT INTO meda_vocabulary VALUES("1416","de","_LANGUAGES","Sprachen");
INSERT INTO meda_vocabulary VALUES("1417","en","_LANGUAGES_SETTINGS","Languages Settings");
INSERT INTO meda_vocabulary VALUES("1418","es","_LANGUAGES_SETTINGS","Configuración de Idiomas");
INSERT INTO meda_vocabulary VALUES("1419","de","_LANGUAGES_SETTINGS","Sprachen-Einstellungen");
INSERT INTO meda_vocabulary VALUES("1420","en","_LANGUAGES_SPOKEN","Languages Spoken");
INSERT INTO meda_vocabulary VALUES("1421","es","_LANGUAGES_SPOKEN","Idiomas que hablo");
INSERT INTO meda_vocabulary VALUES("1422","de","_LANGUAGES_SPOKEN","Sprachkenntnisse");
INSERT INTO meda_vocabulary VALUES("1423","en","_LANGUAGE_ADDED","New language has been successfully added!");
INSERT INTO meda_vocabulary VALUES("1424","es","_LANGUAGE_ADDED","Un nuevo lenguaje se ha añadido!");
INSERT INTO meda_vocabulary VALUES("1425","de","_LANGUAGE_ADDED","Neue Sprache wurde hinzugefügt!");
INSERT INTO meda_vocabulary VALUES("1426","en","_LANGUAGE_ADD_NEW","Add New Language");
INSERT INTO meda_vocabulary VALUES("1427","es","_LANGUAGE_ADD_NEW","Añadir un nuevo idioma");
INSERT INTO meda_vocabulary VALUES("1428","de","_LANGUAGE_ADD_NEW","Neue Sprache hinzufügen");
INSERT INTO meda_vocabulary VALUES("1429","en","_LANGUAGE_EDIT","Edit Language");
INSERT INTO meda_vocabulary VALUES("1430","es","_LANGUAGE_EDIT","Editar Idioma");
INSERT INTO meda_vocabulary VALUES("1431","de","_LANGUAGE_EDIT","Bearbeiten Sprache");
INSERT INTO meda_vocabulary VALUES("1432","en","_LANGUAGE_EDITED","Language data has been successfully updated!");
INSERT INTO meda_vocabulary VALUES("1433","es","_LANGUAGE_EDITED","Idioma de datos se ha actualizado correctamente!");
INSERT INTO meda_vocabulary VALUES("1434","de","_LANGUAGE_EDITED","Language Daten wurden erfolgreich aktualisiert!");
INSERT INTO meda_vocabulary VALUES("1435","en","_LANGUAGE_NAME","Language Name");
INSERT INTO meda_vocabulary VALUES("1436","es","_LANGUAGE_NAME","Idioma Nombre");
INSERT INTO meda_vocabulary VALUES("1437","de","_LANGUAGE_NAME","Sprache Name");
INSERT INTO meda_vocabulary VALUES("1438","en","_LANG_ABBREV_EMPTY","Language abbreviation cannot be empty!");
INSERT INTO meda_vocabulary VALUES("1439","es","_LANG_ABBREV_EMPTY","Abreviatura del idioma no puede estar vacía!");
INSERT INTO meda_vocabulary VALUES("1440","de","_LANG_ABBREV_EMPTY","Sprachkürzel darf nicht leer sein!");
INSERT INTO meda_vocabulary VALUES("1441","en","_LANG_DELETED","Language has been successfully deleted!");
INSERT INTO meda_vocabulary VALUES("1442","es","_LANG_DELETED","Idioma ha sido borrado!");
INSERT INTO meda_vocabulary VALUES("1443","de","_LANG_DELETED","Sprache wurde erfolgreich gelöscht!");
INSERT INTO meda_vocabulary VALUES("1444","en","_LANG_DELETE_LAST_ERROR","You cannot delete last language!");
INSERT INTO meda_vocabulary VALUES("1445","es","_LANG_DELETE_LAST_ERROR","No se puede eliminar Lengua!");
INSERT INTO meda_vocabulary VALUES("1446","de","_LANG_DELETE_LAST_ERROR","Sie können nicht löschen letzten Sprache!");
INSERT INTO meda_vocabulary VALUES("1447","en","_LANG_DELETE_WARNING","Are you sure you want to remove this language? This operation will delete all language vocabulary!");
INSERT INTO meda_vocabulary VALUES("1448","es","_LANG_DELETE_WARNING","¿Estás seguro de que deseas eliminar este idioma? Esta operación eliminará todos vocabulario del idioma!");
INSERT INTO meda_vocabulary VALUES("1449","de","_LANG_DELETE_WARNING","Sind Sie sicher, dass Sie diese Sprache zu entfernen? Dieser Vorgang löscht alle Sprache Wortschatz!");
INSERT INTO meda_vocabulary VALUES("1450","en","_LANG_MISSED","Missed language to update! Please, try again.");
INSERT INTO meda_vocabulary VALUES("1451","es","_LANG_MISSED","El lenguaje perdido de actualizar! Por favor, inténtelo de nuevo.");
INSERT INTO meda_vocabulary VALUES("1452","de","_LANG_MISSED","Verpasste Sprache zu aktualisieren! Bitte versuchen Sie es erneut.");
INSERT INTO meda_vocabulary VALUES("1453","en","_LANG_NAME_EMPTY","Language name cannot be empty!");
INSERT INTO meda_vocabulary VALUES("1454","es","_LANG_NAME_EMPTY","Nombre de idioma no puede estar vacía!");
INSERT INTO meda_vocabulary VALUES("1455","de","_LANG_NAME_EMPTY","Name der Sprache darf nicht leer sein!");
INSERT INTO meda_vocabulary VALUES("1456","en","_LANG_NAME_EXISTS","Language with such name already exists! Please choose another.");
INSERT INTO meda_vocabulary VALUES("1457","es","_LANG_NAME_EXISTS","De idiomas con ese nombre ya existe! Por favor, elija otro.");
INSERT INTO meda_vocabulary VALUES("1458","de","_LANG_NAME_EXISTS","Sprache mit solchen Namen existiert bereits! Bitte wählen Sie einen anderen.");
INSERT INTO meda_vocabulary VALUES("1459","en","_LANG_NOT_DELETED","Language has not been deleted!");
INSERT INTO meda_vocabulary VALUES("1460","es","_LANG_NOT_DELETED","El idioma no fue eliminado!");
INSERT INTO meda_vocabulary VALUES("1461","de","_LANG_NOT_DELETED","Sprache wurde nicht gelöscht!");
INSERT INTO meda_vocabulary VALUES("1462","en","_LANG_ORDER_CHANGED","Language order has been successfully changed!");
INSERT INTO meda_vocabulary VALUES("1463","es","_LANG_ORDER_CHANGED","Orden de los idiomas se ha cambiado!");
INSERT INTO meda_vocabulary VALUES("1464","de","_LANG_ORDER_CHANGED","Sprache Bestellung wurde erfolgreich geändert!");
INSERT INTO meda_vocabulary VALUES("1465","en","_LAST_CURRENCY_ALERT","You cannot delete last active currency!");
INSERT INTO meda_vocabulary VALUES("1466","es","_LAST_CURRENCY_ALERT","No se puede eliminar la moneda activo de último!");
INSERT INTO meda_vocabulary VALUES("1467","de","_LAST_CURRENCY_ALERT","Sie können nicht löschen letzten aktiven Währung!");
INSERT INTO meda_vocabulary VALUES("1468","en","_LAST_LOGGED_IP","Last logged IP");
INSERT INTO meda_vocabulary VALUES("1469","es","_LAST_LOGGED_IP","Última sesión de IP");
INSERT INTO meda_vocabulary VALUES("1470","de","_LAST_LOGGED_IP","Zuletzt eingeloggt IP");
INSERT INTO meda_vocabulary VALUES("1471","en","_LAST_LOGIN","Last Login");
INSERT INTO meda_vocabulary VALUES("1472","es","_LAST_LOGIN","Última inicio de sesión");
INSERT INTO meda_vocabulary VALUES("1473","de","_LAST_LOGIN","Letzter Login");
INSERT INTO meda_vocabulary VALUES("1474","en","_LAST_NAME","Last Name");
INSERT INTO meda_vocabulary VALUES("1475","es","_LAST_NAME","Apellido");
INSERT INTO meda_vocabulary VALUES("1476","de","_LAST_NAME","Nachname");
INSERT INTO meda_vocabulary VALUES("1477","en","_LAST_NAME_EMPTY_ALERT","Last Name cannot be empty!");
INSERT INTO meda_vocabulary VALUES("1478","es","_LAST_NAME_EMPTY_ALERT","Apellido no puede estar vacío! Por favor, vuelva a entrar.");
INSERT INTO meda_vocabulary VALUES("1479","de","_LAST_NAME_EMPTY_ALERT","Nachname darf nicht leer sein!");
INSERT INTO meda_vocabulary VALUES("1480","en","_LAST_RUN","Last run");
INSERT INTO meda_vocabulary VALUES("1481","es","_LAST_RUN","La última ejecución");
INSERT INTO meda_vocabulary VALUES("1482","de","_LAST_RUN","Letzter Lauf");
INSERT INTO meda_vocabulary VALUES("1483","en","_LAST_VISIT","Last Visit");
INSERT INTO meda_vocabulary VALUES("1484","es","_LAST_VISIT","Ultima visita");
INSERT INTO meda_vocabulary VALUES("1485","de","_LAST_VISIT","Letzter Besuch");
INSERT INTO meda_vocabulary VALUES("1486","en","_LATITUDE","Latitude");
INSERT INTO meda_vocabulary VALUES("1487","es","_LATITUDE","Latitud");
INSERT INTO meda_vocabulary VALUES("1488","de","_LATITUDE","Breite");
INSERT INTO meda_vocabulary VALUES("1489","en","_LAYOUT","Layout");
INSERT INTO meda_vocabulary VALUES("1490","es","_LAYOUT","Diseño");
INSERT INTO meda_vocabulary VALUES("1491","de","_LAYOUT","Layout");
INSERT INTO meda_vocabulary VALUES("1492","en","_LEAVE_YOUR_COMMENT","Leave your comment");
INSERT INTO meda_vocabulary VALUES("1493","es","_LEAVE_YOUR_COMMENT","Deja tu comentario");
INSERT INTO meda_vocabulary VALUES("1494","de","_LEAVE_YOUR_COMMENT","Lassen Sie Ihren Kommentar");
INSERT INTO meda_vocabulary VALUES("1495","en","_LEFT","Left");
INSERT INTO meda_vocabulary VALUES("1496","es","_LEFT","Izquierdo");
INSERT INTO meda_vocabulary VALUES("1497","de","_LEFT","Links");
INSERT INTO meda_vocabulary VALUES("1498","en","_LEFT_TO_RIGHT","LTR (left-to-right)");
INSERT INTO meda_vocabulary VALUES("1499","es","_LEFT_TO_RIGHT","LTR (de izquierda a derecha)");
INSERT INTO meda_vocabulary VALUES("1500","de","_LEFT_TO_RIGHT","LTR (von links nach rechts)");
INSERT INTO meda_vocabulary VALUES("1501","en","_LICENSE","License");
INSERT INTO meda_vocabulary VALUES("1502","es","_LICENSE","Licencia");
INSERT INTO meda_vocabulary VALUES("1503","de","_LICENSE","Lizenz");
INSERT INTO meda_vocabulary VALUES("1504","en","_LICENSE_NUMBER","License Number");
INSERT INTO meda_vocabulary VALUES("1505","es","_LICENSE_NUMBER","Número de licencia");
INSERT INTO meda_vocabulary VALUES("1506","de","_LICENSE_NUMBER","Lizenznummer");
INSERT INTO meda_vocabulary VALUES("1507","en","_LINK","Link");
INSERT INTO meda_vocabulary VALUES("1508","es","_LINK","Link");
INSERT INTO meda_vocabulary VALUES("1509","de","_LINK","Link");
INSERT INTO meda_vocabulary VALUES("1510","en","_LINK_PARAMETER","Link Parameter");
INSERT INTO meda_vocabulary VALUES("1511","es","_LINK_PARAMETER","Enlace de parámetros");
INSERT INTO meda_vocabulary VALUES("1512","de","_LINK_PARAMETER","Link-Parameter");
INSERT INTO meda_vocabulary VALUES("1513","en","_LOADING","loading");
INSERT INTO meda_vocabulary VALUES("1514","es","_LOADING","de carga");
INSERT INTO meda_vocabulary VALUES("1515","de","_LOADING","laden");
INSERT INTO meda_vocabulary VALUES("1516","en","_LOCAL_TIME","Local Time");
INSERT INTO meda_vocabulary VALUES("1517","es","_LOCAL_TIME","Hora local");
INSERT INTO meda_vocabulary VALUES("1518","de","_LOCAL_TIME","Ortszeit");
INSERT INTO meda_vocabulary VALUES("1519","en","_LOGIN","Login");
INSERT INTO meda_vocabulary VALUES("1520","es","_LOGIN","Login");
INSERT INTO meda_vocabulary VALUES("1521","de","_LOGIN","Login");
INSERT INTO meda_vocabulary VALUES("1522","en","_LOGINS","Logins");
INSERT INTO meda_vocabulary VALUES("1523","es","_LOGINS","Iniciar sesión");
INSERT INTO meda_vocabulary VALUES("1524","de","_LOGINS","Login");
INSERT INTO meda_vocabulary VALUES("1525","en","_LOGIN_PAGE_MSG","Use a valid administrator username and password to get access to the Administrator Back-End.<br><br>Return to site <a href=\'index.php\'>Home Page</a><br><br><img align=\'center\' src=\'images/lock.png\' alt=\'lock\' width=\'92px\'>");
INSERT INTO meda_vocabulary VALUES("1526","es","_LOGIN_PAGE_MSG","Utilice un nombre de usuario administrador y contraseña válidos para acceder al Administrador de servicios de fondo.<br><br>Volver a la página <a href=\'index.php\'>Home Page</a> <br><br><img align=\'center\' src=\'images/lock.png\' alt=\'lock\' width=\'92px\'>");
INSERT INTO meda_vocabulary VALUES("1527","de","_LOGIN_PAGE_MSG","Verwenden Sie einen gültigen Administrator-Benutzernamen und das Passwort für den Zugriff auf das Administrator-Back-End zu bekommen. <br><br>Zurück zur Website <a href=\'index.php\'>Homepage</a><br><br><img align=\'center\' src=\'images/lock.png\' alt=\'lock\' width=\'92px\'>");
INSERT INTO meda_vocabulary VALUES("1528","en","_LONGITUDE","Longitude");
INSERT INTO meda_vocabulary VALUES("1529","es","_LONGITUDE","Longitud");
INSERT INTO meda_vocabulary VALUES("1530","de","_LONGITUDE","Länge");
INSERT INTO meda_vocabulary VALUES("1531","en","_LOOK_IN","Look in");
INSERT INTO meda_vocabulary VALUES("1532","es","_LOOK_IN","Buscar en");
INSERT INTO meda_vocabulary VALUES("1533","de","_LOOK_IN","Suchen in");
INSERT INTO meda_vocabulary VALUES("1534","en","_MAILER","Mailer");
INSERT INTO meda_vocabulary VALUES("1535","es","_MAILER","Mailer");
INSERT INTO meda_vocabulary VALUES("1536","de","_MAILER","Mailer");
INSERT INTO meda_vocabulary VALUES("1537","en","_MAIN","Main");
INSERT INTO meda_vocabulary VALUES("1538","es","_MAIN","Principal");
INSERT INTO meda_vocabulary VALUES("1539","de","_MAIN","Haupt");
INSERT INTO meda_vocabulary VALUES("1540","en","_MAIN_ADMIN","Main Admin");
INSERT INTO meda_vocabulary VALUES("1541","es","_MAIN_ADMIN","Administrador principal");
INSERT INTO meda_vocabulary VALUES("1542","de","_MAIN_ADMIN","Haupt-Admin");
INSERT INTO meda_vocabulary VALUES("1543","en","_MAKE_APPOINTMENT","Make an Appointment");
INSERT INTO meda_vocabulary VALUES("1544","es","_MAKE_APPOINTMENT","Haga una cita");
INSERT INTO meda_vocabulary VALUES("1545","de","_MAKE_APPOINTMENT","Termin vereinbaren");
INSERT INTO meda_vocabulary VALUES("1546","en","_MALE","Male");
INSERT INTO meda_vocabulary VALUES("1547","es","_MALE","Masculino");
INSERT INTO meda_vocabulary VALUES("1548","de","_MALE","Männlich");
INSERT INTO meda_vocabulary VALUES("1549","en","_MANAGEMENT","Management");
INSERT INTO meda_vocabulary VALUES("1550","es","_MANAGEMENT","Administración");
INSERT INTO meda_vocabulary VALUES("1551","de","_MANAGEMENT","Management");
INSERT INTO meda_vocabulary VALUES("1552","en","_MANAGE_TEMPLATES","Manage Templates");
INSERT INTO meda_vocabulary VALUES("1553","es","_MANAGE_TEMPLATES","Administrar plantillas");
INSERT INTO meda_vocabulary VALUES("1554","de","_MANAGE_TEMPLATES","Vorlagen verwalten");
INSERT INTO meda_vocabulary VALUES("1555","en","_MAP_CODE","Map code");
INSERT INTO meda_vocabulary VALUES("1556","es","_MAP_CODE","Asignar el código de");
INSERT INTO meda_vocabulary VALUES("1557","de","_MAP_CODE","Map-Code");
INSERT INTO meda_vocabulary VALUES("1558","en","_MAP_OVERLAY","Map Overlay");
INSERT INTO meda_vocabulary VALUES("1559","es","_MAP_OVERLAY","Mapa de superposición");
INSERT INTO meda_vocabulary VALUES("1560","de","_MAP_OVERLAY","Landkarten-Overlay");
INSERT INTO meda_vocabulary VALUES("1561","en","_MARCH","March");
INSERT INTO meda_vocabulary VALUES("1562","es","_MARCH","Marzo");
INSERT INTO meda_vocabulary VALUES("1563","de","_MARCH","März");
INSERT INTO meda_vocabulary VALUES("1564","en","_MASS_MAIL","Mass Mail");
INSERT INTO meda_vocabulary VALUES("1565","es","_MASS_MAIL","Misa Mail");
INSERT INTO meda_vocabulary VALUES("1566","de","_MASS_MAIL","Masse Mail");
INSERT INTO meda_vocabulary VALUES("1567","en","_MASS_MAIL_ALERT","Attention: shared hosting services usually have a limit of 200 emails per hour");
INSERT INTO meda_vocabulary VALUES("1568","es","_MASS_MAIL_ALERT","Atención: servicios de alojamiento compartido por lo general tienen un límite de 200 correos electrónicos por hora");
INSERT INTO meda_vocabulary VALUES("1569","de","_MASS_MAIL_ALERT","Achtung: Shared-Hosting-Dienste haben in der Regel ein Limit von 200 Mails pro Stunde");
INSERT INTO meda_vocabulary VALUES("1570","en","_MASS_MAIL_AND_TEMPLATES","Mass Mail & Templates");
INSERT INTO meda_vocabulary VALUES("1571","es","_MASS_MAIL_AND_TEMPLATES","Misa de correo y plantillas");
INSERT INTO meda_vocabulary VALUES("1572","de","_MASS_MAIL_AND_TEMPLATES","Masse Mail & Vorlagen");
INSERT INTO meda_vocabulary VALUES("1573","en","_MAX_APPOINTMENTS_ERROR","You have reached the maximum number of permitted appointments, that have not been verified yet! Please complete at least one of them to proceed booking of new appointments.");
INSERT INTO meda_vocabulary VALUES("1574","es","_MAX_APPOINTMENTS_ERROR","Usted ha llegado al número máximo de citas permitidas, que no han sido verificados todavía! Por favor, complete al menos uno de ellos para proceder reserva de los nuevos nombramientos.");
INSERT INTO meda_vocabulary VALUES("1575","de","_MAX_APPOINTMENTS_ERROR","Sie haben die maximale Anzahl von erlaubten Termine, die bisher noch nicht verifiziert erreicht! Bitte füllen Sie mindestens eine von ihnen zur Buchung von Neueinstellungen gehen.");
INSERT INTO meda_vocabulary VALUES("1576","en","_MAX_CHARS","(max: _MAX_CHARS_ chars)");
INSERT INTO meda_vocabulary VALUES("1577","es","_MAX_CHARS","(max: _MAX_CHARS_ caracteres)");
INSERT INTO meda_vocabulary VALUES("1578","de","_MAX_CHARS","(max: _MAX_CHARS_ Zeichen)");
INSERT INTO meda_vocabulary VALUES("1579","en","_MAX_ORDERS_ERROR","You have reached the maximum number of permitted orders, that you have not yet finished! Please complete at least one of them to proceed.");
INSERT INTO meda_vocabulary VALUES("1580","es","_MAX_ORDERS_ERROR","Usted ha alcanzado el número máximo permitido de las órdenes, que aún no ha terminado! Por favor, complete al menos uno de ellos para proceder.");
INSERT INTO meda_vocabulary VALUES("1581","de","_MAX_ORDERS_ERROR","Sie haben die maximale Anzahl von erlaubten Auftragseingang erreichte, dass Sie noch nicht fertig! Bitte vervollständigen mindestens eine von ihnen, um fortzufahren.");
INSERT INTO meda_vocabulary VALUES("1582","en","_MAY","May");
INSERT INTO meda_vocabulary VALUES("1583","es","_MAY","Mayo");
INSERT INTO meda_vocabulary VALUES("1584","de","_MAY","Mai");
INSERT INTO meda_vocabulary VALUES("1585","en","_MD_APPOINTMENTS","This module provides an efficient way to maintain appointments. A patient can create and manage its own appointments, administrator may manage them via Admin Panel.");
INSERT INTO meda_vocabulary VALUES("1586","es","_MD_APPOINTMENTS","Este módulo proporciona una solución eficiente para mantener citas. Un paciente puede crear y administrar sus propias citas, el administrador podrá gestionar a través de panel de administración.");
INSERT INTO meda_vocabulary VALUES("1587","de","_MD_APPOINTMENTS","Dieses Modul bietet eine effiziente Möglichkeit, um Termine zu halten. Ein Patient kann erstellen und verwalten ihre eigenen Termine, Administrator kann sie über Admin Panel verwalten.");
INSERT INTO meda_vocabulary VALUES("1588","en","_MD_BACKUP_AND_RESTORE","With Backup and Restore module you can dump all of your database tables to a file download or save to a file on the server, and to restore from an uploaded or previously saved database dump.");
INSERT INTO meda_vocabulary VALUES("1589","es","_MD_BACKUP_AND_RESTORE","Con el módulo de seguridad y restauración para volcar todas las tablas de su base de datos de descarga de un archivo o guardarlo en un archivo en el servidor, y restaurar a partir de un depósito de base de datos de subida o guardado previamente.");
INSERT INTO meda_vocabulary VALUES("1590","de","_MD_BACKUP_AND_RESTORE","Mit Backup and Restore-Modul können Sie alle Ihre Datenbanktabellen, eine Datei herunterzuladen Dump speichern oder in eine Datei auf dem Server, und von einer hochgeladenen oder zuvor gespeicherte Datenbank-Dump wiederherstellen.");
INSERT INTO meda_vocabulary VALUES("1591","en","_MD_BANNERS","The Banners module allows administrator to display images on the site in random or rotation style.");
INSERT INTO meda_vocabulary VALUES("1592","es","_MD_BANNERS","El módulo de Banners que permite al administrador visualizar las imágenes en el sitio en el estilo de azar o de la rotación.");
INSERT INTO meda_vocabulary VALUES("1593","de","_MD_BANNERS","Die Banner-Modul erlaubt dem Administrator, Bilder auf der Site in zufälliger oder Rotation Stil angezeigt.");
INSERT INTO meda_vocabulary VALUES("1594","en","_MD_COMMENTS","The Comments module allows visitors to leave comments on articles and administrator of the site to moderate them.");
INSERT INTO meda_vocabulary VALUES("1595","es","_MD_COMMENTS","El módulo de Comentarios permite a los visitantes dejar comentarios en los artículos y administrador del sitio a moderada.");
INSERT INTO meda_vocabulary VALUES("1596","de","_MD_COMMENTS","Die Kommentare Modul ermöglicht es den Besuchern, um Kommentare zu Artikeln und Administrator der Website zu verlassen, um sie zu mäßigen.");
INSERT INTO meda_vocabulary VALUES("1597","en","_MD_CONTACT_US","Contact Us module allows easy create and place on-line contact form on site pages, using predefined code, like: {module:contact_us}.");
INSERT INTO meda_vocabulary VALUES("1598","es","_MD_CONTACT_US","Contáctenos módulo permite una fácil crear y colocar en línea el formulario de contacto en las páginas del sitio, utilizando el código predefinidas, como: {module: contactenos}.");
INSERT INTO meda_vocabulary VALUES("1599","de","_MD_CONTACT_US","Kontakt Modul ermöglicht die einfache Erstellung und am Online-Kontaktformular auf Seiten der Website, unter Verwendung vordefinierter Code, wie: {module:contact_us}.");
INSERT INTO meda_vocabulary VALUES("1600","en","_MD_DOCTORS","The Doctors module allows easy doctors management on your site. Administrator can create, edit or delete customer accounts. Doctors could register on the site and log into their accounts.");
INSERT INTO meda_vocabulary VALUES("1601","es","_MD_DOCTORS","El módulo permite la gestión doctores médicos fácil en su sitio. El administrador puede crear, editar o eliminar cuentas de clientes. Los médicos pueden registrarse en el sitio y acceder a sus cuentas.");
INSERT INTO meda_vocabulary VALUES("1602","de","_MD_DOCTORS","Die Ärzte-Modul ermöglicht die einfache Ärzten Management auf Ihrer Website. Administrator erstellen, bearbeiten oder löschen Kundenkonten. Ärzte konnten auf der Website und log in ihre Konten zu registrieren.");
INSERT INTO meda_vocabulary VALUES("1603","en","_MD_FAQ","The Frequently Asked Questions (faq) module allows admin users to create question and answer pairs which they want displayed on the \'faq\' page.");
INSERT INTO meda_vocabulary VALUES("1604","es","_MD_FAQ","Las Preguntas Frecuentes (FAQ) del módulo permite a los usuarios de administración para crear pares de preguntas y respuestas que desea mostrar en la página \'preguntas frecuentes\'.");
INSERT INTO meda_vocabulary VALUES("1605","de","_MD_FAQ","Die Frequently Asked Questions (FAQ)-Modul ermöglicht admin Benutzer Frage und Antwort-Paare, die sie auf der &#034;FAQ&#034;-Seite angezeigt werden sollen erstellen.");
INSERT INTO meda_vocabulary VALUES("1606","en","_MD_GALLERY","The Gallery module allows administrator to create image or video albums, upload album content and dysplay this content to be viewed by visitor of the site.");
INSERT INTO meda_vocabulary VALUES("1607","es","_MD_GALLERY","El módulo permite al administrador de la Galería para crear álbumes de imágenes o de vídeo, subir contenido del álbum y dysplay este contenido para ser visto por los visitantes del sitio.");
INSERT INTO meda_vocabulary VALUES("1608","de","_MD_GALLERY","Die Galerie-Modul erlaubt dem Administrator, Bild oder Video Alben zu erstellen, hochzuladen Album Inhalte und dysplay diese Inhalte durch Besucher der Website eingesehen werden.");
INSERT INTO meda_vocabulary VALUES("1609","en","_MD_GOOGLE_MAPS","The Google Maps module allows visitors to see doctors addresses on a real Google Maps");
INSERT INTO meda_vocabulary VALUES("1610","es","_MD_GOOGLE_MAPS","El módulo de Google Maps permite a los visitantes ver las direcciones de los médicos reales en Google Maps");
INSERT INTO meda_vocabulary VALUES("1611","de","_MD_GOOGLE_MAPS","Die Google Maps-Modul ermöglicht es den Besuchern Ärzten Adressen auf reale Google Maps sehen");
INSERT INTO meda_vocabulary VALUES("1612","en","_MD_NEWS","The News and Events module allows administrator to post news and events on the site, display latest of them at the side block.");
INSERT INTO meda_vocabulary VALUES("1613","es","_MD_NEWS","El módulo de Noticias y Eventos permite al administrador para publicar noticias y eventos en el sitio, muestra más reciente de ellas en el bloque lateral.");
INSERT INTO meda_vocabulary VALUES("1614","de","_MD_NEWS","Das News und Events-Modul erlaubt dem Administrator, Neuigkeiten und Veranstaltungen auf der Website zu veröffentlichen, zeigen neueste von ihnen an der Seite zu blockieren.");
INSERT INTO meda_vocabulary VALUES("1615","en","_MD_PAGES","Pages module allows administrator to easily create and maintain page content.");
INSERT INTO meda_vocabulary VALUES("1616","es","_MD_PAGES","Módulo de páginas permite al administrador crear y mantener fácilmente contenido de la página.");
INSERT INTO meda_vocabulary VALUES("1617","de","_MD_PAGES","Seiten-Modul ermöglicht Administratoren die einfache Erstellung und Pflege Inhalt der Seite.");
INSERT INTO meda_vocabulary VALUES("1618","en","_MD_PATIENTS","The Patients module allows easy patients management on your site. Administrator can create, edit or delete customer accounts. Patients could register on the site and log into their accounts.");
INSERT INTO meda_vocabulary VALUES("1619","es","_MD_PATIENTS","El módulo permite la gestión de los pacientes Los pacientes fácil en su sitio. Administrador puede crear, editar o borrar cuentas de clientes. Los pacientes pueden registrarse en el sitio e iniciar sesión en sus cuentas.");
INSERT INTO meda_vocabulary VALUES("1620","de","_MD_PATIENTS","Die Patienten-Modul ermöglicht die einfache Verwaltung Patienten auf Ihrer Website. Administrator könnte erstellen, bearbeiten oder löschen Kundenkonten. Die Patienten konnten auf der Website und loggen Sie sich in ihr Konto zu registrieren.");
INSERT INTO meda_vocabulary VALUES("1621","en","_MD_PAYMENTS","The module Payments allows you to easily accepts and manage payments for appointments from patients.");
INSERT INTO meda_vocabulary VALUES("1622","es","_MD_PAYMENTS","Los pagos módulo le permite aceptar y gestionar los pagos para las citas de los pacientes con facilidad.");
INSERT INTO meda_vocabulary VALUES("1623","de","_MD_PAYMENTS","Die Modul-Zahlungen können Sie problemlos akzeptiert und Zahlungen für Termine von Patienten verwalten.");
INSERT INTO meda_vocabulary VALUES("1624","en","_MD_RATINGS","The Ratings module allows your users to rate doctors. The number of votes and average rating will be shown at the doctor\'s profile.");
INSERT INTO meda_vocabulary VALUES("1625","es","_MD_RATINGS","El módulo de calificación permite a sus usuarios valorar los médicos. El número de votos y la nota media se mostrará en el perfil del médico.");
INSERT INTO meda_vocabulary VALUES("1626","de","_MD_RATINGS","Die Bewertungen Modul können Benutzer Ärzte bewerten. Die Stimmenzahl und durchschnittliche Bewertung wird am Profil des Arztes angezeigt.");
INSERT INTO meda_vocabulary VALUES("1627","en","_MD_REMINDER","The Appointments Reminder module is used to automate notification for patients");
INSERT INTO meda_vocabulary VALUES("1628","es","_MD_REMINDER","El módulo de cita se utiliza para automatizar la notificación de los pacientes");
INSERT INTO meda_vocabulary VALUES("1629","de","_MD_REMINDER","Die Termin-Erinnerung-Modul wird verwendet, um Benachrichtigungen für Patienten zu automatisieren");
INSERT INTO meda_vocabulary VALUES("1630","en","_MEMBERSHIP_EXPIRES","Membership Expires");
INSERT INTO meda_vocabulary VALUES("1631","es","_MEMBERSHIP_EXPIRES","La suscripción vence");
INSERT INTO meda_vocabulary VALUES("1632","de","_MEMBERSHIP_EXPIRES","Mitgliedschaft läuft ab");
INSERT INTO meda_vocabulary VALUES("1633","en","_MEMBERSHIP_INFO","Membership Info");
INSERT INTO meda_vocabulary VALUES("1634","es","_MEMBERSHIP_INFO","Afiliación Información");
INSERT INTO meda_vocabulary VALUES("1635","de","_MEMBERSHIP_INFO","Informationen zur Mitgliedschaft");
INSERT INTO meda_vocabulary VALUES("1636","en","_MEMBERSHIP_PLAN","Membership Plan");
INSERT INTO meda_vocabulary VALUES("1637","es","_MEMBERSHIP_PLAN","Plan de Membresía");
INSERT INTO meda_vocabulary VALUES("1638","de","_MEMBERSHIP_PLAN","Mitgliedschaft Plan");
INSERT INTO meda_vocabulary VALUES("1639","en","_MEMBERSHIP_PLANS","Membership Plans");
INSERT INTO meda_vocabulary VALUES("1640","es","_MEMBERSHIP_PLANS","Planes de Afiliación");
INSERT INTO meda_vocabulary VALUES("1641","de","_MEMBERSHIP_PLANS","Mitgliedschaft Pläne");
INSERT INTO meda_vocabulary VALUES("1642","en","_MENUS","Menus");
INSERT INTO meda_vocabulary VALUES("1643","es","_MENUS","Menús");
INSERT INTO meda_vocabulary VALUES("1644","de","_MENUS","Menüs");
INSERT INTO meda_vocabulary VALUES("1645","en","_MENUS_AND_PAGES","Menus and Pages");
INSERT INTO meda_vocabulary VALUES("1646","es","_MENUS_AND_PAGES","Los menús y páginas");
INSERT INTO meda_vocabulary VALUES("1647","de","_MENUS_AND_PAGES","Menüs und Seiten");
INSERT INTO meda_vocabulary VALUES("1648","en","_MENUS_DISABLED_ALERT","Take in account that some menus may be disabled for the current template.");
INSERT INTO meda_vocabulary VALUES("1649","es","_MENUS_DISABLED_ALERT","Tome en cuenta que algunos menús pueden ser deshabilitados para esta plantilla.");
INSERT INTO meda_vocabulary VALUES("1650","de","_MENUS_DISABLED_ALERT","Nehmen Sie in Rechnung, dass einige Menüs für diese Vorlage kann deaktiviert werden.");
INSERT INTO meda_vocabulary VALUES("1651","en","_MENU_ADD","Add Menu");
INSERT INTO meda_vocabulary VALUES("1652","es","_MENU_ADD","Añadir Menú");
INSERT INTO meda_vocabulary VALUES("1653","de","_MENU_ADD","Menü hinzufügen");
INSERT INTO meda_vocabulary VALUES("1654","en","_MENU_CREATED","Menu has been successfully created");
INSERT INTO meda_vocabulary VALUES("1655","es","_MENU_CREATED","Menu fue creado con éxito");
INSERT INTO meda_vocabulary VALUES("1656","de","_MENU_CREATED","Menu wurde erfolgreich erstellt");
INSERT INTO meda_vocabulary VALUES("1657","en","_MENU_DELETED","Menu has been successfully deleted");
INSERT INTO meda_vocabulary VALUES("1658","es","_MENU_DELETED","Menú ha sido borrado");
INSERT INTO meda_vocabulary VALUES("1659","de","_MENU_DELETED","Menu wurde erfolgreich gelöscht");
INSERT INTO meda_vocabulary VALUES("1660","en","_MENU_DELETE_WARNING","Are you sure you want to delete this menu? Note: this will make all its menu links invisible to your site visitors!");
INSERT INTO meda_vocabulary VALUES("1661","es","_MENU_DELETE_WARNING","¿Estás seguro de que deseas eliminar este menú? Nota: esto hará que todo su menú de enlaces invisibles a sus visitantes!");
INSERT INTO meda_vocabulary VALUES("1662","de","_MENU_DELETE_WARNING","Sie sind sicher, dass Sie dieses Menü löschen? Hinweis: Dieser wird alle seine Menü-Links unsichtbar Besucher Ihrer Website!");
INSERT INTO meda_vocabulary VALUES("1663","en","_MENU_EDIT","Edit Menu");
INSERT INTO meda_vocabulary VALUES("1664","es","_MENU_EDIT","Menú Edición");
INSERT INTO meda_vocabulary VALUES("1665","de","_MENU_EDIT","Menü Bearbeiten");
INSERT INTO meda_vocabulary VALUES("1666","en","_MENU_LINK","Menu Link");
INSERT INTO meda_vocabulary VALUES("1667","es","_MENU_LINK","Enlace del menú");
INSERT INTO meda_vocabulary VALUES("1668","de","_MENU_LINK","Menü-Link");
INSERT INTO meda_vocabulary VALUES("1669","en","_MENU_LINK_TEXT","Menu Link (max. 40 chars)");
INSERT INTO meda_vocabulary VALUES("1670","es","_MENU_LINK_TEXT","Enlace del menú (máx. 40 caracteres)");
INSERT INTO meda_vocabulary VALUES("1671","de","_MENU_LINK_TEXT","Menü-Link (max. 40 Zeichen)");
INSERT INTO meda_vocabulary VALUES("1672","en","_MENU_MANAGEMENT","Menus Management");
INSERT INTO meda_vocabulary VALUES("1673","es","_MENU_MANAGEMENT","Menús de Gestión");
INSERT INTO meda_vocabulary VALUES("1674","de","_MENU_MANAGEMENT","Menüs Management");
INSERT INTO meda_vocabulary VALUES("1675","en","_MENU_MISSED","Missed menu to update! Please, try again.");
INSERT INTO meda_vocabulary VALUES("1676","es","_MENU_MISSED","Menú perdidas para actualizar! Por favor, inténtelo de nuevo.");
INSERT INTO meda_vocabulary VALUES("1677","de","_MENU_MISSED","Verpasste Menü zu aktualisieren! Bitte versuchen Sie es erneut.");
INSERT INTO meda_vocabulary VALUES("1678","en","_MENU_NAME","Menu Name");
INSERT INTO meda_vocabulary VALUES("1679","es","_MENU_NAME","Nombre de menú");
INSERT INTO meda_vocabulary VALUES("1680","de","_MENU_NAME","Menüname");
INSERT INTO meda_vocabulary VALUES("1681","en","_MENU_NAME_EMPTY","Menu name cannot be empty!");
INSERT INTO meda_vocabulary VALUES("1682","es","_MENU_NAME_EMPTY","Nombre del menú no puede estar vacía!");
INSERT INTO meda_vocabulary VALUES("1683","de","_MENU_NAME_EMPTY","Menü-Name darf nicht leer sein!");
INSERT INTO meda_vocabulary VALUES("1684","en","_MENU_NOT_CREATED","Menu has not been created!");
INSERT INTO meda_vocabulary VALUES("1685","es","_MENU_NOT_CREATED","Menú no se ha creado!");
INSERT INTO meda_vocabulary VALUES("1686","de","_MENU_NOT_CREATED","Menü wurde nicht erstellt!");
INSERT INTO meda_vocabulary VALUES("1687","en","_MENU_NOT_DELETED","Menu has not been deleted!");
INSERT INTO meda_vocabulary VALUES("1688","es","_MENU_NOT_DELETED","Menú no se ha eliminado!");
INSERT INTO meda_vocabulary VALUES("1689","de","_MENU_NOT_DELETED","Menü wurde nicht gelöscht!");
INSERT INTO meda_vocabulary VALUES("1690","en","_MENU_NOT_FOUND","No Menus Found");
INSERT INTO meda_vocabulary VALUES("1691","es","_MENU_NOT_FOUND","No se han encontrado los menús");
INSERT INTO meda_vocabulary VALUES("1692","de","_MENU_NOT_FOUND","Keine Menüs gefunden");
INSERT INTO meda_vocabulary VALUES("1693","en","_MENU_NOT_SAVED","Menu has not been saved!");
INSERT INTO meda_vocabulary VALUES("1694","es","_MENU_NOT_SAVED","Menú no se salvó!");
INSERT INTO meda_vocabulary VALUES("1695","de","_MENU_NOT_SAVED","Menü wurde nicht gespart!");
INSERT INTO meda_vocabulary VALUES("1696","en","_MENU_ORDER","Menu Order");
INSERT INTO meda_vocabulary VALUES("1697","es","_MENU_ORDER","Orden del menú");
INSERT INTO meda_vocabulary VALUES("1698","de","_MENU_ORDER","Menü Auftrag");
INSERT INTO meda_vocabulary VALUES("1699","en","_MENU_ORDER_CHANGED","Menu order has been successfully changed");
INSERT INTO meda_vocabulary VALUES("1700","es","_MENU_ORDER_CHANGED","Orden del menú se ha cambiado correctamente");
INSERT INTO meda_vocabulary VALUES("1701","de","_MENU_ORDER_CHANGED","Menü Auftrag wurde erfolgreich geändert");
INSERT INTO meda_vocabulary VALUES("1702","en","_MENU_SAVED","Menu has been successfully saved");
INSERT INTO meda_vocabulary VALUES("1703","es","_MENU_SAVED","Menú se ha guardado correctamente");
INSERT INTO meda_vocabulary VALUES("1704","de","_MENU_SAVED","Menu wurde erfolgreich gespeichert");
INSERT INTO meda_vocabulary VALUES("1705","en","_MENU_TITLE","Menu Title");
INSERT INTO meda_vocabulary VALUES("1706","es","_MENU_TITLE","Menu TitleTítulo del menú");
INSERT INTO meda_vocabulary VALUES("1707","de","_MENU_TITLE","Menü Titel");
INSERT INTO meda_vocabulary VALUES("1708","en","_MENU_WORD","Menu");
INSERT INTO meda_vocabulary VALUES("1709","es","_MENU_WORD","Menú");
INSERT INTO meda_vocabulary VALUES("1710","de","_MENU_WORD","Menü");
INSERT INTO meda_vocabulary VALUES("1711","en","_MESSAGE","Message");
INSERT INTO meda_vocabulary VALUES("1712","es","_MESSAGE","Mensaje");
INSERT INTO meda_vocabulary VALUES("1713","de","_MESSAGE","Nachricht");
INSERT INTO meda_vocabulary VALUES("1714","en","_MESSAGE_EMPTY_ALERT","Message cannot be empty! Please re-enter.");
INSERT INTO meda_vocabulary VALUES("1715","es","_MESSAGE_EMPTY_ALERT","El mensaje no puede estar vacío! Por favor, vuelva a entrar.");
INSERT INTO meda_vocabulary VALUES("1716","de","_MESSAGE_EMPTY_ALERT","Nachricht kann nicht leer sein! Bitte erneut eingeben.");
INSERT INTO meda_vocabulary VALUES("1717","en","_META_TAG","Meta Tag");
INSERT INTO meda_vocabulary VALUES("1718","es","_META_TAG","Meta Tag");
INSERT INTO meda_vocabulary VALUES("1719","de","_META_TAG","Meta-Tag");
INSERT INTO meda_vocabulary VALUES("1720","en","_META_TAGS","META Tags");
INSERT INTO meda_vocabulary VALUES("1721","es","_META_TAGS","Etiquetas META");
INSERT INTO meda_vocabulary VALUES("1722","de","_META_TAGS","META-Tags");
INSERT INTO meda_vocabulary VALUES("1723","en","_METHOD","Method");
INSERT INTO meda_vocabulary VALUES("1724","es","_METHOD","Método");
INSERT INTO meda_vocabulary VALUES("1725","de","_METHOD","Methode");
INSERT INTO meda_vocabulary VALUES("1726","en","_MIDDLE_NAME","Middle Name");
INSERT INTO meda_vocabulary VALUES("1727","es","_MIDDLE_NAME","Segundo nombre");
INSERT INTO meda_vocabulary VALUES("1728","de","_MIDDLE_NAME","Zweiter Vorname");
INSERT INTO meda_vocabulary VALUES("1729","en","_MIN","Min");
INSERT INTO meda_vocabulary VALUES("1730","es","_MIN","Acta");
INSERT INTO meda_vocabulary VALUES("1731","de","_MIN","Min");
INSERT INTO meda_vocabulary VALUES("1732","en","_MINUTES","minutes");
INSERT INTO meda_vocabulary VALUES("1733","es","_MINUTES","acta");
INSERT INTO meda_vocabulary VALUES("1734","de","_MINUTES","Minuten");
INSERT INTO meda_vocabulary VALUES("1735","en","_MOBILE_PHONE","Mobile Phone");
INSERT INTO meda_vocabulary VALUES("1736","es","_MOBILE_PHONE","Teléfono móvil");
INSERT INTO meda_vocabulary VALUES("1737","de","_MOBILE_PHONE","Handy");
INSERT INTO meda_vocabulary VALUES("1738","en","_MOBILE_WORK_PHONE","Mobile Work Phone");
INSERT INTO meda_vocabulary VALUES("1739","es","_MOBILE_WORK_PHONE","Teléfono móvil de trabajo");
INSERT INTO meda_vocabulary VALUES("1740","de","_MOBILE_WORK_PHONE","Mobile Arbeits Telefon");
INSERT INTO meda_vocabulary VALUES("1741","en","_MODULES","Modules");
INSERT INTO meda_vocabulary VALUES("1742","es","_MODULES","Módulos");
INSERT INTO meda_vocabulary VALUES("1743","de","_MODULES","Module");
INSERT INTO meda_vocabulary VALUES("1744","en","_MODULES_MANAGEMENT","Modules Management");
INSERT INTO meda_vocabulary VALUES("1745","es","_MODULES_MANAGEMENT","Módulos de Gestión");
INSERT INTO meda_vocabulary VALUES("1746","de","_MODULES_MANAGEMENT","Module Management");
INSERT INTO meda_vocabulary VALUES("1747","en","_MODULES_NOT_FOUND","No modules found!");
INSERT INTO meda_vocabulary VALUES("1748","es","_MODULES_NOT_FOUND","N módulos encontrado!");
INSERT INTO meda_vocabulary VALUES("1749","de","_MODULES_NOT_FOUND","Keine Module gefunden!");
INSERT INTO meda_vocabulary VALUES("1750","en","_MODULE_INSTALLED","Module has been successfully installed!");
INSERT INTO meda_vocabulary VALUES("1751","es","_MODULE_INSTALLED","Módulo fue instalado con éxito!");
INSERT INTO meda_vocabulary VALUES("1752","de","_MODULE_INSTALLED","Modul wurde erfolgreich installiert!");
INSERT INTO meda_vocabulary VALUES("1753","en","_MODULE_INSTALL_ALERT","Are you sure you want to install this module?");
INSERT INTO meda_vocabulary VALUES("1754","es","_MODULE_INSTALL_ALERT","¿Estás seguro de que desea instalar este módulo?");
INSERT INTO meda_vocabulary VALUES("1755","de","_MODULE_INSTALL_ALERT","Sie sind sicher, dass Sie dieses Modul installieren?");
INSERT INTO meda_vocabulary VALUES("1756","en","_MODULE_UNINSTALLED","Module has been successfully un-installed!");
INSERT INTO meda_vocabulary VALUES("1757","es","_MODULE_UNINSTALLED","Módulo éxito sin instalar!");
INSERT INTO meda_vocabulary VALUES("1758","de","_MODULE_UNINSTALLED","Modul wurde erfolgreich in nicht eingebautem Zustand!");
INSERT INTO meda_vocabulary VALUES("1759","en","_MODULE_UNINSTALL_ALERT","Are you sure you want to un-install this module?");
INSERT INTO meda_vocabulary VALUES("1760","es","_MODULE_UNINSTALL_ALERT","¿Estás seguro de que desea desinstalar este módulo?");
INSERT INTO meda_vocabulary VALUES("1761","de","_MODULE_UNINSTALL_ALERT","Sie sind sicher, dass Sie de-installieren dieses Modul?");
INSERT INTO meda_vocabulary VALUES("1762","en","_MONDAY","Monday");
INSERT INTO meda_vocabulary VALUES("1763","es","_MONDAY","dlunes");
INSERT INTO meda_vocabulary VALUES("1764","de","_MONDAY","Montag");
INSERT INTO meda_vocabulary VALUES("1765","en","_MONTH","month");
INSERT INTO meda_vocabulary VALUES("1766","es","_MONTH","mes");
INSERT INTO meda_vocabulary VALUES("1767","de","_MONTH","monat");
INSERT INTO meda_vocabulary VALUES("1768","en","_MONTHS","months");
INSERT INTO meda_vocabulary VALUES("1769","es","_MONTHS","meses");
INSERT INTO meda_vocabulary VALUES("1770","de","_MONTHS","monate");
INSERT INTO meda_vocabulary VALUES("1771","en","_MORE","more");
INSERT INTO meda_vocabulary VALUES("1772","es","_MORE","más");
INSERT INTO meda_vocabulary VALUES("1773","de","_MORE","mehr");
INSERT INTO meda_vocabulary VALUES("1774","en","_MSN_ADD_WATERMARK","Add Watermark to Images");
INSERT INTO meda_vocabulary VALUES("1775","es","_MSN_ADD_WATERMARK","Añadir marcas de agua a las imágenes");
INSERT INTO meda_vocabulary VALUES("1776","de","_MSN_ADD_WATERMARK","Wasserzeichen hinzufügen, um Bilder");
INSERT INTO meda_vocabulary VALUES("1777","en","_MSN_ADMIN_CHANGE_DOCTOR_PASSWORD","Admin Changes Doctor Password");
INSERT INTO meda_vocabulary VALUES("1778","es","_MSN_ADMIN_CHANGE_DOCTOR_PASSWORD","Administración Cambia doctor Contraseña");
INSERT INTO meda_vocabulary VALUES("1779","de","_MSN_ADMIN_CHANGE_DOCTOR_PASSWORD","Ändert Doktor Admin Passwort");
INSERT INTO meda_vocabulary VALUES("1780","en","_MSN_ADMIN_CHANGE_PATIENT_PASSWORD","Admin Changes Patient Password");
INSERT INTO meda_vocabulary VALUES("1781","es","_MSN_ADMIN_CHANGE_PATIENT_PASSWORD","Administrador cambia la contraseña del Paciente");
INSERT INTO meda_vocabulary VALUES("1782","de","_MSN_ADMIN_CHANGE_PATIENT_PASSWORD","Admin-Passwort ändert Patienten");
INSERT INTO meda_vocabulary VALUES("1783","en","_MSN_ALBUMS_PER_LINE","Albums Per Line");
INSERT INTO meda_vocabulary VALUES("1784","es","_MSN_ALBUMS_PER_LINE","Álbumes por línea");
INSERT INTO meda_vocabulary VALUES("1785","de","_MSN_ALBUMS_PER_LINE","Alben pro Zeile");
INSERT INTO meda_vocabulary VALUES("1786","en","_MSN_ALBUM_ICON_HEIGHT","Album Icon Height");
INSERT INTO meda_vocabulary VALUES("1787","es","_MSN_ALBUM_ICON_HEIGHT","Icono Álbum Altura");
INSERT INTO meda_vocabulary VALUES("1788","de","_MSN_ALBUM_ICON_HEIGHT","Album Icon Höhe");
INSERT INTO meda_vocabulary VALUES("1789","en","_MSN_ALBUM_ICON_WIDTH","Album Icon Width");
INSERT INTO meda_vocabulary VALUES("1790","es","_MSN_ALBUM_ICON_WIDTH","Álbum Icono Ancho");
INSERT INTO meda_vocabulary VALUES("1791","de","_MSN_ALBUM_ICON_WIDTH","Album Ikone Breite");
INSERT INTO meda_vocabulary VALUES("1792","en","_MSN_ALBUM_ITEMS_COUNT","Show Items Count in Album");
INSERT INTO meda_vocabulary VALUES("1793","es","_MSN_ALBUM_ITEMS_COUNT","Mostrar Items Count en álbum");
INSERT INTO meda_vocabulary VALUES("1794","de","_MSN_ALBUM_ITEMS_COUNT","Artikel anzeigen in Album Graf");
INSERT INTO meda_vocabulary VALUES("1795","en","_MSN_ALBUM_ITEMS_NUMERATION","Show Items Numeration in Album");
INSERT INTO meda_vocabulary VALUES("1796","es","_MSN_ALBUM_ITEMS_NUMERATION","Mostrar elementos Numeración en álbum");
INSERT INTO meda_vocabulary VALUES("1797","de","_MSN_ALBUM_ITEMS_NUMERATION","Artikel anzeigen Nummerierung in Album");
INSERT INTO meda_vocabulary VALUES("1798","en","_MSN_ALBUM_KEY","Album Key");
INSERT INTO meda_vocabulary VALUES("1799","es","_MSN_ALBUM_KEY","Clave álbum");
INSERT INTO meda_vocabulary VALUES("1800","de","_MSN_ALBUM_KEY","Album Schlüssel");
INSERT INTO meda_vocabulary VALUES("1801","en","_MSN_ALERT_ADMIN_NEW_REGISTRATION","Alert Admin On New Registration");
INSERT INTO meda_vocabulary VALUES("1802","es","_MSN_ALERT_ADMIN_NEW_REGISTRATION","Administrador Alerta en Nuevo Registro");
INSERT INTO meda_vocabulary VALUES("1803","de","_MSN_ALERT_ADMIN_NEW_REGISTRATION","Alert-Admin über Neu Registrierung");
INSERT INTO meda_vocabulary VALUES("1804","en","_MSN_ALLOW_ADDING_BY_ADMIN","Admin Creates Patients");
INSERT INTO meda_vocabulary VALUES("1805","es","_MSN_ALLOW_ADDING_BY_ADMIN","Administración Crea pacientes");
INSERT INTO meda_vocabulary VALUES("1806","de","_MSN_ALLOW_ADDING_BY_ADMIN","Admin Erstellt Patienten");
INSERT INTO meda_vocabulary VALUES("1807","en","_MSN_ALLOW_DOCTORS_LOGIN","Allow Doctors to Login");
INSERT INTO meda_vocabulary VALUES("1808","es","_MSN_ALLOW_DOCTORS_LOGIN","Permiten a los médicos Login");
INSERT INTO meda_vocabulary VALUES("1809","de","_MSN_ALLOW_DOCTORS_LOGIN","Lassen Ärzte zum Login");
INSERT INTO meda_vocabulary VALUES("1810","en","_MSN_ALLOW_DOCTORS_REGISTRATION","Allow Doctors to Register");
INSERT INTO meda_vocabulary VALUES("1811","es","_MSN_ALLOW_DOCTORS_REGISTRATION","Permiten a los médicos Registro");
INSERT INTO meda_vocabulary VALUES("1812","de","_MSN_ALLOW_DOCTORS_REGISTRATION","Lassen Sie sich registrieren Ärzte");
INSERT INTO meda_vocabulary VALUES("1813","en","_MSN_ALLOW_DOCTORS_RESET_PASSWORDS","Allow Reset Passwords");
INSERT INTO meda_vocabulary VALUES("1814","es","_MSN_ALLOW_DOCTORS_RESET_PASSWORDS","Permitir restablecer las contraseñas");
INSERT INTO meda_vocabulary VALUES("1815","de","_MSN_ALLOW_DOCTORS_RESET_PASSWORDS","Lassen Passwörter zurücksetzen");
INSERT INTO meda_vocabulary VALUES("1816","en","_MSN_ALLOW_DOCTORS_SEARCH_LOCATION","Allow Search By Location");
INSERT INTO meda_vocabulary VALUES("1817","es","_MSN_ALLOW_DOCTORS_SEARCH_LOCATION","Permitir Buscar por Ubicación");
INSERT INTO meda_vocabulary VALUES("1818","de","_MSN_ALLOW_DOCTORS_SEARCH_LOCATION","Nach Ort suchen");
INSERT INTO meda_vocabulary VALUES("1819","en","_MSN_ALLOW_DOCTORS_SEARCH_NAME","Allow Search By Name");
INSERT INTO meda_vocabulary VALUES("1820","es","_MSN_ALLOW_DOCTORS_SEARCH_NAME","Permitir Buscar por Nombre");
INSERT INTO meda_vocabulary VALUES("1821","de","_MSN_ALLOW_DOCTORS_SEARCH_NAME","Lassen Suche nach Name");
INSERT INTO meda_vocabulary VALUES("1822","en","_MSN_ALLOW_MULTIPLE_APPOINTMENTS","Allow Multiple Appointments");
INSERT INTO meda_vocabulary VALUES("1823","es","_MSN_ALLOW_MULTIPLE_APPOINTMENTS","Permitir múltiples citas");
INSERT INTO meda_vocabulary VALUES("1824","de","_MSN_ALLOW_MULTIPLE_APPOINTMENTS","Lassen Sie mehrere Termine");
INSERT INTO meda_vocabulary VALUES("1825","en","_MSN_ALLOW_PATIENTS_LOGIN","Allow Patients to Login");
INSERT INTO meda_vocabulary VALUES("1826","es","_MSN_ALLOW_PATIENTS_LOGIN","Permitir que los pacientes Login");
INSERT INTO meda_vocabulary VALUES("1827","de","_MSN_ALLOW_PATIENTS_LOGIN","Patienten ermöglichen, sich in");
INSERT INTO meda_vocabulary VALUES("1828","en","_MSN_ALLOW_PATIENTS_REGISTRATION","Allow Patients to Register");
INSERT INTO meda_vocabulary VALUES("1829","es","_MSN_ALLOW_PATIENTS_REGISTRATION","Permitir que los pacientes registren");
INSERT INTO meda_vocabulary VALUES("1830","de","_MSN_ALLOW_PATIENTS_REGISTRATION","Lassen Patienten registrieren");
INSERT INTO meda_vocabulary VALUES("1831","en","_MSN_ALLOW_PATIENTS_RESET_PASSWORDS","Allow Reset Passwords");
INSERT INTO meda_vocabulary VALUES("1832","es","_MSN_ALLOW_PATIENTS_RESET_PASSWORDS","Permitir restablecer las contraseñas");
INSERT INTO meda_vocabulary VALUES("1833","de","_MSN_ALLOW_PATIENTS_RESET_PASSWORDS","Lassen Passwörter zurücksetzen");
INSERT INTO meda_vocabulary VALUES("1834","en","_MSN_APPOINTMENTS_IS_ACTIVE","Activate Appointments");
INSERT INTO meda_vocabulary VALUES("1835","es","_MSN_APPOINTMENTS_IS_ACTIVE","Activar Nombramientos");
INSERT INTO meda_vocabulary VALUES("1836","de","_MSN_APPOINTMENTS_IS_ACTIVE","Aktivieren Termine");
INSERT INTO meda_vocabulary VALUES("1837","en","_MSN_APPOINTMENTS_PAGE_SIZE","Doctors Per Page");
INSERT INTO meda_vocabulary VALUES("1838","es","_MSN_APPOINTMENTS_PAGE_SIZE","Los médicos por página");
INSERT INTO meda_vocabulary VALUES("1839","de","_MSN_APPOINTMENTS_PAGE_SIZE","Ärzte pro Seite");
INSERT INTO meda_vocabulary VALUES("1840","en","_MSN_APPROVAL_REQUIRED","Approval Required");
INSERT INTO meda_vocabulary VALUES("1841","es","_MSN_APPROVAL_REQUIRED","Aprobación requerida");
INSERT INTO meda_vocabulary VALUES("1842","de","_MSN_APPROVAL_REQUIRED","Genehmigung erforderlich");
INSERT INTO meda_vocabulary VALUES("1843","en","_MSN_APPT_CANCELLATION_PERIOD","Cancellation Period");
INSERT INTO meda_vocabulary VALUES("1844","es","_MSN_APPT_CANCELLATION_PERIOD","Período de cancelación");
INSERT INTO meda_vocabulary VALUES("1845","de","_MSN_APPT_CANCELLATION_PERIOD","Kündigungsfrist");
INSERT INTO meda_vocabulary VALUES("1846","en","_MSN_AUTHORIZE_LOGIN_ID","&nbsp; Authorize.Net Login ID");
INSERT INTO meda_vocabulary VALUES("1847","es","_MSN_AUTHORIZE_LOGIN_ID","&nbsp; Authorize.Net usuario ID");
INSERT INTO meda_vocabulary VALUES("1848","de","_MSN_AUTHORIZE_LOGIN_ID","&nbsp; Authorize.Net Login-ID");
INSERT INTO meda_vocabulary VALUES("1849","en","_MSN_AUTHORIZE_TRANSACTION_KEY","&nbsp; Authorize.Net Transaction Key");
INSERT INTO meda_vocabulary VALUES("1850","es","_MSN_AUTHORIZE_TRANSACTION_KEY","&nbsp; Authorize.Net Transacción Clave");
INSERT INTO meda_vocabulary VALUES("1851","de","_MSN_AUTHORIZE_TRANSACTION_KEY","&nbsp; Authorize.Net Transaktionsschlüssel");
INSERT INTO meda_vocabulary VALUES("1852","en","_MSN_BANNERS_CAPTION_HTML","HTML in Slideshow Caption");
INSERT INTO meda_vocabulary VALUES("1853","es","_MSN_BANNERS_CAPTION_HTML","HTML en Presentación Leyenda");
INSERT INTO meda_vocabulary VALUES("1854","de","_MSN_BANNERS_CAPTION_HTML","HTML-Diashow in Caption");
INSERT INTO meda_vocabulary VALUES("1855","en","_MSN_BANNERS_IS_ACTIVE","Activate Banners");
INSERT INTO meda_vocabulary VALUES("1856","es","_MSN_BANNERS_IS_ACTIVE","Activar Banners");
INSERT INTO meda_vocabulary VALUES("1857","de","_MSN_BANNERS_IS_ACTIVE","Banner zu aktivieren");
INSERT INTO meda_vocabulary VALUES("1858","en","_MSN_COMMENTS_ALLOW","Allow Comments");
INSERT INTO meda_vocabulary VALUES("1859","es","_MSN_COMMENTS_ALLOW","Permitir comentarios");
INSERT INTO meda_vocabulary VALUES("1860","de","_MSN_COMMENTS_ALLOW","Kommentare zulassen");
INSERT INTO meda_vocabulary VALUES("1861","en","_MSN_COMMENTS_LENGTH","Comment Length");
INSERT INTO meda_vocabulary VALUES("1862","es","_MSN_COMMENTS_LENGTH","Comentario Largo");
INSERT INTO meda_vocabulary VALUES("1863","de","_MSN_COMMENTS_LENGTH","Kommentar Länge");
INSERT INTO meda_vocabulary VALUES("1864","en","_MSN_COMMENTS_PAGE_SIZE","Comments Per Page");
INSERT INTO meda_vocabulary VALUES("1865","es","_MSN_COMMENTS_PAGE_SIZE","Comentarios Por Pagina");
INSERT INTO meda_vocabulary VALUES("1866","de","_MSN_COMMENTS_PAGE_SIZE","Kommentare pro Seite");
INSERT INTO meda_vocabulary VALUES("1867","en","_MSN_CONTACT_US_KEY","Contact Key");
INSERT INTO meda_vocabulary VALUES("1868","es","_MSN_CONTACT_US_KEY","Contacto Llave");
INSERT INTO meda_vocabulary VALUES("1869","de","_MSN_CONTACT_US_KEY","Kontakt Schlüssel");
INSERT INTO meda_vocabulary VALUES("1870","en","_MSN_DEFAULT_PAYMENT_SYSTEM","&nbsp; Default Payment System");
INSERT INTO meda_vocabulary VALUES("1871","es","_MSN_DEFAULT_PAYMENT_SYSTEM","&nbsp; Por defecto del sistema de pago");
INSERT INTO meda_vocabulary VALUES("1872","de","_MSN_DEFAULT_PAYMENT_SYSTEM","&nbsp; Standard-Zahlungssystem");
INSERT INTO meda_vocabulary VALUES("1873","en","_MSN_DELAY_LENGTH","Delay Length");
INSERT INTO meda_vocabulary VALUES("1874","es","_MSN_DELAY_LENGTH","Retardo Largo");
INSERT INTO meda_vocabulary VALUES("1875","de","_MSN_DELAY_LENGTH","Delay-Länge");
INSERT INTO meda_vocabulary VALUES("1876","en","_MSN_DELAY_SLOTS","Delay Slots");
INSERT INTO meda_vocabulary VALUES("1877","es","_MSN_DELAY_SLOTS","Ranuras de retardo");
INSERT INTO meda_vocabulary VALUES("1878","de","_MSN_DELAY_SLOTS","Verzögerungsschlitze");
INSERT INTO meda_vocabulary VALUES("1879","en","_MSN_DELETE_PENDING_TIME","Pending Time");
INSERT INTO meda_vocabulary VALUES("1880","es","_MSN_DELETE_PENDING_TIME","Tiempo de espera");
INSERT INTO meda_vocabulary VALUES("1881","de","_MSN_DELETE_PENDING_TIME","Bis Zeit");
INSERT INTO meda_vocabulary VALUES("1882","en","_MSN_DOCTORS_IMAGE_VERIFICATION","Image Verification");
INSERT INTO meda_vocabulary VALUES("1883","es","_MSN_DOCTORS_IMAGE_VERIFICATION","Verificación de la imagen");
INSERT INTO meda_vocabulary VALUES("1884","de","_MSN_DOCTORS_IMAGE_VERIFICATION","Bild Verifikation");
INSERT INTO meda_vocabulary VALUES("1885","en","_MSN_DOCTORS_KEY","Doctors Key");
INSERT INTO meda_vocabulary VALUES("1886","es","_MSN_DOCTORS_KEY","Los médicos clave");
INSERT INTO meda_vocabulary VALUES("1887","de","_MSN_DOCTORS_KEY","Ärzte Key");
INSERT INTO meda_vocabulary VALUES("1888","en","_MSN_DOCTOR_CONFIRM_REMINDER","Doctor Confirm Reminder");
INSERT INTO meda_vocabulary VALUES("1889","es","_MSN_DOCTOR_CONFIRM_REMINDER","Médico Confirmar Recordatorio");
INSERT INTO meda_vocabulary VALUES("1890","de","_MSN_DOCTOR_CONFIRM_REMINDER","Erinnerung Arzt bestätigen");
INSERT INTO meda_vocabulary VALUES("1891","en","_MSN_EMAIL","Contact Email");
INSERT INTO meda_vocabulary VALUES("1892","es","_MSN_EMAIL","Correo electrónico de contacto");
INSERT INTO meda_vocabulary VALUES("1893","de","_MSN_EMAIL","Kontakt E-Mail");
INSERT INTO meda_vocabulary VALUES("1894","en","_MSN_FAQ_IS_ACTIVE","Activate FAQ");
INSERT INTO meda_vocabulary VALUES("1895","es","_MSN_FAQ_IS_ACTIVE","Activar FAQ");
INSERT INTO meda_vocabulary VALUES("1896","de","_MSN_FAQ_IS_ACTIVE","Aktivieren FAQ");
INSERT INTO meda_vocabulary VALUES("1897","en","_MSN_GALLERY_KEY","Gallery Key");
INSERT INTO meda_vocabulary VALUES("1898","es","_MSN_GALLERY_KEY","Galería clave");
INSERT INTO meda_vocabulary VALUES("1899","de","_MSN_GALLERY_KEY","Galerie Key");
INSERT INTO meda_vocabulary VALUES("1900","en","_MSN_GALLERY_WRAPPER","HTML Wrapping Tag");
INSERT INTO meda_vocabulary VALUES("1901","es","_MSN_GALLERY_WRAPPER","Envolver HTML Tag");
INSERT INTO meda_vocabulary VALUES("1902","de","_MSN_GALLERY_WRAPPER","HTML-Wrapping-Tag");
INSERT INTO meda_vocabulary VALUES("1903","en","_MSN_GOOGLE_MAPS_API_KEY","Google Maps API Key");
INSERT INTO meda_vocabulary VALUES("1904","es","_MSN_GOOGLE_MAPS_API_KEY","Google Maps API Key");
INSERT INTO meda_vocabulary VALUES("1905","de","_MSN_GOOGLE_MAPS_API_KEY","Google Maps API Key");
INSERT INTO meda_vocabulary VALUES("1906","en","_MSN_GOOGLE_MAP_HEIGHT","Map Image Height");
INSERT INTO meda_vocabulary VALUES("1907","es","_MSN_GOOGLE_MAP_HEIGHT","Mapa alto de imagen");
INSERT INTO meda_vocabulary VALUES("1908","de","_MSN_GOOGLE_MAP_HEIGHT","Karte Bildhöhe");
INSERT INTO meda_vocabulary VALUES("1909","en","_MSN_GOOGLE_MAP_WIDTH","Map Image Width");
INSERT INTO meda_vocabulary VALUES("1910","es","_MSN_GOOGLE_MAP_WIDTH","Mapa ancho de imagen");
INSERT INTO meda_vocabulary VALUES("1911","de","_MSN_GOOGLE_MAP_WIDTH","Karte Bildbreite");
INSERT INTO meda_vocabulary VALUES("1912","en","_MSN_IMAGE_GALLERY_TYPE","Image Gallery Type");
INSERT INTO meda_vocabulary VALUES("1913","es","_MSN_IMAGE_GALLERY_TYPE","Galería de imágenes Tipo");
INSERT INTO meda_vocabulary VALUES("1914","de","_MSN_IMAGE_GALLERY_TYPE","Bildergalerie Art");
INSERT INTO meda_vocabulary VALUES("1915","en","_MSN_IMAGE_VERIFICATION_ALLOW","Image Verification");
INSERT INTO meda_vocabulary VALUES("1916","es","_MSN_IMAGE_VERIFICATION_ALLOW","Verificación de la imagen");
INSERT INTO meda_vocabulary VALUES("1917","de","_MSN_IMAGE_VERIFICATION_ALLOW","Bild Verifikation");
INSERT INTO meda_vocabulary VALUES("1918","en","_MSN_IS_SEND_DELAY","Sending Delay");
INSERT INTO meda_vocabulary VALUES("1919","es","_MSN_IS_SEND_DELAY","El envío de Delay");
INSERT INTO meda_vocabulary VALUES("1920","de","_MSN_IS_SEND_DELAY","Senden Verzögerung");
INSERT INTO meda_vocabulary VALUES("1921","en","_MSN_MAXIMUM_ALLOWED_APPOINTMENTS","Maximum Allowed Appointments");
INSERT INTO meda_vocabulary VALUES("1922","es","_MSN_MAXIMUM_ALLOWED_APPOINTMENTS","Máximo Citas mascotas");
INSERT INTO meda_vocabulary VALUES("1923","de","_MSN_MAXIMUM_ALLOWED_APPOINTMENTS","Maximal erlaubt Termine");
INSERT INTO meda_vocabulary VALUES("1924","en","_MSN_MAXIMUM_ALLOWED_ORDERS","Maximum Allowed Orders");
INSERT INTO meda_vocabulary VALUES("1925","es","_MSN_MAXIMUM_ALLOWED_ORDERS","Máximo Órdenes animales");
INSERT INTO meda_vocabulary VALUES("1926","de","_MSN_MAXIMUM_ALLOWED_ORDERS","Maximal erlaubt Bestellungen");
INSERT INTO meda_vocabulary VALUES("1927","en","_MSN_MULTIPLE_ITEMS_PER_DAY","Multiple Items per Day");
INSERT INTO meda_vocabulary VALUES("1928","es","_MSN_MULTIPLE_ITEMS_PER_DAY","Varios elementos por Día");
INSERT INTO meda_vocabulary VALUES("1929","de","_MSN_MULTIPLE_ITEMS_PER_DAY","Mehrere Artikel pro Tag");
INSERT INTO meda_vocabulary VALUES("1930","en","_MSN_NEWS_COUNT","News Count");
INSERT INTO meda_vocabulary VALUES("1931","es","_MSN_NEWS_COUNT","Conde Noticias");
INSERT INTO meda_vocabulary VALUES("1932","de","_MSN_NEWS_COUNT","Nachrichten Graf");
INSERT INTO meda_vocabulary VALUES("1933","en","_MSN_NEWS_HEADER_LENGTH","News Header Length");
INSERT INTO meda_vocabulary VALUES("1934","es","_MSN_NEWS_HEADER_LENGTH","Longitud de la cabecera Noticias");
INSERT INTO meda_vocabulary VALUES("1935","de","_MSN_NEWS_HEADER_LENGTH","Nachrichten-Header-Länge");
INSERT INTO meda_vocabulary VALUES("1936","en","_MSN_NEWS_RSS","News RSS");
INSERT INTO meda_vocabulary VALUES("1937","es","_MSN_NEWS_RSS","RSS de las Noticias");
INSERT INTO meda_vocabulary VALUES("1938","de","_MSN_NEWS_RSS","RSS-News");
INSERT INTO meda_vocabulary VALUES("1939","en","_MSN_ONLINE_COLLECT_CREDIT_CARD","&#8226; Credit Cards for \'On-line Orders\'");
INSERT INTO meda_vocabulary VALUES("1940","es","_MSN_ONLINE_COLLECT_CREDIT_CARD","&#8226; Tarjetas de crédito para \'Los pedidos en línea\'");
INSERT INTO meda_vocabulary VALUES("1941","de","_MSN_ONLINE_COLLECT_CREDIT_CARD","&#8226; Kreditkarten für \'Online-Bestellungen\'");
INSERT INTO meda_vocabulary VALUES("1942","en","_MSN_PATIENTS_IMAGE_VERIFICATION","Image Verification");
INSERT INTO meda_vocabulary VALUES("1943","es","_MSN_PATIENTS_IMAGE_VERIFICATION","Verificación de la imagen");
INSERT INTO meda_vocabulary VALUES("1944","de","_MSN_PATIENTS_IMAGE_VERIFICATION","Bild Verifikation");
INSERT INTO meda_vocabulary VALUES("1945","en","_MSN_PATIENT_ARRIVAL_REMINDER","Patient Arrival Reminder");
INSERT INTO meda_vocabulary VALUES("1946","es","_MSN_PATIENT_ARRIVAL_REMINDER","Recordatorio de la llegada del paciente");
INSERT INTO meda_vocabulary VALUES("1947","de","_MSN_PATIENT_ARRIVAL_REMINDER","Patient Ankunft Erinnerung");
INSERT INTO meda_vocabulary VALUES("1948","en","_MSN_PATIENT_CONFIRM_REMINDER","Patient Confirm Reminder");
INSERT INTO meda_vocabulary VALUES("1949","es","_MSN_PATIENT_CONFIRM_REMINDER","Confirmar Recordatorio Paciente");
INSERT INTO meda_vocabulary VALUES("1950","de","_MSN_PATIENT_CONFIRM_REMINDER","Patienten bestätigen Erinnerung");
INSERT INTO meda_vocabulary VALUES("1951","en","_MSN_PAYMENTS_ACTIVE","Activate Payments");
INSERT INTO meda_vocabulary VALUES("1952","es","_MSN_PAYMENTS_ACTIVE","Activar Pagos");
INSERT INTO meda_vocabulary VALUES("1953","de","_MSN_PAYMENTS_ACTIVE","Aktivieren Zahlungen");
INSERT INTO meda_vocabulary VALUES("1954","en","_MSN_PAYMENTS_MODE","Payment Mode");
INSERT INTO meda_vocabulary VALUES("1955","es","_MSN_PAYMENTS_MODE","Modo de Pago");
INSERT INTO meda_vocabulary VALUES("1956","de","_MSN_PAYMENTS_MODE","Zahlungsmodus");
INSERT INTO meda_vocabulary VALUES("1957","en","_MSN_PAYMENT_METHOD_2CO","&#8226; 2CO Payment Method");
INSERT INTO meda_vocabulary VALUES("1958","es","_MSN_PAYMENT_METHOD_2CO","&#8226; 2CO Método de pago");
INSERT INTO meda_vocabulary VALUES("1959","de","_MSN_PAYMENT_METHOD_2CO","&#8226; 2CO Zahlungsmethode");
INSERT INTO meda_vocabulary VALUES("1960","en","_MSN_PAYMENT_METHOD_AUTHORIZE","&#8226; Authorize.Net Payment Method");
INSERT INTO meda_vocabulary VALUES("1961","es","_MSN_PAYMENT_METHOD_AUTHORIZE","&#8226; Authorize.Net Método de pago");
INSERT INTO meda_vocabulary VALUES("1962","de","_MSN_PAYMENT_METHOD_AUTHORIZE","&#8226; Authorize.Net Zahlungsmethode");
INSERT INTO meda_vocabulary VALUES("1963","en","_MSN_PAYMENT_METHOD_ONLINE","&#8226; \'On-line Order\' Payment Method");
INSERT INTO meda_vocabulary VALUES("1964","es","_MSN_PAYMENT_METHOD_ONLINE","&#8226; \'Orden en línea\' Método de pago");
INSERT INTO meda_vocabulary VALUES("1965","de","_MSN_PAYMENT_METHOD_ONLINE","&#8226; \'Online-Bestellung\' Payment Method");
INSERT INTO meda_vocabulary VALUES("1966","en","_MSN_PAYMENT_METHOD_PAYPAL","&#8226; PayPal Payment Method");
INSERT INTO meda_vocabulary VALUES("1967","es","_MSN_PAYMENT_METHOD_PAYPAL","&#8226; Método de pago PayPal");
INSERT INTO meda_vocabulary VALUES("1968","de","_MSN_PAYMENT_METHOD_PAYPAL","&#8226; PayPal Zahlungsmethode");
INSERT INTO meda_vocabulary VALUES("1969","en","_MSN_PAYPAL_EMAIL","&nbsp; PayPal Email");
INSERT INTO meda_vocabulary VALUES("1970","es","_MSN_PAYPAL_EMAIL","&nbsp; PayPal Email");
INSERT INTO meda_vocabulary VALUES("1971","de","_MSN_PAYPAL_EMAIL","&nbsp; PayPal E-Mail");
INSERT INTO meda_vocabulary VALUES("1972","en","_MSN_PRE_MODERATION_ALLOW","Comments Pre-Moderation");
INSERT INTO meda_vocabulary VALUES("1973","es","_MSN_PRE_MODERATION_ALLOW","Comentarios Moderación Pre");
INSERT INTO meda_vocabulary VALUES("1974","de","_MSN_PRE_MODERATION_ALLOW","Kommentare Pre-Moderation");
INSERT INTO meda_vocabulary VALUES("1975","en","_MSN_RATINGS_USER_TYPE","User Type");
INSERT INTO meda_vocabulary VALUES("1976","es","_MSN_RATINGS_USER_TYPE","Tipo de usuario");
INSERT INTO meda_vocabulary VALUES("1977","de","_MSN_RATINGS_USER_TYPE","Benutzertyp");
INSERT INTO meda_vocabulary VALUES("1978","en","_MSN_REG_CONFIRMATION","Confirmation Type");
INSERT INTO meda_vocabulary VALUES("1979","es","_MSN_REG_CONFIRMATION","Tipo de confirmación");
INSERT INTO meda_vocabulary VALUES("1980","de","_MSN_REG_CONFIRMATION","Bestätigung Typ");
INSERT INTO meda_vocabulary VALUES("1981","en","_MSN_REMEMBER_ME","Remember Me");
INSERT INTO meda_vocabulary VALUES("1982","es","_MSN_REMEMBER_ME","Recordarme");
INSERT INTO meda_vocabulary VALUES("1983","de","_MSN_REMEMBER_ME","Angemeldet bleiben");
INSERT INTO meda_vocabulary VALUES("1984","en","_MSN_REMINDER_TYPE","Reminder Type");
INSERT INTO meda_vocabulary VALUES("1985","es","_MSN_REMINDER_TYPE","Tipo Recordatorio");
INSERT INTO meda_vocabulary VALUES("1986","de","_MSN_REMINDER_TYPE","Reminder Typ");
INSERT INTO meda_vocabulary VALUES("1987","en","_MSN_ROTATE_DELAY","Rotation Delay");
INSERT INTO meda_vocabulary VALUES("1988","es","_MSN_ROTATE_DELAY","Rotación de retardo");
INSERT INTO meda_vocabulary VALUES("1989","de","_MSN_ROTATE_DELAY","Rotation Verzögerung");
INSERT INTO meda_vocabulary VALUES("1990","en","_MSN_ROTATION_TYPE","Rotation Type");
INSERT INTO meda_vocabulary VALUES("1991","es","_MSN_ROTATION_TYPE","Tipo de rotación");
INSERT INTO meda_vocabulary VALUES("1992","de","_MSN_ROTATION_TYPE","Rotationstyp");
INSERT INTO meda_vocabulary VALUES("1993","en","_MSN_SCHEDULES_ACCESS_LEVEL","Schedules Access Level");
INSERT INTO meda_vocabulary VALUES("1994","es","_MSN_SCHEDULES_ACCESS_LEVEL","Nivel Horarios de Acceso");
INSERT INTO meda_vocabulary VALUES("1995","de","_MSN_SCHEDULES_ACCESS_LEVEL","Termine Zugriffsebene");
INSERT INTO meda_vocabulary VALUES("1996","en","_MSN_SEND_APPT_NOTIF_TO_ADMIN","Send Notification To Admin");
INSERT INTO meda_vocabulary VALUES("1997","es","_MSN_SEND_APPT_NOTIF_TO_ADMIN","Enviar notificación al administrador");
INSERT INTO meda_vocabulary VALUES("1998","de","_MSN_SEND_APPT_NOTIF_TO_ADMIN","Benachrichtigung an Admin");
INSERT INTO meda_vocabulary VALUES("1999","en","_MSN_SEND_APPT_NOTIF_TO_DOCTOR","Send Notification To Doctor");
INSERT INTO meda_vocabulary VALUES("2000","es","_MSN_SEND_APPT_NOTIF_TO_DOCTOR","Enviar notificación al doctor");
INSERT INTO meda_vocabulary VALUES("2001","de","_MSN_SEND_APPT_NOTIF_TO_DOCTOR","Mitteilung senden zum Doktor");
INSERT INTO meda_vocabulary VALUES("2002","en","_MSN_SEND_ORDER_COPY_TO_ADMIN","Send Order Copy To Admin");
INSERT INTO meda_vocabulary VALUES("2003","es","_MSN_SEND_ORDER_COPY_TO_ADMIN","Enviar copia a fin de administrador");
INSERT INTO meda_vocabulary VALUES("2004","de","_MSN_SEND_ORDER_COPY_TO_ADMIN","Bestellung abschicken Kopie an Admin");
INSERT INTO meda_vocabulary VALUES("2005","en","_MSN_SHOW_NEWSLETTER_SUBSCRIBE_BLOCK","Newsletter Subscription");
INSERT INTO meda_vocabulary VALUES("2006","es","_MSN_SHOW_NEWSLETTER_SUBSCRIBE_BLOCK","Suscripción boletín");
INSERT INTO meda_vocabulary VALUES("2007","de","_MSN_SHOW_NEWSLETTER_SUBSCRIBE_BLOCK","Newsletter Abonnement");
INSERT INTO meda_vocabulary VALUES("2008","en","_MSN_SHOW_NEWS_BLOCK","News Block");
INSERT INTO meda_vocabulary VALUES("2009","es","_MSN_SHOW_NEWS_BLOCK","Bloque de noticias");
INSERT INTO meda_vocabulary VALUES("2010","de","_MSN_SHOW_NEWS_BLOCK","Nachrichten blockieren");
INSERT INTO meda_vocabulary VALUES("2011","en","_MSN_TWO_CHECKOUT_VENDOR","&nbsp; 2CO Vendor ID");
INSERT INTO meda_vocabulary VALUES("2012","es","_MSN_TWO_CHECKOUT_VENDOR","&nbsp; 2CO identificación del vendedor");
INSERT INTO meda_vocabulary VALUES("2013","de","_MSN_TWO_CHECKOUT_VENDOR","&nbsp; 2CO Hersteller-ID");
INSERT INTO meda_vocabulary VALUES("2014","en","_MSN_USER_TYPE","User Type");
INSERT INTO meda_vocabulary VALUES("2015","es","_MSN_USER_TYPE","Tipo de usuario");
INSERT INTO meda_vocabulary VALUES("2016","de","_MSN_USER_TYPE","Benutzertyp");
INSERT INTO meda_vocabulary VALUES("2017","en","_MSN_VAT_VALUE","VAT Value");
INSERT INTO meda_vocabulary VALUES("2018","es","_MSN_VAT_VALUE","IVA Valor");
INSERT INTO meda_vocabulary VALUES("2019","de","_MSN_VAT_VALUE","MwSt. Preis");
INSERT INTO meda_vocabulary VALUES("2020","en","_MSN_VIDEO_GALLERY_TYPE","Video Gallery Type");
INSERT INTO meda_vocabulary VALUES("2021","es","_MSN_VIDEO_GALLERY_TYPE","La galería de video Tipo");
INSERT INTO meda_vocabulary VALUES("2022","de","_MSN_VIDEO_GALLERY_TYPE","Videogalerie Art");
INSERT INTO meda_vocabulary VALUES("2023","en","_MSN_WATERMARK_TEXT","Watermark Text");
INSERT INTO meda_vocabulary VALUES("2024","es","_MSN_WATERMARK_TEXT","Estampilla de texto");
INSERT INTO meda_vocabulary VALUES("2025","de","_MSN_WATERMARK_TEXT","Wasserzeichentext");
INSERT INTO meda_vocabulary VALUES("2026","en","_MS_ADD_WATERMARK","Specifies whether to add watermark to doctors images or not");
INSERT INTO meda_vocabulary VALUES("2027","es","_MS_ADD_WATERMARK","Especifica si se debe añadir agua a los médicos imágenes o no");
INSERT INTO meda_vocabulary VALUES("2028","de","_MS_ADD_WATERMARK","Gibt an, ob Wasserzeichen zu Bildern hinzufügen oder Ärzte nicht");
INSERT INTO meda_vocabulary VALUES("2029","en","_MS_ADMIN_CHANGE_DOCTOR_PASSWORD","Specifies whether to allow changing doctor password by Admin");
INSERT INTO meda_vocabulary VALUES("2030","es","_MS_ADMIN_CHANGE_DOCTOR_PASSWORD","Especifica si se permite cambiar la contraseña médico por Admin");
INSERT INTO meda_vocabulary VALUES("2031","de","_MS_ADMIN_CHANGE_DOCTOR_PASSWORD","Gibt an, ob wechselnden Arzt Passwort Admin");
INSERT INTO meda_vocabulary VALUES("2032","en","_MS_ADMIN_CHANGE_PATIENT_PASSWORD","Specifies whether to allow changing patient password by Admin");
INSERT INTO meda_vocabulary VALUES("2033","es","_MS_ADMIN_CHANGE_PATIENT_PASSWORD","Especifica si se permite cambiar la contraseña de los pacientes por Admin");
INSERT INTO meda_vocabulary VALUES("2034","de","_MS_ADMIN_CHANGE_PATIENT_PASSWORD","Gibt an, ob das Kennwort ändern Patienten durch Admin");
INSERT INTO meda_vocabulary VALUES("2035","en","_MS_ALBUMS_PER_LINE","Number of album icons per line");
INSERT INTO meda_vocabulary VALUES("2036","es","_MS_ALBUMS_PER_LINE","Número de iconos de disco por línea");
INSERT INTO meda_vocabulary VALUES("2037","de","_MS_ALBUMS_PER_LINE","Anzahl der Album Symbole pro Zeile");
INSERT INTO meda_vocabulary VALUES("2038","en","_MS_ALBUM_ICON_HEIGHT","Album icon height");
INSERT INTO meda_vocabulary VALUES("2039","es","_MS_ALBUM_ICON_HEIGHT","Album altura icono");
INSERT INTO meda_vocabulary VALUES("2040","de","_MS_ALBUM_ICON_HEIGHT","Album-Symbol Höhe");
INSERT INTO meda_vocabulary VALUES("2041","en","_MS_ALBUM_ICON_WIDTH","Album icon width");
INSERT INTO meda_vocabulary VALUES("2042","es","_MS_ALBUM_ICON_WIDTH","Album ancho icono");
INSERT INTO meda_vocabulary VALUES("2043","de","_MS_ALBUM_ICON_WIDTH","Album-Symbol Breite");
INSERT INTO meda_vocabulary VALUES("2044","en","_MS_ALBUM_ITEMS_COUNT","Specifies whether to show count of images/video under album name");
INSERT INTO meda_vocabulary VALUES("2045","es","_MS_ALBUM_ITEMS_COUNT","Especifica si se muestra la cuenta de las imágenes/video bajo el nombre del álbum");
INSERT INTO meda_vocabulary VALUES("2046","de","_MS_ALBUM_ITEMS_COUNT","Gibt an, ob Anzahl der Bilder/Videos unter Albumname zeigen");
INSERT INTO meda_vocabulary VALUES("2047","en","_MS_ALBUM_ITEMS_NUMERATION","Specifies whether to show items numeration in albums");
INSERT INTO meda_vocabulary VALUES("2048","es","_MS_ALBUM_ITEMS_NUMERATION","Especifica si se deben mostrar los elementos de numeración en álbumes");
INSERT INTO meda_vocabulary VALUES("2049","de","_MS_ALBUM_ITEMS_NUMERATION","Gibt an, ob Elemente Nummerierung in Alben zeigen");
INSERT INTO meda_vocabulary VALUES("2050","en","_MS_ALBUM_KEY","The shortcode that will be replaced with a certain album images (copy and paste it into the page)");
INSERT INTO meda_vocabulary VALUES("2051","es","_MS_ALBUM_KEY","La palabra clave que será reemplazado con un álbum de imágenes de algunos (copiar y pegarlo en la página)");
INSERT INTO meda_vocabulary VALUES("2052","de","_MS_ALBUM_KEY","Das Schlüsselwort, das mit einem bestimmten Album Bilder ersetzt werden (Kopieren und fügen Sie ihn auf der Seite)");
INSERT INTO meda_vocabulary VALUES("2053","en","_MS_ALERT_ADMIN_NEW_REGISTRATION","Specifies whether to alert admin on new doctor registration");
INSERT INTO meda_vocabulary VALUES("2054","es","_MS_ALERT_ADMIN_NEW_REGISTRATION","Especifica si se debe alertar admin el registro médico nuevo");
INSERT INTO meda_vocabulary VALUES("2055","de","_MS_ALERT_ADMIN_NEW_REGISTRATION","Gibt an, ob admin am neuen Arzt Registrierung aufmerksam");
INSERT INTO meda_vocabulary VALUES("2056","en","_MS_ALLOW_ADDING_BY_ADMIN","Specifies whether to allow adding new patients by Admin");
INSERT INTO meda_vocabulary VALUES("2057","es","_MS_ALLOW_ADDING_BY_ADMIN","Especifica si se permite la adición de nuevos pacientes por Admin");
INSERT INTO meda_vocabulary VALUES("2058","de","_MS_ALLOW_ADDING_BY_ADMIN","Gibt an, ob das Hinzufügen neuer Patienten durch Admin");
INSERT INTO meda_vocabulary VALUES("2059","en","_MS_ALLOW_DOCTORS_LOGIN","Specifies whether to allow existing doctors to login");
INSERT INTO meda_vocabulary VALUES("2060","es","_MS_ALLOW_DOCTORS_LOGIN","Especifica si se debe permitir a los médicos ya existentes para iniciar sesión");
INSERT INTO meda_vocabulary VALUES("2061","de","_MS_ALLOW_DOCTORS_LOGIN","Gibt an, ob vorhandene Ärzten anmelden");
INSERT INTO meda_vocabulary VALUES("2062","en","_MS_ALLOW_DOCTORS_REGISTRATION","Specifies whether to allow doctors to register");
INSERT INTO meda_vocabulary VALUES("2063","es","_MS_ALLOW_DOCTORS_REGISTRATION","Especifica si se debe permitir a los médicos para registrarse");
INSERT INTO meda_vocabulary VALUES("2064","de","_MS_ALLOW_DOCTORS_REGISTRATION","Gibt an, ob Ärzte sich zu registrieren");
INSERT INTO meda_vocabulary VALUES("2065","en","_MS_ALLOW_DOCTORS_RESET_PASSWORDS","Specifies whether to allow doctors to restore their passwords");
INSERT INTO meda_vocabulary VALUES("2066","es","_MS_ALLOW_DOCTORS_RESET_PASSWORDS","Especifica si se debe permitir a los médicos para restablecer sus contraseñas");
INSERT INTO meda_vocabulary VALUES("2067","de","_MS_ALLOW_DOCTORS_RESET_PASSWORDS","Gibt an, ob Ärzte ihre Passwörter wiederherzustellen");
INSERT INTO meda_vocabulary VALUES("2068","en","_MS_ALLOW_DOCTORS_SEARCH_LOCATION","Specifies whether to allow patients to search by doctors by location");
INSERT INTO meda_vocabulary VALUES("2069","es","_MS_ALLOW_DOCTORS_SEARCH_LOCATION","Especifica si se permite a los pacientes a buscar por los médicos por ubicación");
INSERT INTO meda_vocabulary VALUES("2070","de","_MS_ALLOW_DOCTORS_SEARCH_LOCATION","Gibt an, ob die Patienten von Ärzten durch Position suchen");
INSERT INTO meda_vocabulary VALUES("2071","en","_MS_ALLOW_DOCTORS_SEARCH_NAME","Specifies whether to allow patients to search by doctors by name");
INSERT INTO meda_vocabulary VALUES("2072","es","_MS_ALLOW_DOCTORS_SEARCH_NAME","Especifica si se permite a los pacientes a buscar por los médicos por su nombre");
INSERT INTO meda_vocabulary VALUES("2073","de","_MS_ALLOW_DOCTORS_SEARCH_NAME","Gibt an, ob die Patienten von den Ärzten nach Namen suchen");
INSERT INTO meda_vocabulary VALUES("2074","en","_MS_ALLOW_MULTIPLE_APPOINTMENTS","Specifies whether to allow multiple appointments to the doctor in the same day");
INSERT INTO meda_vocabulary VALUES("2075","es","_MS_ALLOW_MULTIPLE_APPOINTMENTS","Especifica si se permite a varias citas al médico en el mismo día");
INSERT INTO meda_vocabulary VALUES("2076","de","_MS_ALLOW_MULTIPLE_APPOINTMENTS","Gibt an, ob mehrere Termine mit dem Arzt am gleichen Tag ermöglichen");
INSERT INTO meda_vocabulary VALUES("2077","en","_MS_ALLOW_PATIENTS_LOGIN","Specifies whether to allow existing patients to login");
INSERT INTO meda_vocabulary VALUES("2078","es","_MS_ALLOW_PATIENTS_LOGIN","Especifica si se debe permitir que los pacientes existentes para ingresar");
INSERT INTO meda_vocabulary VALUES("2079","de","_MS_ALLOW_PATIENTS_LOGIN","Gibt an, ob die bestehenden Patienten anmelden");
INSERT INTO meda_vocabulary VALUES("2080","en","_MS_ALLOW_PATIENTS_REGISTRATION","Specifies whether to allow patients to register");
INSERT INTO meda_vocabulary VALUES("2081","es","_MS_ALLOW_PATIENTS_REGISTRATION","Especifica si se debe permitir a los pacientes para registrar");
INSERT INTO meda_vocabulary VALUES("2082","de","_MS_ALLOW_PATIENTS_REGISTRATION","Gibt an, ob Patienten sich zu registrieren");
INSERT INTO meda_vocabulary VALUES("2083","en","_MS_ALLOW_PATIENTS_RESET_PASSWORDS","Specifies whether to allow patients to restore their passwords");
INSERT INTO meda_vocabulary VALUES("2084","es","_MS_ALLOW_PATIENTS_RESET_PASSWORDS","Especifica si se permite a los pacientes a restablecer sus contraseñas");
INSERT INTO meda_vocabulary VALUES("2085","de","_MS_ALLOW_PATIENTS_RESET_PASSWORDS","Gibt an, ob Patienten, ihre Passwörter wiederherstellen");
INSERT INTO meda_vocabulary VALUES("2086","en","_MS_APPOINTMENTS_IS_ACTIVE","Defines whether Appointments module is active or not");
INSERT INTO meda_vocabulary VALUES("2087","es","_MS_APPOINTMENTS_IS_ACTIVE","Define si el módulo de Nombramientos está activa o no");
INSERT INTO meda_vocabulary VALUES("2088","de","_MS_APPOINTMENTS_IS_ACTIVE","Legt fest, ob Termine Modul aktiv ist oder nicht");
INSERT INTO meda_vocabulary VALUES("2089","en","_MS_APPOINTMENTS_PAGE_SIZE","Defines how many doctor profiles will be shown on the search result page");
INSERT INTO meda_vocabulary VALUES("2090","es","_MS_APPOINTMENTS_PAGE_SIZE","Define cuántos perfiles médico se mostrará en la página de resultados de búsqueda");
INSERT INTO meda_vocabulary VALUES("2091","de","_MS_APPOINTMENTS_PAGE_SIZE","Legt fest, wie viele Arzt-Profile werden auf der Suchergebnisseite angezeigt werden");
INSERT INTO meda_vocabulary VALUES("2092","en","_MS_APPROVAL_REQUIRED","Defines whether an approval (which type of) is required for appointments");
INSERT INTO meda_vocabulary VALUES("2093","es","_MS_APPROVAL_REQUIRED","Define si la aprobación (el tipo de) es necesaria para los nombramientos");
INSERT INTO meda_vocabulary VALUES("2094","de","_MS_APPROVAL_REQUIRED","Legt fest, ob die Genehmigung (welche Art von) für Termine ist erforderlich");
INSERT INTO meda_vocabulary VALUES("2095","en","_MS_APPT_CANCELLATION_PERIOD","Maximum period of time (in hours) after which all unconfirmed appointments will be cancelled");
INSERT INTO meda_vocabulary VALUES("2096","es","_MS_APPT_CANCELLATION_PERIOD","Período máximo de tiempo (en horas) tras el cual todas las citas confirmadas serán canceladas");
INSERT INTO meda_vocabulary VALUES("2097","de","_MS_APPT_CANCELLATION_PERIOD","Maximale Zeit (in Stunden), nach dem alle unbestätigten Termine abgesagt werden");
INSERT INTO meda_vocabulary VALUES("2098","en","_MS_AUTHORIZE_LOGIN_ID","Specifies Authorize.Net API Login ID");
INSERT INTO meda_vocabulary VALUES("2099","es","_MS_AUTHORIZE_LOGIN_ID","Especifica Authorize.Net API Login ID");
INSERT INTO meda_vocabulary VALUES("2100","de","_MS_AUTHORIZE_LOGIN_ID","Gibt Authorize.Net API Login ID");
INSERT INTO meda_vocabulary VALUES("2101","en","_MS_AUTHORIZE_TRANSACTION_KEY","Specifies Authorize.Net Transaction Key");
INSERT INTO meda_vocabulary VALUES("2102","es","_MS_AUTHORIZE_TRANSACTION_KEY","Especificador Authorize.Net Transaction Key");
INSERT INTO meda_vocabulary VALUES("2103","de","_MS_AUTHORIZE_TRANSACTION_KEY","Authorize.Net Transaction Key gibt");
INSERT INTO meda_vocabulary VALUES("2104","en","_MS_BANNERS_CAPTION_HTML","Specifies whether to allow using of HTML in slideshow captions or not");
INSERT INTO meda_vocabulary VALUES("2105","es","_MS_BANNERS_CAPTION_HTML","Especifica si se debe permitir el uso de HTML en los textos de presentación de diapositivas o no");
INSERT INTO meda_vocabulary VALUES("2106","de","_MS_BANNERS_CAPTION_HTML","Gibt an, ob mit Hilfe von HTML-Diashow in Bildunterschriften oder nicht");
INSERT INTO meda_vocabulary VALUES("2107","en","_MS_BANNERS_IS_ACTIVE","Defines whether banners module is active or not");
INSERT INTO meda_vocabulary VALUES("2108","es","_MS_BANNERS_IS_ACTIVE","Define si el módulo banners está activo o no");
INSERT INTO meda_vocabulary VALUES("2109","de","_MS_BANNERS_IS_ACTIVE","Legt fest, ob Banner-Modul aktiv ist oder nicht");
INSERT INTO meda_vocabulary VALUES("2110","en","_MS_COMMENTS_ALLOW","Specifies whether to allow comments to articles");
INSERT INTO meda_vocabulary VALUES("2111","es","_MS_COMMENTS_ALLOW","Especifica si se permiten comentarios a los artículos");
INSERT INTO meda_vocabulary VALUES("2112","de","_MS_COMMENTS_ALLOW","Gibt an, ob Kommentare zu Artikeln ermöglichen");
INSERT INTO meda_vocabulary VALUES("2113","en","_MS_COMMENTS_LENGTH","The maximum length of a comment");
INSERT INTO meda_vocabulary VALUES("2114","es","_MS_COMMENTS_LENGTH","La longitud máxima de un comentario");
INSERT INTO meda_vocabulary VALUES("2115","de","_MS_COMMENTS_LENGTH","Die maximale Länge eines Kommentars");
INSERT INTO meda_vocabulary VALUES("2116","en","_MS_COMMENTS_PAGE_SIZE","Defines how many comments will be shown on one page");
INSERT INTO meda_vocabulary VALUES("2117","es","_MS_COMMENTS_PAGE_SIZE","Define la cantidad de comentarios tanto se muestra en una página");
INSERT INTO meda_vocabulary VALUES("2118","de","_MS_COMMENTS_PAGE_SIZE","Legt fest, wie viel Kommentare werden auf einer Seite angezeigt werden");
INSERT INTO meda_vocabulary VALUES("2119","en","_MS_CONTACT_US_KEY","The shortcode that will be replaced with Contact Us form (copy and paste it into the page)");
INSERT INTO meda_vocabulary VALUES("2120","es","_MS_CONTACT_US_KEY","La palabra clave que serán reemplazadas con nosotros Formulario de contacto (copiar y pegarlo en la página)");
INSERT INTO meda_vocabulary VALUES("2121","de","_MS_CONTACT_US_KEY","Das Schlüsselwort, das mit ersetzt werden Kontakt-Formular (Kopie und fügen Sie ihn in die Seite)");
INSERT INTO meda_vocabulary VALUES("2122","en","_MS_DEFAULT_PAYMENT_SYSTEM","Specifies default payment processing system");
INSERT INTO meda_vocabulary VALUES("2123","es","_MS_DEFAULT_PAYMENT_SYSTEM","Especifica el pago por defecto del sistema de procesamiento");
INSERT INTO meda_vocabulary VALUES("2124","de","_MS_DEFAULT_PAYMENT_SYSTEM","Gibt Zahlungsverzug Verarbeitungssystem");
INSERT INTO meda_vocabulary VALUES("2125","en","_MS_DELAY_LENGTH","Defines a length of delay between sending emails (in seconds)");
INSERT INTO meda_vocabulary VALUES("2126","es","_MS_DELAY_LENGTH","Define un tiempo de retraso entre el envío de correos electrónicos (en segundos)");
INSERT INTO meda_vocabulary VALUES("2127","de","_MS_DELAY_LENGTH","Definiert eine Länge von Verzögerung zwischen dem Senden von E-Mails (in Sekunden)");
INSERT INTO meda_vocabulary VALUES("2128","en","_MS_DELAY_SLOTS","Time delay (unused slots) before the first allowed appointment slot");
INSERT INTO meda_vocabulary VALUES("2129","es","_MS_DELAY_SLOTS","Tiempo de retardo (las ranuras no utilizadas) antes de la ranura de la primera cita permitido");
INSERT INTO meda_vocabulary VALUES("2130","de","_MS_DELAY_SLOTS","Zeitverzögerung (unbenutzte Steckplätze) vor dem ersten Termin Steckplatz erlaubt");
INSERT INTO meda_vocabulary VALUES("2131","en","_MS_DELETE_PENDING_TIME","The maximum pending time for deleting of own comment in minutes");
INSERT INTO meda_vocabulary VALUES("2132","es","_MS_DELETE_PENDING_TIME","El tiempo máximo de espera para la eliminación de comentarios en pocos minutos");
INSERT INTO meda_vocabulary VALUES("2133","de","_MS_DELETE_PENDING_TIME","Die maximale Zeit bis zur Löschung des eigenen Kommentar in Minuten");
INSERT INTO meda_vocabulary VALUES("2134","en","_MS_DOCTORS_IMAGE_VERIFICATION","Specifies whether to allow image verification (captcha) on doctor registration page");
INSERT INTO meda_vocabulary VALUES("2135","es","_MS_DOCTORS_IMAGE_VERIFICATION","Especifica si se debe permitir la verificación de imagen (captcha) en la página de registro médico");
INSERT INTO meda_vocabulary VALUES("2136","de","_MS_DOCTORS_IMAGE_VERIFICATION","Gibt an, ob Bild Verifizierung (Captcha) auf ärztliche Registrierungsseite ermöglichen");
INSERT INTO meda_vocabulary VALUES("2137","en","_MS_DOCTORS_KEY","The shortcode that will be replaced with the list of doctors (copy and paste it into the page)");
INSERT INTO meda_vocabulary VALUES("2138","es","_MS_DOCTORS_KEY","La palabra clave que se reemplazará con la lista de los médicos (copiar y pegar en la página)");
INSERT INTO meda_vocabulary VALUES("2139","de","_MS_DOCTORS_KEY","Das Schlüsselwort, das mit der Liste der Ärzte ersetzt werden (kopieren und ihn in die Seite)");
INSERT INTO meda_vocabulary VALUES("2140","en","_MS_DOCTOR_CONFIRM_REMINDER","Specifies a time interval in hours, before confirm reminder will be sent to doctor");
INSERT INTO meda_vocabulary VALUES("2141","es","_MS_DOCTOR_CONFIRM_REMINDER","Especifica un intervalo de tiempo en horas, antes de recordatorio confirman será enviado a médico");
INSERT INTO meda_vocabulary VALUES("2142","de","_MS_DOCTOR_CONFIRM_REMINDER","Gibt ein Zeitintervall in Stunden, bevor bestätigen Erinnerung wird zum Arzt geschickt werden");
INSERT INTO meda_vocabulary VALUES("2143","en","_MS_EMAIL","The email address, that will be used to get sent information");
INSERT INTO meda_vocabulary VALUES("2144","es","_MS_EMAIL","La dirección de correo electrónico, que se utiliza para obtener la información enviada");
INSERT INTO meda_vocabulary VALUES("2145","de","_MS_EMAIL","Die E-Mail-Adresse, die verwendet werden, um an Informationen zu bekommen sein wird");
INSERT INTO meda_vocabulary VALUES("2146","en","_MS_FAQ_IS_ACTIVE","Defines whether FAQ module is active or not");
INSERT INTO meda_vocabulary VALUES("2147","es","_MS_FAQ_IS_ACTIVE","Define si FAQ módulo está activo o no");
INSERT INTO meda_vocabulary VALUES("2148","de","_MS_FAQ_IS_ACTIVE","Legt fest, ob FAQ-Modul aktiv ist oder nicht");
INSERT INTO meda_vocabulary VALUES("2149","en","_MS_GALLERY_KEY","The shortcode that will be replaced with gallery (copy and paste it into the page)");
INSERT INTO meda_vocabulary VALUES("2150","es","_MS_GALLERY_KEY","La palabra clave que serán reemplazadas con la galería (copiar y pegarlo en la página)");
INSERT INTO meda_vocabulary VALUES("2151","de","_MS_GALLERY_KEY","Das Schlüsselwort, das mit Galerie (Kopie ersetzt wird, und fügen Sie ihn in die Seite)");
INSERT INTO meda_vocabulary VALUES("2152","en","_MS_GALLERY_WRAPPER","Defines a wrapper type for gallery");
INSERT INTO meda_vocabulary VALUES("2153","es","_MS_GALLERY_WRAPPER","Define un tipo de contenedor de la galería");
INSERT INTO meda_vocabulary VALUES("2154","de","_MS_GALLERY_WRAPPER","Definiert eine Wrapper-Typ für die Galerie");
INSERT INTO meda_vocabulary VALUES("2155","en","_MS_GOOGLE_MAPS_API_KEY","Google Maps API Key");
INSERT INTO meda_vocabulary VALUES("2156","es","_MS_GOOGLE_MAPS_API_KEY","Google Maps API Key");
INSERT INTO meda_vocabulary VALUES("2157","de","_MS_GOOGLE_MAPS_API_KEY","Google Maps API Key");
INSERT INTO meda_vocabulary VALUES("2158","en","_MS_GOOGLE_MAP_HEIGHT","Google Maps image height (in pixels)");
INSERT INTO meda_vocabulary VALUES("2159","es","_MS_GOOGLE_MAP_HEIGHT","Google Maps altura de la imagen (en píxeles)");
INSERT INTO meda_vocabulary VALUES("2160","de","_MS_GOOGLE_MAP_HEIGHT","Google Maps Bildhöhe (in Pixel)");
INSERT INTO meda_vocabulary VALUES("2161","en","_MS_GOOGLE_MAP_WIDTH","Google Maps image width (in pixels)");
INSERT INTO meda_vocabulary VALUES("2162","es","_MS_GOOGLE_MAP_WIDTH","Google Maps ancho de la imagen (en píxeles)");
INSERT INTO meda_vocabulary VALUES("2163","de","_MS_GOOGLE_MAP_WIDTH","Google Maps Bildbreite (in Pixel)");
INSERT INTO meda_vocabulary VALUES("2164","en","_MS_IMAGE_GALLERY_TYPE","Allowed types of Image Gallery");
INSERT INTO meda_vocabulary VALUES("2165","es","_MS_IMAGE_GALLERY_TYPE","Tipos de animales Galería de imágenes");
INSERT INTO meda_vocabulary VALUES("2166","de","_MS_IMAGE_GALLERY_TYPE","Erlaubt Arten von Image Gallery");
INSERT INTO meda_vocabulary VALUES("2167","en","_MS_IMAGE_VERIFICATION_ALLOW","Specifies whether to allow image verification (captcha)");
INSERT INTO meda_vocabulary VALUES("2168","es","_MS_IMAGE_VERIFICATION_ALLOW","Especifica si se debe permitir la verificación de la imagen (captcha)");
INSERT INTO meda_vocabulary VALUES("2169","de","_MS_IMAGE_VERIFICATION_ALLOW","Gibt an, ob Bild überprüft werden kann (captcha)");
INSERT INTO meda_vocabulary VALUES("2170","en","_MS_IS_SEND_DELAY","Specifies whether to allow time delay between sending emails");
INSERT INTO meda_vocabulary VALUES("2171","es","_MS_IS_SEND_DELAY","Especifica si se permite tiempo de retardo entre el envío de mensajes de correo electrónico");
INSERT INTO meda_vocabulary VALUES("2172","de","_MS_IS_SEND_DELAY","Gibt an, ob Zeitverzögerung zwischen E-Mails ermöglichen");
INSERT INTO meda_vocabulary VALUES("2173","en","_MS_MAXIMUM_ALLOWED_APPOINTMENTS","Specifies the maximum allowed appointments (not approved) per patient in a day");
INSERT INTO meda_vocabulary VALUES("2174","es","_MS_MAXIMUM_ALLOWED_APPOINTMENTS","Especifica los nombramientos máximo permitido (no aprobado) por paciente en los días de");
INSERT INTO meda_vocabulary VALUES("2175","de","_MS_MAXIMUM_ALLOWED_APPOINTMENTS","Gibt die maximal zulässige Termine (nicht genehmigten) pro Patient im Tag");
INSERT INTO meda_vocabulary VALUES("2176","en","_MS_MAXIMUM_ALLOWED_ORDERS","Specifies the maximum number of allowed orders (not completed) per customer");
INSERT INTO meda_vocabulary VALUES("2177","es","_MS_MAXIMUM_ALLOWED_ORDERS","Especifica el número máximo permitido de las órdenes (no terminado) por cliente");
INSERT INTO meda_vocabulary VALUES("2178","de","_MS_MAXIMUM_ALLOWED_ORDERS","Gibt die maximale Anzahl von erlaubten Befehle (nicht vollendet) pro Kunde");
INSERT INTO meda_vocabulary VALUES("2179","en","_MS_MULTIPLE_ITEMS_PER_DAY","Specifies whether to allow users to rate multiple items per day or not");
INSERT INTO meda_vocabulary VALUES("2180","es","_MS_MULTIPLE_ITEMS_PER_DAY","Especifica si se permite a los usuarios artículos tasas múltiples por día o no");
INSERT INTO meda_vocabulary VALUES("2181","de","_MS_MULTIPLE_ITEMS_PER_DAY","Gibt an, ob Benutzer sich mehrere Artikel pro Tag oder nicht zulassen");
INSERT INTO meda_vocabulary VALUES("2182","en","_MS_NEWS_COUNT","Defines how many news will be shown in news block");
INSERT INTO meda_vocabulary VALUES("2183","es","_MS_NEWS_COUNT","Define el número de noticias se muestra en el bloque de noticias");
INSERT INTO meda_vocabulary VALUES("2184","de","_MS_NEWS_COUNT","Definiert, wie viele Nachrichten in Nachrichten-Block gezeigt werden");
INSERT INTO meda_vocabulary VALUES("2185","en","_MS_NEWS_HEADER_LENGTH","Defines a length of news header in block");
INSERT INTO meda_vocabulary VALUES("2186","es","_MS_NEWS_HEADER_LENGTH","Define una longitud de la cabecera de noticias en el bloque");
INSERT INTO meda_vocabulary VALUES("2187","de","_MS_NEWS_HEADER_LENGTH","Definiert eine Länge von Nachrichten-Header in Block");
INSERT INTO meda_vocabulary VALUES("2188","en","_MS_NEWS_RSS","Defines using of RSS for news");
INSERT INTO meda_vocabulary VALUES("2189","es","_MS_NEWS_RSS","Define el uso de los RSS de noticias");
INSERT INTO meda_vocabulary VALUES("2190","de","_MS_NEWS_RSS","Definiert mit der RSS für Nachrichten");
INSERT INTO meda_vocabulary VALUES("2191","en","_MS_ONLINE_COLLECT_CREDIT_CARD","Specifies whether to allow collecting of credit card info for \'On-line Orders\'");
INSERT INTO meda_vocabulary VALUES("2192","es","_MS_ONLINE_COLLECT_CREDIT_CARD","Especifica si se permite la recogida de información de tarjetas de crédito de \'Pedidos on-line\'");
INSERT INTO meda_vocabulary VALUES("2193","de","_MS_ONLINE_COLLECT_CREDIT_CARD","Gibt an, ob das Sammeln von Kreditkartendaten für \'On-line Bestellungen\'");
INSERT INTO meda_vocabulary VALUES("2194","en","_MS_PATIENTS_IMAGE_VERIFICATION","Specifies whether to allow image verification (captcha) on patient registration page");
INSERT INTO meda_vocabulary VALUES("2195","es","_MS_PATIENTS_IMAGE_VERIFICATION","Especifica si se permite la verificación de la imagen (captcha) en la página de registro de pacientes");
INSERT INTO meda_vocabulary VALUES("2196","de","_MS_PATIENTS_IMAGE_VERIFICATION","Gibt an, ob Bild Verifizierung (Captcha) auf Patienten Registrierungsseite erlauben");
INSERT INTO meda_vocabulary VALUES("2197","en","_MS_PATIENT_ARRIVAL_REMINDER","Specifies a time interval in hours, before arrival  reminder will be sent to patient");
INSERT INTO meda_vocabulary VALUES("2198","es","_MS_PATIENT_ARRIVAL_REMINDER","Especifica un intervalo de tiempo en horas, antes de recordatorio de llegada serán enviados a paciente");
INSERT INTO meda_vocabulary VALUES("2199","de","_MS_PATIENT_ARRIVAL_REMINDER","Gibt ein Zeitintervall in Stunden, vor der Anreise Erinnerung wird den Patienten gesendet werden");
INSERT INTO meda_vocabulary VALUES("2200","en","_MS_PATIENT_CONFIRM_REMINDER","Specifies a time interval in hours, before confirm reminder will be sent to patient");
INSERT INTO meda_vocabulary VALUES("2201","es","_MS_PATIENT_CONFIRM_REMINDER","Especifica un intervalo de tiempo en horas, antes de recordatorio confirman será enviado a paciente");
INSERT INTO meda_vocabulary VALUES("2202","de","_MS_PATIENT_CONFIRM_REMINDER","Gibt ein Zeitintervall in Stunden, bevor bestätigen Erinnerung wird den Patienten gesendet werden");
INSERT INTO meda_vocabulary VALUES("2203","en","_MS_PAYMENTS_ACTIVE","Defines whether payments module is active or not");
INSERT INTO meda_vocabulary VALUES("2204","es","_MS_PAYMENTS_ACTIVE","Define si el módulo de pagos está activa o no");
INSERT INTO meda_vocabulary VALUES("2205","de","_MS_PAYMENTS_ACTIVE","Legt fest, ob Zahlungen Modul aktiv ist oder nicht");
INSERT INTO meda_vocabulary VALUES("2206","en","_MS_PAYMENTS_MODE","Specifies which mode is turned ON for payments");
INSERT INTO meda_vocabulary VALUES("2207","es","_MS_PAYMENTS_MODE","Especifica en qué modo está activado para los pagos");
INSERT INTO meda_vocabulary VALUES("2208","de","_MS_PAYMENTS_MODE","Gibt an, welcher Modus wird für Zahlungen gedreht");
INSERT INTO meda_vocabulary VALUES("2209","en","_MS_PAYMENT_METHOD_2CO","Specifies whether to allow \'2CO\' payment method");
INSERT INTO meda_vocabulary VALUES("2210","es","_MS_PAYMENT_METHOD_2CO","Especifica si se permite el método de CO \'2 \'de pago");
INSERT INTO meda_vocabulary VALUES("2211","de","_MS_PAYMENT_METHOD_2CO","Gibt an, ob \'2CO\' Zahlungsmethode ermöglichen");
INSERT INTO meda_vocabulary VALUES("2212","en","_MS_PAYMENT_METHOD_AUTHORIZE","Specifies whether to allow \'Authorize.Net\' payment method");
INSERT INTO meda_vocabulary VALUES("2213","es","_MS_PAYMENT_METHOD_AUTHORIZE","Especifica si se permite el método \'Authorize.Net de pago");
INSERT INTO meda_vocabulary VALUES("2214","de","_MS_PAYMENT_METHOD_AUTHORIZE","Gibt an, ob \"Authorize.Net\" Zahlungsmethode");
INSERT INTO meda_vocabulary VALUES("2215","en","_MS_PAYMENT_METHOD_ONLINE","Specifies whether to allow \'On-line Order\' payment method");
INSERT INTO meda_vocabulary VALUES("2216","es","_MS_PAYMENT_METHOD_ONLINE","Especifica si se permite el método \'on-line Orden de pago");
INSERT INTO meda_vocabulary VALUES("2217","de","_MS_PAYMENT_METHOD_ONLINE","Gibt an, ob \'On-line Bestellung\' Zahlungsart");
INSERT INTO meda_vocabulary VALUES("2218","en","_MS_PAYMENT_METHOD_PAYPAL","Specifies whether to allow \'PayPal\' payment method");
INSERT INTO meda_vocabulary VALUES("2219","es","_MS_PAYMENT_METHOD_PAYPAL","Especifica si se permite \'PayPal\' método de pago");
INSERT INTO meda_vocabulary VALUES("2220","de","_MS_PAYMENT_METHOD_PAYPAL","Gibt an, ob \'PayPal\' Zahlungsmethode");
INSERT INTO meda_vocabulary VALUES("2221","en","_MS_PAYPAL_EMAIL","Specifies PayPal (business) email ");
INSERT INTO meda_vocabulary VALUES("2222","es","_MS_PAYPAL_EMAIL","Especifica PayPal (de negocios) de correo electrónico");
INSERT INTO meda_vocabulary VALUES("2223","de","_MS_PAYPAL_EMAIL","Gibt PayPal (Geschäft) E-Mail");
INSERT INTO meda_vocabulary VALUES("2224","en","_MS_PRE_MODERATION_ALLOW","Specifies whether to allow pre-moderation for comments");
INSERT INTO meda_vocabulary VALUES("2225","es","_MS_PRE_MODERATION_ALLOW","Especifica si se permite antes de la moderación de los comentarios");
INSERT INTO meda_vocabulary VALUES("2226","de","_MS_PRE_MODERATION_ALLOW","Gibt an, ob Pre-Moderation für Kommentare zulassen");
INSERT INTO meda_vocabulary VALUES("2227","en","_MS_RATINGS_USER_TYPE","Type of users, who can rate doctors");
INSERT INTO meda_vocabulary VALUES("2228","es","_MS_RATINGS_USER_TYPE","Tipo de usuarios, que pueden calificar los médicos");
INSERT INTO meda_vocabulary VALUES("2229","de","_MS_RATINGS_USER_TYPE","Typ von Usern, die Ärzte bewerten können");
INSERT INTO meda_vocabulary VALUES("2230","en","_MS_REG_CONFIRMATION","Defines whether confirmation (which type of) is required for registration");
INSERT INTO meda_vocabulary VALUES("2231","es","_MS_REG_CONFIRMATION","Define si la confirmación (el tipo) es necesaria para la inscripción");
INSERT INTO meda_vocabulary VALUES("2232","de","_MS_REG_CONFIRMATION","Legt fest, ob die Bestätigung (welche Art) für die Anmeldung ist erforderlich");
INSERT INTO meda_vocabulary VALUES("2233","en","_MS_REMEMBER_ME","Specifies whether to allow Remember Me feature");
INSERT INTO meda_vocabulary VALUES("2234","es","_MS_REMEMBER_ME","Especifica si se permite Recordarme función");
INSERT INTO meda_vocabulary VALUES("2235","de","_MS_REMEMBER_ME","Gibt an, ob Remember Me Funktion");
INSERT INTO meda_vocabulary VALUES("2236","en","_MS_REMINDER_TYPE","Specifies a type of the Reminder");
INSERT INTO meda_vocabulary VALUES("2237","es","_MS_REMINDER_TYPE","Especifica un tipo de recordatorio");
INSERT INTO meda_vocabulary VALUES("2238","de","_MS_REMINDER_TYPE","Gibt eine Art der Erinnerung");
INSERT INTO meda_vocabulary VALUES("2239","en","_MS_ROTATE_DELAY","Defines banners rotation delay in seconds");
INSERT INTO meda_vocabulary VALUES("2240","es","_MS_ROTATE_DELAY","Define retraso banners de rotación en cuestión de segundos");
INSERT INTO meda_vocabulary VALUES("2241","de","_MS_ROTATE_DELAY","Definiert Banner Rotation Verzögerung in Sekunden");
INSERT INTO meda_vocabulary VALUES("2242","en","_MS_ROTATION_TYPE","Different type of banner rotation");
INSERT INTO meda_vocabulary VALUES("2243","es","_MS_ROTATION_TYPE","Tipo de rotación de banners");
INSERT INTO meda_vocabulary VALUES("2244","de","_MS_ROTATION_TYPE","Verschiedene Arten von Banner-Rotation");
INSERT INTO meda_vocabulary VALUES("2245","en","_MS_SCHEDULES_ACCESS_LEVEL","Specifies patient access level to view doctor schedules");
INSERT INTO meda_vocabulary VALUES("2246","es","_MS_SCHEDULES_ACCESS_LEVEL","Especifica el nivel de acceso de los pacientes para ver los horarios del médico");
INSERT INTO meda_vocabulary VALUES("2247","de","_MS_SCHEDULES_ACCESS_LEVEL","Gibt Patienten Zugriffsebene für den Arzt Termine angezeigt");
INSERT INTO meda_vocabulary VALUES("2248","en","_MS_SEND_APPT_NOTIF_TO_ADMIN","Specifies whether to send notification to admin about creating appointments or changing it\'s status");
INSERT INTO meda_vocabulary VALUES("2249","es","_MS_SEND_APPT_NOTIF_TO_ADMIN","Especifica si se debe enviar una notificación al administrador acerca de cómo crear o cambiar citas de estado");
INSERT INTO meda_vocabulary VALUES("2250","de","_MS_SEND_APPT_NOTIF_TO_ADMIN","Gibt an, ob eine Benachrichtigung an den Admin über das Erstellen oder Ändern Termine Status senden");
INSERT INTO meda_vocabulary VALUES("2251","en","_MS_SEND_APPT_NOTIF_TO_DOCTOR","Specifies whether to send notification to doctor about creating appointments or changing it\'s status");
INSERT INTO meda_vocabulary VALUES("2252","es","_MS_SEND_APPT_NOTIF_TO_DOCTOR","Especifica si se debe enviar la notificación al médico acerca de cómo crear o cambiar citas estatus");
INSERT INTO meda_vocabulary VALUES("2253","de","_MS_SEND_APPT_NOTIF_TO_DOCTOR","Gibt an, ob eine Benachrichtigung für den Arzt senden zum Erstellen oder Ändern Termine Status");
INSERT INTO meda_vocabulary VALUES("2254","en","_MS_SEND_ORDER_COPY_TO_ADMIN","Specifies whether to allow sending a copy of order to admin");
INSERT INTO meda_vocabulary VALUES("2255","es","_MS_SEND_ORDER_COPY_TO_ADMIN","Especifica si se permite el envío de una copia de la orden de admin");
INSERT INTO meda_vocabulary VALUES("2256","de","_MS_SEND_ORDER_COPY_TO_ADMIN","Gibt an, ob Sie eine Kopie, um admin");
INSERT INTO meda_vocabulary VALUES("2257","en","_MS_SHOW_NEWSLETTER_SUBSCRIBE_BLOCK","Defines whether to show Newsletter Subscription block or not");
INSERT INTO meda_vocabulary VALUES("2258","es","_MS_SHOW_NEWSLETTER_SUBSCRIBE_BLOCK","Define si se debe mostrar bloque Suscripción al boletín o no");
INSERT INTO meda_vocabulary VALUES("2259","de","_MS_SHOW_NEWSLETTER_SUBSCRIBE_BLOCK","Legt fest, ob zur Newsletter-Anmeldung sperren oder nicht zeigen");
INSERT INTO meda_vocabulary VALUES("2260","en","_MS_SHOW_NEWS_BLOCK","Defines whether to show News side block or not");
INSERT INTO meda_vocabulary VALUES("2261","es","_MS_SHOW_NEWS_BLOCK","Define si se debe mostrar bloque Noticias lado o no");
INSERT INTO meda_vocabulary VALUES("2262","de","_MS_SHOW_NEWS_BLOCK","Legt fest, ob zu News Seite sperren oder nicht zeigen");
INSERT INTO meda_vocabulary VALUES("2263","en","_MS_TWO_CHECKOUT_VENDOR","Specifies 2CO Vendor ID");
INSERT INTO meda_vocabulary VALUES("2264","es","_MS_TWO_CHECKOUT_VENDOR","Especifica 2CO Vendor ID");
INSERT INTO meda_vocabulary VALUES("2265","de","_MS_TWO_CHECKOUT_VENDOR","Gibt 2CO Vendor ID");
INSERT INTO meda_vocabulary VALUES("2266","en","_MS_USER_TYPE","Type of users, who can post comments");
INSERT INTO meda_vocabulary VALUES("2267","es","_MS_USER_TYPE","Tipo de usuarios, que pueden enviar comentarios");
INSERT INTO meda_vocabulary VALUES("2268","de","_MS_USER_TYPE","Art der Benutzer kann die post comments");
INSERT INTO meda_vocabulary VALUES("2269","en","_MS_VAT_VALUE","Specifies default VAT value for order (in %)");
INSERT INTO meda_vocabulary VALUES("2270","es","_MS_VAT_VALUE","Especifica el valor predeterminado de IVA por el orden (en%)");
INSERT INTO meda_vocabulary VALUES("2271","de","_MS_VAT_VALUE","Gibt standardmäßige MwSt. Preis-Leistungs-Ordnung (in%)");
INSERT INTO meda_vocabulary VALUES("2272","en","_MS_VIDEO_GALLERY_TYPE","Allowed types of Video Gallery");
INSERT INTO meda_vocabulary VALUES("2273","es","_MS_VIDEO_GALLERY_TYPE","Tipos de animales Galería de Videos");
INSERT INTO meda_vocabulary VALUES("2274","de","_MS_VIDEO_GALLERY_TYPE","Erlaubt Arten von Video-Galerie");
INSERT INTO meda_vocabulary VALUES("2275","en","_MS_WATERMARK_TEXT","Watermark text that will be added to images");
INSERT INTO meda_vocabulary VALUES("2276","es","_MS_WATERMARK_TEXT","Texto de la marca que se añadirá a las imágenes");
INSERT INTO meda_vocabulary VALUES("2277","de","_MS_WATERMARK_TEXT","Wasserzeichen Text, der die Bilder hinzugefügt werden");
INSERT INTO meda_vocabulary VALUES("2278","en","_MUST_BE_LOGGED","You must be logged in to view this page! <a href=\'index.php?_ACCOUNT_=login\'>Login</a> or <a href=\'index.php?_ACCOUNT_=create_account\'>Create Account for free</a>.");
INSERT INTO meda_vocabulary VALUES("2279","es","_MUST_BE_LOGGED","Debe estar registrado para ver esta página! <a href=\'index.php?_ACCOUNT_=login\'>Login</a> o <a href=\'index.php?_ACCOUNT_=create_account\'>Crear una cuenta gratis</a>.");
INSERT INTO meda_vocabulary VALUES("2280","de","_MUST_BE_LOGGED","Sie müssen eingeloggt sein um diese Seite anzuzeigen! <a href=\'index.php?_ACCOUNT_=login\'>Login</a> oder <a href=\'index.php?_ACCOUNT_=create_account\'>Account erstellen kostenlos</a>.");
INSERT INTO meda_vocabulary VALUES("2281","en","_MY_ACCOUNT","My Account");
INSERT INTO meda_vocabulary VALUES("2282","es","_MY_ACCOUNT","Mi Cuenta");
INSERT INTO meda_vocabulary VALUES("2283","de","_MY_ACCOUNT","Ihr Konto");
INSERT INTO meda_vocabulary VALUES("2284","en","_MY_ADDRESSES","My Addresses");
INSERT INTO meda_vocabulary VALUES("2285","es","_MY_ADDRESSES","Mis direcciones");
INSERT INTO meda_vocabulary VALUES("2286","de","_MY_ADDRESSES","Meine Adressen");
INSERT INTO meda_vocabulary VALUES("2287","en","_MY_APPOINTMENTS","My Appointments");
INSERT INTO meda_vocabulary VALUES("2288","es","_MY_APPOINTMENTS","Mis citas");
INSERT INTO meda_vocabulary VALUES("2289","de","_MY_APPOINTMENTS","Meine Termine");
INSERT INTO meda_vocabulary VALUES("2290","en","_MY_IMAGES","My Images");
INSERT INTO meda_vocabulary VALUES("2291","es","_MY_IMAGES","Mis Imágenes");
INSERT INTO meda_vocabulary VALUES("2292","de","_MY_IMAGES","Meine Bilder");
INSERT INTO meda_vocabulary VALUES("2293","en","_MY_ORDERS","My Orders");
INSERT INTO meda_vocabulary VALUES("2294","es","_MY_ORDERS","Mis pedidos");
INSERT INTO meda_vocabulary VALUES("2295","de","_MY_ORDERS","Meine Bestellungen");
INSERT INTO meda_vocabulary VALUES("2296","en","_MY_SPECIALITIES","My Specialities");
INSERT INTO meda_vocabulary VALUES("2297","es","_MY_SPECIALITIES","Mis especialidades");
INSERT INTO meda_vocabulary VALUES("2298","de","_MY_SPECIALITIES","Meine Spezialitäten");
INSERT INTO meda_vocabulary VALUES("2299","en","_NAME","Name");
INSERT INTO meda_vocabulary VALUES("2300","es","_NAME","Nombre");
INSERT INTO meda_vocabulary VALUES("2301","de","_NAME","Name");
INSERT INTO meda_vocabulary VALUES("2302","en","_NEVER","never");
INSERT INTO meda_vocabulary VALUES("2303","es","_NEVER","nunca");
INSERT INTO meda_vocabulary VALUES("2304","de","_NEVER","nie");
INSERT INTO meda_vocabulary VALUES("2305","en","_NEWS","News");
INSERT INTO meda_vocabulary VALUES("2306","es","_NEWS","Noticias");
INSERT INTO meda_vocabulary VALUES("2307","de","_NEWS","Nachrichten");
INSERT INTO meda_vocabulary VALUES("2308","en","_NEWSLETTER_PRE_SUBSCRIBE_ALERT","Please click on the \"Subscribe\" button to complete the process.");
INSERT INTO meda_vocabulary VALUES("2309","es","_NEWSLETTER_PRE_SUBSCRIBE_ALERT","Por favor, haga clic en el botón &#034;Suscribirse&#034; para completar el proceso.");
INSERT INTO meda_vocabulary VALUES("2310","de","_NEWSLETTER_PRE_SUBSCRIBE_ALERT","Bitte klicken Sie auf den &#034;Abonnieren&#034;-Knopf, um den Vorgang abzuschließen.");
INSERT INTO meda_vocabulary VALUES("2311","en","_NEWSLETTER_PRE_UNSUBSCRIBE_ALERT","Please click on the \"Unsubscribe\" button to complete the process.");
INSERT INTO meda_vocabulary VALUES("2312","es","_NEWSLETTER_PRE_UNSUBSCRIBE_ALERT","Por favor, haga clic en &#034;Anular&#034; para completar el proceso.");
INSERT INTO meda_vocabulary VALUES("2313","de","_NEWSLETTER_PRE_UNSUBSCRIBE_ALERT","Bitte klicken Sie auf die Schaltfläche &#034;Abmelden&#034;, um den Vorgang abzuschließen.");
INSERT INTO meda_vocabulary VALUES("2314","en","_NEWSLETTER_SUBSCRIBERS","Newsletter Subscribers");
INSERT INTO meda_vocabulary VALUES("2315","es","_NEWSLETTER_SUBSCRIBERS","Suscriptores del boletín");
INSERT INTO meda_vocabulary VALUES("2316","de","_NEWSLETTER_SUBSCRIBERS","Newsletter-Abonnenten");
INSERT INTO meda_vocabulary VALUES("2317","en","_NEWSLETTER_SUBSCRIBE_SUCCESS","Thank you for subscribing to our electronic newsletter. You will receive soon an email with details of your subscription.");
INSERT INTO meda_vocabulary VALUES("2318","es","_NEWSLETTER_SUBSCRIBE_SUCCESS","Gracias por suscribirse a nuestro boletín electrónico. Usted recibirá pronto un correo electrónico con los detalles de su suscripción.");
INSERT INTO meda_vocabulary VALUES("2319","de","_NEWSLETTER_SUBSCRIBE_SUCCESS","Danke für die Anmeldung zu unseren elektronischen Newsletter. Sie erhalten in Kürze eine E-Mail mit Angabe Ihres Abonnements.");
INSERT INTO meda_vocabulary VALUES("2320","en","_NEWSLETTER_SUBSCRIBE_TEXT","<p>To receive newsletters from our site, simply enter your email and click on \"Subscribe\" button.</p><p>If you later decide to stop your subscription or change the type of news you receive, simply follow the link at the end of the latest newsletter and update your profile or unsubscribe by ticking the checkbox below.</p>");
INSERT INTO meda_vocabulary VALUES("2321","es","_NEWSLETTER_SUBSCRIBE_TEXT","<p>Para recibir boletines de noticias de nuestro sitio, simplemente introduzca su email y haga clic en el botón &#034;Suscribirse&#034;.</p><p>Si posteriormente decide dejar su suscripción o cambiar el tipo de noticias que recibe, sólo tiene que seguir el enlace al final del último boletín de noticias y actualizar su perfil o darse de baja, marcando la casilla a continuación.</p>");
INSERT INTO meda_vocabulary VALUES("2322","de","_NEWSLETTER_SUBSCRIBE_TEXT","<p>Um Newsletter von unserer Website zu erhalten, geben Sie einfach Ihre Email und klicken Sie auf &#034;Abonnieren&#034;-Knopf. </p><p> Wenn Sie sich später entscheiden, um Ihr Abonnement beenden oder ändern Sie den Typ der Nachricht erhalten, folgen Sie einfach dem Link am Ende des aktuellen Newsletter und aktualisieren Sie Ihr Profil oder abbestellen, indem Sie das Kontrollkästchen unten.</p>");
INSERT INTO meda_vocabulary VALUES("2323","en","_NEWSLETTER_SUBSCRIPTION_MANAGEMENT","Newsletter Subscription Management");
INSERT INTO meda_vocabulary VALUES("2324","es","_NEWSLETTER_SUBSCRIPTION_MANAGEMENT","Boletín de administración de suscripciones");
INSERT INTO meda_vocabulary VALUES("2325","de","_NEWSLETTER_SUBSCRIPTION_MANAGEMENT","Newsletter-Abonnement-Verwaltung");
INSERT INTO meda_vocabulary VALUES("2326","en","_NEWSLETTER_UNSUBSCRIBE_SUCCESS","You have been successfully unsubscribed from our newsletter!");
INSERT INTO meda_vocabulary VALUES("2327","es","_NEWSLETTER_UNSUBSCRIBE_SUCCESS","Que han sido éxito de baja de nuestro boletín de noticias!");
INSERT INTO meda_vocabulary VALUES("2328","de","_NEWSLETTER_UNSUBSCRIBE_SUCCESS","Sie haben sich erfolgreich von unserem Newsletter abgemeldet!");
INSERT INTO meda_vocabulary VALUES("2329","en","_NEWSLETTER_UNSUBSCRIBE_TEXT","<p>To unsubscribe from our newsletters, enter your email address below and click the unsubscribe button.</p>");
INSERT INTO meda_vocabulary VALUES("2330","es","_NEWSLETTER_UNSUBSCRIBE_TEXT","<p>Para darse de baja de nuestros boletines, introduzca su dirección de correo electrónico y haga clic en el botón de darse de baja.</p>");
INSERT INTO meda_vocabulary VALUES("2331","de","_NEWSLETTER_UNSUBSCRIBE_TEXT","<p>Um von unserem Newsletter abmelden, geben Sie Ihre E-Mail-Adresse ein und klicken Sie auf die Schaltfläche Abbestellen.</p>");
INSERT INTO meda_vocabulary VALUES("2332","en","_NEWS_AND_EVENTS","News & Events");
INSERT INTO meda_vocabulary VALUES("2333","es","_NEWS_AND_EVENTS","Noticias y Eventos");
INSERT INTO meda_vocabulary VALUES("2334","de","_NEWS_AND_EVENTS","News & Events");
INSERT INTO meda_vocabulary VALUES("2335","en","_NEWS_MANAGEMENT","News Management");
INSERT INTO meda_vocabulary VALUES("2336","es","_NEWS_MANAGEMENT","Gestión de Noticias");
INSERT INTO meda_vocabulary VALUES("2337","de","_NEWS_MANAGEMENT","News Management");
INSERT INTO meda_vocabulary VALUES("2338","en","_NEWS_SETTINGS","News Settings");
INSERT INTO meda_vocabulary VALUES("2339","es","_NEWS_SETTINGS","Noticias Ajustes");
INSERT INTO meda_vocabulary VALUES("2340","de","_NEWS_SETTINGS","News Einstellungen");
INSERT INTO meda_vocabulary VALUES("2341","en","_NEW_APPOINTMENT","New Appointment");
INSERT INTO meda_vocabulary VALUES("2342","es","_NEW_APPOINTMENT","Nueva cita");
INSERT INTO meda_vocabulary VALUES("2343","de","_NEW_APPOINTMENT","Neueinstellung");
INSERT INTO meda_vocabulary VALUES("2344","en","_NEW_ARTICLE","New Article");
INSERT INTO meda_vocabulary VALUES("2345","es","_NEW_ARTICLE","Nuevo artículo");
INSERT INTO meda_vocabulary VALUES("2346","de","_NEW_ARTICLE","Neuer Artikel");
INSERT INTO meda_vocabulary VALUES("2347","en","_NEXT","Next");
INSERT INTO meda_vocabulary VALUES("2348","es","_NEXT","Próximo");
INSERT INTO meda_vocabulary VALUES("2349","de","_NEXT","Nächste");
INSERT INTO meda_vocabulary VALUES("2350","en","_NEXT_APPOINTMENT_AT","Next appointment at");
INSERT INTO meda_vocabulary VALUES("2351","es","_NEXT_APPOINTMENT_AT","Próxima cita en");
INSERT INTO meda_vocabulary VALUES("2352","de","_NEXT_APPOINTMENT_AT","Nächster Termin bei");
INSERT INTO meda_vocabulary VALUES("2353","en","_NEXT_APPT_IN_2_MONTHS","Next appointment more than in 2 months");
INSERT INTO meda_vocabulary VALUES("2354","es","_NEXT_APPT_IN_2_MONTHS","Próxima cita más que en 2 meses");
INSERT INTO meda_vocabulary VALUES("2355","de","_NEXT_APPT_IN_2_MONTHS","Nächster Termin mehr als 2 Monaten");
INSERT INTO meda_vocabulary VALUES("2356","en","_NO","No");
INSERT INTO meda_vocabulary VALUES("2357","es","_NO","No");
INSERT INTO meda_vocabulary VALUES("2358","de","_NO","Keine");
INSERT INTO meda_vocabulary VALUES("2359","en","_NONE","None");
INSERT INTO meda_vocabulary VALUES("2360","es","_NONE","Ninguno");
INSERT INTO meda_vocabulary VALUES("2361","de","_NONE","keiner");
INSERT INTO meda_vocabulary VALUES("2362","en","_NOTICE_MODULES_CODE","To add available modules to this page just copy and paste into the text one of the following shortcodes:");
INSERT INTO meda_vocabulary VALUES("2363","es","_NOTICE_MODULES_CODE","Para agregar módulos disponibles para esta página sólo tienes que copiar y pegar en el texto uno de los siguientes códigos cortos:");
INSERT INTO meda_vocabulary VALUES("2364","de","_NOTICE_MODULES_CODE","Um die verfügbaren Module auf dieser Seite fügen Sie einfach kopieren und in den Text eine der folgenden Shortcodes:");
INSERT INTO meda_vocabulary VALUES("2365","en","_NOTIFICATION_MSG","Please send me information related to my health care, health insurance or site updates!");
INSERT INTO meda_vocabulary VALUES("2366","es","_NOTIFICATION_MSG","Por favor, envíenme información relacionada con el cuidado de mi salud, seguro de salud o las actualizaciones del sitio!");
INSERT INTO meda_vocabulary VALUES("2367","de","_NOTIFICATION_MSG","Bitte senden Sie mir Informationen zu meiner Ärztin, Krankenversicherung oder Website-Updates!");
INSERT INTO meda_vocabulary VALUES("2368","en","_NOTIFICATION_STATUS_CHANGED","Notification status changed");
INSERT INTO meda_vocabulary VALUES("2369","es","_NOTIFICATION_STATUS_CHANGED","Estatuto de notificación cambiado");
INSERT INTO meda_vocabulary VALUES("2370","de","_NOTIFICATION_STATUS_CHANGED","Notification Status geändert");
INSERT INTO meda_vocabulary VALUES("2371","en","_NOT_ALLOWED","Not Allowed");
INSERT INTO meda_vocabulary VALUES("2372","es","_NOT_ALLOWED","No se admiten");
INSERT INTO meda_vocabulary VALUES("2373","de","_NOT_ALLOWED","Nicht Erlaubt");
INSERT INTO meda_vocabulary VALUES("2374","en","_NOT_AUTHORIZED","You are not authorized to view this page.");
INSERT INTO meda_vocabulary VALUES("2375","es","_NOT_AUTHORIZED","Usted no está autorizado a ver esta página.");
INSERT INTO meda_vocabulary VALUES("2376","de","_NOT_AUTHORIZED","Sie sind nicht berechtigt, diese Seite anzuzeigen.");
INSERT INTO meda_vocabulary VALUES("2377","en","_NOT_AVAILABLE","N/A");
INSERT INTO meda_vocabulary VALUES("2378","es","_NOT_AVAILABLE","N/A");
INSERT INTO meda_vocabulary VALUES("2379","de","_NOT_AVAILABLE","N/A");
INSERT INTO meda_vocabulary VALUES("2380","en","_NOT_YET_PAID","Not yet paid");
INSERT INTO meda_vocabulary VALUES("2381","es","_NOT_YET_PAID","Todavía no se ha pagado");
INSERT INTO meda_vocabulary VALUES("2382","de","_NOT_YET_PAID","Noch nicht entrichtet");
INSERT INTO meda_vocabulary VALUES("2383","en","_NOVEMBER","November");
INSERT INTO meda_vocabulary VALUES("2384","es","_NOVEMBER","Noviembre");
INSERT INTO meda_vocabulary VALUES("2385","de","_NOVEMBER","November");
INSERT INTO meda_vocabulary VALUES("2386","en","_NO_APPOINTMENTS_AVAILABLE","No appointments available at this time");
INSERT INTO meda_vocabulary VALUES("2387","es","_NO_APPOINTMENTS_AVAILABLE","No hay citas disponibles en este momento");
INSERT INTO meda_vocabulary VALUES("2388","de","_NO_APPOINTMENTS_AVAILABLE","Keine Termine zu diesem Zeitpunkt");
INSERT INTO meda_vocabulary VALUES("2389","en","_NO_AVAILABLE_PLANS_NOTICE","Your current plan is _PLAN_NAME_. You have no available plans to upgrade.");
INSERT INTO meda_vocabulary VALUES("2390","es","_NO_AVAILABLE_PLANS_NOTICE","Su plan actual es _PLAN_NAME_. No tiene planes disponibles para actualizar.");
INSERT INTO meda_vocabulary VALUES("2391","de","_NO_AVAILABLE_PLANS_NOTICE","Ihre aktuelle Plan ist _PLAN_NAME_. Sie haben keine Pläne zur Verfügung, zu aktualisieren.");
INSERT INTO meda_vocabulary VALUES("2392","en","_NO_COMMENTS_YET","No comments yet.");
INSERT INTO meda_vocabulary VALUES("2393","es","_NO_COMMENTS_YET","Todavía no hay comentarios.");
INSERT INTO meda_vocabulary VALUES("2394","de","_NO_COMMENTS_YET","Noch keine Kommentare.");
INSERT INTO meda_vocabulary VALUES("2395","en","_NO_DOCTORS_FOUND","No doctor in our database matches your search criteria. Please revise your search.");
INSERT INTO meda_vocabulary VALUES("2396","es","_NO_DOCTORS_FOUND","Ningún médico en nuestra base de datos coincide con los criterios de búsqueda.");
INSERT INTO meda_vocabulary VALUES("2397","de","_NO_DOCTORS_FOUND","Kein Arzt in unserer Datenbank ihren Suchkriterien entspricht.");
INSERT INTO meda_vocabulary VALUES("2398","en","_NO_DOCTORS_FOUND_IN_SPEC","No doctors found in this speciality at this moment!");
INSERT INTO meda_vocabulary VALUES("2399","es","_NO_DOCTORS_FOUND_IN_SPEC","Los médicos no se encuentran en esta especialidad en este momento!");
INSERT INTO meda_vocabulary VALUES("2400","de","_NO_DOCTORS_FOUND_IN_SPEC","Keine Ärzte auf diesem Fachgebiet in diesem Moment gefunden!");
INSERT INTO meda_vocabulary VALUES("2401","en","_NO_NEWS","No news");
INSERT INTO meda_vocabulary VALUES("2402","es","_NO_NEWS","No hay noticias");
INSERT INTO meda_vocabulary VALUES("2403","de","_NO_NEWS","Keine Nachrichten");
INSERT INTO meda_vocabulary VALUES("2404","en","_NO_PATIENTS_FOUND","No Patients Found");
INSERT INTO meda_vocabulary VALUES("2405","es","_NO_PATIENTS_FOUND","Ninguno de los pacientes encontrados");
INSERT INTO meda_vocabulary VALUES("2406","de","_NO_PATIENTS_FOUND","Keine Patienten gefunden");
INSERT INTO meda_vocabulary VALUES("2407","en","_NO_PATIENTS_FOUND_ALERT","No patients found! Try another search or click Set Admin button to assign administrator to this appointment.");
INSERT INTO meda_vocabulary VALUES("2408","es","_NO_PATIENTS_FOUND_ALERT","Ninguno de los pacientes encontraron! Realiza una nueva búsqueda o haga clic en el botón Set Admin para asignar el administrador de este nombramiento.");
INSERT INTO meda_vocabulary VALUES("2409","de","_NO_PATIENTS_FOUND_ALERT","Keiner der Patienten gefunden! Probieren Sie eine andere Suche oder klicken Sie auf Admin-Taste, um Administrator zu diesem Termin zuweisen.");
INSERT INTO meda_vocabulary VALUES("2410","en","_NO_PAYMENT_METHODS_ALERT","No payment methods available! Please contact our technical support.");
INSERT INTO meda_vocabulary VALUES("2411","es","_NO_PAYMENT_METHODS_ALERT","No hay métodos de pago disponibles! Por favor, póngase en contacto con nuestro soporte técnico.");
INSERT INTO meda_vocabulary VALUES("2412","de","_NO_PAYMENT_METHODS_ALERT","Keine Zahlungsmethoden zur Verfügung! Bitte kontaktieren Sie unseren technischen Support.");
INSERT INTO meda_vocabulary VALUES("2413","en","_NO_RECORDS_FOUND","No records found");
INSERT INTO meda_vocabulary VALUES("2414","es","_NO_RECORDS_FOUND","No se encontraron registros");
INSERT INTO meda_vocabulary VALUES("2415","de","_NO_RECORDS_FOUND","Keine Datensätze gefunden");
INSERT INTO meda_vocabulary VALUES("2416","en","_NO_RECORDS_UPDATED","No records were updated!");
INSERT INTO meda_vocabulary VALUES("2417","es","_NO_RECORDS_UPDATED","No hay registros fueron actualizados!");
INSERT INTO meda_vocabulary VALUES("2418","de","_NO_RECORDS_UPDATED","Keine Datensätze wurden aktualisiert!");
INSERT INTO meda_vocabulary VALUES("2419","en","_NO_SEARCH_CRITERIA_SELECTED","No search criteria selected! Please select or enter any search criteria and try again.");
INSERT INTO meda_vocabulary VALUES("2420","es","_NO_SEARCH_CRITERIA_SELECTED","No hay criterios de búsqueda seleccionados! Por favor seleccione o introduzca los criterios de búsqueda y vuelve a intentarlo.");
INSERT INTO meda_vocabulary VALUES("2421","de","_NO_SEARCH_CRITERIA_SELECTED","Keine Suchkriterien ausgewählt! Bitte wählen Sie oder geben Sie keine Suchkriterien und versuchen Sie es erneut.");
INSERT INTO meda_vocabulary VALUES("2422","en","_NO_SPECIALITY_SELECTED","No specially selected! Please select doctor speciality and try again.");
INSERT INTO meda_vocabulary VALUES("2423","es","_NO_SPECIALITY_SELECTED","No especialmente seleccionados! Por favor, seleccione especialidad del médico y vuelva a intentarlo.");
INSERT INTO meda_vocabulary VALUES("2424","de","_NO_SPECIALITY_SELECTED","Keine speziell ausgewählte! Bitte wählen Sie Arzt Spezialität und erneut versuchen.");
INSERT INTO meda_vocabulary VALUES("2425","en","_NO_TEMPLATE","no template");
INSERT INTO meda_vocabulary VALUES("2426","es","_NO_TEMPLATE","sin plantilla");
INSERT INTO meda_vocabulary VALUES("2427","de","_NO_TEMPLATE","keine vorlage");
INSERT INTO meda_vocabulary VALUES("2428","en","_NO_WRITE_ACCESS_ALERT","Please check you have write access to following folders:");
INSERT INTO meda_vocabulary VALUES("2429","es","_NO_WRITE_ACCESS_ALERT","Por favor, compruebe que tiene acceso de escritura a las carpetas siguientes:");
INSERT INTO meda_vocabulary VALUES("2430","de","_NO_WRITE_ACCESS_ALERT","Bitte überprüfen Sie den Schreibzugriff auf folgenden Ordner:");
INSERT INTO meda_vocabulary VALUES("2431","en","_OCTOBER","October");
INSERT INTO meda_vocabulary VALUES("2432","es","_OCTOBER","Octubre");
INSERT INTO meda_vocabulary VALUES("2433","de","_OCTOBER","Oktober");
INSERT INTO meda_vocabulary VALUES("2434","en","_OFF","Off");
INSERT INTO meda_vocabulary VALUES("2435","es","_OFF","Desc.");
INSERT INTO meda_vocabulary VALUES("2436","de","_OFF","aus");
INSERT INTO meda_vocabulary VALUES("2437","en","_OFFLINE_LOGIN_ALERT","To log into Admin Panel when site is offline, type in your browser: http://{your_site_address}/index.php?admin=login");
INSERT INTO meda_vocabulary VALUES("2438","es","_OFFLINE_LOGIN_ALERT","Para entrar en el panel de administración cuando el sitio está en línea, escriba en su navegador: http:// {your_site_address}/index.php?admin=login");
INSERT INTO meda_vocabulary VALUES("2439","de","_OFFLINE_LOGIN_ALERT","So melden Sie sich beim Admin Panel Website offline ist, geben Sie in Ihrem Browser: {your_site_address}/index.php?admin=login");
INSERT INTO meda_vocabulary VALUES("2440","en","_OFFLINE_MESSAGE","Offline Message");
INSERT INTO meda_vocabulary VALUES("2441","es","_OFFLINE_MESSAGE","Mensaje Desconectado");
INSERT INTO meda_vocabulary VALUES("2442","de","_OFFLINE_MESSAGE","Offline-Nachricht");
INSERT INTO meda_vocabulary VALUES("2443","en","_ON","On");
INSERT INTO meda_vocabulary VALUES("2444","es","_ON","Activ.");
INSERT INTO meda_vocabulary VALUES("2445","de","_ON","an");
INSERT INTO meda_vocabulary VALUES("2446","en","_ONLINE_ORDER","On-line Order");
INSERT INTO meda_vocabulary VALUES("2447","es","_ONLINE_ORDER","Orden en línea");
INSERT INTO meda_vocabulary VALUES("2448","de","_ONLINE_ORDER","On-line Bestellen");
INSERT INTO meda_vocabulary VALUES("2449","en","_ONLY_PATIENTS_ACCESS","Only patients can access this page!");
INSERT INTO meda_vocabulary VALUES("2450","es","_ONLY_PATIENTS_ACCESS","Sólo los pacientes pueden acceder a esta página!");
INSERT INTO meda_vocabulary VALUES("2451","de","_ONLY_PATIENTS_ACCESS","Nur Patienten können auf diese Seite zugreifen!");
INSERT INTO meda_vocabulary VALUES("2452","en","_OPEN","Open");
INSERT INTO meda_vocabulary VALUES("2453","es","_OPEN","Abrir");
INSERT INTO meda_vocabulary VALUES("2454","de","_OPEN","Offen");
INSERT INTO meda_vocabulary VALUES("2455","en","_OPEN_ORDER_NOTICE","You have an order that has not yet paid! Please wait while your order is processed or <a href=index.php?doctor=my_orders>cancel</a> any open orders if you want to proceed with a new booking.");
INSERT INTO meda_vocabulary VALUES("2456","es","_OPEN_ORDER_NOTICE","Usted tiene una orden que aún no ha pagado! Por favor, espere mientras se procesa su pedido o <a href=index.php?doctor=my_orders>cancelan</a> cualquier orden abierta si desea continuar con una nueva reserva.");
INSERT INTO meda_vocabulary VALUES("2457","de","_OPEN_ORDER_NOTICE","Sie haben eine Bestellung, die noch nicht bezahlt hat! Bitte warten Sie, während Ihre Bestellung bearbeitet oder <a href=index.php?doctor=my_orders>abbrechen</a> alle offenen Aufträge, wenn Sie mit einem neuen Buchungs fortfahren möchten.");
INSERT INTO meda_vocabulary VALUES("2458","en","_OPERATION_BLOCKED","This operation is blocked in Demo Version!");
INSERT INTO meda_vocabulary VALUES("2459","es","_OPERATION_BLOCKED","Esta operación está bloqueada en Versión Demo!");
INSERT INTO meda_vocabulary VALUES("2460","de","_OPERATION_BLOCKED","Dieser Vorgang ist in der Demoversion gesperrt!");
INSERT INTO meda_vocabulary VALUES("2461","en","_OPERATION_COMMON_COMPLETED","The operation has been successfully completed!");
INSERT INTO meda_vocabulary VALUES("2462","es","_OPERATION_COMMON_COMPLETED","La operación se completó con éxito!");
INSERT INTO meda_vocabulary VALUES("2463","de","_OPERATION_COMMON_COMPLETED","Die Operation wurde erfolgreich abgeschlossen!");
INSERT INTO meda_vocabulary VALUES("2464","en","_OPERATION_WAS_ALREADY_COMPLETED","This operation is already completed!");
INSERT INTO meda_vocabulary VALUES("2465","es","_OPERATION_WAS_ALREADY_COMPLETED","Esta operación ya se había terminado!");
INSERT INTO meda_vocabulary VALUES("2466","de","_OPERATION_WAS_ALREADY_COMPLETED","Dieser Vorgang wurde bereits abgeschlossen!");
INSERT INTO meda_vocabulary VALUES("2467","en","_OR","or");
INSERT INTO meda_vocabulary VALUES("2468","es","_OR","o");
INSERT INTO meda_vocabulary VALUES("2469","de","_OR","oder");
INSERT INTO meda_vocabulary VALUES("2470","en","_ORDER","Order");
INSERT INTO meda_vocabulary VALUES("2471","es","_ORDER","Orden");
INSERT INTO meda_vocabulary VALUES("2472","de","_ORDER","Bestellen");
INSERT INTO meda_vocabulary VALUES("2473","en","_ORDERS","Orders");
INSERT INTO meda_vocabulary VALUES("2474","es","_ORDERS","Órdenes");
INSERT INTO meda_vocabulary VALUES("2475","de","_ORDERS","Bestellungen");
INSERT INTO meda_vocabulary VALUES("2476","en","_ORDERS_COUNT","Orders count");
INSERT INTO meda_vocabulary VALUES("2477","es","_ORDERS_COUNT","Órdenes de contar");
INSERT INTO meda_vocabulary VALUES("2478","de","_ORDERS_COUNT","Bestellungen rechnen");
INSERT INTO meda_vocabulary VALUES("2479","en","_ORDERS_MANAGEMENT","Orders Management");
INSERT INTO meda_vocabulary VALUES("2480","es","_ORDERS_MANAGEMENT","Gestión de los pedidos");
INSERT INTO meda_vocabulary VALUES("2481","de","_ORDERS_MANAGEMENT","Bestellungen Management");
INSERT INTO meda_vocabulary VALUES("2482","en","_ORDER_CANCELED","Order Canceled");
INSERT INTO meda_vocabulary VALUES("2483","es","_ORDER_CANCELED","Pedido cancelado");
INSERT INTO meda_vocabulary VALUES("2484","de","_ORDER_CANCELED","Bestellung storniert");
INSERT INTO meda_vocabulary VALUES("2485","en","_ORDER_COMPLETED","Order Completed");
INSERT INTO meda_vocabulary VALUES("2486","es","_ORDER_COMPLETED","Order Completo");
INSERT INTO meda_vocabulary VALUES("2487","de","_ORDER_COMPLETED","Auftrag abgeschlossen");
INSERT INTO meda_vocabulary VALUES("2488","en","_ORDER_DATE","Order Date");
INSERT INTO meda_vocabulary VALUES("2489","es","_ORDER_DATE","Fecha del pedido");
INSERT INTO meda_vocabulary VALUES("2490","de","_ORDER_DATE","Sortierung: Datum");
INSERT INTO meda_vocabulary VALUES("2491","en","_ORDER_DESCRIPTION","Order Description");
INSERT INTO meda_vocabulary VALUES("2492","es","_ORDER_DESCRIPTION","Solicitar Descripción");
INSERT INTO meda_vocabulary VALUES("2493","de","_ORDER_DESCRIPTION","Auftrag Beschreibung");
INSERT INTO meda_vocabulary VALUES("2494","en","_ORDER_DETAILS","Order Details");
INSERT INTO meda_vocabulary VALUES("2495","es","_ORDER_DETAILS","Detalles de pedidos");
INSERT INTO meda_vocabulary VALUES("2496","de","_ORDER_DETAILS","Um Details");
INSERT INTO meda_vocabulary VALUES("2497","en","_ORDER_ERROR","Cannot complete your order! Please try again later.");
INSERT INTO meda_vocabulary VALUES("2498","es","_ORDER_ERROR","No se puede completar su solicitud! Por favor, inténtelo de nuevo más tarde.");
INSERT INTO meda_vocabulary VALUES("2499","de","_ORDER_ERROR","Kann nicht abgeschlossen werden Ihre Bestellung! Bitte versuchen Sie es später erneut.");
INSERT INTO meda_vocabulary VALUES("2500","en","_ORDER_NUMBER","Order number");
INSERT INTO meda_vocabulary VALUES("2501","es","_ORDER_NUMBER","Número de orden");
INSERT INTO meda_vocabulary VALUES("2502","de","_ORDER_NUMBER","Bestell-Nummer");
INSERT INTO meda_vocabulary VALUES("2503","en","_ORDER_PAID_ADMIN_COPY","Order has been paid (admin copy)");
INSERT INTO meda_vocabulary VALUES("2504","es","_ORDER_PAID_ADMIN_COPY","Orden ha sido pagado (admin copia)");
INSERT INTO meda_vocabulary VALUES("2505","de","_ORDER_PAID_ADMIN_COPY","Bestellung bezahlt wurde (admin kopieren)");
INSERT INTO meda_vocabulary VALUES("2506","en","_ORDER_PEPARING_ERROR","An error occurred while preparing the order! Please try again later.");
INSERT INTO meda_vocabulary VALUES("2507","es","_ORDER_PEPARING_ERROR","Se produjo un error mientras se prepara la orden! Por favor, inténtelo de nuevo más tarde.");
INSERT INTO meda_vocabulary VALUES("2508","de","_ORDER_PEPARING_ERROR","Ein Fehler trat bei der Vorbereitung der Bestellung! Bitte versuchen Sie es später erneut.");
INSERT INTO meda_vocabulary VALUES("2509","en","_ORDER_PLACED_MSG","Thank you! The order has been accepted and will be processed shortly.");
INSERT INTO meda_vocabulary VALUES("2510","es","_ORDER_PLACED_MSG","¡Gracias! La orden fue aceptada y se procesan en breve.");
INSERT INTO meda_vocabulary VALUES("2511","de","_ORDER_PLACED_MSG","Vielen Dank! Die Bestellung wurde angenommen und wird in Kürze bearbeitet werden.");
INSERT INTO meda_vocabulary VALUES("2512","en","_ORDER_PLACED_ONLINE_ADMIN_COPY","Online order has been placed (admin copy)");
INSERT INTO meda_vocabulary VALUES("2513","es","_ORDER_PLACED_ONLINE_ADMIN_COPY","Pedido en línea se ha colocado (admin copia)");
INSERT INTO meda_vocabulary VALUES("2514","de","_ORDER_PLACED_ONLINE_ADMIN_COPY","Online Bestellung aufgegeben wurde (admin kopieren)");
INSERT INTO meda_vocabulary VALUES("2515","en","_ORDER_PRICE","Order Price");
INSERT INTO meda_vocabulary VALUES("2516","es","_ORDER_PRICE","Orden de precios");
INSERT INTO meda_vocabulary VALUES("2517","de","_ORDER_PRICE","Bestellen Preis");
INSERT INTO meda_vocabulary VALUES("2518","en","_ORDER_WAS_CANCELED_MSG","Your order has been canceled.");
INSERT INTO meda_vocabulary VALUES("2519","es","_ORDER_WAS_CANCELED_MSG","Su pedido ha sido cancelado.");
INSERT INTO meda_vocabulary VALUES("2520","de","_ORDER_WAS_CANCELED_MSG","Ihre Bestellung wurde storniert.");
INSERT INTO meda_vocabulary VALUES("2521","en","_ORDER_WAS_COMPLETED_MSG","Thank you for purchasing from our site! Your order has been completed.");
INSERT INTO meda_vocabulary VALUES("2522","es","_ORDER_WAS_COMPLETED_MSG","Muchas gracias por comprar en nuestro sitio! Su pedido ha sido completado.");
INSERT INTO meda_vocabulary VALUES("2523","de","_ORDER_WAS_COMPLETED_MSG","Danke für den Kauf von unserer Seite! Ihre Bestellung ist abgeschlossen.");
INSERT INTO meda_vocabulary VALUES("2524","en","_OTHER","Other");
INSERT INTO meda_vocabulary VALUES("2525","es","_OTHER","Otro");
INSERT INTO meda_vocabulary VALUES("2526","de","_OTHER","Anderen");
INSERT INTO meda_vocabulary VALUES("2527","en","_OUR_LOCATION","Our Location");
INSERT INTO meda_vocabulary VALUES("2528","es","_OUR_LOCATION","Nuestra Ubicación");
INSERT INTO meda_vocabulary VALUES("2529","de","_OUR_LOCATION","Unser Standort");
INSERT INTO meda_vocabulary VALUES("2530","en","_OWNER","Owner");
INSERT INTO meda_vocabulary VALUES("2531","es","_OWNER","Propietario");
INSERT INTO meda_vocabulary VALUES("2532","de","_OWNER","Eigentümer");
INSERT INTO meda_vocabulary VALUES("2533","en","_PAGE","Page");
INSERT INTO meda_vocabulary VALUES("2534","es","_PAGE","Página");
INSERT INTO meda_vocabulary VALUES("2535","de","_PAGE","Seite");
INSERT INTO meda_vocabulary VALUES("2536","en","_PAGES","Pages");
INSERT INTO meda_vocabulary VALUES("2537","es","_PAGES","Páginas");
INSERT INTO meda_vocabulary VALUES("2538","de","_PAGES","Seiten");
INSERT INTO meda_vocabulary VALUES("2539","en","_PAGE_ADD_NEW","Add New Page");
INSERT INTO meda_vocabulary VALUES("2540","es","_PAGE_ADD_NEW","Add New Page");
INSERT INTO meda_vocabulary VALUES("2541","de","_PAGE_ADD_NEW","Neue Seite hinzufügen");
INSERT INTO meda_vocabulary VALUES("2542","en","_PAGE_CREATED","Page has been successfully created");
INSERT INTO meda_vocabulary VALUES("2543","es","_PAGE_CREATED","La página se ha creado correctamente");
INSERT INTO meda_vocabulary VALUES("2544","de","_PAGE_CREATED","Seite wurde erfolgreich erstellt");
INSERT INTO meda_vocabulary VALUES("2545","en","_PAGE_DELETED","Page has been successfully deleted");
INSERT INTO meda_vocabulary VALUES("2546","es","_PAGE_DELETED","Page ha sido borrado");
INSERT INTO meda_vocabulary VALUES("2547","de","_PAGE_DELETED","Seite wurde erfolgreich gelöscht");
INSERT INTO meda_vocabulary VALUES("2548","en","_PAGE_DELETE_WARNING","Are you sure you want to delete this page?");
INSERT INTO meda_vocabulary VALUES("2549","es","_PAGE_DELETE_WARNING","¿Estás seguro de que deseas eliminar esta página?");
INSERT INTO meda_vocabulary VALUES("2550","de","_PAGE_DELETE_WARNING","Sind Sie sicher, dass Sie diese Seite wirklich löschen?");
INSERT INTO meda_vocabulary VALUES("2551","en","_PAGE_EDIT_HOME","Edit Home Page");
INSERT INTO meda_vocabulary VALUES("2552","es","_PAGE_EDIT_HOME","Editar Home Page");
INSERT INTO meda_vocabulary VALUES("2553","de","_PAGE_EDIT_HOME","Bearbeiten Home Page");
INSERT INTO meda_vocabulary VALUES("2554","en","_PAGE_EDIT_PAGES","Edit Pages");
INSERT INTO meda_vocabulary VALUES("2555","es","_PAGE_EDIT_PAGES","Editar páginas");
INSERT INTO meda_vocabulary VALUES("2556","de","_PAGE_EDIT_PAGES","Bearbeiten Seiten");
INSERT INTO meda_vocabulary VALUES("2557","en","_PAGE_EDIT_SYS_PAGES","Edit System Pages");
INSERT INTO meda_vocabulary VALUES("2558","es","_PAGE_EDIT_SYS_PAGES","Editar páginas del sistema");
INSERT INTO meda_vocabulary VALUES("2559","de","_PAGE_EDIT_SYS_PAGES","Edit System Seiten");
INSERT INTO meda_vocabulary VALUES("2560","en","_PAGE_EXPIRED","The page you requested has expired!");
INSERT INTO meda_vocabulary VALUES("2561","es","_PAGE_EXPIRED","Página solicitada ha caducado!");
INSERT INTO meda_vocabulary VALUES("2562","de","_PAGE_EXPIRED","Der von Ihnen angeforderte Seite ist abgelaufen!");
INSERT INTO meda_vocabulary VALUES("2563","en","_PAGE_HEADER","Page Header");
INSERT INTO meda_vocabulary VALUES("2564","es","_PAGE_HEADER","Encabezado de página");
INSERT INTO meda_vocabulary VALUES("2565","de","_PAGE_HEADER","Seitenkopf");
INSERT INTO meda_vocabulary VALUES("2566","en","_PAGE_HEADER_EMPTY","Page header cannot be empty!");
INSERT INTO meda_vocabulary VALUES("2567","es","_PAGE_HEADER_EMPTY","Cabecera de la página no puede estar vacía!");
INSERT INTO meda_vocabulary VALUES("2568","de","_PAGE_HEADER_EMPTY","Page Header kann nicht leer sein!");
INSERT INTO meda_vocabulary VALUES("2569","en","_PAGE_KEY_EMPTY","Page key cannot be empty!");
INSERT INTO meda_vocabulary VALUES("2570","es","_PAGE_KEY_EMPTY","Page clave no puede estar vacía!");
INSERT INTO meda_vocabulary VALUES("2571","de","_PAGE_KEY_EMPTY","Page-Taste kann nicht leer sein!");
INSERT INTO meda_vocabulary VALUES("2572","en","_PAGE_LINK_TOO_LONG","Menu link too long!");
INSERT INTO meda_vocabulary VALUES("2573","es","_PAGE_LINK_TOO_LONG","Enlace del menú demasiado tiempo!");
INSERT INTO meda_vocabulary VALUES("2574","de","_PAGE_LINK_TOO_LONG","Link Menu zu lang!");
INSERT INTO meda_vocabulary VALUES("2575","en","_PAGE_MANAGEMENT","Pages Management");
INSERT INTO meda_vocabulary VALUES("2576","es","_PAGE_MANAGEMENT","Páginas de Gestión de");
INSERT INTO meda_vocabulary VALUES("2577","de","_PAGE_MANAGEMENT","Seiten-Management");
INSERT INTO meda_vocabulary VALUES("2578","en","_PAGE_NOT_CREATED","Page has not been created!");
INSERT INTO meda_vocabulary VALUES("2579","es","_PAGE_NOT_CREATED","La página no ha sido creado!");
INSERT INTO meda_vocabulary VALUES("2580","de","_PAGE_NOT_CREATED","Seite wurde nicht erstellt!");
INSERT INTO meda_vocabulary VALUES("2581","en","_PAGE_NOT_DELETED","Page has not been deleted!");
INSERT INTO meda_vocabulary VALUES("2582","es","_PAGE_NOT_DELETED","La página no se ha eliminado!");
INSERT INTO meda_vocabulary VALUES("2583","de","_PAGE_NOT_DELETED","Seite wurde nicht gelöscht!");
INSERT INTO meda_vocabulary VALUES("2584","en","_PAGE_NOT_EXISTS","The page you attempted to access does not exist.");
INSERT INTO meda_vocabulary VALUES("2585","es","_PAGE_NOT_EXISTS","La página que intenta acceder no existe.");
INSERT INTO meda_vocabulary VALUES("2586","de","_PAGE_NOT_EXISTS","Die Seite, die Sie aufrufen wollten, existiert nicht.");
INSERT INTO meda_vocabulary VALUES("2587","en","_PAGE_NOT_FOUND","No Pages Found");
INSERT INTO meda_vocabulary VALUES("2588","es","_PAGE_NOT_FOUND","No se han encontrado páginas");
INSERT INTO meda_vocabulary VALUES("2589","de","_PAGE_NOT_FOUND","Keine Seiten gefunden");
INSERT INTO meda_vocabulary VALUES("2590","en","_PAGE_NOT_SAVED","Page has not been saved!");
INSERT INTO meda_vocabulary VALUES("2591","es","_PAGE_NOT_SAVED","La página no se salvó!");
INSERT INTO meda_vocabulary VALUES("2592","de","_PAGE_NOT_SAVED","Diese Seite wurde nicht gespart!");
INSERT INTO meda_vocabulary VALUES("2593","en","_PAGE_ORDER_CHANGED","Page order has been successfully changed!");
INSERT INTO meda_vocabulary VALUES("2594","es","_PAGE_ORDER_CHANGED","Orden de las páginas se ha cambiado correctamente!");
INSERT INTO meda_vocabulary VALUES("2595","de","_PAGE_ORDER_CHANGED","Page Bestellung wurde erfolgreich geändert!");
INSERT INTO meda_vocabulary VALUES("2596","en","_PAGE_REMOVED","Page has been successfully removed!");
INSERT INTO meda_vocabulary VALUES("2597","es","_PAGE_REMOVED","Page se ha eliminado correctamente!");
INSERT INTO meda_vocabulary VALUES("2598","de","_PAGE_REMOVED","Diese Seite wurde erfolgreich entfernt!");
INSERT INTO meda_vocabulary VALUES("2599","en","_PAGE_REMOVE_WARNING","Are you sure you want move this page to the Trash?");
INSERT INTO meda_vocabulary VALUES("2600","es","_PAGE_REMOVE_WARNING","¿Está seguro que desea mover este pagina a la papelera?");
INSERT INTO meda_vocabulary VALUES("2601","de","_PAGE_REMOVE_WARNING","Sie sind sicher, dass Sie bewegen Sie diese Seite in den Papierkorb?");
INSERT INTO meda_vocabulary VALUES("2602","en","_PAGE_RESTORED","Page has been successfully restored!");
INSERT INTO meda_vocabulary VALUES("2603","es","_PAGE_RESTORED","Page fue restaurado con éxito!");
INSERT INTO meda_vocabulary VALUES("2604","de","_PAGE_RESTORED","Diese Seite wurde erfolgreich wiederhergestellt!");
INSERT INTO meda_vocabulary VALUES("2605","en","_PAGE_RESTORE_WARNING","Are you sure you want to restore this page?");
INSERT INTO meda_vocabulary VALUES("2606","es","_PAGE_RESTORE_WARNING","¿Estás seguro de que desea restaurar esta página?");
INSERT INTO meda_vocabulary VALUES("2607","de","_PAGE_RESTORE_WARNING","Sind Sie sicher, dass Sie diese Seite wiederherstellen?");
INSERT INTO meda_vocabulary VALUES("2608","en","_PAGE_SAVED","Page has been successfully saved");
INSERT INTO meda_vocabulary VALUES("2609","es","_PAGE_SAVED","La página se ha guardado correctamente");
INSERT INTO meda_vocabulary VALUES("2610","de","_PAGE_SAVED","Diese Seite wurde erfolgreich gespeichert");
INSERT INTO meda_vocabulary VALUES("2611","en","_PAGE_TEXT","Page text");
INSERT INTO meda_vocabulary VALUES("2612","es","_PAGE_TEXT","Las páginas de texto");
INSERT INTO meda_vocabulary VALUES("2613","de","_PAGE_TEXT","Seite Text");
INSERT INTO meda_vocabulary VALUES("2614","en","_PAGE_UNKNOWN","Unknown page!");
INSERT INTO meda_vocabulary VALUES("2615","es","_PAGE_UNKNOWN","Página desconocido!");
INSERT INTO meda_vocabulary VALUES("2616","de","_PAGE_UNKNOWN","Unbekannte Seite!");
INSERT INTO meda_vocabulary VALUES("2617","en","_PAID","Paid");
INSERT INTO meda_vocabulary VALUES("2618","es","_PAID","Pagado");
INSERT INTO meda_vocabulary VALUES("2619","de","_PAID","Bezahlt");
INSERT INTO meda_vocabulary VALUES("2620","en","_PARAMETER","Parameter");
INSERT INTO meda_vocabulary VALUES("2621","es","_PARAMETER","Parámetro");
INSERT INTO meda_vocabulary VALUES("2622","de","_PARAMETER","Parameter");
INSERT INTO meda_vocabulary VALUES("2623","en","_PASSWORD","Password");
INSERT INTO meda_vocabulary VALUES("2624","es","_PASSWORD","Contraseña");
INSERT INTO meda_vocabulary VALUES("2625","de","_PASSWORD","Kennwort");
INSERT INTO meda_vocabulary VALUES("2626","en","_PASSWORD_ALREADY_SENT","Password has been already sent to your email. Please try again later.");
INSERT INTO meda_vocabulary VALUES("2627","es","_PASSWORD_ALREADY_SENT","Contraseña era ya ha sido enviada a su correo electrónico. Por favor, inténtelo de nuevo más tarde.");
INSERT INTO meda_vocabulary VALUES("2628","de","_PASSWORD_ALREADY_SENT","Passwort wurde bereits auf Ihre E-Mail geschickt. Bitte versuchen Sie es später erneut.");
INSERT INTO meda_vocabulary VALUES("2629","en","_PASSWORD_CHANGED","Password has been successfully changed.");
INSERT INTO meda_vocabulary VALUES("2630","es","_PASSWORD_CHANGED","Contraseña se ha cambiado correctamente.");
INSERT INTO meda_vocabulary VALUES("2631","de","_PASSWORD_CHANGED","Kennwort wurde erfolgreich geändert");
INSERT INTO meda_vocabulary VALUES("2632","en","_PASSWORD_DO_NOT_MATCH","Password and confirmation do not match!");
INSERT INTO meda_vocabulary VALUES("2633","es","_PASSWORD_DO_NOT_MATCH","Contraseña y la confirmación no coinciden!");
INSERT INTO meda_vocabulary VALUES("2634","de","_PASSWORD_DO_NOT_MATCH","Kennwort und Bestätigung stimmen nicht überein!");
INSERT INTO meda_vocabulary VALUES("2635","en","_PASSWORD_FORGOTTEN","Forgotten Password");
INSERT INTO meda_vocabulary VALUES("2636","es","_PASSWORD_FORGOTTEN","He olvidado la contraseña");
INSERT INTO meda_vocabulary VALUES("2637","de","_PASSWORD_FORGOTTEN","Passwort vergessen?");
INSERT INTO meda_vocabulary VALUES("2638","en","_PASSWORD_FORGOTTEN_PAGE_MSG","Use a valid administrator e-mail to restore your password to the Administrator Back-End.<br><br>Return to site <a href=\'index.php\'>Home Page</a><br><br><img align=\'center\' src=\'images/password.png\' alt=\'password\' width=\'92px\'>");
INSERT INTO meda_vocabulary VALUES("2639","es","_PASSWORD_FORGOTTEN_PAGE_MSG","Utilice un administrador de correo electrónico válida para restablecer su contraseña en el Administrador de servicios de fondo. <br> Volver a la página<a href=\'index.php\'>Home Page</a><br><br><img align=\'center\' src=\'images/password.png\' alt=\'password\' width=\'92px\'>");
INSERT INTO meda_vocabulary VALUES("2640","de","_PASSWORD_FORGOTTEN_PAGE_MSG","Verwenden Sie eine gültige E-Mail-Administrator das Passwort zum Administrator-Back-End zu wiederherzustellen.<br><br>Zurück zur Website <a href=\'index.php\'>Homepage</a><br><br><img align=\'center\' src=\'images/password.png\' alt=\'password\' width=\'92px\'>");
INSERT INTO meda_vocabulary VALUES("2641","en","_PASSWORD_IS_EMPTY","Passwords must not be empty and at least six (6) characters in length!");
INSERT INTO meda_vocabulary VALUES("2642","es","_PASSWORD_IS_EMPTY","Las contraseñas no deben estar vacías y por lo menos seis (6) caracteres de longitud!");
INSERT INTO meda_vocabulary VALUES("2643","de","_PASSWORD_IS_EMPTY","Passwörter dürfen nicht leer sein und mindestens sechs (6) Zeichen lang sein!");
INSERT INTO meda_vocabulary VALUES("2644","en","_PASSWORD_NOT_CHANGED","Password has not been changed. Please try again!");
INSERT INTO meda_vocabulary VALUES("2645","es","_PASSWORD_NOT_CHANGED","La contraseña no ha cambiado. Por favor, inténtelo de nuevo!");
INSERT INTO meda_vocabulary VALUES("2646","de","_PASSWORD_NOT_CHANGED","Passwort wurde nicht geändert. Bitte versuchen Sie es erneut!");
INSERT INTO meda_vocabulary VALUES("2647","en","_PASSWORD_RECOVERY_MSG","To recover your password, please enter your e-mail address and a link will be emailed to you.");
INSERT INTO meda_vocabulary VALUES("2648","es","_PASSWORD_RECOVERY_MSG","Para recuperar su contraseña, por favor, introduzca su dirección de correo electrónico y un enlace será enviada a usted.");
INSERT INTO meda_vocabulary VALUES("2649","de","_PASSWORD_RECOVERY_MSG","Um Ihr Kennwort ein, geben Sie bitte Ihre E-Mail-Adresse und einem Link wird an Sie geschickt wird.");
INSERT INTO meda_vocabulary VALUES("2650","en","_PASSWORD_SUCCESSFULLY_SENT","Your password has been successfully sent to the email address.");
INSERT INTO meda_vocabulary VALUES("2651","es","_PASSWORD_SUCCESSFULLY_SENT","Su contraseña ha sido enviado con éxito a la dirección de correo electrónico.");
INSERT INTO meda_vocabulary VALUES("2652","de","_PASSWORD_SUCCESSFULLY_SENT","Ihr Passwort wurde erfolgreich an die Email-Adresse gesendet.");
INSERT INTO meda_vocabulary VALUES("2653","en","_PATIENT","Patient");
INSERT INTO meda_vocabulary VALUES("2654","es","_PATIENT","Paciente");
INSERT INTO meda_vocabulary VALUES("2655","de","_PATIENT","Patient");
INSERT INTO meda_vocabulary VALUES("2656","en","_PATIENTS","Patients");
INSERT INTO meda_vocabulary VALUES("2657","es","_PATIENTS","Los Pacientes");
INSERT INTO meda_vocabulary VALUES("2658","de","_PATIENTS","Die Patienten");
INSERT INTO meda_vocabulary VALUES("2659","en","_PATIENTS_AWAITING_MODERATION_ALERT","There are _COUNT_ patient/s awaiting approval of registration. Click <a href=\'index.php?admin=mod_patients_management\'>here</a> for review.");
INSERT INTO meda_vocabulary VALUES("2660","es","_PATIENTS_AWAITING_MODERATION_ALERT","Hay _COUNT_ paciente/s en espera de su aprobación. Haga clic <a href=\'index.php?admin=mod_patients_management\'>aquí</a> para su revisión.");
INSERT INTO meda_vocabulary VALUES("2661","de","_PATIENTS_AWAITING_MODERATION_ALERT","Es gibt _COUNT_ Patient/en Erwartung Ihrer Zustimmung. Klicken Sie <a href=\'index.php?admin=mod_patients_management\'>hier</a> für die Überprüfung.");
INSERT INTO meda_vocabulary VALUES("2662","en","_PATIENTS_MANAGEMENT","Patients Management");
INSERT INTO meda_vocabulary VALUES("2663","es","_PATIENTS_MANAGEMENT","Gestión de pacientes");
INSERT INTO meda_vocabulary VALUES("2664","de","_PATIENTS_MANAGEMENT","Die Patienten-Management");
INSERT INTO meda_vocabulary VALUES("2665","en","_PATIENTS_RATING","Patients Rating");
INSERT INTO meda_vocabulary VALUES("2666","es","_PATIENTS_RATING","Pacientes Puntuación");
INSERT INTO meda_vocabulary VALUES("2667","de","_PATIENTS_RATING","Patienten-Bewertung");
INSERT INTO meda_vocabulary VALUES("2668","en","_PATIENTS_SETTINGS","Patients Settings");
INSERT INTO meda_vocabulary VALUES("2669","es","_PATIENTS_SETTINGS","Configuración de los pacientes");
INSERT INTO meda_vocabulary VALUES("2670","de","_PATIENTS_SETTINGS","Patienten-Einstellungen");
INSERT INTO meda_vocabulary VALUES("2671","en","_PATIENT_APPOINTMENT_ACCEPTED","Patient Appointment has been accepted and approved!");
INSERT INTO meda_vocabulary VALUES("2672","es","_PATIENT_APPOINTMENT_ACCEPTED","Cita del paciente se ha colocado y aceptadoPatient appointment has been placed and accepted");
INSERT INTO meda_vocabulary VALUES("2673","de","_PATIENT_APPOINTMENT_ACCEPTED","Patient Termin gelegt worden und akzeptiert");
INSERT INTO meda_vocabulary VALUES("2674","en","_PATIENT_ARRIVAL_REMINDER_EMAIL","Patient Arrival Reminder Email");
INSERT INTO meda_vocabulary VALUES("2675","es","_PATIENT_ARRIVAL_REMINDER_EMAIL","Llegada Paciente Email Reminder");
INSERT INTO meda_vocabulary VALUES("2676","de","_PATIENT_ARRIVAL_REMINDER_EMAIL","Patienten Ankunft Reminder Email");
INSERT INTO meda_vocabulary VALUES("2677","en","_PATIENT_CONFIRMED_APPOINTMENT","Patient has confirmed appointment");
INSERT INTO meda_vocabulary VALUES("2678","es","_PATIENT_CONFIRMED_APPOINTMENT","El paciente ha confirmado cita");
INSERT INTO meda_vocabulary VALUES("2679","de","_PATIENT_CONFIRMED_APPOINTMENT","Patient hat Ernennung bestätigt");
INSERT INTO meda_vocabulary VALUES("2680","en","_PATIENT_CONFIRM_REMINDER_EMAIL","Patient Confirm Reminder Email");
INSERT INTO meda_vocabulary VALUES("2681","es","_PATIENT_CONFIRM_REMINDER_EMAIL","Paciente Confirmar Email Reminder");
INSERT INTO meda_vocabulary VALUES("2682","de","_PATIENT_CONFIRM_REMINDER_EMAIL","Patienten bestätigen Reminder Email");
INSERT INTO meda_vocabulary VALUES("2683","en","_PATIENT_GROUP","Patient Group");
INSERT INTO meda_vocabulary VALUES("2684","es","_PATIENT_GROUP","Paciente Grupo");
INSERT INTO meda_vocabulary VALUES("2685","de","_PATIENT_GROUP","Patienten-Gruppe");
INSERT INTO meda_vocabulary VALUES("2686","en","_PATIENT_GROUPS","Patient Groups");
INSERT INTO meda_vocabulary VALUES("2687","es","_PATIENT_GROUPS","Grupos de pacientes");
INSERT INTO meda_vocabulary VALUES("2688","de","_PATIENT_GROUPS","Patientengruppen");
INSERT INTO meda_vocabulary VALUES("2689","en","_PATIENT_INFO","Patient Info");
INSERT INTO meda_vocabulary VALUES("2690","es","_PATIENT_INFO","Información del Paciente");
INSERT INTO meda_vocabulary VALUES("2691","de","_PATIENT_INFO","Patienten-Info");
INSERT INTO meda_vocabulary VALUES("2692","en","_PATIENT_LOGIN","Patient Login");
INSERT INTO meda_vocabulary VALUES("2693","es","_PATIENT_LOGIN","Inicio de Sesión");
INSERT INTO meda_vocabulary VALUES("2694","de","_PATIENT_LOGIN","Patienten Anmelden");
INSERT INTO meda_vocabulary VALUES("2695","en","_PATIENT_NOTES","Patient Notes");
INSERT INTO meda_vocabulary VALUES("2696","es","_PATIENT_NOTES","Toma nota de los pacientes");
INSERT INTO meda_vocabulary VALUES("2697","de","_PATIENT_NOTES","Patienten Hinweise");
INSERT INTO meda_vocabulary VALUES("2698","en","_PATIENT_REQUESTED_APPOINTMENT","Patient has requested appointment");
INSERT INTO meda_vocabulary VALUES("2699","es","_PATIENT_REQUESTED_APPOINTMENT","Paciente ha solicitado cita");
INSERT INTO meda_vocabulary VALUES("2700","de","_PATIENT_REQUESTED_APPOINTMENT","Patient Termin beantragt");
INSERT INTO meda_vocabulary VALUES("2701","en","_PAYED_BY","Payed by");
INSERT INTO meda_vocabulary VALUES("2702","es","_PAYED_BY","Pagado por");
INSERT INTO meda_vocabulary VALUES("2703","de","_PAYED_BY","Bezahlt per");
INSERT INTO meda_vocabulary VALUES("2704","en","_PAYMENTS","Payments");
INSERT INTO meda_vocabulary VALUES("2705","es","_PAYMENTS","Pagos");
INSERT INTO meda_vocabulary VALUES("2706","de","_PAYMENTS","Zahlungen");
INSERT INTO meda_vocabulary VALUES("2707","en","_PAYMENTS_SETTINGS","Payment Settings");
INSERT INTO meda_vocabulary VALUES("2708","es","_PAYMENTS_SETTINGS","Configuración de pagos");
INSERT INTO meda_vocabulary VALUES("2709","de","_PAYMENTS_SETTINGS","Zahlungseinstellungen");
INSERT INTO meda_vocabulary VALUES("2710","en","_PAYMENT_COMPANY_ACCOUNT","Payment Company Account");
INSERT INTO meda_vocabulary VALUES("2711","es","_PAYMENT_COMPANY_ACCOUNT","Pago de cuenta de la compañía");
INSERT INTO meda_vocabulary VALUES("2712","de","_PAYMENT_COMPANY_ACCOUNT","Zahlung Firmenkonto");
INSERT INTO meda_vocabulary VALUES("2713","en","_PAYMENT_DATE","Payment Date");
INSERT INTO meda_vocabulary VALUES("2714","es","_PAYMENT_DATE","Fecha de Pago");
INSERT INTO meda_vocabulary VALUES("2715","de","_PAYMENT_DATE","Zahltag");
INSERT INTO meda_vocabulary VALUES("2716","en","_PAYMENT_METHOD","Payment Method");
INSERT INTO meda_vocabulary VALUES("2717","es","_PAYMENT_METHOD","Forma de Pago");
INSERT INTO meda_vocabulary VALUES("2718","de","_PAYMENT_METHOD","Zahlungsweise");
INSERT INTO meda_vocabulary VALUES("2719","en","_PAYMENT_SUM","Payment Sum");
INSERT INTO meda_vocabulary VALUES("2720","es","_PAYMENT_SUM","Pago de Suma");
INSERT INTO meda_vocabulary VALUES("2721","de","_PAYMENT_SUM","Die Zahlung Sum");
INSERT INTO meda_vocabulary VALUES("2722","en","_PAYMENT_TYPE","Payment Type");
INSERT INTO meda_vocabulary VALUES("2723","es","_PAYMENT_TYPE","Tipo de Pago");
INSERT INTO meda_vocabulary VALUES("2724","de","_PAYMENT_TYPE","Zahlungsart");
INSERT INTO meda_vocabulary VALUES("2725","en","_PAYPAL","PayPal");
INSERT INTO meda_vocabulary VALUES("2726","es","_PAYPAL","PayPal");
INSERT INTO meda_vocabulary VALUES("2727","de","_PAYPAL","PayPal");
INSERT INTO meda_vocabulary VALUES("2728","en","_PAYPAL_NOTICE","Save time. Pay securely using your stored payment information.<br />Pay with <b>credit card</b>, <b>bank account</b> or <b>PayPal</b> account balance.");
INSERT INTO meda_vocabulary VALUES("2729","es","_PAYPAL_NOTICE","Ahorre tiempo. Pague con seguridad con su información almacenada pago.<br /> Pago con <b>tarjeta de crédito</b>, <b> cuenta bancaria</b> o <b>PayPal</b> saldo de la cuenta.");
INSERT INTO meda_vocabulary VALUES("2730","de","_PAYPAL_NOTICE","Sparen Sie Zeit. Sicher bezahlen mit Ihrer gespeicherten Zahlungsinformationen. <br />Bezahlen mit <b>Kreditkarte, Bankkonto</b> oder <b>PayPal-Guthaben.</b>");
INSERT INTO meda_vocabulary VALUES("2731","en","_PAYPAL_ORDER","PayPal Order");
INSERT INTO meda_vocabulary VALUES("2732","es","_PAYPAL_ORDER","PayPal Orden");
INSERT INTO meda_vocabulary VALUES("2733","de","_PAYPAL_ORDER","PayPal Auftrag");
INSERT INTO meda_vocabulary VALUES("2734","en","_PC_ACCOUNT_TYPE_TEXT","the type of account");
INSERT INTO meda_vocabulary VALUES("2735","es","_PC_ACCOUNT_TYPE_TEXT","el tipo de cuenta");
INSERT INTO meda_vocabulary VALUES("2736","de","_PC_ACCOUNT_TYPE_TEXT","die Art des Kontos");
INSERT INTO meda_vocabulary VALUES("2737","en","_PC_APPOINTMENT_DETAILS_TEXT","important information about appointment");
INSERT INTO meda_vocabulary VALUES("2738","es","_PC_APPOINTMENT_DETAILS_TEXT","información importante acerca de la designación");
INSERT INTO meda_vocabulary VALUES("2739","de","_PC_APPOINTMENT_DETAILS_TEXT","wichtige Informationen über die Ernennung");
INSERT INTO meda_vocabulary VALUES("2740","en","_PC_APPOINTMENT_NUMBER_TEXT","the code of appointment");
INSERT INTO meda_vocabulary VALUES("2741","es","_PC_APPOINTMENT_NUMBER_TEXT","el código de la cita");
INSERT INTO meda_vocabulary VALUES("2742","de","_PC_APPOINTMENT_NUMBER_TEXT","der Code der Ernennung");
INSERT INTO meda_vocabulary VALUES("2743","en","_PC_EVENT_TEXT","the title of event");
INSERT INTO meda_vocabulary VALUES("2744","es","_PC_EVENT_TEXT","el título del evento");
INSERT INTO meda_vocabulary VALUES("2745","de","_PC_EVENT_TEXT","der Titel der Veranstaltung");
INSERT INTO meda_vocabulary VALUES("2746","en","_PC_FIRST_NAME_TEXT","the first name of patient or admin");
INSERT INTO meda_vocabulary VALUES("2747","es","_PC_FIRST_NAME_TEXT","el primer nombre del paciente o de administración");
INSERT INTO meda_vocabulary VALUES("2748","de","_PC_FIRST_NAME_TEXT","der erste Name des Patienten oder admin");
INSERT INTO meda_vocabulary VALUES("2749","en","_PC_HOURS_TEXT","number of hours");
INSERT INTO meda_vocabulary VALUES("2750","es","_PC_HOURS_TEXT","número de horas");
INSERT INTO meda_vocabulary VALUES("2751","de","_PC_HOURS_TEXT","Anzahl der Stunden");
INSERT INTO meda_vocabulary VALUES("2752","en","_PC_LAST_NAME_TEXT","the last name of user or admin");
INSERT INTO meda_vocabulary VALUES("2753","es","_PC_LAST_NAME_TEXT","el apellido del usuario o admin");
INSERT INTO meda_vocabulary VALUES("2754","de","_PC_LAST_NAME_TEXT","der Nachname des Benutzers oder admin");
INSERT INTO meda_vocabulary VALUES("2755","en","_PC_REGISTRATION_CODE_TEXT","confirmation code for new account");
INSERT INTO meda_vocabulary VALUES("2756","es","_PC_REGISTRATION_CODE_TEXT","código de confirmación para la nueva cuenta");
INSERT INTO meda_vocabulary VALUES("2757","de","_PC_REGISTRATION_CODE_TEXT","Bestätigungs-Code für neues Konto");
INSERT INTO meda_vocabulary VALUES("2758","en","_PC_USER_EMAIL_TEXT","email of user");
INSERT INTO meda_vocabulary VALUES("2759","es","_PC_USER_EMAIL_TEXT","correo electrónico del usuario");
INSERT INTO meda_vocabulary VALUES("2760","de","_PC_USER_EMAIL_TEXT","E-Mail an Benutzer");
INSERT INTO meda_vocabulary VALUES("2761","en","_PC_USER_NAME_TEXT","username (login) of user");
INSERT INTO meda_vocabulary VALUES("2762","es","_PC_USER_NAME_TEXT","nombre de usuario (login) del usuario");
INSERT INTO meda_vocabulary VALUES("2763","de","_PC_USER_NAME_TEXT","Benutzername (Login) des Benutzers");
INSERT INTO meda_vocabulary VALUES("2764","en","_PC_USER_PASSWORD_TEXT","password for user or admin");
INSERT INTO meda_vocabulary VALUES("2765","es","_PC_USER_PASSWORD_TEXT","clave para el usuario o administrador");
INSERT INTO meda_vocabulary VALUES("2766","de","_PC_USER_PASSWORD_TEXT","Kennwort für den Benutzer oder Administrator");
INSERT INTO meda_vocabulary VALUES("2767","en","_PC_WEB_SITE_BASED_URL_TEXT","web site base url");
INSERT INTO meda_vocabulary VALUES("2768","es","_PC_WEB_SITE_BASED_URL_TEXT","sitio web, base de url");
INSERT INTO meda_vocabulary VALUES("2769","de","_PC_WEB_SITE_BASED_URL_TEXT","Website Basis-URL");
INSERT INTO meda_vocabulary VALUES("2770","en","_PC_WEB_SITE_URL_TEXT","web site url");
INSERT INTO meda_vocabulary VALUES("2771","es","_PC_WEB_SITE_URL_TEXT","URL del sitio web");
INSERT INTO meda_vocabulary VALUES("2772","de","_PC_WEB_SITE_URL_TEXT","Website eintragen");
INSERT INTO meda_vocabulary VALUES("2773","en","_PC_YEAR_TEXT","current year in YYYY format");
INSERT INTO meda_vocabulary VALUES("2774","es","_PC_YEAR_TEXT","del año en curso en formato AAAA");
INSERT INTO meda_vocabulary VALUES("2775","de","_PC_YEAR_TEXT","laufenden Jahr im Format YYYY");
INSERT INTO meda_vocabulary VALUES("2776","en","_PD_PAYMENT_MODULES","Patients, Doctors & Payments");
INSERT INTO meda_vocabulary VALUES("2777","es","_PD_PAYMENT_MODULES","Patienten, Ärzte und Zahlungen");
INSERT INTO meda_vocabulary VALUES("2778","de","_PD_PAYMENT_MODULES","Pacientes, Médicos y Pagos");
INSERT INTO meda_vocabulary VALUES("2779","en","_PENDING","Pending");
INSERT INTO meda_vocabulary VALUES("2780","es","_PENDING","Pendiente");
INSERT INTO meda_vocabulary VALUES("2781","de","_PENDING","Anstehend");
INSERT INTO meda_vocabulary VALUES("2782","en","_PERFORM_OPERATION_COMMON_ALERT","Are you sure you want to perform this operation?");
INSERT INTO meda_vocabulary VALUES("2783","es","_PERFORM_OPERATION_COMMON_ALERT","¿Está seguro que desea llevar a cabo esta operación?");
INSERT INTO meda_vocabulary VALUES("2784","de","_PERFORM_OPERATION_COMMON_ALERT","Sie sind Sicher, dass. she Diesen Vorgang?");
INSERT INTO meda_vocabulary VALUES("2785","en","_PERSONAL_DETAILS","Personal Details");
INSERT INTO meda_vocabulary VALUES("2786","es","_PERSONAL_DETAILS","Datos personales");
INSERT INTO meda_vocabulary VALUES("2787","de","_PERSONAL_DETAILS","Persönliche Daten");
INSERT INTO meda_vocabulary VALUES("2788","en","_PERSONAL_INFORMATION","Personal Information");
INSERT INTO meda_vocabulary VALUES("2789","es","_PERSONAL_INFORMATION","Información Personal");
INSERT INTO meda_vocabulary VALUES("2790","de","_PERSONAL_INFORMATION","Persönliche Informationen");
INSERT INTO meda_vocabulary VALUES("2791","en","_PHONE","Phone");
INSERT INTO meda_vocabulary VALUES("2792","es","_PHONE","Teléfono");
INSERT INTO meda_vocabulary VALUES("2793","de","_PHONE","Telefon");
INSERT INTO meda_vocabulary VALUES("2794","en","_PHONES","Phones");
INSERT INTO meda_vocabulary VALUES("2795","es","_PHONES","Teléfonos");
INSERT INTO meda_vocabulary VALUES("2796","de","_PHONES","Telefone");
INSERT INTO meda_vocabulary VALUES("2797","en","_PHOTO","Photo");
INSERT INTO meda_vocabulary VALUES("2798","es","_PHOTO","Foto");
INSERT INTO meda_vocabulary VALUES("2799","de","_PHOTO","Foto");
INSERT INTO meda_vocabulary VALUES("2800","en","_PLACEMENT","Placement");
INSERT INTO meda_vocabulary VALUES("2801","es","_PLACEMENT","Colocación");
INSERT INTO meda_vocabulary VALUES("2802","de","_PLACEMENT","Platzierung");
INSERT INTO meda_vocabulary VALUES("2803","en","_PLACE_ORDER","Place Order");
INSERT INTO meda_vocabulary VALUES("2804","es","_PLACE_ORDER","Lugar Orden");
INSERT INTO meda_vocabulary VALUES("2805","de","_PLACE_ORDER","Bestellung aufgeben");
INSERT INTO meda_vocabulary VALUES("2806","en","_PLAN","Plan");
INSERT INTO meda_vocabulary VALUES("2807","es","_PLAN","Plan");
INSERT INTO meda_vocabulary VALUES("2808","de","_PLAN","Plan");
INSERT INTO meda_vocabulary VALUES("2809","en","_PLAY","Play");
INSERT INTO meda_vocabulary VALUES("2810","es","_PLAY","Jugar");
INSERT INTO meda_vocabulary VALUES("2811","de","_PLAY","Spielen");
INSERT INTO meda_vocabulary VALUES("2812","en","_POPULARITY","Popularity");
INSERT INTO meda_vocabulary VALUES("2813","es","_POPULARITY","Popularidad");
INSERT INTO meda_vocabulary VALUES("2814","de","_POPULARITY","Beliebtheit");
INSERT INTO meda_vocabulary VALUES("2815","en","_POPULAR_SEARCH","Popular Search");
INSERT INTO meda_vocabulary VALUES("2816","es","_POPULAR_SEARCH","Popular Buscar");
INSERT INTO meda_vocabulary VALUES("2817","de","_POPULAR_SEARCH","Beliebte Suchen");
INSERT INTO meda_vocabulary VALUES("2818","en","_POSTED_ON","Posted on");
INSERT INTO meda_vocabulary VALUES("2819","es","_POSTED_ON","Publicado en");
INSERT INTO meda_vocabulary VALUES("2820","de","_POSTED_ON","Posted on");
INSERT INTO meda_vocabulary VALUES("2821","en","_POST_COM_REGISTERED_ALERT","Your need to be registered to post comments.");
INSERT INTO meda_vocabulary VALUES("2822","es","_POST_COM_REGISTERED_ALERT","Su necesidad de estar registrado para enviar comentarios.");
INSERT INTO meda_vocabulary VALUES("2823","de","_POST_COM_REGISTERED_ALERT","Your need to be registered to post comments.");
INSERT INTO meda_vocabulary VALUES("2824","en","_PREDEFINED_CONSTANTS","Predefined Constants");
INSERT INTO meda_vocabulary VALUES("2825","es","_PREDEFINED_CONSTANTS","Constantes predefinidas");
INSERT INTO meda_vocabulary VALUES("2826","de","_PREDEFINED_CONSTANTS","Vordefinierte Konstanten");
INSERT INTO meda_vocabulary VALUES("2827","en","_PREFERRED_LANGUAGE","Preferred Language");
INSERT INTO meda_vocabulary VALUES("2828","es","_PREFERRED_LANGUAGE","Idioma de preferencia");
INSERT INTO meda_vocabulary VALUES("2829","de","_PREFERRED_LANGUAGE","Bevorzugte Sprache");
INSERT INTO meda_vocabulary VALUES("2830","en","_PREPARING","Preparing");
INSERT INTO meda_vocabulary VALUES("2831","es","_PREPARING","Preparación");
INSERT INTO meda_vocabulary VALUES("2832","de","_PREPARING","Vorbereitung");
INSERT INTO meda_vocabulary VALUES("2833","en","_PREVIEW","Preview");
INSERT INTO meda_vocabulary VALUES("2834","es","_PREVIEW","Prevista");
INSERT INTO meda_vocabulary VALUES("2835","de","_PREVIEW","Vorschau");
INSERT INTO meda_vocabulary VALUES("2836","en","_PREVIOUS","Previous");
INSERT INTO meda_vocabulary VALUES("2837","es","_PREVIOUS","Anterior");
INSERT INTO meda_vocabulary VALUES("2838","de","_PREVIOUS","Vorherige");
INSERT INTO meda_vocabulary VALUES("2839","en","_PRICE","Price");
INSERT INTO meda_vocabulary VALUES("2840","es","_PRICE","Precio");
INSERT INTO meda_vocabulary VALUES("2841","de","_PRICE","Preis");
INSERT INTO meda_vocabulary VALUES("2842","en","_PRICE_FORMAT","Price Format");
INSERT INTO meda_vocabulary VALUES("2843","es","_PRICE_FORMAT","Formato Precio");
INSERT INTO meda_vocabulary VALUES("2844","de","_PRICE_FORMAT","Preis Format");
INSERT INTO meda_vocabulary VALUES("2845","en","_PRICE_FORMAT_ALERT","Allows to display prices for visitor in appropriate format");
INSERT INTO meda_vocabulary VALUES("2846","es","_PRICE_FORMAT_ALERT","Permite mostrar los precios de los visitantes en el formato adecuado");
INSERT INTO meda_vocabulary VALUES("2847","de","_PRICE_FORMAT_ALERT","Ermöglicht die Preise für Besucher in geeigneter Form angezeigt werden");
INSERT INTO meda_vocabulary VALUES("2848","en","_PRINT","Print");
INSERT INTO meda_vocabulary VALUES("2849","es","_PRINT","Imprimir");
INSERT INTO meda_vocabulary VALUES("2850","de","_PRINT","Drucken");
INSERT INTO meda_vocabulary VALUES("2851","en","_PRIVILEGES","Privileges");
INSERT INTO meda_vocabulary VALUES("2852","es","_PRIVILEGES","Privilegios");
INSERT INTO meda_vocabulary VALUES("2853","de","_PRIVILEGES","Vorrechte");
INSERT INTO meda_vocabulary VALUES("2854","en","_PRIVILEGES_MANAGEMENT","Privileges Management");
INSERT INTO meda_vocabulary VALUES("2855","es","_PRIVILEGES_MANAGEMENT","Privilegios de administración");
INSERT INTO meda_vocabulary VALUES("2856","de","_PRIVILEGES_MANAGEMENT","Privileges-Management");
INSERT INTO meda_vocabulary VALUES("2857","en","_PRODUCTS","Products");
INSERT INTO meda_vocabulary VALUES("2858","es","_PRODUCTS","Productos");
INSERT INTO meda_vocabulary VALUES("2859","de","_PRODUCTS","Produkte");
INSERT INTO meda_vocabulary VALUES("2860","en","_PRODUCTS_COUNT","Products count");
INSERT INTO meda_vocabulary VALUES("2861","es","_PRODUCTS_COUNT","Productos cuentan");
INSERT INTO meda_vocabulary VALUES("2862","de","_PRODUCTS_COUNT","Produkte zählen");
INSERT INTO meda_vocabulary VALUES("2863","en","_PRODUCTS_MANAGEMENT","Products Management");
INSERT INTO meda_vocabulary VALUES("2864","es","_PRODUCTS_MANAGEMENT","Productos para la administración");
INSERT INTO meda_vocabulary VALUES("2865","de","_PRODUCTS_MANAGEMENT","Produkte Management");
INSERT INTO meda_vocabulary VALUES("2866","en","_PRODUCT_DESCRIPTION","Product Description");
INSERT INTO meda_vocabulary VALUES("2867","es","_PRODUCT_DESCRIPTION","Descripción del producto");
INSERT INTO meda_vocabulary VALUES("2868","de","_PRODUCT_DESCRIPTION","Produkt-Beschreibung");
INSERT INTO meda_vocabulary VALUES("2869","en","_PRODUCT_NOT_FOUND","Product has not been found!");
INSERT INTO meda_vocabulary VALUES("2870","es","_PRODUCT_NOT_FOUND","El producto no se ha encontrado!");
INSERT INTO meda_vocabulary VALUES("2871","de","_PRODUCT_NOT_FOUND","Produkt wurde nicht gefunden!");
INSERT INTO meda_vocabulary VALUES("2872","en","_PROFESSIONAL_INFORMATION","Professional Information");
INSERT INTO meda_vocabulary VALUES("2873","es","_PROFESSIONAL_INFORMATION","Información Profesional");
INSERT INTO meda_vocabulary VALUES("2874","de","_PROFESSIONAL_INFORMATION","Infos für Fachleute");
INSERT INTO meda_vocabulary VALUES("2875","en","_PROFILE_DETAILS","Profile Details");
INSERT INTO meda_vocabulary VALUES("2876","es","_PROFILE_DETAILS","Detalles del perfil");
INSERT INTO meda_vocabulary VALUES("2877","de","_PROFILE_DETAILS","Profildetails");
INSERT INTO meda_vocabulary VALUES("2878","en","_PUBLIC","Public");
INSERT INTO meda_vocabulary VALUES("2879","es","_PUBLIC","Pública");
INSERT INTO meda_vocabulary VALUES("2880","de","_PUBLIC","Öffentliche");
INSERT INTO meda_vocabulary VALUES("2881","en","_PUBLISHED","Published");
INSERT INTO meda_vocabulary VALUES("2882","es","_PUBLISHED","Publicado");
INSERT INTO meda_vocabulary VALUES("2883","de","_PUBLISHED","Veröffentlicht");
INSERT INTO meda_vocabulary VALUES("2884","en","_PUBLISH_YOUR_COMMENT","Publish your comment");
INSERT INTO meda_vocabulary VALUES("2885","es","_PUBLISH_YOUR_COMMENT","Publicar tu comentario");
INSERT INTO meda_vocabulary VALUES("2886","de","_PUBLISH_YOUR_COMMENT","Veröffentlichen she Ihren Kommentar");
INSERT INTO meda_vocabulary VALUES("2887","en","_QUESTION","Question");
INSERT INTO meda_vocabulary VALUES("2888","es","_QUESTION","Pregunta");
INSERT INTO meda_vocabulary VALUES("2889","de","_QUESTION","Frage");
INSERT INTO meda_vocabulary VALUES("2890","en","_QUESTIONS","Questions");
INSERT INTO meda_vocabulary VALUES("2891","es","_QUESTIONS","Preguntas");
INSERT INTO meda_vocabulary VALUES("2892","de","_QUESTIONS","Fragen");
INSERT INTO meda_vocabulary VALUES("2893","en","_RATE","Rate");
INSERT INTO meda_vocabulary VALUES("2894","es","_RATE","Tipo");
INSERT INTO meda_vocabulary VALUES("2895","de","_RATE","Rate");
INSERT INTO meda_vocabulary VALUES("2896","en","_RATINGS","Ratings");
INSERT INTO meda_vocabulary VALUES("2897","es","_RATINGS","Valoraciones");
INSERT INTO meda_vocabulary VALUES("2898","de","_RATINGS","Bewertungen");
INSERT INTO meda_vocabulary VALUES("2899","en","_RATINGS_SETTINGS","Ratings Settings");
INSERT INTO meda_vocabulary VALUES("2900","es","_RATINGS_SETTINGS","Valoraciones Configuración");
INSERT INTO meda_vocabulary VALUES("2901","de","_RATINGS_SETTINGS","Bewertungen Einstellungen");
INSERT INTO meda_vocabulary VALUES("2902","en","_REACTIVATION_EMAIL","Resend Activation Email");
INSERT INTO meda_vocabulary VALUES("2903","es","_REACTIVATION_EMAIL","Reenviar email de activación");
INSERT INTO meda_vocabulary VALUES("2904","de","_REACTIVATION_EMAIL","Aktivierungsmail erneut zuschicken");
INSERT INTO meda_vocabulary VALUES("2905","en","_READ_MORE","Read more");
INSERT INTO meda_vocabulary VALUES("2906","es","_READ_MORE","Leer más");
INSERT INTO meda_vocabulary VALUES("2907","de","_READ_MORE","Lesen Sie mehr");
INSERT INTO meda_vocabulary VALUES("2908","en","_REASON","Reason");
INSERT INTO meda_vocabulary VALUES("2909","es","_REASON","Razón");
INSERT INTO meda_vocabulary VALUES("2910","de","_REASON","Grund");
INSERT INTO meda_vocabulary VALUES("2911","en","_REFRESH","Refresh");
INSERT INTO meda_vocabulary VALUES("2912","es","_REFRESH","Refrescar");
INSERT INTO meda_vocabulary VALUES("2913","de","_REFRESH","erfrischen");
INSERT INTO meda_vocabulary VALUES("2914","en","_REFUNDED","Refunded");
INSERT INTO meda_vocabulary VALUES("2915","es","_REFUNDED","Devuelto");
INSERT INTO meda_vocabulary VALUES("2916","de","_REFUNDED","Erstattet");
INSERT INTO meda_vocabulary VALUES("2917","en","_REGISTERED","Registered");
INSERT INTO meda_vocabulary VALUES("2918","es","_REGISTERED","Registrado");
INSERT INTO meda_vocabulary VALUES("2919","de","_REGISTERED","registriert");
INSERT INTO meda_vocabulary VALUES("2920","en","_REGISTERED_FROM_IP","Registered from IP");
INSERT INTO meda_vocabulary VALUES("2921","es","_REGISTERED_FROM_IP","Registradas a partir de la IP");
INSERT INTO meda_vocabulary VALUES("2922","de","_REGISTERED_FROM_IP","Einschreiben aus IP");
INSERT INTO meda_vocabulary VALUES("2923","en","_REGISTRATIONS","Registrations");
INSERT INTO meda_vocabulary VALUES("2924","es","_REGISTRATIONS","Inscripciones");
INSERT INTO meda_vocabulary VALUES("2925","de","_REGISTRATIONS","anmeldungen");
INSERT INTO meda_vocabulary VALUES("2926","en","_REGISTRATION_CODE","Registration code");
INSERT INTO meda_vocabulary VALUES("2927","es","_REGISTRATION_CODE","Código de registro");
INSERT INTO meda_vocabulary VALUES("2928","de","_REGISTRATION_CODE","Registrierungs-Code");
INSERT INTO meda_vocabulary VALUES("2929","en","_REGISTRATION_CONFIRMATION","Registration Confirmation");
INSERT INTO meda_vocabulary VALUES("2930","es","_REGISTRATION_CONFIRMATION","Confirmación de registro");
INSERT INTO meda_vocabulary VALUES("2931","de","_REGISTRATION_CONFIRMATION","Anmeldebestätigung");
INSERT INTO meda_vocabulary VALUES("2932","en","_REGISTRATION_FORM","Registration Form");
INSERT INTO meda_vocabulary VALUES("2933","es","_REGISTRATION_FORM","Formulario de Inscripción");
INSERT INTO meda_vocabulary VALUES("2934","de","_REGISTRATION_FORM","Anmeldeformular");
INSERT INTO meda_vocabulary VALUES("2935","en","_REGISTRATION_NOT_COMPLETED","Your registration process is not yet complete! Please check again your email for further instructions or go to Resend Activation Email page to get them again.");
INSERT INTO meda_vocabulary VALUES("2936","es","_REGISTRATION_NOT_COMPLETED","El proceso de registro todavía no está completo! Por favor, compruebe de nuevo su correo electrónico para obtener más instrucciones o ir a la página de activación Reenviar correo electrónico a conseguirlos de nuevo.");
INSERT INTO meda_vocabulary VALUES("2937","de","_REGISTRATION_NOT_COMPLETED","Ihre Registrierung ist noch nicht abgeschlossen! Bitte überprüfen Sie nochmals Ihre E-Mail für weitere Anweisungen oder gehen Sie zu Activation Email Seite erneut, um sie wieder zu bekommen.");
INSERT INTO meda_vocabulary VALUES("2938","en","_REMEMBER_ME","Remember Me");
INSERT INTO meda_vocabulary VALUES("2939","es","_REMEMBER_ME","Acuérdate de mí");
INSERT INTO meda_vocabulary VALUES("2940","de","_REMEMBER_ME","Erinnere dich an mich");
INSERT INTO meda_vocabulary VALUES("2941","en","_REMINDER","Reminder");
INSERT INTO meda_vocabulary VALUES("2942","es","_REMINDER","Recordatorio");
INSERT INTO meda_vocabulary VALUES("2943","de","_REMINDER","Erinnerung");
INSERT INTO meda_vocabulary VALUES("2944","en","_REMINDER_SENT","Reminder Sent");
INSERT INTO meda_vocabulary VALUES("2945","es","_REMINDER_SENT","Recordatorio Enviado");
INSERT INTO meda_vocabulary VALUES("2946","de","_REMINDER_SENT","Mahnung");
INSERT INTO meda_vocabulary VALUES("2947","en","_REMINDER_SETTINGS","Reminder Settings");
INSERT INTO meda_vocabulary VALUES("2948","es","_REMINDER_SETTINGS","Configuración de recordatorio");
INSERT INTO meda_vocabulary VALUES("2949","de","_REMINDER_SETTINGS","Erinnerung Einstellungen");
INSERT INTO meda_vocabulary VALUES("2950","en","_REMOVE","Remove");
INSERT INTO meda_vocabulary VALUES("2951","es","_REMOVE","Eliminar");
INSERT INTO meda_vocabulary VALUES("2952","de","_REMOVE","Entfernen");
INSERT INTO meda_vocabulary VALUES("2953","en","_REMOVED","Removed");
INSERT INTO meda_vocabulary VALUES("2954","es","_REMOVED","Eliminado");
INSERT INTO meda_vocabulary VALUES("2955","de","_REMOVED","Entfernt");
INSERT INTO meda_vocabulary VALUES("2956","en","_REMOVE_ACCOUNT","Remove Account");
INSERT INTO meda_vocabulary VALUES("2957","es","_REMOVE_ACCOUNT","Quite la cuenta");
INSERT INTO meda_vocabulary VALUES("2958","de","_REMOVE_ACCOUNT","Konto entfernen");
INSERT INTO meda_vocabulary VALUES("2959","en","_REMOVE_ACCOUNT_ALERT","Are you sure you want to remove your account?");
INSERT INTO meda_vocabulary VALUES("2960","es","_REMOVE_ACCOUNT_ALERT","¿Está seguro que desea eliminar su cuenta?");
INSERT INTO meda_vocabulary VALUES("2961","de","_REMOVE_ACCOUNT_ALERT","Sie sind sicher, dass Sie Ihr Konto entfernen?");
INSERT INTO meda_vocabulary VALUES("2962","en","_REMOVE_ACCOUNT_PASSWORD_CONFIRM","Enter your password to confirm removing account");
INSERT INTO meda_vocabulary VALUES("2963","es","_REMOVE_ACCOUNT_PASSWORD_CONFIRM","Ingrese su contraseña para confirmar la eliminación de la cuenta");
INSERT INTO meda_vocabulary VALUES("2964","de","_REMOVE_ACCOUNT_PASSWORD_CONFIRM","Geben Sie Ihr Passwort zur Bestätigung Entfernen Konto");
INSERT INTO meda_vocabulary VALUES("2965","en","_REMOVE_ACCOUNT_WARNING","If you don\'t think you will use this site again and would like your account deleted, we can take care of this for you. Keep in mind, that you will not be able to reactivate your account or retrieve any of the content or information that was added. If you are sure you want to this, enter your password then click Remove button.");
INSERT INTO meda_vocabulary VALUES("2966","es","_REMOVE_ACCOUNT_WARNING","Si usted no piensa que va a utilizar este sitio de nuevo y le gustaría que su cuenta eliminada, nos podemos encargar de esto por usted. Tenga en cuenta, que no podrá reactivar su cuenta o recuperar cualquier contenido o información que se ha añadido. Si está seguro de que quieres esto, introduzca su contraseña a continuación, haga clic en el botón Eliminar.");
INSERT INTO meda_vocabulary VALUES("2967","de","_REMOVE_ACCOUNT_WARNING","Wenn Sie nicht glauben wollen, werden Sie diese Seite wieder zu verwenden und würden gerne Ihren Account gelöscht wird, können wir uns um diese für Sie. Denken Sie daran, dass Sie nicht in der Lage sein Ihr Konto zu reaktivieren oder abrufen des Inhalts oder Informationen, die hinzugefügt wurde. Wenn Sie sicher, dass Sie dies wollen, geben Sie Ihr Passwort klicken Sie dann auf die Schaltfläche Entfernen.");
INSERT INTO meda_vocabulary VALUES("2968","en","_REMOVE_LAST_COUNTRY_ALERT","The country selected has not been deleted, because you must have at least one active country for correct work of the site!");
INSERT INTO meda_vocabulary VALUES("2969","es","_REMOVE_LAST_COUNTRY_ALERT","El país seleccionado no se ha eliminado, ya que debe tener al menos un país activo para un funcionamiento correcto del sitio!");
INSERT INTO meda_vocabulary VALUES("2970","de","_REMOVE_LAST_COUNTRY_ALERT","Das Land ausgewählt wurde nicht gelöscht, weil Sie mindestens ein aktives Land, um korrekte Arbeitsweise der Seite haben muss!");
INSERT INTO meda_vocabulary VALUES("2971","en","_RESEND_ACTIVATION_EMAIL","Resend Activation Email");
INSERT INTO meda_vocabulary VALUES("2972","es","_RESEND_ACTIVATION_EMAIL","Reenviar email de activación");
INSERT INTO meda_vocabulary VALUES("2973","de","_RESEND_ACTIVATION_EMAIL","Aktivierungsmail erneut zuschicken");
INSERT INTO meda_vocabulary VALUES("2974","en","_RESEND_ACTIVATION_EMAIL_MSG","Please enter your email address then click on Send button. You will receive the activation email shortly.");
INSERT INTO meda_vocabulary VALUES("2975","es","_RESEND_ACTIVATION_EMAIL_MSG","Por favor, introduzca su dirección de correo electrónico continuación, haga clic en el botón Enviar. Usted recibirá el mensaje de activación en breve.");
INSERT INTO meda_vocabulary VALUES("2976","de","_RESEND_ACTIVATION_EMAIL_MSG","Bitte geben Sie Ihre E-Mail-Adresse ein und klicken Sie auf Senden. Sie wird die Aktivierung per E-Mail zugesandt.");
INSERT INTO meda_vocabulary VALUES("2977","en","_RESERVED","Reserved");
INSERT INTO meda_vocabulary VALUES("2978","es","_RESERVED","reservado");
INSERT INTO meda_vocabulary VALUES("2979","de","_RESERVED","reserviert");
INSERT INTO meda_vocabulary VALUES("2980","en","_RESET","Reset");
INSERT INTO meda_vocabulary VALUES("2981","es","_RESET","Restablecer");
INSERT INTO meda_vocabulary VALUES("2982","de","_RESET","Reset");
INSERT INTO meda_vocabulary VALUES("2983","en","_RESIDENCY_TRAINING","Residency Training");
INSERT INTO meda_vocabulary VALUES("2984","es","_RESIDENCY_TRAINING","Entrenamiento de Residentes");
INSERT INTO meda_vocabulary VALUES("2985","de","_RESIDENCY_TRAINING","Facharztausbildung");
INSERT INTO meda_vocabulary VALUES("2986","en","_RESTORE","Restore");
INSERT INTO meda_vocabulary VALUES("2987","es","_RESTORE","Restaurar");
INSERT INTO meda_vocabulary VALUES("2988","de","_RESTORE","Wiederherstellen");
INSERT INTO meda_vocabulary VALUES("2989","en","_RETYPE_PASSWORD","Retype Password");
INSERT INTO meda_vocabulary VALUES("2990","es","_RETYPE_PASSWORD","Volver a escribir contraseña");
INSERT INTO meda_vocabulary VALUES("2991","de","_RETYPE_PASSWORD","Passwort wiederholen");
INSERT INTO meda_vocabulary VALUES("2992","en","_RIGHT","Right");
INSERT INTO meda_vocabulary VALUES("2993","es","_RIGHT","Derecho");
INSERT INTO meda_vocabulary VALUES("2994","de","_RIGHT","Recht");
INSERT INTO meda_vocabulary VALUES("2995","en","_RIGHT_TO_LEFT","RTL (right-to-left)");
INSERT INTO meda_vocabulary VALUES("2996","es","_RIGHT_TO_LEFT","RTL (de derecha a izquierda)");
INSERT INTO meda_vocabulary VALUES("2997","de","_RIGHT_TO_LEFT","RTL (von rechts nach links)");
INSERT INTO meda_vocabulary VALUES("2998","en","_ROLES_AND_PRIVILEGES","Roles & Privileges");
INSERT INTO meda_vocabulary VALUES("2999","es","_ROLES_AND_PRIVILEGES","Los roles y privilegios");
INSERT INTO meda_vocabulary VALUES("3000","de","_ROLES_AND_PRIVILEGES","Rollen und Zugriffsrechte");
INSERT INTO meda_vocabulary VALUES("3001","en","_ROLES_MANAGEMENT","Roles Management");
INSERT INTO meda_vocabulary VALUES("3002","es","_ROLES_MANAGEMENT","Funciones de administración");
INSERT INTO meda_vocabulary VALUES("3003","de","_ROLES_MANAGEMENT","Rollen-Management");
INSERT INTO meda_vocabulary VALUES("3004","en","_RSS_FEED_TYPE","RSS Feed Type");
INSERT INTO meda_vocabulary VALUES("3005","es","_RSS_FEED_TYPE","RSS Feed Tipo");
INSERT INTO meda_vocabulary VALUES("3006","de","_RSS_FEED_TYPE","RSS Feed-Typ");
INSERT INTO meda_vocabulary VALUES("3007","en","_RSS_FILE_ERROR","Cannot open RSS file to add new item! Please check your access rights to <b>feeds/</b> directory or try again later.");
INSERT INTO meda_vocabulary VALUES("3008","es","_RSS_FILE_ERROR","No se puede abrir el archivo RSS para añadir el artículo nuevo! Por favor, compruebe sus derechos de acceso a <b>feeds/</b> del directorio o inténtelo de nuevo más tarde.");
INSERT INTO meda_vocabulary VALUES("3009","de","_RSS_FILE_ERROR","Kann nicht geöffnet werden RSS-Datei auf neues Element hinzufügen! Bitte überprüfen Sie Ihre Zugriffsrechte auf <b>feeds/</b> Verzeichnis oder versuchen Sie es später erneut.");
INSERT INTO meda_vocabulary VALUES("3010","en","_RUN_CRON","Run cron");
INSERT INTO meda_vocabulary VALUES("3011","es","_RUN_CRON","Ejecutar cron");
INSERT INTO meda_vocabulary VALUES("3012","de","_RUN_CRON","Run cron");
INSERT INTO meda_vocabulary VALUES("3013","en","_RUN_EVERY","Run every");
INSERT INTO meda_vocabulary VALUES("3014","es","_RUN_EVERY","Ejecutar cada");
INSERT INTO meda_vocabulary VALUES("3015","de","_RUN_EVERY","Führen Sie alle");
INSERT INTO meda_vocabulary VALUES("3016","en","_SAID","said");
INSERT INTO meda_vocabulary VALUES("3017","es","_SAID","dijo");
INSERT INTO meda_vocabulary VALUES("3018","de","_SAID","sagte");
INSERT INTO meda_vocabulary VALUES("3019","en","_SATURDAY","Saturday");
INSERT INTO meda_vocabulary VALUES("3020","es","_SATURDAY","sábado");
INSERT INTO meda_vocabulary VALUES("3021","de","_SATURDAY","Samstag");
INSERT INTO meda_vocabulary VALUES("3022","en","_SCHEDULE","Schedule");
INSERT INTO meda_vocabulary VALUES("3023","es","_SCHEDULE","Programar");
INSERT INTO meda_vocabulary VALUES("3024","de","_SCHEDULE","Planen");
INSERT INTO meda_vocabulary VALUES("3025","en","_SCHEDULES","Schedules");
INSERT INTO meda_vocabulary VALUES("3026","es","_SCHEDULES","Horarios");
INSERT INTO meda_vocabulary VALUES("3027","de","_SCHEDULES","Termine");
INSERT INTO meda_vocabulary VALUES("3028","en","_SCHEDULES_TIMEBLOCKS","Schedule Time Blocks");
INSERT INTO meda_vocabulary VALUES("3029","es","_SCHEDULES_TIMEBLOCKS","Programar bloques de tiempo");
INSERT INTO meda_vocabulary VALUES("3030","de","_SCHEDULES_TIMEBLOCKS","Planen Sie Zeitblöcke");
INSERT INTO meda_vocabulary VALUES("3031","en","_SCHEDULE_TIME_OVERLAPPING_ALERT","This period of time (fully or partially) has been already chosen for selected schedule! Please re-enter.");
INSERT INTO meda_vocabulary VALUES("3032","es","_SCHEDULE_TIME_OVERLAPPING_ALERT","Este período de tiempo (total o parcialmente) fue elegido ya para el horario seleccionado! Por favor, vuelva a introducir.");
INSERT INTO meda_vocabulary VALUES("3033","de","_SCHEDULE_TIME_OVERLAPPING_ALERT","Dieser Zeitraum (vollständig oder teilweise) wurde bereits für ausgewählte Zeitplan gewählt! Bitte erneut eingeben.");
INSERT INTO meda_vocabulary VALUES("3034","en","_SEARCH","Search");
INSERT INTO meda_vocabulary VALUES("3035","es","_SEARCH","Búsqueda");
INSERT INTO meda_vocabulary VALUES("3036","de","_SEARCH","Suche");
INSERT INTO meda_vocabulary VALUES("3037","en","_SEARCH_KEYWORDS","search keywords");
INSERT INTO meda_vocabulary VALUES("3038","es","_SEARCH_KEYWORDS","búsqueda");
INSERT INTO meda_vocabulary VALUES("3039","de","_SEARCH_KEYWORDS","Suchbegriffe");
INSERT INTO meda_vocabulary VALUES("3040","en","_SEARCH_RESULTS","Search Results");
INSERT INTO meda_vocabulary VALUES("3041","es","_SEARCH_RESULTS","Resultados de la búsqueda");
INSERT INTO meda_vocabulary VALUES("3042","de","_SEARCH_RESULTS","Suchergebnisse");
INSERT INTO meda_vocabulary VALUES("3043","en","_SEARCH_RESULT_FOR","Search Results for");
INSERT INTO meda_vocabulary VALUES("3044","es","_SEARCH_RESULT_FOR","Resultados de la búsqueda para");
INSERT INTO meda_vocabulary VALUES("3045","de","_SEARCH_RESULT_FOR","Suchergebnisse für");
INSERT INTO meda_vocabulary VALUES("3046","en","_SEC","Sec");
INSERT INTO meda_vocabulary VALUES("3047","es","_SEC","Seg");
INSERT INTO meda_vocabulary VALUES("3048","de","_SEC","sec");
INSERT INTO meda_vocabulary VALUES("3049","en","_SELECT","select");
INSERT INTO meda_vocabulary VALUES("3050","es","_SELECT","Seleccione");
INSERT INTO meda_vocabulary VALUES("3051","de","_SELECT","wählen");
INSERT INTO meda_vocabulary VALUES("3052","en","_SELECT_FILE_TO_UPLOAD","Select a file to upload");
INSERT INTO meda_vocabulary VALUES("3053","es","_SELECT_FILE_TO_UPLOAD","Seleccione un archivo para cargar");
INSERT INTO meda_vocabulary VALUES("3054","de","_SELECT_FILE_TO_UPLOAD","Wählen Sie eine Datei zum Hochladen");
INSERT INTO meda_vocabulary VALUES("3055","en","_SELECT_LANG_TO_UPDATE","Select a language to update");
INSERT INTO meda_vocabulary VALUES("3056","es","_SELECT_LANG_TO_UPDATE","Seleccione un idioma para actualizar");
INSERT INTO meda_vocabulary VALUES("3057","de","_SELECT_LANG_TO_UPDATE","Wählen Sie eine Sprache zu aktualisieren");
INSERT INTO meda_vocabulary VALUES("3058","en","_SELECT_PATIENT_ALERT","Select patient from drop down box and click Apply button to proceed.");
INSERT INTO meda_vocabulary VALUES("3059","es","_SELECT_PATIENT_ALERT","Seleccione paciente de lista desplegable y haga clic en el botón de Aceptar para continuar.");
INSERT INTO meda_vocabulary VALUES("3060","de","_SELECT_PATIENT_ALERT","Wählen Patienten von Dropdown-Feld und klicken Sie auf die Schaltfläche Übernehmen, um fortzufahren.");
INSERT INTO meda_vocabulary VALUES("3061","en","_SELECT_PLAN","Select Plan");
INSERT INTO meda_vocabulary VALUES("3062","es","_SELECT_PLAN","Seleccionar plan");
INSERT INTO meda_vocabulary VALUES("3063","de","_SELECT_PLAN","Plan auswählen");
INSERT INTO meda_vocabulary VALUES("3064","en","_SEND","Send");
INSERT INTO meda_vocabulary VALUES("3065","es","_SEND","Enviar");
INSERT INTO meda_vocabulary VALUES("3066","de","_SEND","Senden");
INSERT INTO meda_vocabulary VALUES("3067","en","_SENDING","Sending");
INSERT INTO meda_vocabulary VALUES("3068","es","_SENDING","Envío");
INSERT INTO meda_vocabulary VALUES("3069","de","_SENDING","Senden");
INSERT INTO meda_vocabulary VALUES("3070","en","_SEND_COPY_TO_ADMIN","Send a copy to admin");
INSERT INTO meda_vocabulary VALUES("3071","es","_SEND_COPY_TO_ADMIN","Enviar una copia al administrador");
INSERT INTO meda_vocabulary VALUES("3072","de","_SEND_COPY_TO_ADMIN","Senden Einer kopie ein Admin");
INSERT INTO meda_vocabulary VALUES("3073","en","_SEND_INVOICE","Send Invoice");
INSERT INTO meda_vocabulary VALUES("3074","es","_SEND_INVOICE","Enviar factura");
INSERT INTO meda_vocabulary VALUES("3075","de","_SEND_INVOICE","Senden Rechnung");
INSERT INTO meda_vocabulary VALUES("3076","en","_SENT","Sent");
INSERT INTO meda_vocabulary VALUES("3077","es","_SENT","Enviado");
INSERT INTO meda_vocabulary VALUES("3078","de","_SENT","Geschickt");
INSERT INTO meda_vocabulary VALUES("3079","en","_SEO_LINKS_ALERT","If you select this option, make sure SEO Links Section uncommented in .htaccess file");
INSERT INTO meda_vocabulary VALUES("3080","es","_SEO_LINKS_ALERT","Si selecciona esta opción, asegúrese de SEO Enlaces sin comentarios en la sección .haccess");
INSERT INTO meda_vocabulary VALUES("3081","de","_SEO_LINKS_ALERT","Wenn Sie diese Option, um sicherzustellen, SEO Links Abschnitt unkommentiert in .htaccess-Datei");
INSERT INTO meda_vocabulary VALUES("3082","en","_SEO_URLS","SEO URLs");
INSERT INTO meda_vocabulary VALUES("3083","es","_SEO_URLS","SEO URLs");
INSERT INTO meda_vocabulary VALUES("3084","de","_SEO_URLS","SEO URLs");
INSERT INTO meda_vocabulary VALUES("3085","en","_SEPTEMBER","September");
INSERT INTO meda_vocabulary VALUES("3086","es","_SEPTEMBER","Septiembre");
INSERT INTO meda_vocabulary VALUES("3087","de","_SEPTEMBER","September");
INSERT INTO meda_vocabulary VALUES("3088","en","_SERVER_INFO","Server Info");
INSERT INTO meda_vocabulary VALUES("3089","es","_SERVER_INFO","Servidor de Información");
INSERT INTO meda_vocabulary VALUES("3090","de","_SERVER_INFO","Server Info");
INSERT INTO meda_vocabulary VALUES("3091","en","_SERVER_LOCALE","Server Locale");
INSERT INTO meda_vocabulary VALUES("3092","es","_SERVER_LOCALE","servidor local");
INSERT INTO meda_vocabulary VALUES("3093","de","_SERVER_LOCALE","Server locale");
INSERT INTO meda_vocabulary VALUES("3094","en","_SESSION_EXPIRED","Your session has expired! Please login again.");
INSERT INTO meda_vocabulary VALUES("3095","es","_SESSION_EXPIRED","Su sesión ha caducado! Por favor, ingresa de nuevo.");
INSERT INTO meda_vocabulary VALUES("3096","de","_SESSION_EXPIRED","Ihre Session ist abgelaufen! Bitte loggen Sie sich erneut.");
INSERT INTO meda_vocabulary VALUES("3097","en","_SETTINGS","Settings");
INSERT INTO meda_vocabulary VALUES("3098","es","_SETTINGS","Configuración");
INSERT INTO meda_vocabulary VALUES("3099","de","_SETTINGS","Einstellungen");
INSERT INTO meda_vocabulary VALUES("3100","en","_SETTINGS_SAVED","Changes were saved! Please refresh the <a href=\'index.php\'>Home Page</a> to see the results.");
INSERT INTO meda_vocabulary VALUES("3101","es","_SETTINGS_SAVED","Los cambios fueron salvados! Por favor, actualice la <a href=\'index.php\'>Home Page</a> para ver los resultados.");
INSERT INTO meda_vocabulary VALUES("3102","de","_SETTINGS_SAVED","Ünderungen wurden gespeichert! Bitte aktualisieren Sie die <a href=index.php>Home Page</a> zu den Suchergebnissen finden Sie im.");
INSERT INTO meda_vocabulary VALUES("3103","en","_SET_ADMIN","Set Admin");
INSERT INTO meda_vocabulary VALUES("3104","es","_SET_ADMIN","Set Admin");
INSERT INTO meda_vocabulary VALUES("3105","de","_SET_ADMIN","Stellen Admin");
INSERT INTO meda_vocabulary VALUES("3106","en","_SET_TIME","Set Time");
INSERT INTO meda_vocabulary VALUES("3107","es","_SET_TIME","Ajuste de la hora");
INSERT INTO meda_vocabulary VALUES("3108","de","_SET_TIME","Eingestellte Zeit");
INSERT INTO meda_vocabulary VALUES("3109","en","_SHOW_ALERT_WINDOW","Show Alert Window");
INSERT INTO meda_vocabulary VALUES("3110","es","_SHOW_ALERT_WINDOW","Mostrar la ventana Aviso de");
INSERT INTO meda_vocabulary VALUES("3111","de","_SHOW_ALERT_WINDOW","Alarmfenster anzeigen");
INSERT INTO meda_vocabulary VALUES("3112","en","_SHOW_DASHBOARD","Show Dashboard");
INSERT INTO meda_vocabulary VALUES("3113","es","_SHOW_DASHBOARD","Mostrar Dashboard");
INSERT INTO meda_vocabulary VALUES("3114","de","_SHOW_DASHBOARD","Übersicht anzeigen");
INSERT INTO meda_vocabulary VALUES("3115","en","_SHOW_IN_SEARCH","Show in Search");
INSERT INTO meda_vocabulary VALUES("3116","es","_SHOW_IN_SEARCH","Ver en la búsqueda");
INSERT INTO meda_vocabulary VALUES("3117","de","_SHOW_IN_SEARCH","Show auf der Suche");
INSERT INTO meda_vocabulary VALUES("3118","en","_SHOW_META_TAGS","Show META tags");
INSERT INTO meda_vocabulary VALUES("3119","es","_SHOW_META_TAGS","Mostrar Las etiquetas META");
INSERT INTO meda_vocabulary VALUES("3120","de","_SHOW_META_TAGS","META-Tags anzeigen");
INSERT INTO meda_vocabulary VALUES("3121","en","_SHOW_ON_DASHBOARD","Show on Dashboard");
INSERT INTO meda_vocabulary VALUES("3122","es","_SHOW_ON_DASHBOARD","Mostrar en el Dashboard");
INSERT INTO meda_vocabulary VALUES("3123","de","_SHOW_ON_DASHBOARD","Anzeigen auf Armaturenbrett");
INSERT INTO meda_vocabulary VALUES("3124","en","_SIDE_PANEL","Side Panel");
INSERT INTO meda_vocabulary VALUES("3125","es","_SIDE_PANEL","El panel lateral");
INSERT INTO meda_vocabulary VALUES("3126","de","_SIDE_PANEL","Seitenteil");
INSERT INTO meda_vocabulary VALUES("3127","en","_SIGN_IN","Sign In");
INSERT INTO meda_vocabulary VALUES("3128","es","_SIGN_IN","Inicia sesión");
INSERT INTO meda_vocabulary VALUES("3129","de","_SIGN_IN","Eintragen");
INSERT INTO meda_vocabulary VALUES("3130","en","_SIMPLE","Simple");
INSERT INTO meda_vocabulary VALUES("3131","es","_SIMPLE","Simple");
INSERT INTO meda_vocabulary VALUES("3132","de","_SIMPLE","Einfache");
INSERT INTO meda_vocabulary VALUES("3133","en","_SITE_DEVELOPMENT_MODE_ALERT","The site is running in Development Mode! To turn it off change <b>SITE_MODE</b> value in <b>inc/settings.inc.php</b>");
INSERT INTO meda_vocabulary VALUES("3134","es","_SITE_DEVELOPMENT_MODE_ALERT","El sitio se está ejecutando en el modo de desarrollo! Para desactivarlo cambio <b>SITE_MODE</b> valor en <b>inc/settings.inc.php</b>");
INSERT INTO meda_vocabulary VALUES("3135","de","_SITE_DEVELOPMENT_MODE_ALERT","Die Seite ist in Entwicklung Modus läuft! Um ihn auszuschalten ändern <b>SITE_MODE</b>-Wert in <b>inc/settings.inc.php</b>");
INSERT INTO meda_vocabulary VALUES("3136","en","_SITE_INFO","Site Info");
INSERT INTO meda_vocabulary VALUES("3137","es","_SITE_INFO","Información del Sitio");
INSERT INTO meda_vocabulary VALUES("3138","de","_SITE_INFO","Website Info");
INSERT INTO meda_vocabulary VALUES("3139","en","_SITE_OFFLINE","Site Offline");
INSERT INTO meda_vocabulary VALUES("3140","es","_SITE_OFFLINE","Sitio fuera de línea");
INSERT INTO meda_vocabulary VALUES("3141","de","_SITE_OFFLINE","Website offline");
INSERT INTO meda_vocabulary VALUES("3142","en","_SITE_OFFLINE_ALERT","Select whether access to the Site Front-End is available. If Yes, the Front-End will display the message below");
INSERT INTO meda_vocabulary VALUES("3143","es","_SITE_OFFLINE_ALERT","Seleccione si el acceso al Sitio Front-End está disponible. En caso afirmativo, el Front-End mostrará el mensaje siguiente:");
INSERT INTO meda_vocabulary VALUES("3144","de","_SITE_OFFLINE_ALERT","Wählen Sie, ob der Zugriff auf die Site-Front-End zur Verfügung steht. Falls ja, wird die Front-End-Display die Meldung unten");
INSERT INTO meda_vocabulary VALUES("3145","en","_SITE_OFFLINE_MESSAGE_ALERT","A message that displays in the Front-End if your site is offline");
INSERT INTO meda_vocabulary VALUES("3146","es","_SITE_OFFLINE_MESSAGE_ALERT","Un mensaje que aparece en el front-end si su sitio está en línea");
INSERT INTO meda_vocabulary VALUES("3147","de","_SITE_OFFLINE_MESSAGE_ALERT","Eine Nachricht, die Displays in der Front-End, wenn Ihre Website ist offline");
INSERT INTO meda_vocabulary VALUES("3148","en","_SITE_PREVIEW","Site Preview");
INSERT INTO meda_vocabulary VALUES("3149","es","_SITE_PREVIEW","Sitio de vista preliminar");
INSERT INTO meda_vocabulary VALUES("3150","de","_SITE_PREVIEW","Website-Vorschau");
INSERT INTO meda_vocabulary VALUES("3151","en","_SITE_RANKS","Site Ranks");
INSERT INTO meda_vocabulary VALUES("3152","es","_SITE_RANKS","Sitio Ranks");
INSERT INTO meda_vocabulary VALUES("3153","de","_SITE_RANKS","Website Reihen");
INSERT INTO meda_vocabulary VALUES("3154","en","_SITE_RSS","Site RSS");
INSERT INTO meda_vocabulary VALUES("3155","es","_SITE_RSS","RSS del sitio");
INSERT INTO meda_vocabulary VALUES("3156","de","_SITE_RSS","Website RSS");
INSERT INTO meda_vocabulary VALUES("3157","en","_SITE_SETTINGS","Site Settings");
INSERT INTO meda_vocabulary VALUES("3158","es","_SITE_SETTINGS","Configuración del sitio");
INSERT INTO meda_vocabulary VALUES("3159","de","_SITE_SETTINGS","Site-Einstellungen");
INSERT INTO meda_vocabulary VALUES("3160","en","_SMTP_AUTH","SMTP Authentication");
INSERT INTO meda_vocabulary VALUES("3161","es","_SMTP_AUTH","Autenticación SMTP");
INSERT INTO meda_vocabulary VALUES("3162","de","_SMTP_AUTH","SMTP-Authentifizierung");
INSERT INTO meda_vocabulary VALUES("3163","en","_SMTP_HOST","SMTP Host");
INSERT INTO meda_vocabulary VALUES("3164","es","_SMTP_HOST","SMTP host");
INSERT INTO meda_vocabulary VALUES("3165","de","_SMTP_HOST","SMTP-Host");
INSERT INTO meda_vocabulary VALUES("3166","en","_SMTP_PORT","SMTP Port");
INSERT INTO meda_vocabulary VALUES("3167","es","_SMTP_PORT","Puerto SMTP");
INSERT INTO meda_vocabulary VALUES("3168","de","_SMTP_PORT","SMTP-Port");
INSERT INTO meda_vocabulary VALUES("3169","en","_SMTP_SECURE","SMTP Secure");
INSERT INTO meda_vocabulary VALUES("3170","es","_SMTP_SECURE","Secure SMTP");
INSERT INTO meda_vocabulary VALUES("3171","de","_SMTP_SECURE","SMTP Sichere");
INSERT INTO meda_vocabulary VALUES("3172","en","_SOCIAL_NETWORKS","Social Networks");
INSERT INTO meda_vocabulary VALUES("3173","es","_SOCIAL_NETWORKS","Redes Sociales");
INSERT INTO meda_vocabulary VALUES("3174","de","_SOCIAL_NETWORKS","soziale Netzwerke");
INSERT INTO meda_vocabulary VALUES("3175","en","_SOMEONE_ELSE","Someone else");
INSERT INTO meda_vocabulary VALUES("3176","es","_SOMEONE_ELSE","Alguien más");
INSERT INTO meda_vocabulary VALUES("3177","de","_SOMEONE_ELSE","Jemand anderes");
INSERT INTO meda_vocabulary VALUES("3178","en","_SPECIALITIES","Specialities");
INSERT INTO meda_vocabulary VALUES("3179","es","_SPECIALITIES","Especialidades");
INSERT INTO meda_vocabulary VALUES("3180","de","_SPECIALITIES","Spezialitäten");
INSERT INTO meda_vocabulary VALUES("3181","en","_SPECIALITIES_MANAGEMENT","Specialities Management");
INSERT INTO meda_vocabulary VALUES("3182","es","_SPECIALITIES_MANAGEMENT","Especialidades Administración");
INSERT INTO meda_vocabulary VALUES("3183","de","_SPECIALITIES_MANAGEMENT","Spezialitäten-Management");
INSERT INTO meda_vocabulary VALUES("3184","en","_SPECIALITY","Speciality");
INSERT INTO meda_vocabulary VALUES("3185","es","_SPECIALITY","Especialidad");
INSERT INTO meda_vocabulary VALUES("3186","de","_SPECIALITY","Spezialität");
INSERT INTO meda_vocabulary VALUES("3187","en","_STANDARD","Standard");
INSERT INTO meda_vocabulary VALUES("3188","es","_STANDARD","Estándar");
INSERT INTO meda_vocabulary VALUES("3189","de","_STANDARD","Standards");
INSERT INTO meda_vocabulary VALUES("3190","en","_START_FINISH_DATE_ERROR","Finish date must be later than start date! Please re-enter.");
INSERT INTO meda_vocabulary VALUES("3191","es","_START_FINISH_DATE_ERROR","Fecha de finalización debe ser posterior a la fecha de inicio! Por favor, vuelva a entrar.");
INSERT INTO meda_vocabulary VALUES("3192","de","_START_FINISH_DATE_ERROR","Endtermin muss spätestens Startdatum werden! Bitte erneut eingeben.");
INSERT INTO meda_vocabulary VALUES("3193","en","_START_FINISH_TIME_ERROR","Start time must occur earlier than end time. Please re-enter start time and end time.");
INSERT INTO meda_vocabulary VALUES("3194","es","_START_FINISH_TIME_ERROR","Hora de inicio debe producirse antes de la hora final. Por favor, vuelva a entrar en el tiempo de inicio y finalización.");
INSERT INTO meda_vocabulary VALUES("3195","de","_START_FINISH_TIME_ERROR","Startzeit muss früher als Ende der Zeit auftreten. Bitte erneut eingeben Start-und Endzeit.");
INSERT INTO meda_vocabulary VALUES("3196","en","_STATE","State");
INSERT INTO meda_vocabulary VALUES("3197","es","_STATE","Estado");
INSERT INTO meda_vocabulary VALUES("3198","de","_STATE","Zustand");
INSERT INTO meda_vocabulary VALUES("3199","en","_STATES","States");
INSERT INTO meda_vocabulary VALUES("3200","es","_STATES","Unidos");
INSERT INTO meda_vocabulary VALUES("3201","de","_STATES","Staaten");
INSERT INTO meda_vocabulary VALUES("3202","en","_STATE_PROVINCE","State/Province");
INSERT INTO meda_vocabulary VALUES("3203","es","_STATE_PROVINCE","Estado/Provincia");
INSERT INTO meda_vocabulary VALUES("3204","de","_STATE_PROVINCE","Staat/Provinz");
INSERT INTO meda_vocabulary VALUES("3205","en","_STATISTICS","Statistics");
INSERT INTO meda_vocabulary VALUES("3206","es","_STATISTICS","Estadística");
INSERT INTO meda_vocabulary VALUES("3207","de","_STATISTICS","Statistik");
INSERT INTO meda_vocabulary VALUES("3208","en","_STATUS","Status");
INSERT INTO meda_vocabulary VALUES("3209","es","_STATUS","Estado");
INSERT INTO meda_vocabulary VALUES("3210","de","_STATUS","Status");
INSERT INTO meda_vocabulary VALUES("3211","en","_STATUS_CHANGED","Status Changed");
INSERT INTO meda_vocabulary VALUES("3212","es","_STATUS_CHANGED","Cambio en el estado");
INSERT INTO meda_vocabulary VALUES("3213","de","_STATUS_CHANGED","Status geändert");
INSERT INTO meda_vocabulary VALUES("3214","en","_STOP","Stop");
INSERT INTO meda_vocabulary VALUES("3215","es","_STOP","Detener");
INSERT INTO meda_vocabulary VALUES("3216","de","_STOP","Anschlag");
INSERT INTO meda_vocabulary VALUES("3217","en","_SUBJECT","Subject");
INSERT INTO meda_vocabulary VALUES("3218","es","_SUBJECT","Tema");
INSERT INTO meda_vocabulary VALUES("3219","de","_SUBJECT","Gegenstand");
INSERT INTO meda_vocabulary VALUES("3220","en","_SUBJECT_EMPTY_ALERT","Subject cannot be empty!");
INSERT INTO meda_vocabulary VALUES("3221","es","_SUBJECT_EMPTY_ALERT","Sin perjuicio no puede estar vacío!");
INSERT INTO meda_vocabulary VALUES("3222","de","_SUBJECT_EMPTY_ALERT","Betreff darf nicht leer sein!");
INSERT INTO meda_vocabulary VALUES("3223","en","_SUBMIT","Submit");
INSERT INTO meda_vocabulary VALUES("3224","es","_SUBMIT","Submit");
INSERT INTO meda_vocabulary VALUES("3225","de","_SUBMIT","Eintragen");
INSERT INTO meda_vocabulary VALUES("3226","en","_SUBMIT_PAYMENT","Submit Payment");
INSERT INTO meda_vocabulary VALUES("3227","es","_SUBMIT_PAYMENT","Presentar el pago");
INSERT INTO meda_vocabulary VALUES("3228","de","_SUBMIT_PAYMENT","Submit Zahlung");
INSERT INTO meda_vocabulary VALUES("3229","en","_SUBSCRIBE","Subscribe");
INSERT INTO meda_vocabulary VALUES("3230","es","_SUBSCRIBE","Suscribir");
INSERT INTO meda_vocabulary VALUES("3231","de","_SUBSCRIBE","Zeichnen");
INSERT INTO meda_vocabulary VALUES("3232","en","_SUBSCRIBE_EMAIL_EXISTS_ALERT","Someone with such email has already been subscribed to our newsletter. Please choose another email address for subscription.");
INSERT INTO meda_vocabulary VALUES("3233","es","_SUBSCRIBE_EMAIL_EXISTS_ALERT","Alguien con el correo electrónico como ya se ha suscrito a nuestro boletín de noticias. Por favor, elija otra dirección de correo electrónico para la suscripción.");
INSERT INTO meda_vocabulary VALUES("3234","de","_SUBSCRIBE_EMAIL_EXISTS_ALERT","Jemand mit einer solchen E-Mail hat schon unseren Newsletter abonniert worden. Bitte wählen Sie ein anderes E-Mail-Adresse zum Bezug anzubieten.");
INSERT INTO meda_vocabulary VALUES("3235","en","_SUBSCRIBE_TO_NEWSLETTER","Newsletter Subscription");
INSERT INTO meda_vocabulary VALUES("3236","es","_SUBSCRIBE_TO_NEWSLETTER","Suscríbete al boletín de noticias");
INSERT INTO meda_vocabulary VALUES("3237","de","_SUBSCRIBE_TO_NEWSLETTER","Newsletter abonnieren");
INSERT INTO meda_vocabulary VALUES("3238","en","_SUBSCRIPTION_ALREADY_SENT","You have already subscribed to our newsletter. Please try again later or wait _WAIT_ seconds.");
INSERT INTO meda_vocabulary VALUES("3239","es","_SUBSCRIPTION_ALREADY_SENT","Ya se ha suscrito a nuestro boletín. Por favor, inténtelo de nuevo más tarde o esperar unos segundos _WAIT_.");
INSERT INTO meda_vocabulary VALUES("3240","de","_SUBSCRIPTION_ALREADY_SENT","Sie haben bereits unseren Newsletter abonniert. Bitte versuchen Sie es später noch einmal oder warten _WAIT_ Sekunden.");
INSERT INTO meda_vocabulary VALUES("3241","en","_SUBSCRIPTION_MANAGEMENT","Subscription Management");
INSERT INTO meda_vocabulary VALUES("3242","es","_SUBSCRIPTION_MANAGEMENT","De administración de suscripciones");
INSERT INTO meda_vocabulary VALUES("3243","de","_SUBSCRIPTION_MANAGEMENT","Abo-Verwaltung");
INSERT INTO meda_vocabulary VALUES("3244","en","_SUBTOTAL","Subtotal");
INSERT INTO meda_vocabulary VALUES("3245","es","_SUBTOTAL","Total parcial");
INSERT INTO meda_vocabulary VALUES("3246","de","_SUBTOTAL","Zwischensumme");
INSERT INTO meda_vocabulary VALUES("3247","en","_SUNDAY","Sunday");
INSERT INTO meda_vocabulary VALUES("3248","es","_SUNDAY","domingo");
INSERT INTO meda_vocabulary VALUES("3249","de","_SUNDAY","Sonntag");
INSERT INTO meda_vocabulary VALUES("3250","en","_SWITCH_TO_EXPORT","Switch to Export");
INSERT INTO meda_vocabulary VALUES("3251","es","_SWITCH_TO_EXPORT","Cambiar a la exportación");
INSERT INTO meda_vocabulary VALUES("3252","de","_SWITCH_TO_EXPORT","Schalter für den Export");
INSERT INTO meda_vocabulary VALUES("3253","en","_SWITCH_TO_NORMAL","Switch to Normal");
INSERT INTO meda_vocabulary VALUES("3254","es","_SWITCH_TO_NORMAL","Cambiar a la normal");
INSERT INTO meda_vocabulary VALUES("3255","de","_SWITCH_TO_NORMAL","Wechseln Sie zur Normalansicht");
INSERT INTO meda_vocabulary VALUES("3256","en","_SYMBOL","Symbol");
INSERT INTO meda_vocabulary VALUES("3257","es","_SYMBOL","Símbolo");
INSERT INTO meda_vocabulary VALUES("3258","de","_SYMBOL","Symbol");
INSERT INTO meda_vocabulary VALUES("3259","en","_SYMBOL_PLACEMENT","Symbol Placement");
INSERT INTO meda_vocabulary VALUES("3260","es","_SYMBOL_PLACEMENT","Ubicación de Símbolo");
INSERT INTO meda_vocabulary VALUES("3261","de","_SYMBOL_PLACEMENT","Symbolplatzierung");
INSERT INTO meda_vocabulary VALUES("3262","en","_SYSTEM","System");
INSERT INTO meda_vocabulary VALUES("3263","es","_SYSTEM","Sistema");
INSERT INTO meda_vocabulary VALUES("3264","de","_SYSTEM","System");
INSERT INTO meda_vocabulary VALUES("3265","en","_SYSTEM_EMAIL_DELETE_ALERT","This email template is used by the system and cannot be deleted!");
INSERT INTO meda_vocabulary VALUES("3266","es","_SYSTEM_EMAIL_DELETE_ALERT","Esta plantilla de correo electrónico es utilizado por el sistema y no se puede eliminar!");
INSERT INTO meda_vocabulary VALUES("3267","de","_SYSTEM_EMAIL_DELETE_ALERT","Diese E-Mail-Vorlage wird durch das System verwendet und kann nicht gelöscht werden!");
INSERT INTO meda_vocabulary VALUES("3268","en","_SYSTEM_MODULE","System Module");
INSERT INTO meda_vocabulary VALUES("3269","es","_SYSTEM_MODULE","Módulo del Sistema");
INSERT INTO meda_vocabulary VALUES("3270","de","_SYSTEM_MODULE","System-Modul");
INSERT INTO meda_vocabulary VALUES("3271","en","_SYSTEM_MODULES","System Modules");
INSERT INTO meda_vocabulary VALUES("3272","es","_SYSTEM_MODULES","Sistema de Módulos");
INSERT INTO meda_vocabulary VALUES("3273","de","_SYSTEM_MODULES","System-Module");
INSERT INTO meda_vocabulary VALUES("3274","en","_SYSTEM_MODULE_ACTIONS_BLOCKED","All operations with system module are blocked!");
INSERT INTO meda_vocabulary VALUES("3275","es","_SYSTEM_MODULE_ACTIONS_BLOCKED","Todas las operaciones con el módulo del sistema están bloqueados!");
INSERT INTO meda_vocabulary VALUES("3276","de","_SYSTEM_MODULE_ACTIONS_BLOCKED","Alle Operationen mit System-Modul blockiert sind!");
INSERT INTO meda_vocabulary VALUES("3277","en","_SYSTEM_TEMPLATE","System Template");
INSERT INTO meda_vocabulary VALUES("3278","es","_SYSTEM_TEMPLATE","System plantilla");
INSERT INTO meda_vocabulary VALUES("3279","de","_SYSTEM_TEMPLATE","System Vorlage");
INSERT INTO meda_vocabulary VALUES("3280","en","_TAG","Tag");
INSERT INTO meda_vocabulary VALUES("3281","es","_TAG","Tag");
INSERT INTO meda_vocabulary VALUES("3282","de","_TAG","Begriffe");
INSERT INTO meda_vocabulary VALUES("3283","en","_TAG_TITLE_IS_EMPTY","Tag &lt;TITLE&gt; cannot be empty! Please re-enter.");
INSERT INTO meda_vocabulary VALUES("3284","es","_TAG_TITLE_IS_EMPTY","&lt;Title&gt; no puede estar vacío! Por favor, introduzca");
INSERT INTO meda_vocabulary VALUES("3285","de","_TAG_TITLE_IS_EMPTY","&lt;TITLE&gt; Tag nicht leer sein! Bitte erneut eingeben.");
INSERT INTO meda_vocabulary VALUES("3286","en","_TARGET","Target");
INSERT INTO meda_vocabulary VALUES("3287","es","_TARGET","Meta");
INSERT INTO meda_vocabulary VALUES("3288","de","_TARGET","Ziel");
INSERT INTO meda_vocabulary VALUES("3289","en","_TEMPLATES_STYLES","Templates & Styles");
INSERT INTO meda_vocabulary VALUES("3290","es","_TEMPLATES_STYLES","Plantillas y Estilos");
INSERT INTO meda_vocabulary VALUES("3291","de","_TEMPLATES_STYLES","Templates & Styles");
INSERT INTO meda_vocabulary VALUES("3292","en","_TEMPLATE_CODE","Template code");
INSERT INTO meda_vocabulary VALUES("3293","es","_TEMPLATE_CODE","Plantilla de código");
INSERT INTO meda_vocabulary VALUES("3294","de","_TEMPLATE_CODE","Template-Code");
INSERT INTO meda_vocabulary VALUES("3295","en","_TEMPLATE_IS_EMPTY","Template cannot be empty! Please re-enter.");
INSERT INTO meda_vocabulary VALUES("3296","es","_TEMPLATE_IS_EMPTY","Plantilla no puede estar vacía! Por favor, vuelva a entrar.");
INSERT INTO meda_vocabulary VALUES("3297","de","_TEMPLATE_IS_EMPTY","Vorlage kann nicht leer sein! Bitte erneut eingeben.");
INSERT INTO meda_vocabulary VALUES("3298","en","_TEST_EMAIL","Test Email");
INSERT INTO meda_vocabulary VALUES("3299","es","_TEST_EMAIL","Prueba de correo electrónico");
INSERT INTO meda_vocabulary VALUES("3300","de","_TEST_EMAIL","Test-E-Mail");
INSERT INTO meda_vocabulary VALUES("3301","en","_TEST_MODE_ALERT","Test Mode in Payment Module is turned ON! To change current mode click <a href=index.php?admin=mod_payments_settings>here</a>.");
INSERT INTO meda_vocabulary VALUES("3302","es","_TEST_MODE_ALERT","Modo de prueba en el módulo de pago se pone en ON! Para cambiar <a actual, haga clic en el modo de href=index.php?admin=mod_payments_settings>aquí </a>.");
INSERT INTO meda_vocabulary VALUES("3303","de","_TEST_MODE_ALERT","Testmodus in Zahlung Modul ist eingeschaltet! Um aktuelle Modus ändern, klicken Sie <a href=index.php?admin=mod_payments_settings>hier</a>.");
INSERT INTO meda_vocabulary VALUES("3304","en","_TEST_MODE_ALERT_SHORT","Payment Module is running in Test Mode!");
INSERT INTO meda_vocabulary VALUES("3305","es","_TEST_MODE_ALERT_SHORT","Módulo de pago se está ejecutando en modo de prueba!");
INSERT INTO meda_vocabulary VALUES("3306","de","_TEST_MODE_ALERT_SHORT","Zahlung Modul wird im Test-Modus läuft!");
INSERT INTO meda_vocabulary VALUES("3307","en","_TEXT","Text");
INSERT INTO meda_vocabulary VALUES("3308","es","_TEXT","Texto");
INSERT INTO meda_vocabulary VALUES("3309","de","_TEXT","Text");
INSERT INTO meda_vocabulary VALUES("3310","en","_TEXT_DIRECTION_ALERT","For Administration Panel only");
INSERT INTO meda_vocabulary VALUES("3311","es","_TEXT_DIRECTION_ALERT","Para Panel de Administración sólo");
INSERT INTO meda_vocabulary VALUES("3312","de","_TEXT_DIRECTION_ALERT","Für Administration Panel nur");
INSERT INTO meda_vocabulary VALUES("3313","en","_THUMBNAIL","Thumbnail");
INSERT INTO meda_vocabulary VALUES("3314","es","_THUMBNAIL","Miniatura");
INSERT INTO meda_vocabulary VALUES("3315","de","_THUMBNAIL","Vorschaubild");
INSERT INTO meda_vocabulary VALUES("3316","en","_THUMBNAIL_CREATE_TOOLTIP","creates thumbnail _SIZE_");
INSERT INTO meda_vocabulary VALUES("3317","es","_THUMBNAIL_CREATE_TOOLTIP","crea _SIZE_ miniaturas");
INSERT INTO meda_vocabulary VALUES("3318","de","_THUMBNAIL_CREATE_TOOLTIP","erstellt Thumbnail _SIZE_");
INSERT INTO meda_vocabulary VALUES("3319","en","_THURSDAY","Thursday");
INSERT INTO meda_vocabulary VALUES("3320","es","_THURSDAY","jueves");
INSERT INTO meda_vocabulary VALUES("3321","de","_THURSDAY","Donnerstag");
INSERT INTO meda_vocabulary VALUES("3322","en","_TIME","Time");
INSERT INTO meda_vocabulary VALUES("3323","es","_TIME","Tiempo");
INSERT INTO meda_vocabulary VALUES("3324","de","_TIME","Zeit");
INSERT INTO meda_vocabulary VALUES("3325","en","_TIMEOFF","Timeoff");
INSERT INTO meda_vocabulary VALUES("3326","es","_TIMEOFF","Tiempo libre");
INSERT INTO meda_vocabulary VALUES("3327","de","_TIMEOFF","Auszeit");
INSERT INTO meda_vocabulary VALUES("3328","en","_TIME_BLOCKS","Time Blocks");
INSERT INTO meda_vocabulary VALUES("3329","es","_TIME_BLOCKS","Bloques de tiempo");
INSERT INTO meda_vocabulary VALUES("3330","de","_TIME_BLOCKS","Zeitblöcke");
INSERT INTO meda_vocabulary VALUES("3331","en","_TIME_FORMAT","Time Format");
INSERT INTO meda_vocabulary VALUES("3332","es","_TIME_FORMAT","Formato de hora");
INSERT INTO meda_vocabulary VALUES("3333","de","_TIME_FORMAT","Zeitformat");
INSERT INTO meda_vocabulary VALUES("3334","en","_TIME_SLOTS","Time Slots");
INSERT INTO meda_vocabulary VALUES("3335","es","_TIME_SLOTS","Intervalos de tiempo");
INSERT INTO meda_vocabulary VALUES("3336","de","_TIME_SLOTS","Zeitschlitze");
INSERT INTO meda_vocabulary VALUES("3337","en","_TIME_ZONE","Time Zone");
INSERT INTO meda_vocabulary VALUES("3338","es","_TIME_ZONE","Zona horaria");
INSERT INTO meda_vocabulary VALUES("3339","de","_TIME_ZONE","Time Zone");
INSERT INTO meda_vocabulary VALUES("3340","en","_TITLE","Title");
INSERT INTO meda_vocabulary VALUES("3341","es","_TITLE","Título");
INSERT INTO meda_vocabulary VALUES("3342","de","_TITLE","Titel");
INSERT INTO meda_vocabulary VALUES("3343","en","_TODAY","Today");
INSERT INTO meda_vocabulary VALUES("3344","es","_TODAY","Hoy");
INSERT INTO meda_vocabulary VALUES("3345","de","_TODAY","Heute");
INSERT INTO meda_vocabulary VALUES("3346","en","_TODAY_APPOINTMENTS","Today\'s Appointments");
INSERT INTO meda_vocabulary VALUES("3347","es","_TODAY_APPOINTMENTS","Las citas de hoy");
INSERT INTO meda_vocabulary VALUES("3348","de","_TODAY_APPOINTMENTS","Heutige Termine");
INSERT INTO meda_vocabulary VALUES("3349","en","_TOP","Top");
INSERT INTO meda_vocabulary VALUES("3350","es","_TOP","Superior");
INSERT INTO meda_vocabulary VALUES("3351","de","_TOP","Oben");
INSERT INTO meda_vocabulary VALUES("3352","en","_TOTAL","Total");
INSERT INTO meda_vocabulary VALUES("3353","es","_TOTAL","Total");
INSERT INTO meda_vocabulary VALUES("3354","de","_TOTAL","Insgesamt");
INSERT INTO meda_vocabulary VALUES("3355","en","_TOTAL_PRICE","Total Price");
INSERT INTO meda_vocabulary VALUES("3356","es","_TOTAL_PRICE","Precio Total");
INSERT INTO meda_vocabulary VALUES("3357","de","_TOTAL_PRICE","Gesamtpreis");
INSERT INTO meda_vocabulary VALUES("3358","en","_TO_TIME","To Time");
INSERT INTO meda_vocabulary VALUES("3359","es","_TO_TIME","Para Tiempo");
INSERT INTO meda_vocabulary VALUES("3360","de","_TO_TIME","Um Zeit");
INSERT INTO meda_vocabulary VALUES("3361","en","_TRANSACTION","Transaction");
INSERT INTO meda_vocabulary VALUES("3362","es","_TRANSACTION","Transacción");
INSERT INTO meda_vocabulary VALUES("3363","de","_TRANSACTION","Transaktion");
INSERT INTO meda_vocabulary VALUES("3364","en","_TRANSLATE_VIA_GOOGLE","Translate via Google");
INSERT INTO meda_vocabulary VALUES("3365","es","_TRANSLATE_VIA_GOOGLE","Traducir a través de Google");
INSERT INTO meda_vocabulary VALUES("3366","de","_TRANSLATE_VIA_GOOGLE","Übersetzen mit Google");
INSERT INTO meda_vocabulary VALUES("3367","en","_TRASH","Trash");
INSERT INTO meda_vocabulary VALUES("3368","es","_TRASH","Basura");
INSERT INTO meda_vocabulary VALUES("3369","de","_TRASH","Müll");
INSERT INTO meda_vocabulary VALUES("3370","en","_TRASH_PAGES","Trash Pages");
INSERT INTO meda_vocabulary VALUES("3371","es","_TRASH_PAGES","Papelera Páginas");
INSERT INTO meda_vocabulary VALUES("3372","de","_TRASH_PAGES","Trash Seiten");
INSERT INTO meda_vocabulary VALUES("3373","en","_TRUNCATE_RELATED_TABLES","Truncate related tables?");
INSERT INTO meda_vocabulary VALUES("3374","es","_TRUNCATE_RELATED_TABLES","Truncar tablas relacionadas?");
INSERT INTO meda_vocabulary VALUES("3375","de","_TRUNCATE_RELATED_TABLES","Truncate verknüpften Tabellen?");
INSERT INTO meda_vocabulary VALUES("3376","en","_TRY_LATER","An error occurred while executing. Please try again later!");
INSERT INTO meda_vocabulary VALUES("3377","es","_TRY_LATER","Se produjo un error mientras que la ejecución. Por favor, inténtelo de nuevo más tarde!");
INSERT INTO meda_vocabulary VALUES("3378","de","_TRY_LATER","Ein Fehler Trat während der ausführung der Operation. Bitte versuchen Sie Es Noch Einmal später!");
INSERT INTO meda_vocabulary VALUES("3379","en","_TUESDAY","Tuesday");
INSERT INTO meda_vocabulary VALUES("3380","es","_TUESDAY","martes");
INSERT INTO meda_vocabulary VALUES("3381","de","_TUESDAY","Dienstag");
INSERT INTO meda_vocabulary VALUES("3382","en","_TYPE","Type");
INSERT INTO meda_vocabulary VALUES("3383","es","_TYPE","Tipo");
INSERT INTO meda_vocabulary VALUES("3384","de","_TYPE","Typ");
INSERT INTO meda_vocabulary VALUES("3385","en","_TYPE_CHARS","Type the characters you see in the picture");
INSERT INTO meda_vocabulary VALUES("3386","es","_TYPE_CHARS","Escriba los caracteres que ve en la imagen");
INSERT INTO meda_vocabulary VALUES("3387","de","_TYPE_CHARS","Geben Sie die Zeichen im Bild sehen");
INSERT INTO meda_vocabulary VALUES("3388","en","_UNCATEGORIZED","Uncategorized");
INSERT INTO meda_vocabulary VALUES("3389","es","_UNCATEGORIZED","Hasta");
INSERT INTO meda_vocabulary VALUES("3390","de","_UNCATEGORIZED","Uncategorized");
INSERT INTO meda_vocabulary VALUES("3391","en","_UNDEFINED","undefined");
INSERT INTO meda_vocabulary VALUES("3392","es","_UNDEFINED","indefinido");
INSERT INTO meda_vocabulary VALUES("3393","de","_UNDEFINED","undefiniert");
INSERT INTO meda_vocabulary VALUES("3394","en","_UNINSTALL","Uninstall");
INSERT INTO meda_vocabulary VALUES("3395","es","_UNINSTALL","Desinstalar");
INSERT INTO meda_vocabulary VALUES("3396","de","_UNINSTALL","Deinstallieren");
INSERT INTO meda_vocabulary VALUES("3397","en","_UNKNOWN","Unknown");
INSERT INTO meda_vocabulary VALUES("3398","es","_UNKNOWN","Desconocido");
INSERT INTO meda_vocabulary VALUES("3399","de","_UNKNOWN","Unbekannt");
INSERT INTO meda_vocabulary VALUES("3400","en","_UNLIMITED","unlimited");
INSERT INTO meda_vocabulary VALUES("3401","es","_UNLIMITED","ilimitado");
INSERT INTO meda_vocabulary VALUES("3402","de","_UNLIMITED","unbegrenzt");
INSERT INTO meda_vocabulary VALUES("3403","en","_UNSUBSCRIBE","Unsubscribe");
INSERT INTO meda_vocabulary VALUES("3404","es","_UNSUBSCRIBE","Darse de baja");
INSERT INTO meda_vocabulary VALUES("3405","de","_UNSUBSCRIBE","Unsubscribe");
INSERT INTO meda_vocabulary VALUES("3406","en","_UP","Up");
INSERT INTO meda_vocabulary VALUES("3407","es","_UP","Arriba");
INSERT INTO meda_vocabulary VALUES("3408","de","_UP","Bis");
INSERT INTO meda_vocabulary VALUES("3409","en","_UPCOMING_APPOINTMENTS","Upcoming Appointments");
INSERT INTO meda_vocabulary VALUES("3410","es","_UPCOMING_APPOINTMENTS","Próximas citas");
INSERT INTO meda_vocabulary VALUES("3411","de","_UPCOMING_APPOINTMENTS","Upcoming Appointments");
INSERT INTO meda_vocabulary VALUES("3412","en","_UPDATING_ACCOUNT_ERROR","An error occurred while updating your account! Please try again later or send information about this error to administration of the site.");
INSERT INTO meda_vocabulary VALUES("3413","es","_UPDATING_ACCOUNT_ERROR","Se produjo un error al actualizar su cuenta! Por favor, inténtelo de nuevo más tarde o enviar información sobre este error a la administración del sitio.");
INSERT INTO meda_vocabulary VALUES("3414","de","_UPDATING_ACCOUNT_ERROR","Fehler beim Aktualisieren Sie Ihr Konto! Bitte versuchen Sie es später noch einmal oder senden Sie Informationen zu diesem Fehler zur Verwaltung der Website.");
INSERT INTO meda_vocabulary VALUES("3415","en","_UPDATING_OPERATION_COMPLETED","Updating operation has been successfully completed!");
INSERT INTO meda_vocabulary VALUES("3416","es","_UPDATING_OPERATION_COMPLETED","Actualización de la operación se completó con éxito!");
INSERT INTO meda_vocabulary VALUES("3417","de","_UPDATING_OPERATION_COMPLETED","Aktualisierung ist erfolgreich abgeschlossen!");
INSERT INTO meda_vocabulary VALUES("3418","en","_UPLOAD","Upload");
INSERT INTO meda_vocabulary VALUES("3419","es","_UPLOAD","Cargar");
INSERT INTO meda_vocabulary VALUES("3420","de","_UPLOAD","Upload");
INSERT INTO meda_vocabulary VALUES("3421","en","_UPLOAD_AND_PROCCESS","Upload and Process");
INSERT INTO meda_vocabulary VALUES("3422","es","_UPLOAD_AND_PROCCESS","Subir y Proceso");
INSERT INTO meda_vocabulary VALUES("3423","de","_UPLOAD_AND_PROCCESS","Upload-und Prozessmanagement");
INSERT INTO meda_vocabulary VALUES("3424","en","_UPLOAD_FROM_FILE","Upload from File");
INSERT INTO meda_vocabulary VALUES("3425","es","_UPLOAD_FROM_FILE","Cargar desde archivo");
INSERT INTO meda_vocabulary VALUES("3426","de","_UPLOAD_FROM_FILE","Upload von Datei");
INSERT INTO meda_vocabulary VALUES("3427","en","_UPLOAD_IMAGES_TO_GALLERY","Click to upload images to gallery.");
INSERT INTO meda_vocabulary VALUES("3428","es","_UPLOAD_IMAGES_TO_GALLERY","Haga clic para subir imágenes a la galería.");
INSERT INTO meda_vocabulary VALUES("3429","de","_UPLOAD_IMAGES_TO_GALLERY","Klicken Sie auf die Bilder auf Galerie hochladen.");
INSERT INTO meda_vocabulary VALUES("3430","en","_URL","URL");
INSERT INTO meda_vocabulary VALUES("3431","es","_URL","URL");
INSERT INTO meda_vocabulary VALUES("3432","de","_URL","URL");
INSERT INTO meda_vocabulary VALUES("3433","en","_USED_ON","Used On");
INSERT INTO meda_vocabulary VALUES("3434","es","_USED_ON","Se utiliza en");
INSERT INTO meda_vocabulary VALUES("3435","de","_USED_ON","Verwendet auf");
INSERT INTO meda_vocabulary VALUES("3436","en","_USERNAME","Username");
INSERT INTO meda_vocabulary VALUES("3437","es","_USERNAME","Nombre de usuario");
INSERT INTO meda_vocabulary VALUES("3438","de","_USERNAME","Benutzername");
INSERT INTO meda_vocabulary VALUES("3439","en","_USERNAME_AND_PASSWORD","Username & Password");
INSERT INTO meda_vocabulary VALUES("3440","es","_USERNAME_AND_PASSWORD","Nombre de usuario y contraseña");
INSERT INTO meda_vocabulary VALUES("3441","de","_USERNAME_AND_PASSWORD","Benutzername und Passwort");
INSERT INTO meda_vocabulary VALUES("3442","en","_USERNAME_EMPTY_ALERT","Username cannot be empty! Please re-enter.");
INSERT INTO meda_vocabulary VALUES("3443","es","_USERNAME_EMPTY_ALERT","Nombre de usuario no puede estar vacía! Por favor, vuelva a entrar.");
INSERT INTO meda_vocabulary VALUES("3444","de","_USERNAME_EMPTY_ALERT","Benutzername darf nicht leer sein! Bitte erneut eingeben.");
INSERT INTO meda_vocabulary VALUES("3445","en","_USERNAME_LENGTH_ALERT","The length of username cannot be less than 4 characters! Please re-enter.");
INSERT INTO meda_vocabulary VALUES("3446","es","_USERNAME_LENGTH_ALERT","La longitud de nombre de usuario no puede ser menos de 4 caracteres! Por favor, vuelva a entrar.");
INSERT INTO meda_vocabulary VALUES("3447","de","_USERNAME_LENGTH_ALERT","Die Länge der Benutzername darf nicht weniger als 4 Zeichen! Bitte erneut eingeben.");
INSERT INTO meda_vocabulary VALUES("3448","en","_USER_EMAIL_EXISTS_ALERT","User with such email already exists! Please choose another.");
INSERT INTO meda_vocabulary VALUES("3449","es","_USER_EMAIL_EXISTS_ALERT","Usuario con el correo electrónico ya existe! Por favor seleccione otro.");
INSERT INTO meda_vocabulary VALUES("3450","de","_USER_EMAIL_EXISTS_ALERT","User mit solchen E-Mail ist bereits vorhanden! Bitte wählen Sie einen anderen.");
INSERT INTO meda_vocabulary VALUES("3451","en","_USER_EXISTS_ALERT","User with such username already exists! Please choose another.");
INSERT INTO meda_vocabulary VALUES("3452","es","_USER_EXISTS_ALERT","Usuario con nombre de usuario ya existe! Por favor seleccione otro.");
INSERT INTO meda_vocabulary VALUES("3453","de","_USER_EXISTS_ALERT","User mit solchen Benutzername existiert bereits! Bitte wählen Sie einen anderen.");
INSERT INTO meda_vocabulary VALUES("3454","en","_USER_NAME","User name");
INSERT INTO meda_vocabulary VALUES("3455","es","_USER_NAME","Nombre de usuario");
INSERT INTO meda_vocabulary VALUES("3456","de","_USER_NAME","Benutzername");
INSERT INTO meda_vocabulary VALUES("3457","en","_USE_THIS_PASSWORD","Use this password");
INSERT INTO meda_vocabulary VALUES("3458","es","_USE_THIS_PASSWORD","Utilice esta contraseña");
INSERT INTO meda_vocabulary VALUES("3459","de","_USE_THIS_PASSWORD","Verwenden Sie dieses Kennwort");
INSERT INTO meda_vocabulary VALUES("3460","en","_VALID_FROM_DATE","Valid From Date");
INSERT INTO meda_vocabulary VALUES("3461","es","_VALID_FROM_DATE","Válido desde Fecha");
INSERT INTO meda_vocabulary VALUES("3462","de","_VALID_FROM_DATE","Gültig ab Datum");
INSERT INTO meda_vocabulary VALUES("3463","en","_VALID_TO_DATE","Valid To Date");
INSERT INTO meda_vocabulary VALUES("3464","es","_VALID_TO_DATE","Válido para");
INSERT INTO meda_vocabulary VALUES("3465","de","_VALID_TO_DATE","Gültig bis Datum");
INSERT INTO meda_vocabulary VALUES("3466","en","_VALUE","Value");
INSERT INTO meda_vocabulary VALUES("3467","es","_VALUE","Valor");
INSERT INTO meda_vocabulary VALUES("3468","de","_VALUE","Wert");
INSERT INTO meda_vocabulary VALUES("3469","en","_VAT","VAT");
INSERT INTO meda_vocabulary VALUES("3470","es","_VAT","IVA");
INSERT INTO meda_vocabulary VALUES("3471","de","_VAT","Mehrwertsteuer");
INSERT INTO meda_vocabulary VALUES("3472","en","_VERIFIED","Verified");
INSERT INTO meda_vocabulary VALUES("3473","es","_VERIFIED","Verificado");
INSERT INTO meda_vocabulary VALUES("3474","de","_VERIFIED","Verified");
INSERT INTO meda_vocabulary VALUES("3475","en","_VERIFY_APPOINTMENT","Verify Appointment");
INSERT INTO meda_vocabulary VALUES("3476","es","_VERIFY_APPOINTMENT","Compruebe Nombramiento");
INSERT INTO meda_vocabulary VALUES("3477","de","_VERIFY_APPOINTMENT","Stellen Sie sicher, Ernennung");
INSERT INTO meda_vocabulary VALUES("3478","en","_VERSION","Version");
INSERT INTO meda_vocabulary VALUES("3479","es","_VERSION","Versión");
INSERT INTO meda_vocabulary VALUES("3480","de","_VERSION","Version");
INSERT INTO meda_vocabulary VALUES("3481","en","_VIDEO","Video");
INSERT INTO meda_vocabulary VALUES("3482","es","_VIDEO","Video");
INSERT INTO meda_vocabulary VALUES("3483","de","_VIDEO","Video");
INSERT INTO meda_vocabulary VALUES("3484","en","_VIEW_ALL","View All");
INSERT INTO meda_vocabulary VALUES("3485","es","_VIEW_ALL","Ver todos");
INSERT INTO meda_vocabulary VALUES("3486","de","_VIEW_ALL","Alle anzeigen");
INSERT INTO meda_vocabulary VALUES("3487","en","_VIEW_PROFILE","View Profile");
INSERT INTO meda_vocabulary VALUES("3488","es","_VIEW_PROFILE","Ver el perfil");
INSERT INTO meda_vocabulary VALUES("3489","de","_VIEW_PROFILE","Profil");
INSERT INTO meda_vocabulary VALUES("3490","en","_VIEW_WORD","View");
INSERT INTO meda_vocabulary VALUES("3491","es","_VIEW_WORD","Ver");
INSERT INTO meda_vocabulary VALUES("3492","de","_VIEW_WORD","Blick");
INSERT INTO meda_vocabulary VALUES("3493","en","_VISIT_DURATION","Visit Duration");
INSERT INTO meda_vocabulary VALUES("3494","es","_VISIT_DURATION","Duración de la visita");
INSERT INTO meda_vocabulary VALUES("3495","de","_VISIT_DURATION","Besuchen Dauer");
INSERT INTO meda_vocabulary VALUES("3496","en","_VISIT_PRICE","Visit Price");
INSERT INTO meda_vocabulary VALUES("3497","es","_VISIT_PRICE","Visita Precio");
INSERT INTO meda_vocabulary VALUES("3498","de","_VISIT_PRICE","Besuchen Preis");
INSERT INTO meda_vocabulary VALUES("3499","en","_VISIT_REASON","Visit Reason");
INSERT INTO meda_vocabulary VALUES("3500","es","_VISIT_REASON","Visita Razón");
INSERT INTO meda_vocabulary VALUES("3501","de","_VISIT_REASON","Besuchen Grund");
INSERT INTO meda_vocabulary VALUES("3502","en","_VISIT_REASONS","Visit Reasons");
INSERT INTO meda_vocabulary VALUES("3503","es","_VISIT_REASONS","Visita Razones");
INSERT INTO meda_vocabulary VALUES("3504","de","_VISIT_REASONS","Besuchen Gründe");
INSERT INTO meda_vocabulary VALUES("3505","en","_VISIT_REASONS_MANAGEMENT","Visit Reasons Management");
INSERT INTO meda_vocabulary VALUES("3506","es","_VISIT_REASONS_MANAGEMENT","Visita Gestión Razones");
INSERT INTO meda_vocabulary VALUES("3507","de","_VISIT_REASONS_MANAGEMENT","Besuchen Gründe Verwaltung");
INSERT INTO meda_vocabulary VALUES("3508","en","_VISUAL_SETTINGS","Visual Settings");
INSERT INTO meda_vocabulary VALUES("3509","es","_VISUAL_SETTINGS","Ajustes Visual");
INSERT INTO meda_vocabulary VALUES("3510","de","_VISUAL_SETTINGS","Visuelle Einstellungen");
INSERT INTO meda_vocabulary VALUES("3511","en","_VOCABULARY","Vocabulary");
INSERT INTO meda_vocabulary VALUES("3512","es","_VOCABULARY","Vocabulario");
INSERT INTO meda_vocabulary VALUES("3513","de","_VOCABULARY","Wortschatz");
INSERT INTO meda_vocabulary VALUES("3514","en","_VOC_KEYS_UPDATED","Operation has been successfully completed. Updated: _KEYS_ keys. Click <a href=\'index.php?admin=vocabulary&filter_by=A\'>here</a> to refresh the site.");
INSERT INTO meda_vocabulary VALUES("3515","es","_VOC_KEYS_UPDATED","La operación se completó con éxito. Actualización: claves _KEYS_. Haga clic en href=\'index.php?admin=vocabulary&filter_by=A\'>aquí</a> para volver a cargar el sitio.");
INSERT INTO meda_vocabulary VALUES("3516","de","_VOC_KEYS_UPDATED","Operation wurde erfolgreich abgeschlossen. Aktualisiert: _KEYS_ Tasten. Klicken Sie <a href=\'index.php?admin=vocabulary&filter_by=A\'>hier</a>, um die Website zu aktualisieren.");
INSERT INTO meda_vocabulary VALUES("3517","en","_VOC_KEY_UPDATED","Vocabulary key has been successfully updated.");
INSERT INTO meda_vocabulary VALUES("3518","es","_VOC_KEY_UPDATED","Vocabulario clave se ha actualizado correctamente.");
INSERT INTO meda_vocabulary VALUES("3519","de","_VOC_KEY_UPDATED","Wortschatz Schlüssel wurde erfolgreich aktualisiert.");
INSERT INTO meda_vocabulary VALUES("3520","en","_VOC_KEY_VALUE_EMPTY","Key value cannot be empty! Please re-enter.");
INSERT INTO meda_vocabulary VALUES("3521","es","_VOC_KEY_VALUE_EMPTY","Valor de la clave no puede estar vacía! Por favor, vuelva a entrar.");
INSERT INTO meda_vocabulary VALUES("3522","de","_VOC_KEY_VALUE_EMPTY","Key-Wert darf nicht leer sein! Bitte erneut eingeben.");
INSERT INTO meda_vocabulary VALUES("3523","en","_VOC_NOT_FOUND","No keys found");
INSERT INTO meda_vocabulary VALUES("3524","es","_VOC_NOT_FOUND","No hay teclas que se encuentran");
INSERT INTO meda_vocabulary VALUES("3525","de","_VOC_NOT_FOUND","Kein Schlüssel gefunden");
INSERT INTO meda_vocabulary VALUES("3526","en","_VOC_UPDATED","Vocabulary has been successfully updated. Click <a href=\'index.php\'>here</a> to refresh the site.");
INSERT INTO meda_vocabulary VALUES("3527","es","_VOC_UPDATED","Vocabulario se ha actualizado correctamente. Haga clic <a href=\'index.php\'>aquí</a> para actualizar el sitio.");
INSERT INTO meda_vocabulary VALUES("3528","de","_VOC_UPDATED","Wortschatz wurde erfolgreich aktualisiert. Klicken Sie <a href=index.php>hier</a>, um Website aktualisieren.");
INSERT INTO meda_vocabulary VALUES("3529","en","_VOTE_NOT_REGISTERED","Your vote has not been registered! You must be logged in as a patient before you can vote.");
INSERT INTO meda_vocabulary VALUES("3530","es","_VOTE_NOT_REGISTERED","Su voto no se ha registrado? Debe estar registrado como paciente antes de poder votar.");
INSERT INTO meda_vocabulary VALUES("3531","de","_VOTE_NOT_REGISTERED","Ihre Stimme wurde nicht registriert! Sie müssen als Patienten eingeloggt sein, bevor Sie wählen können.");
INSERT INTO meda_vocabulary VALUES("3532","en","_WEB_SITE","Web Site");
INSERT INTO meda_vocabulary VALUES("3533","es","_WEB_SITE","Sitio Web");
INSERT INTO meda_vocabulary VALUES("3534","de","_WEB_SITE","Web-Site");
INSERT INTO meda_vocabulary VALUES("3535","en","_WEDNESDAY","Wednesday");
INSERT INTO meda_vocabulary VALUES("3536","es","_WEDNESDAY","miércoles");
INSERT INTO meda_vocabulary VALUES("3537","de","_WEDNESDAY","Mittwoch");
INSERT INTO meda_vocabulary VALUES("3538","en","_WEEK_DAY","Week Day");
INSERT INTO meda_vocabulary VALUES("3539","es","_WEEK_DAY","Día de la semana");
INSERT INTO meda_vocabulary VALUES("3540","de","_WEEK_DAY","Tag der Woche");
INSERT INTO meda_vocabulary VALUES("3541","en","_WEEK_START_DAY","Week Start Day");
INSERT INTO meda_vocabulary VALUES("3542","es","_WEEK_START_DAY","Semana Día de inicio");
INSERT INTO meda_vocabulary VALUES("3543","de","_WEEK_START_DAY","Woche Starttag");
INSERT INTO meda_vocabulary VALUES("3544","en","_WELCOME_ADMIN","welcome to Admin Panel!");
INSERT INTO meda_vocabulary VALUES("3545","es","_WELCOME_ADMIN","Bienvenido a Panel de Administración!");
INSERT INTO meda_vocabulary VALUES("3546","de","_WELCOME_ADMIN","Willkommen auf dem Admin Panel!");
INSERT INTO meda_vocabulary VALUES("3547","en","_WELCOME_DOCTOR_TEXT","<p>Hello <b>_FIRST_NAME_ _LAST_NAME_</b>!</p><p>Welcome to Doctor\'s Account Panel, that allows you to view account status, manage your account settings etc.</p><p>_TODAY_<br />_LAST_LOGIN_</p><p><b>&#8226;</b> To view this account summary just click on a <a href=\'index.php?doctor=home\'>Dashboard</a> link.</p><p><b>&#8226;</b> <a href=\'index.php?doctor=my_account\'>Edit My Account</a> page allows you to change your personal info and account data.</p>\n<p><b>&#8226;</b> <a href=\'index.php?doctor=my_specialities\'>My Specialities</a> page allows you to manage your specialities.</p>\n<p><b>&#8226;</b> <a href=\'index.php?doctor=my_addresses\'>My Addresses</a> page allows you to manage the addresses where doctor accepts patients.</p>\n<p><b>&#8226;</b> <a href=\'index.php?doctor=appointments\'>My Appointments</a> page allows you to review and manage your appointments.</p>");
INSERT INTO meda_vocabulary VALUES("3548","es","_WELCOME_DOCTOR_TEXT","<p>Hola <b>_FIRST_NAME_ _LAST_NAME_</b>!</p><p>Bienvenido a Grupo cuenta del médico, que le permite ver el estado de cuenta, gestionar la configuración de cuenta, etc.</p><p>_TODAY_<br />_LAST_LOGIN_</p><p><b>&#8226;</b> Para ver el resumen de cuenta basta con hacer clic en un enlace <a href=\'index.php?doctor=home\'>Salpicadero</a>.</p><p><b>&#8226;</b> <a href=\'index.php?doctor=my_account\'>Editar Mi Cuenta</a> página le permite cambiar su información personal y los datos de la cuenta.</p>\n<p><b>&#8226;</b> <a href=\'index.php?doctor=my_specialities\'>Mis Especialidades</a> página le permite administrar sus especialidades..</p>\n<p><b>&#8226;</b> <a href=\'index.php?doctor=my_addresses\'>Mis Direcciones</a> página le permite administrar las direcciones donde médico acepta pacientes.</p>\n<p><b>&#8226;</b> <a href=\'index.php?doctor=appointments\'>Mis Citas</a> página le permite revisar y gestionar sus citas.</p>");
INSERT INTO meda_vocabulary VALUES("3549","de","_WELCOME_DOCTOR_TEXT","<p>Hallo <b>_FIRST_NAME_ _LAST_NAME_</b>!</p><p>Welcome to Doctor Konto Panel, mit denen Sie Kontostand einsehen können, Ihr Konto zu verwalten Einstellungen usw.</p><p>_TODAY_<br />_LAST_LOGIN_</p><p><b>&#8226;</b> Um dieses Konto Zusammenfassung anzuzeigen einfach auf einen <a href=\'index.php?doctor=home\'>Armaturenbrett</a> Link klicken.</p><p><b>&#8226;</b> <a href=\'index.php?doctor=my_account\'>Mein Konto bearbeiten</a> Seite können Sie Ihre persönlichen Daten und Kontodaten ändern.</p>\n<p><b>&#8226;</b> <a href=\'index.php?doctor=my_specialities\'>Meine Spezialitäten</a> Seite können Sie Ihre Spezialitäten verwalten.</p>\n<p><b>&#8226;</b> <a href=\'index.php?doctor=my_addresses\'>Meine Adressen</a> Seite können Sie die Adressen, wo Arzt nimmt Patienten zu verwalten.</p>\n<p><b>&#8226;</b> <a href=\'index.php?doctor=appointments\'>Meine Termine</a> Seite können Sie überprüfen und Ihre Termine verwalten.</p>");
INSERT INTO meda_vocabulary VALUES("3550","en","_WELCOME_PATIENT_TEXT","<p>Hello <b>_FIRST_NAME_ _LAST_NAME_</b>!</p>\n<p>Welcome to Patient\'s Account Panel, that allows you to view account status, manage your account settings etc.</p>\n<p>_TODAY_<br />_LAST_LOGIN_</p>\n<p><b>&#8226;</b> To view this account summary just click on a <a href=\'index.php?patient=home\'>Dashboard</a> link.</p>\n<p><b>&#8226;</b> <a href=\'index.php?patient=my_account\'>Edit My Account</a> page allows you to change your personal info and account data.</p>\n<p><b>&#8226;</b> <a href=\'index.php?patient=my_appointments\'>My Appointments</a> page allows you to review and manage your appointments.</p>");
INSERT INTO meda_vocabulary VALUES("3551","es","_WELCOME_PATIENT_TEXT","<p>Hola <b> _FIRST_NAME_ _LAST_NAME_ </b></p>\n<p>Bienvenido a Grupo Cuenta pacientes mujeres, que le permite ver el estado de cuenta, gestionar los ajustes de cuentas, etc</p>\n<p>_TODAY_<br />_LAST_LOGIN_</p>\n<p><b>&#8226;</b> Para ver este resumen de la cuenta basta con hacer clic en un <a href=\'index.php?patient=home\'>Salpicadero</a> enlace.</p>\n<p><b>&#8226;</b> <a href=\'index.php?patient=my_account\'>Editar mi cuenta</a> la página le permite cambiar su información personal y datos de la cuenta.</p>\n<p><b>&#8226;</b> <a href=\'index.php?patient=my_appointments\'>Mis citas</a> la página le permite revisar y gestionar sus citas.</p>");
INSERT INTO meda_vocabulary VALUES("3552","de","_WELCOME_PATIENT_TEXT","<p>Hallo <b>_FIRST_NAME_ _LAST_NAME_</b></p>\n<p>Willkommen bei Patienten Konto Systemsteuerung, Systemsteuerung, mit denen Sie Konto-Status anzeigen, verwalten Sie Ihre Kontoeinstellungen etc.</p> \n<p>_TODAY_<br />_LAST_LOGIN_</p>\n<p><b>&#8226;</b> Um dieses Konto Zusammenfassung anzuschauen, bitte auf einer <a klicken href=\'index.php?patient=home\'>Armaturenbrett</a> Link.</p>\n<p><b>&#8226;</b> <a href=\'index.php?patient=my_account\'>Mein Konto bearbeiten</a> Alter können Sie Ihre persönlichen Daten und Kontodaten zu ändern.</p>\n<p><b>&#8226;</b> <a href=\'index.php?patient=my_appointments\'>Meine Termine</a> Alter können Sie überprüfen und verwalten Sie Ihre Termine.</p>");
INSERT INTO meda_vocabulary VALUES("3553","en","_WHAT_IS_CVV","What is CVV");
INSERT INTO meda_vocabulary VALUES("3554","es","_WHAT_IS_CVV","Qué es el CVV");
INSERT INTO meda_vocabulary VALUES("3555","de","_WHAT_IS_CVV","Was ist CVV");
INSERT INTO meda_vocabulary VALUES("3556","en","_WHEN","When");
INSERT INTO meda_vocabulary VALUES("3557","es","_WHEN","Cuando");
INSERT INTO meda_vocabulary VALUES("3558","de","_WHEN","Wann");
INSERT INTO meda_vocabulary VALUES("3559","en","_WHERE","Where");
INSERT INTO meda_vocabulary VALUES("3560","es","_WHERE","Donde");
INSERT INTO meda_vocabulary VALUES("3561","de","_WHERE","Wo");
INSERT INTO meda_vocabulary VALUES("3562","en","_WHO","Who");
INSERT INTO meda_vocabulary VALUES("3563","es","_WHO","Quién");
INSERT INTO meda_vocabulary VALUES("3564","de","_WHO","Wer");
INSERT INTO meda_vocabulary VALUES("3565","en","_WHO_IS_APPOINTMENT_FOR","Who is this appointment for?");
INSERT INTO meda_vocabulary VALUES("3566","es","_WHO_IS_APPOINTMENT_FOR","¿Quién es esta cita para que?");
INSERT INTO meda_vocabulary VALUES("3567","de","_WHO_IS_APPOINTMENT_FOR","Wer ist dieser Termin für?");
INSERT INTO meda_vocabulary VALUES("3568","en","_WIDGET_INTEGRATION_MESSAGE","You may integrate Medical Appointment search engine with another existing web site.");
INSERT INTO meda_vocabulary VALUES("3569","es","_WIDGET_INTEGRATION_MESSAGE","Usted puede integrar el motor de búsqueda de Cita Médica con otro sitio web existente.");
INSERT INTO meda_vocabulary VALUES("3570","de","_WIDGET_INTEGRATION_MESSAGE","Sie können Medical Termin Suchmaschine mit einem anderen bestehenden Website zu integrieren.");
INSERT INTO meda_vocabulary VALUES("3571","en","_WILL_YOU_USE_INSURANCE","Will you use insurance?");
INSERT INTO meda_vocabulary VALUES("3572","es","_WILL_YOU_USE_INSURANCE","¿Va a utilizar el seguro?");
INSERT INTO meda_vocabulary VALUES("3573","de","_WILL_YOU_USE_INSURANCE","Werden Sie Versicherungs benutzen?");
INSERT INTO meda_vocabulary VALUES("3574","en","_WITH","With");
INSERT INTO meda_vocabulary VALUES("3575","es","_WITH","Con");
INSERT INTO meda_vocabulary VALUES("3576","de","_WITH","Mit");
INSERT INTO meda_vocabulary VALUES("3577","en","_WORK_PHONE","Work Phone");
INSERT INTO meda_vocabulary VALUES("3578","es","_WORK_PHONE","Teléfono del trabajo");
INSERT INTO meda_vocabulary VALUES("3579","de","_WORK_PHONE","Arbeit Telefon");
INSERT INTO meda_vocabulary VALUES("3580","en","_WRONG_APPOINTMENT_CODE","Wrong confirmation code or your appointment is already confirmed!");
INSERT INTO meda_vocabulary VALUES("3581","es","_WRONG_APPOINTMENT_CODE","Código de confirmación es incorrecto o está a su nombramiento ha sido confirmado ya!");
INSERT INTO meda_vocabulary VALUES("3582","de","_WRONG_APPOINTMENT_CODE","Falsche Bestätigungscode oder Ihre Ernennung wurde bereits bestätigt!");
INSERT INTO meda_vocabulary VALUES("3583","en","_WRONG_CODE_ALERT","Sorry, the code you have entered is invalid! Please try again.");
INSERT INTO meda_vocabulary VALUES("3584","es","_WRONG_CODE_ALERT","Lo sentimos, el código que ha introducido no es válido! Por favor, inténtelo de nuevo.");
INSERT INTO meda_vocabulary VALUES("3585","de","_WRONG_CODE_ALERT","Leider war der Code, den Sie eingegeben haben ungültig! Bitte versuchen Sie es erneut.");
INSERT INTO meda_vocabulary VALUES("3586","en","_WRONG_CONFIRMATION_CODE","Wrong confirmation code or your registration has been already confirmed!");
INSERT INTO meda_vocabulary VALUES("3587","es","_WRONG_CONFIRMATION_CODE","Código de confirmación incorrecto o su registro se confirmó ya!");
INSERT INTO meda_vocabulary VALUES("3588","de","_WRONG_CONFIRMATION_CODE","Falscher Bestätigungscode oder Ihre Anmeldung wurde bereits bestätigt!");
INSERT INTO meda_vocabulary VALUES("3589","en","_WRONG_FILE_TYPE","Uploaded file is not a valid PHP vocabulary file! Please re-enter.");
INSERT INTO meda_vocabulary VALUES("3590","es","_WRONG_FILE_TYPE","El archivo subido no es un archivo válido PHP vocabulario! Por favor, vuelva a entrar.");
INSERT INTO meda_vocabulary VALUES("3591","de","_WRONG_FILE_TYPE","Datei hochgeladen ist keine gültige PHP-Datei Wortschatz! Bitte erneut eingeben.");
INSERT INTO meda_vocabulary VALUES("3592","en","_WRONG_LOGIN","Wrong username or password!");
INSERT INTO meda_vocabulary VALUES("3593","es","_WRONG_LOGIN","Nombre de usuario o contraseña incorrecta!");
INSERT INTO meda_vocabulary VALUES("3594","de","_WRONG_LOGIN","Falscher Benutzername oder Passwort!");
INSERT INTO meda_vocabulary VALUES("3595","en","_WRONG_PARAMETER_PASSED","Wrong parameters passed - cannot complete operation!");
INSERT INTO meda_vocabulary VALUES("3596","es","_WRONG_PARAMETER_PASSED","Parámetros erróneos pasado - no puede completar la operación! ");
INSERT INTO meda_vocabulary VALUES("3597","de","_WRONG_PARAMETER_PASSED","Falscher Parameter übergeben - kann nicht die gesamte Bedienung!");
INSERT INTO meda_vocabulary VALUES("3598","en","_WYSIWYG_EDITOR","WYSIWYG Editor");
INSERT INTO meda_vocabulary VALUES("3599","es","_WYSIWYG_EDITOR","Editor WYSIWYG");
INSERT INTO meda_vocabulary VALUES("3600","de","_WYSIWYG_EDITOR","WYSIWYG-Editor");
INSERT INTO meda_vocabulary VALUES("3601","en","_YEAR","year");
INSERT INTO meda_vocabulary VALUES("3602","es","_YEAR","año");
INSERT INTO meda_vocabulary VALUES("3603","de","_YEAR","jahr");
INSERT INTO meda_vocabulary VALUES("3604","en","_YEARS","years");
INSERT INTO meda_vocabulary VALUES("3605","es","_YEARS","años");
INSERT INTO meda_vocabulary VALUES("3606","de","_YEARS","jahre");
INSERT INTO meda_vocabulary VALUES("3607","en","_YES","Yes");
INSERT INTO meda_vocabulary VALUES("3608","es","_YES","Sí");
INSERT INTO meda_vocabulary VALUES("3609","de","_YES","Ja");
INSERT INTO meda_vocabulary VALUES("3610","en","_YOUR_EMAIL","Your Email");
INSERT INTO meda_vocabulary VALUES("3611","es","_YOUR_EMAIL","Su correo electrónico");
INSERT INTO meda_vocabulary VALUES("3612","de","_YOUR_EMAIL","Ihre E-Mail");
INSERT INTO meda_vocabulary VALUES("3613","en","_YOUR_NAME","Your Name");
INSERT INTO meda_vocabulary VALUES("3614","es","_YOUR_NAME","Su nombre");
INSERT INTO meda_vocabulary VALUES("3615","de","_YOUR_NAME","Ihr Name");
INSERT INTO meda_vocabulary VALUES("3616","en","_YOU_ARE_LOGGED_AS","You are logged in as");
INSERT INTO meda_vocabulary VALUES("3617","es","_YOU_ARE_LOGGED_AS","Estás conectado como");
INSERT INTO meda_vocabulary VALUES("3618","de","_YOU_ARE_LOGGED_AS","Sie sind angemeldet als");
INSERT INTO meda_vocabulary VALUES("3619","en","_ZIPCODE_EMPTY_ALERT","Zip/Postal code cannot be empty! Please re-enter.");
INSERT INTO meda_vocabulary VALUES("3620","es","_ZIPCODE_EMPTY_ALERT","Código postal no puede estar vacía! Por favor, vuelva a entrar.");
INSERT INTO meda_vocabulary VALUES("3621","de","_ZIPCODE_EMPTY_ALERT","PLZ kann nicht leer sein! Bitte erneut eingeben.");
INSERT INTO meda_vocabulary VALUES("3622","en","_ZIP_CODE","Zip/Postal code");
INSERT INTO meda_vocabulary VALUES("3623","es","_ZIP_CODE","Código Postal");
INSERT INTO meda_vocabulary VALUES("3624","de","_ZIP_CODE","Postleitzahl");



