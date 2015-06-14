(function($){
	
	var Menu = function(element){
	  	var menu = $(element);
	  	var options = menu.children('ul').children('li');
	  	var submenu = options.children('ul').children('li');


	  	var defEvent = 'click';
	  	var multiple = false;

	  	if(menu.hasClass('bg-fixed')){
	  		$('<div class=fixed></div>').css({
	  			'width': menu.outerWidth(),
	  			'top' : 0,
	  			'left' : 0,
	  			'height' : '100%',
	  			'background' : menu.css('background')
	  		}).insertBefore(menu);
	  	}
	  	
	  	if(menu.hasClass('hover')){
	  		defEvent = 'hover';
	  	}

	  	if(menu.hasClass('multiple')){
	  		multiple = true;
	  	}


	  	options.each(function(){
	  		$this = $(this);

	  		if($this.children('ul').children('li').length > 0){
	  			
	  			//If has submenu then add image for navigation
	  			$('<img class=arrow src=images/arrow.png >').appendTo($this);

	  			//If has submenu then add event to triger the accordion
	  			$this.on(defEvent, function(evt){
	  				evt.preventDefault();

	  				$this = $(this);
	  				

	  				$this.find('.arrow').toggleClass('rotate');

		  			$this.children('ul').slideToggle(300);

		  			if(!multiple){
			  			var siblings = $this.siblings('li');
			  			siblings.children('ul').slideUp(300);

			  			siblings.each(function(){
			  				var arrow = $(this).find('.arrow');

			  				if(arrow.hasClass('rotate'))arrow.removeClass('rotate');
			  			});
		  			}
	  			});
	  		}else{

	  			$this.on('click', function(evt){
			  		evt.preventDefault();

			  		$this = $(this);

			  		var direction = $this.find('a').attr('href');
			  		if(direction!=undefined && direction!='#'){
			  			location.href=direction;
			  		}


			  	});

	  		}

	  	});
		

		submenu.each(function(){
			$this = $(this);

  			$this.on('click', function(){
		  		$this = $(this);

		  		var direction = $this.find('a').attr('href');
		  		if(direction!=undefined && direction!='#'){
		  			location.href=direction;
		  		}	
		  	});

		});

		return this;

	}


	 $.fn.menu = function() {
    
        return this.each(function(key, value){
            var element = $(this);
            // Return early if this element already has a plugin instance
            if (element.data('menu')) return element.data('menu');
            // Pass options to plugin constructor
            var menu = new Menu(this);
            // Store plugin object in this element's data
            element.data('menu', menu);
        });

	};
	
	$(document).ready(function() {
		$('.menu').menu();
	});


})(jQuery);