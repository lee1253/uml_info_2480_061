<cfparam name="contentid" default="" />

<cfset contentFunctions = createObject("content") />

<cfif form.keyExists("title")>
    <cfset contentFunctions.processContent( form ) />
</cfif>
<cfset contentData = contentFunctions.obtainArticle( contentid ) />

<cfset allContent = contentFunctions.allContent() />
<cfoutput> 
    <div class="row">
        <div class="col-3">
            <ul class="nav flex-column">
                <cfoutput query="allContent">
                    <li class="nav-item">
                        <a class="nav-link" href="#cgi.SCRIPT_NAME#?tool=managecontent&contentid=#contentid#">#trim(title)#</a>
                    </li>
                </cfoutput>
            </ul>
        </div>
        <div class="col-9">

            <form action="#cgi.script_name#?tool=managecontent" method ="POST"> 
                <input type="hidden" name="contentid" value="#contentid#" />
                <div class="form-floating mb-3">
                    <input type="text" id="title" name="title" class="form-control" value="#contentData.title#" placeholder="Please Enter The ISBN13 of the book" />
                    <label for="title">Title: </label>
                </div>
                <div class="form-floating mb-3">
                    <div>
                        <label for="description">Description</label>
                    </div>
                    <textarea id="description" name="description">
                        <cfoutput>#contentData.description#</cfoutput>
                    </textarea>
                    <script>
                        ClassicEditor
                            .create(document.querySelector('##description'))
                            .catch(error => {console.dir(error)});
                    </script>
                </div>
                <input type="submit" class="btn btn-primary" style="width:100%" value="Save" />
        </div>
    </div>
    

</form>

</cfoutput>