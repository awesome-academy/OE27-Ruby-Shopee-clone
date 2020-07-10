$(document).on('turbolinks:load', function() {
  let url = new URLSearchParams(window.location.search);
  let min_value = url.has('q[price_gteq]') ? url.get('q[price_gteq]') : 0;
  let max_value = url.has('q[price_lteq]') ? url.get('q[price_lteq]') : 20000000;
  $('#the_slider').slider({
    range: true,
    min: 0,
    max: 20000000,
    values: [min_value, max_value],
    slide: function(event, ui) {
      $('#q_price_gteq').val(ui.values[0]);
      $('#q_price_lteq').val(ui.values[1]);
      $('#display-price-min').text(ui.values[0].toLocaleString('vi', '.', ''));
      $('#display-price-max').text(ui.values[1].toLocaleString('vi', '.', ''));
    },
  });
});
