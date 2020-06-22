$(function() {
  function validate_image(file_size, tag, e) {
    if (file_size > 1) {
      alert(I18n.t("shop.product.create.validate_image"));
      $(this).val(null);
    } else {
      tag.html(`<img src='${URL.createObjectURL(e.target.files[0])}'>`);
    }
  }
  
  $('.images').on('change', 'input[type=file]', function(e) {
    let file_size = this.files[0].size / 1024 / 1024;
    let tag = $(this).closest('td').next('td');
    validate_image(file_size, tag, e);
  });
  
  $('input[type=file]').bind('change', function(e) {
    let file_size = this.files[0].size / 1024 / 1024;
    let tag = $(this).parent().find('.preview-avatar');
    validate_image(file_size, tag, e);
  });
  
  $('#data-table').DataTable({
    'columnDefs': [
      {'orderable': false, 'targets': 6},
    ],
    'language': {
      'emptyTable': I18n.t("shop.datatable.empty"),
      'search': I18n.t("shop.datatable.search"),
      'paginate': {
        'next': I18n.t("shop.datatable.paginate.next"),
        'previous': I18n.t("shop.datatable.paginate.previous"),
      },
      'info': I18n.t("shop.datatable.info"),
      'lengthMenu': I18n.t("shop.datatable.lengthMenu"),
    },
    'paging': true,
    'lengthChange': true,
    'searching': true,
    'info': true,
    'autoWidth': true,
  });
  
  function checkbox(param) {
    if (param.is(':checked')) {
      param.parent().find('input[type=hidden]').val(true);
    } else {
      param.parent().find('input[type=hidden]').val(false);
    }
  }
  
  $('.del-img input[type=checkbox]').change(function() {
    checkbox($(this));
  })
  
  $('.del-color input[type=checkbox]').change(function() {
    checkbox($(this));
  })
  
  $('#select-status .form-control').change(function() {
    $('#select-status #status option:first').val('');
    $('#select-status').submit();
  })
});
