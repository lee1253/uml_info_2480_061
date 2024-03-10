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
            <div class="form-floating mb-3">
                <input type="text" id="isbn13" name="isbn13" class="form-control" value="" placeholder="ISBN13">
                <label for="isbn13">ISBN13:</label>
            </div>
            <div class="form-floating mb-3">
                <input type="text" id="title" name="title" class="form-control" placeholder="Book Title">
                <label for="title">Book Title:</label>
            </div>
            <!-- New text inputs -->
            <div class="form-floating mb-3">
                <input type="text" id="year" name="year" class="form-control" placeholder="Year">
                <label for="year">Year:</label>
            </div>
            <div class="form-floating mb-3">
                <input type="number" id="weight" name="weight" step=".1" class="form-control" placeholder="Weight">
                <label for="weight">Weight:</label>
            </div>
            <div class="form-floating mb-3">
                <input type="text" id="isbn" name="isbn" class="form-control" placeholder="ISBN">
                <label for="isbn">ISBN:</label>
            </div>
            <div class="form-floating mb-3">
                <input type="number" id="pages" name="pages" class="form-control" placeholder="Pages">
                <label for="pages">Pages:</label>
            </div>
            <!-- Submit button -->
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
