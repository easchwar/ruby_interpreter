(function() {
  var output = function(data) {
    var $div = $('<div class="stdout">');
    $div.html(data.replace(/\n/g, "<br>"));
    $('#out').append($div);
  };

  var result = function(data) {
    $('#result').html(data);
  };

  var error = function(data) {
    console.log(data);
    var err = "Error: <br> " + data;
    $('#result').html(err);
  };

  $(function() {
    window.jsrepl = new JSREPL({
      input: function(continuation) {
        var input = window.prompt('input the thing');
        continuation(input);
      },
      output: output,
      result: result,
      error: error, 
      timeout: {
        time: 3000,
        callback: function() {
          console.log('too long!');
          window.jsrepl.loadLanguage('ruby', function() {
            console.log("recovered");
          });
          return true;
        }
      }
    });

    window.jsrepl.loadLanguage('ruby', function() {
      alert('ruby loaded!');
    });
  });

})();
