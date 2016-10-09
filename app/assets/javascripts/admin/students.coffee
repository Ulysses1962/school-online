# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
  $(document).ready ->
    # Adding student phones
    $("#add-phone-commit").click ->
      p_num                      = $("#student_phones").val()
      update_p_path              = $("#update_phones_path").val()
      update_p_path_with_params  = "#{update_p_path}?p_num=#{p_num}"

      $("#student_phone").val("")

      if p_num
        $.ajax update_p_path_with_params,
          type:     'GET'
          dataType: 'script'   

     # Enabling Import     
     $("#student_school_data").change ->
      $(":submit").removeAttr("disabled")                      
