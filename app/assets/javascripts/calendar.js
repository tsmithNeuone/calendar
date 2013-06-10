$(document).ready(function() {

    // page is now ready, initialize the calendar...

    $('#calendar').fullCalendar({
        // put your options and callbacks here
        weekends: true,
        selectable: true,
        unselectAuto: true,
        height: 650,
        editable: true,
        ignoreTimezone: false,
        select: function(date) {
			$("#create_event_dialog").modal('show');
			$("#event_starts_at_1i").val(date.getFullYear());
			$("#event_starts_at_2i").val((date.getMonth() + 1));
			$("#event_starts_at_3i").val(date.getDate());
			$("#event_ends_at_1i").val(date.getFullYear());
			$("#event_ends_at_2i").val((date.getMonth() + 1));
			$("#event_ends_at_3i").val(date.getDate());
	//		$(".ends_at_date_field").hide();
	//		$(".starts_at_date_field").hide();
			
	    	
         },
         
    	slotMinutes: 30,  
   		eventSources: [{  
    		url: '/sub_events',
    		color: 'rgb(230,146,0)',
   		}],
   		eventRender: function(event, element, view)
	   	{
	        element.qtip({ content: "Description: " + event.description });
	    }
    	
    });
     $('#calendar').fullCalendar('addEventSource',  '/events');

});