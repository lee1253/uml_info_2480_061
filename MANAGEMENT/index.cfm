<!--- The Management section is for the employees of the store to manage inventory and other items. --->
<!--- This is the security that would kick in in production but I'm commenting it out so people can access the management page
<cfif !session.keyExists("user") ||
     (!session.keyExists("user") && !session.user.keyExists("isAdmin")) || 
        (!session.user.isAdmin)>
    <cflocation url="#cgi.SCRIPT_NAME.replace('management/','')#" />
</cfif> --->
<!DOCTYPE html> 
<html lang="en"> 
    <head> 
        <meta charset="UTF-8"> 
        <title>Management</title> 
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha38 4-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK 8M2HN" crossorigin="anonymous"> 
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3. 2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM 9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script> 
        <script src="https://cdn.ckeditor.com/ckeditor5/41.1.0/classic/ckeditor.js"></script>
    </head> 
    <body>
        <cfparam name="tool" default="addEdit"/>

        <div id="wrapper" class="container">
            <div id="navArea">
                <cfinclude template="managementNav.cfm" />
            </div>
            <div id="mainArea">
                <cfinclude template="#tool#.cfm"/>
            </div>
        </div>
    </body> 
</html>