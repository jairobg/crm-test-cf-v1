$(document).ready(function(){	

	jQuery.validator.messages.required = "";
	$("#addPropertyForm").validate({			
		submitHandler: function(form) {
			/*
			$("div.error").hide();
			alert("submit! use link below to go to the other step");
			*/
			//form.submit();
			this.submit();
		},
		debug:false
	});
	
	$("input.datefieldinput").mask("99/99/9999");
});
