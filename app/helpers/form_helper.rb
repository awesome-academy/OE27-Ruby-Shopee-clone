module FormHelper
  def errors_for form, field, full_error_message: true, object: false
    object = object ? form : form.object
    message = if full_error_message
      object.errors.full_messages_for(field).join ", "
    else
      object.errors.message[field].join ", "
    end
    content_tag :p, message, class: "text-danger #{field}"
  end
end
