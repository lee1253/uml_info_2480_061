<cftry>
    <cfset addEditFunctions = createObject("component", "addedit") />
    <div class="row">
        <div id="main" class="col-9">
            <cfoutput>#mainForm()#</cfoutput>
        </div>
        <div id="leftgutter" class="col-lg-3 order-first">
            <cfoutput>#sideNav()#</cfoutput>
        </div>
    </div>
<cfcatch type="any">
    <cfoutput>#cfcatch.Message#</cfoutput>
</cfcatch>
</cftry>
<cfdump var="#form#">
<cfif structKeyExists(form, "isbn13") and structKeyExists(form, "title")>
    <cfset addEditFunctions.processForms(form)>
</cfif>

<!-- Functions -->
<cffunction name="mainForm">
    <cfoutput>
        <form action="#cgi.script_name#?tool=addedit" method="post">
            <label for="isbn13">ISBN13:</label>
            <input type="text" id="isbn13" name="isbn13" value="" placeholder="ISBN13" /><br>
            <label for="title">Book Title:</label>
            <input type="text" id="title" name="title" placeholder="Book Title"/><br>
            <button type="submit" class="btn btn-primary">Add Book</button>
        </form>
    </cfoutput>
</cffunction>

<cffunction name="sideNav">
    <cfset allbooks = addEditFunctions.sideNavBooks()>
    <div>
        Book List
    </div>
    <cfoutput>
        <ul class="nav flex-column">
            <cfloop query="allbooks">
                <li class="nav-item">
                    <a class="nav-link">#trim(title)#</a>
                </li>
            </cfloop>
        </ul>
    </cfoutput>
</cffunction>
