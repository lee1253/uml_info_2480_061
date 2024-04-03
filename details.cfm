<cfparam name="searchme" default=""> 
<cfparam name="genre" default="">



<cfset bookInfo = bookstoreFunctions.obtainSearchResults( searchme, genre ) />

<cfoutput>
    <div> 
        <h3>
            <cfoutput> 
                #bookstoreFunctions.resultsHeader(searchme, genre)# 
            </cfoutput> 
        </h3> 
    </div>
    <cfif bookinfo.recordcount == 0> 
        #noResults()# 
    <cfelseif bookinfo.recordcount == 1> 
        #oneResult()# 
    <cfelse> 
        #manyResults()# 
    </cfif>
</cfoutput>

<cffunction name="noResults">
    There were no results.
</cffunction>

<cffunction name="oneResult">
    <cfoutput> 
        <img src="images/#bookinfo.IMAGE[1]#" style="float:left; width:250px; 
            height:250px" />     
        <h3>Title: #bookinfo.title[1]#</h3> 
        <div>Publisher: #bookinfo.name[1]#</div> 
        <div>Year of Publication: #bookinfo.year[1]#</div>
    </cfoutput> 
</cffunction>

<cffunction name="manyResults">
    
<ol class="nav flex-column">
    <cfoutput query="bookinfo">  
        <li class="nav-item">
            <a class="nav-link" href="#cgi.script_name#?p=details&searchme=#trim(isbn13)#">
                #trim(title)#
            </a>
        </li> 
    </cfoutput> 
</ol>  
</cffunction>