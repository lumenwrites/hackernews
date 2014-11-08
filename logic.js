    // **************** JavaScript Start ****************
    // Get list of the top stories (id's)
    function getTopStories() {
        var xmlhttp = new XMLHttpRequest();
        var url = "https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty";

        listview.model.clear(); // Delete all existing stories from the model to refresh

        xmlhttp.onreadystatechange=function() {
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                listStories(xmlhttp.responseText);
            }
        }
        xmlhttp.open("GET", url, true);
        xmlhttp.send();
    }

    // Take list of stories, and get data about each of them
    function listStories(json) {
        var obj = JSON.parse(json);
        //listview.model.append( {jsondata: obj.first +" "+ obj.last })
        var i = 0;
        for (i = 0; i < 50; i++) {
            getStoryData(obj[i]);
        }
    }    

    // Take a story and apply "append story" to it.
    function getStoryData(story_id) {
        var xmlhttp = new XMLHttpRequest();
        var url = "https://hacker-news.firebaseio.com/v0/item/"+story_id+".json?print=pretty";
        
        xmlhttp.onreadystatechange=function() {
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                appendStory(xmlhttp.responseText);
            }
        }
        xmlhttp.open("GET", url, true);
        xmlhttp.send();
    }

    // Take json data about the story, and append it to listview
    function appendStory(json) {
        var obj = JSON.parse(json);
        listview.model.append( {title: obj["title"],
        						score: obj["score"],
								url: obj["url"],
								comments_url: "https://news.ycombinator.com/item?id=" + obj["id"],
						        author: obj["by"],
								id: obj["id"]});
    }    

    // Test Data
//property int refresh : 0
var refresh = 0;
    function testData() {
        listview.model.clear();
        var i = 0;
        for (i; i < 5; i++) {
            listview.model.append ({
                title: refresh + " " + "title " + i,
                score: i,
                url: "http://example.com/" + i,
                author: "author " + i,
                id: i,
            });
            console.log("add element " + i)
        }
        refresh++;
    }





    // **************** JavaScript End ****************


    // **************** Comments JavaScript Start ****************
    function listComments(story_id) {
        var xmlhttp = new XMLHttpRequest();
        var url = "https://hacker-news.firebaseio.com/v0/item/"+story_id+".json?print=pretty";
 
        xmlhttp.onreadystatechange=function() {
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                appendComments(xmlhttp.responseText);
            }
        }
        console.log("I'm working!!");
        xmlhttp.open("GET", url, true);
        xmlhttp.send();
    }

    function appendComments(story_data) {
        var comment_ids = JSON.parse(story_data)["kids"];
        console.log("Comment ids are: " + comment_ids);
        var i = 1;
        for (i = 1; i < comment_ids.length ; i++) {
            //console.log("comment id is: " + comment_ids[i] )
            getCommentData(comment_ids[i]);
        }
    }

    function getCommentData(comment_id) {
        var xmlhttp = new XMLHttpRequest();
        var url = "https://hacker-news.firebaseio.com/v0/item/"+comment_id+".json?print=pretty";
        
        xmlhttp.onreadystatechange=function() {
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                appendComment(xmlhttp.responseText);
            }
        }
        xmlhttp.open("GET", url, true);
        xmlhttp.send();
    }
    
    
    function appendComment(json) {
        var comment = JSON.parse(json);
        console.log("append comment with id :" + comment["id"]);
        if (comment["kids"]) {
            
            }
        comments_model.append( {comment_text: comment["text"],
						        //author: obj["by"],
							 });
        
    }    


    // **************** Comments JavaScript End ****************
