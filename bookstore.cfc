component {

	function obtainSearchResults( searchMe="",genre="" ){
		if(searchme.len() > 0){
		var qs = new query( datasource = application.dsource );
		qs.setSql( "select * from books inner join publishers on books.publisherId=publishers.id 
        where title like :searchMe or isbn13 like :isbn" );
		qs.addParam(
			name      = "searchMe",
			cfsqltype = "CF_SQL_NVARCHAR",
			value     = searchMe
		);
		qs.addParam(
			name      = "isbn",
			cfsqltype = "CF_SQL_NVARCHAR",
			value     = "%#searchme#%"
		);
		return qs.execute().getResult();
		} else if (genre.len() > 0){
			var qs = new query( datasource = application.dsource );
			qs.setSql( "SELECT * from books INNER JOIN genreToBook ON books.isbn13 = genreToBook.bookid
				 INNER JOIN publishers ON books.publisherid=publishers.id WHERE genreid=:genre" );
			qs.addParam(
				name      = "genre",
				cfsqltype = "CF_SQL_NVARCHAR",
				value     = trim(arguments.genre)
			);
			return qs.execute().getResult();
		}

	}

	function genresInStock(){
        var qs = new query(datasource=application.dsource);
        qs.setSql("select distinct name, genreid from genreToBook
            inner join genres on genreToBook.genreid = genres.id
            order by genres.name
        ");
        return qs.execute().getResult();
    }

	function resultsHeader(searchMe="", genre=""){
        if(searchMe.len()){
            return "KeyWord: #searchme#";
        } else if(genre.len()){
            var qs = new query( datasource=application.dsource );
            qs.setSql("select * from genres where id=:genre");
            qs.addParam(name="genre",value=arguments.genre);
			var genreName=qs.execute().getResult().name[1];

			return "Genre: #genrename#";
        }
    }

	function obtainArticle( id ){
        var qs = new query(datasource=application.dsource);
        qs.setSql("select * from content where contentId=:id");
		qs.addParam(name="id",value=id);
        return qs.execute().getResult();
    }

}