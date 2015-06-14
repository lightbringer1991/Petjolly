<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Ajax Full Featured Calendar 2</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <!-- styles -->
    <link href="css/bootstrap.css" rel="stylesheet">
    <link href="css/bootstrap-responsive.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
    <link href="css/smoothness/jquery-ui.css" rel="stylesheet">
    <link href="css/fullcalendar.print.css" media="print" rel="stylesheet">
    <link href="css/fullcalendar.css" rel="stylesheet">
    <link href="lib/colorpicker/css/colorpicker.css" rel="stylesheet">
    <link href="lib/spectrum/spectrum.css" rel="stylesheet">    
    <link href="lib/timepicker/jquery-ui-timepicker-addon.css" rel="stylesheet">
	    
    <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
      <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
  </head>

  <body>

    <div class="navbar navbar-default navbar-fixed-top">
      <div class="navbar-inner">
        <div class="container">
          <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </a>
          <a class="navbar-brand" href="index.php">Ajax Full Featured Calendar 2</a>
        </div>
      </div>
    </div>

    <div class="container">
	  
      <a href="index.php" class="btn btn-default pull-right" style="margin-bottom: 20px;">View Events</a>
		
      <div class="clearfix"></div>
        
      <div class="box">
        <div class="header"><h4>Add Event</h4></div>
        <div class="content pad"> 
            
            <form id="add_event">
            
                <label>Title:</label>
                <input type="text" class="validate[required] form-control" name="title" placeholder="Event Title" id="title">
                <label>Description:</label>
                <textarea class="form-control" name="description" id="description" placeholder="Event Description"></textarea>
                <div class="pull-left mr-10">
                <label>Start Date:</label>
                <input type="text" name="start_date" class="form-control input-sm validate[required]" id="datepicker">
                </div>
                <div class="pull-left">
                <label>Start Time:</label>
                <input type="text" class="form-control input-sm" name="start_time" placeholder="HH:MM" id="tp1">
                </div>
                <div class="clearfix"></div>
                <div class="pull-left mr-10">
                <label>End Date:</label>
                <input type="text" class="form-control input-sm" name="end_date" id="datepicker2">
                </div>
                <div class="pull-left">
                <label>End Time:</label>
                <input type="text" class="form-control input-sm" name="end_time" placeholder="HH:MM" id="tp2">
                </div>
                <div class="clearfix"></div>
                <div class="pull-left">
                <label>Event Color:</label>
                <input type="text" class="form-control input-sm" name="color" id="cp">
                </div>
                <div class="clearfix"></div><br />
                <label>All Day Event:</label>
                <select name="allDay" class="form-control input-sm">
                    <option value="true" selected>Yes</option>
                    <option value="false">No</option>
                </select>
                <div class="clearfix"></div>
                <div class="pull-left mr-10">
                <label>Repeat:</label>
                <select name="repeat_method" class="form-control">
                    <option value="no" selected>No</option>
                    <option value="every_day">Every Day</option>
                    <option value="every_week">Every Week</option>
                    <option value="every_month">Every Month</option>
                </select>
                </div>
                 <div class="pull-left">
                <label>Times:</label>
                <select name="repeat_times" class="form-control">
                    <option value="1" selected>1</option>
                    <?php
						for($i = 2; $i <= 30; $i++) {
							echo '<option value="'.$i.'">'.$i.'</option>';		
						}
					?>
                </select>
                </div>
                <div class="clearfix"></div>
                <label>Url:</label>
                <input type="text" class="form-control" name="url" id="url" placeholder="http://www.domain.com">
                <p class="help-block">Hint: If this event does not have url please leave blank</p>
    
                <button type="submit" onclick="calendar.save()" class="btn btn-primary pull-right">Add Event</button>
                
            </form>
            
        </div> 
    </div>

    </div> <!-- /container -->

    <!-- javascript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="lib/moment.js"></script>
    <script src="lib/jquery.js"></script>
    <script src="lib/jquery-ui.js"></script>
    <script src="js/bootstrap.js"></script>
    <script src="js/fullcalendar.js"></script>
    <script src="js/gcal.js"></script>
    <script src="js/jquery.calendar.js"></script>
    <script src="lib/colorpicker/bootstrap-colorpicker.js"></script>
	<script src="lib/spectrum/spectrum.js"></script>
    
    <script src="lib/timepicker/jquery-ui-sliderAccess.js"></script>
    <script src="lib/timepicker/jquery-ui-timepicker-addon.min.js"></script>
        
    <script src="js/custom.js"></script>
    
    <script type="text/javascript">
		$().FullCalendarExt();
	</script>

  </body>
</html>
