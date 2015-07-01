(function() {
  var chooseOption, printQuestions, resetPage;

  $(document).ready(function() {
    return $.ajax({
      type: "GET",
      url: "/cauti-surveillance-tool/data/questions.json",
      success: function(data, textStatus, jqXHR) {
        console.log(data.questions);
        window.questions = data.questions;
        printQuestions("start");
        return resetPage();
      }
    });
  });

  printQuestions = function(parent) {
    var criteria_items, html_string, i, j, k, len, len1, len2, option, question, ref, ref1, results;
    results = [];
    for (i = 0, len = questions.length; i < len; i++) {
      question = questions[i];
      if (!(question.parent === parent)) {
        continue;
      }
      html_string = "";
      html_string = html_string + ("<div class='" + question.type + "'>" + question.text + "</div>");
      if (question.criteria != null) {
        html_string = html_string + "<ul>";
        ref = question.criteria;
        for (j = 0, len1 = ref.length; j < len1; j++) {
          criteria_items = ref[j];
          html_string = html_string + ("<li>" + criteria_items + "</li>");
        }
        html_string = html_string + "</ul>";
      }
      if (question.options != null) {
        html_string = html_string + "<ul>";
        ref1 = question.options;
        for (k = 0, len2 = ref1.length; k < len2; k++) {
          option = ref1[k];
          html_string = html_string + ("<a href='#'><li id='" + option.id + "' class='option_button'>" + option.text + "</li></a>");
        }
        html_string = html_string + "</ul>";
      }
      $("#question_block").html(html_string);
      results.push(chooseOption());
    }
    return results;
  };

  chooseOption = function() {
    return $(".option_button").click(function() {
      var opt_id;
      opt_id = $(this).attr('id');
      return printQuestions(opt_id);
    });
  };

  resetPage = function() {
    return $(".page-heading, #start_over").click(function() {
      return printQuestions("start");
    });
  };

}).call(this);
