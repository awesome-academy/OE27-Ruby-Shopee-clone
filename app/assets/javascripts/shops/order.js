$(document).on('turbolinks:load', function() {
  $('#status > option').first().val(null);
  
  $('#btn-update-order').click(function() {
    $order_status = $(this).parent().find('#order-status');
    let status = $order_status.val();
    let url = $order_status.data('url');
    $.ajax({
      method: 'PATCH',
      dataType: 'json',
      url: url,
      data: {
        authenticity_token: $('meta[name="csrf-token"]').attr('content'),
        status: status,
      },
      success: function(res) {
        if (res === true) {
          alert(I18n.t("shop.order.detail.update_success"));
        } else {
          alert(I18n.t("shop.order.detail.update_fail"));
        }
      },
      error: function() {
        alert(I18n.t("shop.order.detail.update_fail"));
      }
    });
  });
})
