// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .


$("#project_client_id").change(function(){  //calls this function when the selected value changes
  $.get("/projects/"+$(this).val()+"/get_json",function(data, status, xhr){  //does ajax call to the invoice route we set up above
    data = eval(data);  //turn the response text into a javascript object
    $("#project_client_contact_person_name").val(data.name);  //sets the value of the fields to the data returned
  });
});

function toggleClassSelected(id) {
        var ele = document.getElementById(id);
        $(".selected").removeClass("selected");
        ele.className = 'selected';
    }
