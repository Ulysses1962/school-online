# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  $(document).ready ->
    $("#add-subject-commit").click ->
      idx                     = $("#teacher_subjects").val()
      update_path             = $("#update_path").val()
      update_path_with_param  = "#{update_path}?idx=#{idx}"

      $("#teacher_subjects option:eq(0)").prop("selected", true)

      if idx
        $.ajax update_path_with_param,
          type:     'GET'
          dataType: 'script'

    $("#add-role-commit").click ->
      idr                       = $("#teacher_roles").val()
      update_r_path             = $("#update_roles_path").val()
      update_r_path_with_param  = "#{update_r_path}?idr=#{idr}"

      $("#teacher_roles option:eq(0)").prop("selected", true) 

      if idr
        $.ajax update_r_path_with_param,
          type:     'GET'
          dataType: 'script'    

      

