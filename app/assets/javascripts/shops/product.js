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
  
  $(function() {
    var $statusElm = $(".download-progress .progress-bar");
    $("button#export").on("click", function(e) {
      $.ajax({
        url: "/export/products",
        dataType: "json"
      }).done(function(response, status, ajaxOpts) {
        if (status === "success" && response && response.jid) {
          var jobId = response.jid;
          var intervalName = "job_" + jobId;
          $statusElm.text("Exporting 0%...");
          window[intervalName] = setInterval(function() {
            getExportJobStatus(jobId, intervalName);
          }, 100);
        }
      }).fail(function(error) {
        console.log(error);
      });
    });
    
    function getExportJobStatus(jobId, intervalName) {
      $.ajax({
        url: "/export_status",
        dataType: "json",
        data: {
          job_id: jobId
        }
      }).done(function(response, status, ajaxOpt) {
        if (status === "success") {
          var percentage = response.percentage;
          $statusElm.text("Exporting " + percentage + "%...");
          if (response.status === "complete") {
            $statusElm.text("Export completed. Downloading...");
            setTimeout(function() {
              clearInterval(window[intervalName]);
              delete window[intervalName];
              $(location).attr("href", "/export_download.xlsx?id=" + jobId);
              $statusElm.text("");
            }, 500);
          }
        }
      }).fail(function(error) {
        console.log(error);
      });
    }
  });
});
