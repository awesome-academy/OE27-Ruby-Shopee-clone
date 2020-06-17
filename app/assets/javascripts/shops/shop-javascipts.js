$(function () {
  $('tbody > tr:first .del-row').click(false);
  
  $('#new-row').click(function () {
    let row = $('tbody > tr:first').clone();
    $('tbody').append(row);
  })
  
  $('tbody').on('click', '.del-row', function (e) {
    $(this).closest('tr').remove();
  })
  
  function validate_image(file_size, tag, e) {
    if (file_size > 1) {
      alert(I18n.t("shop.product.create.validate_image"));
      $(this).val(null);
    } else {
      tag.html(`<img src='${URL.createObjectURL(e.target.files[0])}'>`);
    }
  }
  
  $('.images').on('change', 'input[type=file]', function (e) {
    let file_size = this.files[0].size / 1024 / 1024;
    let tag = $(this).closest('td').next('td')
    validate_image(file_size, tag, e)
  })
  
  $('input[type=file]').bind('change', function (e) {
    let file_size = this.files[0].size / 1024 / 1024;
    let tag = $(this).parent().find('.preview-avatar')
    validate_image(file_size, tag, e)
  });
})
