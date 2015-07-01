---
---

$(document).ready ->
  $.ajax
    type: "GET"
    url: "/data/questions.json"
    success: (data, textStatus, jqXHR) ->
      console.log(data.questions)
      window.questions = data.questions
      # printQuestions()
      printQuestions("start")
      resetPage()
      
printQuestions = (parent) ->
  for question in questions when question.parent is parent
    # $("#question_block").append("<div class='#{question.type}'>#{question.text}</div>")

    html_string = ""
    html_string = html_string + "<div class='#{question.type}'>#{question.text}</div>"

    if question.criteria?
      html_string = html_string + "<ul>"
      for criteria_items in question.criteria
        html_string = html_string + "<li>#{criteria_items}</li>"
      html_string = html_string + "</ul>"
      # $("#question_block").append(html_string)

    if question.options?
      html_string = html_string + "<ul>"
      for option in question.options  
        html_string = html_string + "<a href='#'><li id='#{option.id}' class='option_button'>#{option.text}</li></a>"
      html_string = html_string + "</ul>"
      # $("#question_block").append(options_html_string)

    $("#question_block").html(html_string)
    chooseOption()

chooseOption = ->
  $(".option_button").click ->
    # console.log($(this).attr('id'))
    opt_id = $(this).attr('id')
    printQuestions(opt_id)

resetPage = ->
  $(".page-heading, #start_over").click ->
    printQuestions("start")
