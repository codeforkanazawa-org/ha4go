# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
        $('body').on 'click', '#agree_message_check', ->
                console.log($("#agree_message_check").prop("checked"))
                if ($("#agree_message_check").prop("checked"))
                        $("#need_agree_button").prop("disabled", false);
                else
                        $("#need_agree_button").prop("disabled", true);

$ ->
        $('body').on 'click', '#write_comment', ->
                $('#write_comment').hide()
                $('#add_comment').show()
