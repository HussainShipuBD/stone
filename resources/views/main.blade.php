<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
<head>
    <link rel="icon" href="favicon.ico" type="image/x-icon"/> 
    <meta data-n-head="ssr" name="viewport" content="width=device-width, initial-scale=1">
    <!--Favicon-->	
    <link rel="shortcut icon" type="image/x-icon" href="/assets/images/fav/favicon.ico">
    <!-- Title -->         
    <title>Stone Project</title>         

    <link href="/css/bootstrap.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css" integrity="sha384-oS3vJWv+0UjzBfQzYUhtDYW+Pj2yciDJxpsK1OYPAYjqT085Qq/1cq5FLXAZQ7Ay" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="http://unpkg.com/view-design/dist/styles/iview.css">
    <!-- Font family -->
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:ital,wght@0,300;0,400;0,600;0,700;0,800;1,300;1,400;1,600;1,700;1,800&display=swap" rel="stylesheet">
    <link href="/css/common.css" rel="stylesheet"/>  
    <link href="/css/main.css" rel="stylesheet"/> 
    <link href="/css/responsive.css" rel="stylesheet"/> 
</head>

<body>
    <div id="app">
        <master></master>
    </div>
    <script>
         (function () {
                window.Laravel = {
                    csrfToken: '{{ csrf_token() }}'
                };
                @if(Auth::check())
                    window.authUser={!! Auth::user() !!}
                    @else
                    window.authUser=false
                    @endif
            })();
    </script>

    <script src="{{ mix('js/app.js') }}"></script>
</body>

</html>