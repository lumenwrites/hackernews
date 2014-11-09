    // **************** JavaScript Start ****************
    // Get list of the top stories (id's)
function getTopStories() {
        listview.model.clear(); // Delete all existing stories from the model to refresh
    
        var xmlhttp = new XMLHttpRequest();
        var url = "https://hacker-news.firebaseio.com/v0/topstories.json";

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

function getAskHN() {
        listview.model.clear(); // Delete all existing stories from the model to refresh
    
        var xmlhttp = new XMLHttpRequest();
        var url = "https://hacker-news.firebaseio.com/v0/maxitem.json";

        xmlhttp.onreadystatechange=function() {
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                var maxItem = JSON.parse(xmlhttp.responseText);
		var i = maxItem;
		while (i > (maxItem - 250)) {
		    getAskHNData(i);
		    i--;
		}
            }
        }
        xmlhttp.open("GET", url, true);
        xmlhttp.send();
}

function getAskHNData(story_id) {
        var xmlhttp = new XMLHttpRequest();
        var url = "https://hacker-news.firebaseio.com/v0/item/"+story_id+".json";
        xmlhttp.onreadystatechange=function() {
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                appendStory(xmlhttp.responseText);
            }
        }
        xmlhttp.open("GET", url, true);
        xmlhttp.send();
    }



    // Take a story and apply "append story" to it.
function getStoryData(story_id) {
        var xmlhttp = new XMLHttpRequest();
        var url = "https://hacker-news.firebaseio.com/v0/item/"+story_id+".json";
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
	if (obj["url"].length > 1) {
	    var story_url = obj["url"];
	} else {
	    var story_url = "https://news.ycombinator.com/item?id=" + obj["id"];
	}
        listview.model.append( {title: obj["title"],
        			score: obj["score"],
				url: story_url,
				comments_url: "https://news.ycombinator.com/item?id=" + obj["id"],
				author: obj["by"],
				story_text: obj["text"],
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


