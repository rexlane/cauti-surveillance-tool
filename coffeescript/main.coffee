---
---

$(document).ready ->
  $.ajax
    type: "GET"
    url: "{{ site.baseurl }}/data/questions.json"
    success: (data, textStatus, jqXHR) ->
      console.log(data.questions)
      window.questions = data.questions
      printQuestion("start")
      loadQuestionFromHash()

printQuestion = (question_id) ->
  question = questions[question_id]
  html_string = ""
  html_string = html_string + "<div class='#{question.type}' id='#{question_id}'>#{question.text}</div>"

  if question.criteria?
    html_string = html_string + "<ul>"
    for criteria_items in question.criteria
      html_string = html_string + "<li>#{criteria_items}</li>"
    html_string = html_string + "</ul>"

  if question.options?
    html_string = html_string + "<ul>"
    for option in question.options  
      html_string = html_string + "<a href='##{option.target}'><li id='#{option.target}' class='option_button'>#{option.text}</li></a>"
    html_string = html_string + "</ul>"

  $("#question_block").html(html_string)
  chooseNext()

loadQuestionFromHash = ->
  hash = location.hash
  hash = hash.substring(1)
  printQuestion(hash)

chooseNext = ->
  $(window).bind 'hashchange', (e) ->
    loadQuestionFromHash()