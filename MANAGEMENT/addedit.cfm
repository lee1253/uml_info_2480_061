<cfparam name="book" default="" />
<cfparam name="qTerm" default="" />

<cftry> 
    <cfset addEditFunctions = createObject("addedit") /> 
    <cfset addEditFunctions.processForms(form)>

    <div class="row"> 
        <div id="main" class="col-9">
            <cfif book.len() gt 0>
                <cfoutput> #mainForm()# </cfoutput>
            </cfif>
        </div> 
        <div id="leftgutter" class="col-lg-3 order-first"> 
            <cfoutput> #sideNav()# </cfoutput>
        </div> 
    </div> 
    <cfcatch type="any"> 
        <cfoutput> #cfcatch.Message#</cfoutput> 
    </cfcatch>
</cftry>

<!--- This is the main inventory form --->
<cffunction name="mainForm"> 

    <cfset var thisBookDetails = addEditFunctions.bookDetails(book) />
    <cfset allPublishers = addEditFunctions.allPublishers()>
    <cfset var allGenres = addEditFunctions.allgenres() />
    <cfset var allGenresForThisBook = addEditFunctions.bookGenres( book ) />

    <cfoutput> 
        <form action="#cgi.script_name#?tool=addedit&book=#book#&qTerm=#qTerm#" method ="POST" enctype="multipart/form-data"> 
            
            <div class="form-floating mb-3">
                <input type="text" id="isbn13" name="isbn13" class="form-control" value="#thisBookDetails.isbn13[1]#" placeholder="Please Enter The ISBN13 of the book" />
                <label for="isbn13">ISBN 13: </label>
            </div>
            <div class="form-floating mb-3">
                <input type="text" id="title" name="title" class="form-control" value="#thisBookDetails.title[1]#" placeholder="Please Enter The Title of the book" />
                <label for="title">Title: </label>
            </div>
            <div class="form-floating mb-3">
                <input type="text" id="isbn" name="isbn" class="form-control" value="#thisBookDetails.isbn[1]#" placeholder="Please Enter The 10 digit ISBN" />
                <label for="isbn">ISBN: </label>
            </div>
            <div class="form-floating mb-3">
                <input type="number" id="year" name="year" class="form-control" value="#thisBookDetails.year[1]#" placeholder="Please Enter The Year Of Print" />
                <label for="year">Year: </label>
            </div>
            <div class="form-floating mb-3">
                <input type="number" id="weight" name="weight" step=".1" class="form-control" value="#thisBookDetails.weight[1]#" placeholder="Please Enter The Weight of the Book" />
                <label for="weight">Weight: </label>
            </div>
            <div class="form-floating mb-3">
                <input type="number" id="pages" name="pages" class="form-control" value="#thisBookDetails.pages[1]#" placeholder="Please Enter Number of Pages" />
                <label for="pages">Pages: </label>
            </div>
            <div class="form-floating mb-3">
                <select class="form-select" id="publisher" name="publisher" aria-label="Publisher Select Control">
                    <option ></option>
                    <cfloop query="allPublishers">
                        <option value="#id#" #id eq thisBookDetails.publisherId[1] ? "selected" : ""#>#name#</option>
                    </cfloop>
                </select>
                <label for="publisher">Publisher</label>
            </div>
            <label for="uploadImage">Upload Cover</label>
            <div class="row">
                <div class="col">
                    <div class="input-group mb-3">
                        <input type="file" id="uploadImage" name="uploadimage" class="form-control" />
                        <input type="hidden" name="image" value="#trim(thisBookDetails.image[1])#" />
                    </div>
                </div>
                <div class="col">
                    <cfif thisBookDetails.image[1].len() gt 0 >
                        <img src="../images/#trim(thisBookDetails.image[1])#" style="width:200px" />
                    </cfif>
                </div>
            </div>
            <div class="form-floating mb-3">
                <div>
                    <label for="description">Description</label>
                </div>
                <textarea id="description" name="description">
                    <cfoutput>#thisBookDetails.description#</cfoutput>
                </textarea>
                <script>
                    ClassicEditor
                        .create(document.querySelector('##description'))
                        .catch(error => {console.dir(error)});
                </script>
            </div>
            <div>
                <h4>Genres</h4>
                <!--- This is an addition that allows all checkboxes to be unchecked and a 
                    genre value which will return no values to be submitted to the system --->
                <input type="hidden" name="genre" value="0" />

                
                <cfloop query="allGenres">
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" value="#id#" id="genre#id#" name="genre">
                        <label class="form-check-label" for="genre#id#">
                          #name#
                        </label>
                      </div>
                </cfloop>
                <cfloop query="allGenresForThisBook">
                    <script type="text/javascript">
                        try{
                            document.getElementById("genre#genreId#").checked=true;
                        }catch(err){
                            console.dir(err);
                        }
                    </script>
                </cfloop>
            </div>
            
            <button type="submit" class="btn btn-primary" style="width:100%">Add Book</button>  
        </form> 
    </cfoutput> 
</cffunction>

<!--- This handles the side navigation where we choose a book to edit --->
<cffunction name="sideNav">
    <cfset findBookForm()> 
    <cfset allbooks = addEditFunctions.sideNavBooks( qterm )>  
    <div>
        Book List
    </div>
    <cfoutput>
        <ul class="nav flex-column">
            <a class="nav-link" href="#cgi.SCRIPT_NAME#?tool=addedit&book=new">New Book</a>
            <cfloop query="allbooks">
                <li class="nav-item">
                    <a class="nav-link" href="#cgi.SCRIPT_NAME#?tool=addedit&book=#isbn13#&qTerm=#qTerm#">#trim(title)#</a>
                </li>
            </cfloop>
        </ul>
    </cfoutput>
</cffunction>

<cffunction name="findBookForm">
    <cfoutput>
        <form action="#cgi.script_name#?tool=#tool#" method="post">
            <div class="form-floating mb-3">
                <input type="text" id="qterm" name="qterm" class="form-control" value="#qterm#" placeholder="Enter a search term to find a book to edit" />
                <label for="qterm">Search Inventory </label>
            </div>
        </form>
    </cfoutput>
</cffunction>