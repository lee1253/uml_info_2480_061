/***
 *
 * This file handles all of the data processing for the inventory page ( called addEdit.cfm )
 *
 * @author Dan Card
 * @date   2024-03-28
 * */

 component {

	/***
	 * Handles processing any new data which is submitted to the page, typically from the mainNav inventory form.
	 *
	 * @formData A structure containing all of the data needed to create or update the book.
	 * */
	function processForms( required struct formData ){
		if ( formData.keyExists( "isbn13" ) && formData.isbn13.len() == 13 && formData.title.len() > 0 ) {
			if ( formData.keyExists( "uploadImage" ) && formData.uploadImage.len() ) {
				formData.image = uploadBookCover();
			}

			var qs = new query( datasource = application.dsource );
			qs.setSql( "IF NOT EXISTS (SELECT * from books WHERE isbn13=:isbn13) 
				INSERT INTO books (isbn13,title) VALUES (:isbn13,:title) ;

				UPDATE books SET
					title=:title,
					weight=:weight,
					year=:year,
					isbn=:isbn,
					pages=:pages,
					publisherId=:publisherId,
					image=:image,
					description=:description
				WHERE isbn13=:isbn13	
				
				" );
			qs.addParam(
				name      = "isbn13",
				cfsqltype = "CF_SQL_NVARCHAR",
				value     = formData.isbn13,
				null      = formData.isbn13.len() != 13
			);
			qs.addParam(
				name      = "title",
				cfsqltype = "CF_SQL_NVARCHAR",
				value     = formData.title,
				null      = formData.title.len() == 0
			);
			qs.addParam(
				name      = "weight",
				cfsqltype = "CF_SQL_NUMERIC",
				value     = formData.weight,
				null      = !isValid( "numeric", formData.weight )
			);
			qs.addParam(
				name      = "year",
				cfsqltype = "CF_SQL_NUMERIC",
				value     = formData.year,
				null      = !isValid( "numeric", formData.year )
			);
			qs.addParam(
				name      = "isbn",
				cfsqltype = "CF_SQL_NVARCHAR",
				value     = formData.isbn,
				null      = formData.isbn.len() == 0
			);
			qs.addParam(
				name      = "pages",
				cfsqltype = "CF_SQL_NUMERIC",
				value     = formData.pages,
				null      = !isValid( "numeric", formData.pages )
			);
			qs.addParam(
				name      = "publisherId",
				cfsqltype = "CF_SQL_NVARCHAR",
				value     = formData.publisher,
				null      = formData.publisher.len() == 0
			);
			qs.addParam(
				name      = "image",
				cfsqltype = "CF_SQL_NVARCHAR",
				value     = formData.image,
				null      = formData.image.len() == 0
			);
			qs.addParam(
				name      = "description",
				cfsqltype = "CF_SQL_NVARCHAR",
				value     = formData.description,
				null      = formData.description.len() == 0
			);
			qs.execute();

			if ( formData.keyExists( "genre" ) ) {
				deleteAllBookGenres( formData.isbn13 )

				formData.genre
					.listToArray()
					.each( function( item ){
						insertGenre( item, formData.isbn13 )
					} )
			}
		}
	}

	/***
	 *
	 * Searches for books to edit fitting a criteria and returns the list
	 *
	 * */
	function sideNavBooks( qTerm ){
		if ( qTerm.len() == 0 ) {
			return queryNew( "" );
		} else {
			var qs = new query( datasource = application.dsource );
			qs.setSql( "select * from books where title like :qTerm order by title" );
			qs.addParam(
				name      = "qTerm",
				cfsqltype = "CF_SQL_NVARCHAR",
				value     = "%#qTerm#%"
			);
			return qs.execute().getResult();
		}
	}

	/***
	 *
	 * Searches the database for the details of a particular book in order to edit it
	 *
	 * */
	function bookDetails( isbn13 ){
		var qs = new query( datasource = application.dsource );
		qs.setSql( "select * from books where isbn13=:isbn13" );
		qs.addParam(
			name      = "isbn13",
			cfsqltype = "CF_SQL_NVARCHAR",
			value     = isbn13
		);
		return qs.execute().getResult();
	}

	/***
	 *
	 * Retrieves all the publishers in the database to populate the publishers select control
	 *
	 * */
	function allPublishers(){
		var qs = new query( datasource = application.dsource );
		qs.setSql( "select * from publishers" );
		return qs.execute().getResult();
	}

	/***
	 *
	 * Handle the upload of the book cover
	 *
	 * */
	function uploadBookCover(){
		var imageData = fileUpload(
			expandPath( "../images/" ),
			"uploadImage",
			"*",
			"makeUnique"
		);
		return imageData.serverFile;
	}

	/***
	 *
	 * Returns all genres in our system to the UI in order to choose them for a book
	 *
	 **/

	function allGenres( isbn13 ){
		var qs = new query( datasource = application.dsource );
		qs.setSql( "select * from genres order by name" );
		return qs.execute().getResult();
	}

	/***
	 *
	 * Accepts the genreId and the Bookid (isbn13) and inserts them in to the genreToBooks Table
	 *
	 * @genreId
	 * @bookId 
	 **/
	function insertGenre( genreId, bookId ){
		var qs = new query( datasource = application.dsource );
		qs.setSql( "insert into genreToBook (bookid, genreid) VALUES (:bookid, :genreid) " );
		qs.addParam( name = "bookid", value = arguments.bookId );
		qs.addParam( name = "genreid", value = arguments.genreId );
		qs.execute();
	}

	/***
	 *
	 * Removes all genres for a particular book from the system
	 *
	 * @bookId The ISBN13 of the book
	 **/
	function deleteAllBookGenres( bookId ){
		var qs = new query( datasource = application.dsource );
		qs.setSql( "delete from genreToBook WHERE bookId=:bookid " );
		qs.addParam( name = "bookid", value = arguments.bookId );
		qs.execute();
	}

	/***
	 *
	 * Accepts an ISBN13 and returns all of the genres in the system for that book
	 *
	 * @bookid The ISBN13 of the book
	 **/
	function bookGenres( bookId ){
		var qs = new query( datasource = application.dsource );
		qs.setSql( "select * from genreToBook where bookid=:bookId" );
		qs.addParam( name = "bookId", value = arguments.bookid );
		return qs.execute().getResult()
	}

}