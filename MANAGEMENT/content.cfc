component {


    function obtainArticle( id ){
        var qs = new query(datasource=application.dsource);
        qs.setSql("select * from content where contentId=:id");
		qs.addParam(name="id",value=id);
        return qs.execute().getResult();
    }

    function allContent( id ){
        var qs = new query(datasource=application.dsource);
        qs.setSql("select * from content order by title");
        return qs.execute().getResult();
    }

    function processContent( formData ){
        var qs = new query( datasource=application.dsource );
        if(formData.keyExists("contentid")){
            qs.setSql("update content set title=:title, description=:description where contentid=:id");
            qs.addParam(name="id",value=formdata.contentid);
        } else {
            qs.setSql("insert into content (title, description) VALUES (:title,:description) ;")
        }
        qs.addParam(name="title",value=formData.title);
        qs.addParam(name="description",value=formData.description);
        qs.execute();
    }
}