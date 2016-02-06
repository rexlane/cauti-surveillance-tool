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

      $(".text-toggle").click (e) ->
        e.preventDefault()
        $($(this).attr("href")).slideToggle()
        $(this).toggleClass('is-showing-text')


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
    # for option in question.options  
    #   html_string = html_string + "<li id='#{option.target}' class='option_button'><a href='##{option.target}' class='option_button_link'>#{option.text}</a></li>"
    option_first = question.options[0]  
    html_string = html_string + "<a href='##{option_first.target}' class='option_button_link'><li id='#{option_first.target}' class='btn btn-primary option_button first'>#{option_first.text}</li></a>"
    option_second = question.options[1]  
    html_string = html_string + "<a href='##{option_second.target}' class='option_button_link'><li id='#{option_second.target}' class='btn btn-primary option_button second'>#{option_second.text}</li></a>"
    html_string = html_string + "</ul>"

  html_string = html_string + "</div>"

  if question.more?
    more(question_id)
    # $('.text-toggle').show()
  else
    $('.text-toggle').hide()

    # noMore()

  refreshBodyWrapper(html_string)

more = (question_id) ->
  $('.text-toggle').show()
  question = questions[question_id]
  more_string = ""
  more_string = more_string + "<p id='stuff'>#{question.more}</p><p><a href='{{ site.cdc_url }}' target='_blank'>Read more.</p>"
  $('#more_text').html(more_string)

refreshBodyWrapper = (new_string) ->
  $("#body_wrapper").hide(changePageText(new_string)).fadeIn('slow')

changePageText = (new_string) ->
  $("#question_block").html(new_string)
  setLIHeight()

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

setLIHeight = ->
  maxHeight = 0
  $('.option_wrapper .option_button .option_button_link').each ->
    if maxHeight < $(this).height()
      maxHeight = $(this).height()
    return
  $('.option_wrapper .option_button .option_button_link').height maxHeight
  return
