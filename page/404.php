<?php
/**
* @project ApPHP Medical Appointment
* @copyright (c) 2012 - 2014 ApPHP
* @author ApPHP <info@apphp.com>
* @license http://www.gnu.org/licenses/
*/

// *** Make sure the file isn't accessed directly
defined('APPHP_EXEC') or die('Restricted Access');
//--------------------------------------------------------------------------

// draw title bar
draw_title_bar(_PAGES); 

draw_content_start();
draw_important_message(_PAGE_NOT_EXISTS);
draw_content_end();
	
?>