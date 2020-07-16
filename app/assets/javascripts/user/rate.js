$(document).on('turbolinks:load', function() {
  $('#rating label').text('');
  $('#rating').on("click", 'label', function(event){
  let star = $(this).prev(':radio').val();
  let product_id = $('#product_id').val();
  let user_id = $('#review_user_id').val();
  let url = $('.data-link').data('url');
  $.ajax({
      method: 'POST',
      dataType: 'json',
      url: url,
      data: {
        star: star,
        product_id: product_id,
        user_id : user_id,
        authenticity_token: $('meta[name="csrf-token"]').attr('content')
      },
      success: function(result) {
        $('#rating').find('*').prop('disabled', true);
      }
     });
  });
})
