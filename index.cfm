<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>June's Books</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
</head>
<body>
<div id="wrapper" class="container">
    <cfinclude template="header.cfm" />
    <cfinclude template="horizontalnav.cfm" />
    <div style="display: flex;">
    <div style="flex: 50%;">
        <cfinclude template="carousel.cfm" />
    </div>
    <div style="flex: 50%;">
        <cfinclude template="genrenav.cfm" />
    </div>
</div>

    <cfinclude template="footer.cfm" />
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN"
        crossorigin="anonymous"></script>
</body>
</html>
