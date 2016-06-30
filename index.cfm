<cfsetting showdebugoutput="false">
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <title>PCO Song Browser</title>

    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">

    <!-- Optional theme -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap-theme.min.css" integrity="sha384-fLW2N01lMqjakBkx3l/M9EahuwpSfeNvV63J5ezn3uZzapT0u7EYsXMjQV+0En5r" crossorigin="anonymous">

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>
  <body>
    <div class="container">
      <h2>PCO Song Browser</h2>
      <div class="row">
        <div class="col-md-4">
          <select class="form-control" multiple  id="song-list" style="height: 80vh;"></select>
          <!-- <div class="list-group" id="song-list"></div> -->
        </div>
        <div class="col-md-8" id="song-detail">
        <a href="#" class="btn btn-default btn-xs" id="song-link" target="_blank">Open Song in PCO</a>
          <pre id="song-chart"></pre>
        </div>
      </div>
    </div>

    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <!-- Latest compiled and minified JavaScript -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>

    <script>
      $( document ).ready(function() { 

        get_songs(0);

        function get_songs(offset) {
          $.ajax({
            url: "pco.cfc",
            method: "GET",
            data: {method:'song_list', offset:offset},
            dataType: 'json'
          })
          .done(function( data ) {
            $.each(data.data, function (i, val) {
              $('#song-list').append('<option class="song-title-option" data-songid="'+val.id+'">'+val.attributes.title+'</button>');
            });

            if(data.meta.next) {
              get_songs(data.meta.next.offset)
              console.log(data.meta);
            } else {
              $('.song-title-option').on('click', function() {
                // $('.list-group-item.active').removeClass('active');
                // $(this).toggleClass('active');
                get_arrangements($(this).data('songid'));
              })
            }
          });
        }

        function get_arrangements(songid) {
          $.ajax({
            url: "pco.cfc",
            data: {method:'song_arrangements', songid:songid},
            method: "GET",
            dataType: 'json'
          })
          .done(function( data ) {
            $('#song-chart').text(data.data[0].attributes.chord_chart);
            $('#song-link').attr('href', 'https://services.planningcenteronline.com/songs/'+songid+'/arrangements/'+data.data[0].id);
          });
        }


      });
    </script>
  </body>
</html>