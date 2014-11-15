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
    var url = "http://api.ihackernews.com/ask?format=jsonp";
    
    console.log("getAskHN function is working!!");
    xmlhttp.onreadystatechange=function() {
        if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
	    console.log("Got a response!!");
	    var list_ask_hn = JSON.parse(xmlhttp.responseText);
	    console.log("response text " + xmlhttp.responseText);
	    var i = 0;
	    for (i = 0; i < 25; i++) {
		getStoryData(list_ask_hn["items"][i]["id"]);
		console.log("Ask HN id: " + list_ask_hn["items"][i]["id"]);
	    }
        }
    }
    xmlhttp.open("GET", url, true);
    xmlhttp.send();
}

// function getAskHNData(story_id) {
//         var xmlhttp = new XMLHttpRequest();
//         var url = "https://hacker-news.firebaseio.com/v0/item/"+story_id+".json";
//         xmlhttp.onreadystatechange=function() {
//             if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
//                 appendStory(xmlhttp.responseText);
//             }
//         }
//         xmlhttp.open("GET", url, true);
//         xmlhttp.send();
//     }



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

	if (obj["kids"]){
	    var number_of_comments = obj["kids"].length
	} else {
	    var number_of_comments = 0
	}

	var time_ago = timeAgoFromEpochTime(obj["time"])
        listview.model.append( {title: obj["title"],
        			score: obj["score"],
				url: story_url,
				comments_url: "https://news.ycombinator.com/item?id=" + obj["id"],
				author: obj["by"],
				story_text: obj["text"],
				id: obj["id"],
				number_of_comments: number_of_comments,
				time_ago: time_ago});
    }    

// Unix time to time ago
function timeAgoFromEpochTime(epoch) {
    var secs = ((new Date()).getTime() / 1000) - epoch;
    Math.floor(secs);
    var minutes = secs / 60;
    secs = Math.floor(secs % 60);
    if (minutes < 1) {
        return secs + (secs > 1 ? ' seconds ago' : ' second ago');
    }
    var hours = minutes / 60;
    minutes = Math.floor(minutes % 60);
    if (hours < 1) {
        return minutes + (minutes > 1 ? ' minutes ago' : ' minute ago');
    }
    var days = hours / 24;
    hours = Math.floor(hours % 24);
    if (days < 1) {
        return hours + (hours > 1 ? ' hours ago' : ' hour ago');
    }
    var weeks = days / 7;
    days = Math.floor(days % 7);
    if (weeks < 1) {
        return days + (days > 1 ? ' days ago' : ' day ago');
    }
    var months = weeks / 4.35;
    weeks = Math.floor(weeks % 4.35);
    if (months < 1) {
        return weeks + (weeks > 1 ? ' weeks ago' : ' week ago');
    }
    var years = months / 12;
    months = Math.floor(months % 12);
    if (years < 1) {
        return months + (months > 1 ? ' months ago' : ' month ago');
    }
    years = Math.floor(years);
    return years + (years > 1 ? ' years ago' : ' years ago');
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


