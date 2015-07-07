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

  compileParents = (item) ->
    # html_string = ""
    html_string = html_string + "<div class='main_block #{item.type}'><p>#{item.text}</p>"

    if item.criteria?
      html_string = html_string + "<ul>"
      for criteria_items in item.criteria
        html_string = html_string + "<li>#{criteria_items}</li>"
      html_string = html_string + "</ul>"

    if item.options?
      html_string = html_string + "<ul class='option_wrapper'>"
      for option in item.options  
        html_string = html_string + "<li id='#{option.target}' class='option_button'><a href='##{option.target}' class='option_button_link'>#{option.text}</a></li>"
      html_string = html_string + "</ul>"

    html_string = html_string + "</div>"

  if question.parent3?
    parent_id = question.parent3
    parent = questions[parent_id]
    compileParents(parent)

  if question.parent2?
    parent_id = question.parent2
    parent = questions[parent_id]
    compileParents(parent)

  if question.parent1?
    parent_id = question.parent1
    parent = questions[parent_id]
    compileParents(parent)

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

  $("#question_block").html(html_string)
  # findAllParents(question_id)
  chooseNext()


# findAllParents = (question_id) ->
#   question = questions[question_id]
#   html_string = ""

#   compileParents = (item) ->
#     # html_string = ""
#     html_string = html_string + "<div class='main_block #{item.type}'><p>#{item.text}</p>"

#     if item.criteria?
#       html_string = html_string + "<ul>"
#       for criteria_items in item.criteria
#         html_string = html_string + "<li>#{criteria_items}</li>"
#       html_string = html_string + "</ul>"

#     if item.options?
#       html_string = html_string + "<ul class='option_wrapper'>"
#       for option in item.options  
#         html_string = html_string + "<li id='#{option.target}' class='option_button'><a href='##{option.target}' class='option_button_link'>#{option.text}</a></li>"
#       html_string = html_string + "</ul>"

#     html_string = html_string + "</div>"

#   if question.parent3?
#     parent_id = question.parent3
#     parent = questions[parent_id]
#     compileParents(parent)

#   if question.parent2?
#     parent_id = question.parent2
#     parent = questions[parent_id]
#     compileParents(parent)

#   if question.parent1?
#     parent_id = question.parent1
#     parent = questions[parent_id]
#     compileParents(parent)

#   $("#question_block").prepend(html_string)

# compileParents = (item) ->
#   # html_string = ""
#   html_string = html_string + "<div class='main_block #{item.type}' id='#{item}'><p>#{item.text}</p>"

#   if item.criteria?
#     html_string = html_string + "<ul>"
#     for criteria_items in item.criteria
#       html_string = html_string + "<li>#{criteria_items}</li>"
#     html_string = html_string + "</ul>"

#   if item.options?
#     html_string = html_string + "<ul class='option_wrapper'>"
#     for option in item.options  
#       html_string = html_string + "<li id='#{option.target}' class='option_button'><a href='##{option.target}' class='option_button_link'>#{option.text}</a></li>"
#     html_string = html_string + "</ul>"

#   html_string = html_string + "</div>"

  # $("#question_block").prepend(html_string)
  # chooseNext()

loadQuestionFromHash = ->
  if window.location.hash != ""
    hash = location.hash
    hash = hash.substring(1)
    printQuestion(hash)
  else
    printQuestion("start")

chooseNext = ->
  $(window).bind 'hashchange', (e) ->
    loadQuestionFromHash()