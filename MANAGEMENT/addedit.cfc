component {

    function processForms(required struct formData) {
        if (formData.keyExists("isbn13") && len(trim(formData.isbn13)) == 13 && len(trim(formData.title)) > 0) {
            
            var qs = new query(datasource=application.dsource);
            
            qs.setSQL("
                IF NOT EXISTS (SELECT * FROM books WHERE isbn13 = :isbn13)
                BEGIN
                    INSERT INTO books (isbn13, title) VALUES (:isbn13, :title);
                END
                ELSE
                BEGIN
                    UPDATE books SET 
                        title = :title,
                        weight = :weight,
                        year = :year,
                        pages = :pages
                    WHERE isbn13 = :isbn13;
                END
            ");
            
            qs.addparam(name="isbn13", cfsqltype="CF_SQL_VARCHAR", value=formData.isbn13, null=(len(trim(formData.isbn13)) != 13));
            qs.addparam(name="title", cfsqltype="CF_SQL_NVARCHAR", value=formData.title, null=(len(trim(formData.title)) == 0));
            qs.addParam(name="weight", cfsqltype="CF_SQL_NUMERIC", value=formData.weight);
            qs.addParam(name="year", cfsqltype="CF_SQL_NUMERIC", value=formData.year);
            qs.addParam(name="pages", cfsqltype="CF_SQL_NUMERIC", value=formData.pages);
            
            qs.execute();
        }
    }

    function sideNavBooks() {
        var allBooksQuery = new query(datasource=application.dsource);
        allBooksQuery.setSql("select * from books");
        allBooksQuery = allBooksQuery.execute().getResult();
        return allBooksQuery;
    }

}
