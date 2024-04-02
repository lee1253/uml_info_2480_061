<cfoutput>
    <cfset bookstoreFunctions = createObject("component", "bookstore")>
    
    <cfset genresInStock = bookstoreFunctions.genresInStock()>
    
    <h3>Search By Genre</h3>
    <ul class="nav flex-column">
        <cfloop query="genresInStock">
            <li class="nav-item">
                <a class="nav-link" href="#cgi.SCRIPT_NAME#?p=details&genre=#genreid#">#name#</a>
            </li>
        </cfloop>
    </ul>
    </cfoutput>
    