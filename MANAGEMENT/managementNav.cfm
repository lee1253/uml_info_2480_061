<cfoutput>
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="##navbarSupportedContent"
                aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav mr-auto">
                <li class="nav-item active">
                    <a class="nav-link" href="..">Storefront</a>
                </li>
                <li class="nav-item active">
                    <a class="nav-link" href="#cgi.SCRIPT_NAME#?tool=addedit">Inventory</a>
                </li>
                <li class="nav-item active">
                    <a class="nav-link" href="#cgi.SCRIPT_NAME#?tool=createUUIDs">UUIDS</a>
                </li>
                <li class="nav-item active">
                    <a class="nav-link" href="#cgi.SCRIPT_NAME#?tool=managecontent">Content</a>
                </li>
            </ul>
        </div>
    </nav>
</cfoutput>