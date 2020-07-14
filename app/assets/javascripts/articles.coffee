# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'turbolinks:load', ->
  $('#article-tags').tagit
    fieldName:   'category_list'
    singleField: true

  if gon.article_tags?
    for tag in gon.article_tags
      $('#article-tags').tagit 'createTag', tag[1]