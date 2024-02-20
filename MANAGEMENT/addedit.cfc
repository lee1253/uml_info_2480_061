component {

    function processForms(required struct formData) {
        if (structKeyExists(formData, "isbn13") and structKeyExists(formData, "title")) {
            var qs = new query(datasource = application.dsource);
            qs.setSql("insert into books (isbn13,title) values (:isbn13,:title)");
            qs.addParam(
                name = "isbn13",
                cfsqltype = "CF_SQL_NVARCHAR",
                value = formData.isbn13
            );
            qs.addParam(
                name = "title",
                cfsqltype = "CF_SQL_NVARCHAR",
                value = formData.title
            );
            qs.execute();
        }
    }

    function sideNavBooks() {
        var allBooksQuery = new query(datasource = application.dsource);
        allBooksQuery.setSql("select * from books");
        allBooksQuery = allBooksQuery.execute().getResult();
        return allBooksQuery;
    }

}

