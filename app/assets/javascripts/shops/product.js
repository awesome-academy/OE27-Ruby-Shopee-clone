$(document).on('turbolinks:load', function() {
  let url = new URLSearchParams(window.location.search);
  let min_value = url.has('price_min') ? url.get('price_min') : 0;
  let max_value = url.has('price_max') ? url.get('price_max') : 20000000;
  $('#the_slider').slider({
    range: true,
    min: 0,
    max: 20000000,
    values: [min_value, max_value],
    slide: function(event, ui) {
      $('#price_min').val(ui.values[0]);
      $('#price_max').val(ui.values[1]);
      $('#display-price-min').text(ui.values[0].toLocaleString('vi', '.', ''));
      $('#display-price-max').text(ui.values[1].toLocaleString('vi', '.', ''));
    },
  });
});
