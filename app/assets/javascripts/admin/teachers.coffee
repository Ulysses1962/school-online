# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  $(document).ready ->
    # Adding subjects
    $("#add-subject-commit").click ->
      idx                     = $("#teacher_subjects").val()
      update_path             = $("#update_path").val()
      update_path_with_param  = "#{update_path}?idx=#{idx}"

      $("#teacher_subjects option:eq(0)").prop("selected", true)

      if idx
        $.ajax update_path_with_param,
          type:     'GET'
          dataType: 'script'

    # Adding roles      
    $("#add-role-commit").click ->
      idr                       = $("#teacher_roles").val()
      update_r_path             = $("#update_roles_path").val()
      update_r_path_with_param  = "#{update_r_path}?idr=#{idr}"

      $("#teacher_roles option:eq(0)").prop("selected", true) 

      if idr
        $.ajax update_r_path_with_param,
          type:     'GET'
          dataType: 'script'    

    # Adding teacher phones
    $("#add-phone-commit").click ->
      p_num                      = $("#teacher_phones").val()
      update_p_path              = $("#update_phones_path").val()
      update_p_path_with_params  = "#{update_p_path}?p_num=#{p_num}"

      $("#teacher_phone").val("")

      if p_num
        $.ajax update_p_path_with_params,
          type:     'GET'
          dataType: 'script'   

     # Enabling Import     
     $("#teacher_school_data").change ->
      $(":submit").removeAttr("disabled")                      

      

