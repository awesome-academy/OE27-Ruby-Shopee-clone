$(function() {
  $('.btn-del-img').click(function(e) {
    if (confirm(I18n.t("shop.product.delete.image"))) {
      let id = $(this).data('id');
      let url = $(this).attr('href');
      let product_id = $(this).data('product-id');
      $.ajax({
        method: 'DELETE',
        dataType: 'json',
        url: url,
        data: {
          authenticity_token: $('meta[name="csrf-token"]').attr('content'),
          product_id: product_id
        },
        success: function(res) {
          if (res === 1) {
            $('#img-' + id).remove();
            toastr.success(I18n.t("shop.product.delete.delete_success"));
          } else {
            toastr.error(I18n.t("shop.product.delete.delete_fail"));
          }
        },
        error: function() {
          toastr.error(I18n.t("shop.product.delete.delete_fail"));
        },
      });
    }
    e.preventDefault();
  });
})
