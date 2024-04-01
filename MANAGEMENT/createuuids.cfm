<ul> 
    <cfoutput>
        <cfloop from="1" to="20" index="I">
            <input type="text" value="#createuuid()#" style="width:50%" /><br/>
        </cfloop> 
    </cfoutput> 
</ul>