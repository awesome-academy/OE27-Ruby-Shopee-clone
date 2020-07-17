$(document).on('turbolinks:load', function() {
  const MAX_PRICE = 20000000;
  const  MIN_PRICE = 0;
  let url = new URLSearchParams(window.location.search);
  let min_value = url.has('q[price_gteq]') ? url.get('q[price_gteq]') : MIN_PRICE;
  let max_value = url.has('q[price_lteq]') ? url.get('q[price_lteq]') : MAX_PRICE;
  $('#the_slider').slider({
    range: true,
    min: MIN_PRICE,
    max: MAX_PRICE,
    values: [min_value, max_value],
    slide: function(event, ui) {
      $('#q_price_gteq').val(ui.values[0]);
      $('#q_price_lteq').val(ui.values[1]);
      $('#display-price-min').text(ui.values[0].toLocaleString('vi', '.', ''));
      $('#display-price-max').text(ui.values[1].toLocaleString('vi', '.', ''));
    },
  });

  $('#q_brand_name_cont option:first-child').val('');
  $('#q_category_name_cont option:first-child').val('');
  $('select').select2();
  
  $statusElm = $('.download-progress #percent-download');
  $('.download-progress').addClass('d-none');
  $('#btn-export').on('click', function(e) {
    $('.download-progress').removeClass('d-none');
    let product_name = url.has('q[name_cont]') ? url.get('q[name_cont]') : '';
    let brand_name = url.has('q[brand_name_cont]') ? url.get('q[brand_name_cont]') : '';
    let category_name = url.has('q[category_name_cont]') ? url.get('q[category_name_cont]') : '';
    let price_gteq = url.has('q[price_gteq]') ? url.get('q[price_gteq]') : MIN_PRICE;
    let price_lteq = url.has('q[price_lteq]') ? url.get('q[price_lteq]') : MAX_PRICE;
    let created_at_gteq = url.has('q[created_at_gteq]') ? url.get('q[price_lteq]') : '';
    let created_at_lteq = url.has('q[created_at_lteq]') ? url.get('q[created_at_lteq]') : '';
    $.ajax({
      method: 'GET',
      url: '/shops/export/products',
      dataType: 'json',
      data: {
        q: {
          name_cont: product_name,
          brand_name_cont: brand_name,
          category_name_cont: category_name,
          price_gteq: price_gteq,
          price_lteq: price_lteq,
          created_at_gteq: created_at_gteq,
          created_at_lteq: created_at_lteq
        }
      },
    }).done(function(response, status, ajaxOpts) {
      $('.download-progress').removeClass('d-none');
      if (status === 'success' && response && response.jid) {
        var jobId = response.jid;
        var intervalName = `job_${jobId}`;
        $statusElm.text(I18n.t("shop.product.exporting") + " 0%");
        window[intervalName] = setInterval(function() {
          getExportJobStatus(jobId, intervalName);
        }, 2000);
      }
    })
  });
  
  function getExportJobStatus(jobId, intervalName) {
    $.ajax({
      url: '/shops/export_status',
      dataType: 'json',
      data: {
        job_id: jobId,
      },
    }).done(function(response, status) {
      $('.download-progress').removeClass('d-none');
      if (status === 'success') {
        var percentage = response.percentage;
        $statusElm.text(I18n.t("shop.product.exporting") + ' ' + percentage + '%');
        if (response.status === 'complete') {
          $statusElm.text(I18n.t("shop.product.export_success"));
          download();
        }
      }
    })
  }
  
  function download() {
    setTimeout(function() {
      clearInterval(window[intervalName]);
      delete window[intervalName];
      $(location).attr('href', '/shops/export_download.xlsx?id=' + jobId);
    }, 2000);
  }
});
