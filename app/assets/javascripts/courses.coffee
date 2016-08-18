template_finishCourse =  '<a data-confirm="{confirm_text}" ' +
  'class="btn btn-danger" ' +
  'href="/admin/courses/{course_id}?status=finished">{button_text}</a>'

template_inactiveCourse = '<button name="button" type="submit" ' +
  'class="btn btn-default disabled">{button_text}</button>'

$ ->
  $(document).on "click", "div[class*=course_action_] a", (e) ->
    self = $(this)

    $.ajax
      url: $(this).attr("href")
      type: "PATCH"
      dataType: "json"
      error: (jqXHR, textStatus, errorThrown) ->
        alert "AJAX Error: #{textStatus}"
      success: (data, textStatus, jqXHR) ->
        switch data.course_status
          when "started"
            self.parent().html(template_finishCourse
              .replace("{course_id}", data.course_id)
              .replace("{confirm_text}", data.confirm_text)
              .replace("{button_text}", data.button_text))
          when "finished"
            self.parent().html(template_inactiveCourse
              .replace("{button_text}", data.button_text))

    e.preventDefault()
    e.stopPropagation()
