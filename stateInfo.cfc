/***
 *
 * Acts as controller for the stateInfo.cfm page  which manages the state and session data for the site
 *
 **/
 component {

	/***
	 *
	 * Accepts paramters for a new user struct in the session and returns the user struct accordingly
	 *
	 * @isLoggedIn    Whether the user is logged in or not
	 * @firstname     The firstname of the user
	 * @lastname      The lastname of the user
	 * @email         The email of the user
	 * @accountNumber The unique identifier of the user
	 * @isAdmin       Whether the user is an admin or not - Defaults to 0
	 **/
	function obtainUser(
		isLoggedIn    = 0,
		firstname     = "",
		lastname      = "",
		email         = "",
		accountNumber = "",
		isAdmin       = 0
	){
		return {
			"isLoggedIn" : arguments.isLoggedIn,
			"firstname"  : arguments.firstname,
			"lastname"   : arguments.lastname,
			"email"      : arguments.email,
			"acctNumber" : arguments.accountNumber,
			"isAdmin"    : arguments.isAdmin
		}
	}

	/***
	 *
	 * Checks the database to see if the user already exists and then creates a new account acordingly
	 *
	 * @formData A struct representing the form scope
	 * */
	function processNewAccount( formData ){
		var retme = { success : false, message : "" }

		if ( emailUnique( formdata.email ) ) {
			var newId = createUUID();
			if ( addPassword( newId, formData.password ) ) {
				addAccount(
					newid,
					formdata.title,
					formdata.firstname,
					formdata.lastname,
					formdata.email
				);
				retme.success = true;
				retme.message = "Account Made. Go Login!";
			} else {
				retme.message = "We had a problem. Please resubmit";
			}
		} else {
			retme.message = "That email is already in our database. Please log in";
		}
		return retme;
	}

	function emailUnique( required string email ){
		var qs = new query( datasource = application.dsource );
		qs.setSql( "select * from people where email=:email" );
		qs.addParam( name = "email", value = arguments.email );
		return qs.execute().getResult().recordcount == 0;
	}

	function addPassword( id, password ){
		try {
			var qs = new query( datasource = application.dsource );
			qs.setSql( "insert into passwords (personid, password)
           values (:personid, :password) " );
			qs.addParam( name = "personid", value = arguments.id );
			qs.addParam( name = "password", value = hash( arguments.password, "SHA-512" ) );
			qs.execute();
			return true;
		} catch ( ary err ) {
			return false;
		}
	}

	/***
	 *
	 * Adds an account into the database
	 *
	 * @id       
	 * @title    
	 * @firstname
	 * @lastname 
	 * @email    
	 **/
	function addAccount(
		required string id,
		required string title,
		required string firstname,
		required string lastname,
		required string email
	){
		try {
			var qs = new query( datasource = application.dsource );
			qs.setSql( "insert into people (personid, title,  firstname, lastname, email)
           values (:personid, :title, :firstname, :lastname, :email) " );
			qs.addParam( name = "personid", value = arguments.id );
			qs.addParam( name = "title", value = arguments.title );
			qs.addParam( name = "firstname", value = arguments.firstname );
			qs.addParam( name = "lastname", value = arguments.lastname );
			qs.addParam( name = "email", value = arguments.email );

			qs.execute();
			return true;
		} catch ( ary err ) {
			return false;
		}
	}


	function logMeIn( username, password ){
		var qs = new query( datasource = application.dsource );
		qs.setSql( "select * from people 
            inner join passwords on people.personid = passwords.personid
        where people.email=:email and passwords.password = :password" );
		qs.addParam( name = "email", value = arguments.username );
		qs.addParam( name = "password", value = hash( arguments.password, "SHA-512" ) );
		return qs.execute().getResult();
	}

}