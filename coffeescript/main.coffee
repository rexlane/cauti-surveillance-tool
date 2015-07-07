---
---

$(document).ready ->
  $.ajax
    type: "GET"
    url: "{{ site.baseurl }}/data/questions.json"
    success: (data, textStatus, jqXHR) ->
      window.questions = data.questions
      bindFindQuestionToHashChange()
      findQuestionFromHash()

generateQuestionText = (question_id) ->
  question = questions[question_id]
  html_string = ""
  html_string = html_string + "<div class='main_block #{question.type}' id='#{question_id}'><p>#{question.text}</p>"

  if question.criteria?
    html_string = html_string + "<ul>"
    for criteria_items in question.criteria
      html_string = html_string + "<li>#{criteria_items}</li>"
    html_string = html_string + "</ul>"

  if question.options?
    html_string = html_string + "<ul class='option_wrapper'>"
    for option in question.options  
      html_string = html_string + "<li id='#{option.target}' class='option_button'><a href='##{option.target}' class='option_button_link'>#{option.text}</a></li>"
    html_string = html_string + "</ul>"

  html_string = html_string + "</div>"
  changePageText(html_string)

changePageText = (new_string) ->
  $("#question_block").hide().html(new_string).fadeIn('slow')

findQuestionFromHash = ->
  # $("#question_block").fadeOut('fast')
  if window.location.hash != ""
    hash = location.hash
    hash = hash.substring(1)
    generateQuestionText(hash)
  else
    generateQuestionText("start")

bindFindQuestionToHashChange = ->
  $(window).bind 'hashchange', (e) ->
    findQuestionFromHash()