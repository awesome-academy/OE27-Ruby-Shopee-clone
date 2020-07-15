$(document).on('turbolinks:load', function() {
  $(document).on('click', '.inp_color', function() {
    let url = $(this).data('url');
    let color_id = $('.inp_color:checked').val();
    let product_id = $('#product_id').val();
    let url_session = $('#url-session').data('url');
    $.ajax({
      method: 'GET',
      dataType: 'json',
      url: url,
      data: {
        color_id: color_id,
        product_id: product_id
      },
      success: function(result) {
        $("#data_a").load(url_session +' #data_a');
        var session_data = $('.data-session').data('session');

        $('#order_item_product_color').val(result['product_color']);
        if (session_data == null || session_data[result['product_color']] == undefined){
          $('#order_item_quantity').prop('max', result['quantity']);
          $('#quantity_avai').text(result['quantity']);
        }else{
          var quantity_session = parseFloat(session_data[result['product_color']]['quantity']);
          $('#order_item_quantity').prop('max', parseFloat(result['quantity']) - quantity_session);
          $('#quantity_avai').text(parseFloat(result['quantity']) - quantity_session);
        }
        if((parseFloat(result['quantity']) - quantity_session) == 0){
          $('.submit-order').prop('disabled', true);
          $('#quantity_avai').text(I18n.t('order.out_of_stock'));
        }else{
          $('.submit-order').prop('disabled', false);
        }
      },
      error: function() {
        toastr.error(I18n.t("order.fail"));
      }
    });
  });
})
