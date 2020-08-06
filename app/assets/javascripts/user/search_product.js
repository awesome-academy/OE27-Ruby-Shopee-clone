$(document).on('turbolinks:load', function() {
  $(document).on('input', '#form-search', function(e) {
    $('#say_hi').submit();
  });
})
