# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "page:change", ->
  $("td[data-time-created]").each (index, element) =>
    d = new Date $(element).data "time-created"
    $(element).text d.toLocaleString()
  if $("#entry_room_id").length
    $("#users_online").find("tr:contains('@')").remove()
    $.post $("#entry_room_id").val() + "/people", { 'user_id' : parseInt($("#entry_user_id").val(), 10) }
    for element in $("#entry_room_users_array").val().split(', ')
      $("#users_online").append('<tr><td>' + element + '</td></tr>') if $("#users_online").find('tr:contains(element)').length == 0
    

$(window).on "page:before-change", ->
  if $("#entry_room_id").length
    $.ajax "/rooms/" + $("#entry_room_id").val() + "/people",
      type: 'DELETE' 
      data: { 'user_id' : parseInt($("#entry_user_id").val(), 10) }

$ ->
  setInterval ->
    $.post "/rooms/" + $("#entry_room_id").val() + "/people/online", { 'user_id' : parseInt($("#entry_user_id").val(), 10) }
  , 10000