<cfparam name="id" default="" />


<cfset myContent = bookstoreFunctions.obtainArticle( id ) />

<cfoutput>
    <h1>#myContent.title#</h1>
    <h4>#dateformat(MyContent.dateWritten,"mm.dd.yyyy")#</h4>
    <p>#myContent.description#</p>
</cfoutput>