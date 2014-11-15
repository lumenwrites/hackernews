// **************** Comments JavaScript Start ****************

function printStoryId(story_id) {
    console.log("story id is: " + story_id);
}

function createCommentsModel(story_id) {
    treemodel.clear();

    //Get Story data
    var storyRequest = new XMLHttpRequest();
    var url = "https://hacker-news.firebaseio.com/v0/item/"+story_id+".json";
    //var url = "https://hacker-news.firebaseio.com/v0/item/8863.json"
    storyRequest.onreadystatechange=function() {
        if (storyRequest.readyState == 4 && storyRequest.status == 200) {
	    //Once I have data, create top lvl of comments
            var story_children = JSON.parse(storyRequest.responseText)["kids"];

	    //Loop through top comment branches
	    var i = 0;
	    for (i = 0; i < story_children.length ; i++) {
		var comment_id = story_children[i];
		appendTopLvlComment(comment_id);
	    } // End top for loop.

        }
    }// End get story data
    storyRequest.open("GET", url, true);
    storyRequest.send();
}

function appendTopLvlComment(comment_id){
    //Get Comment data
    var commentRequest = new XMLHttpRequest();
    var url = "https://hacker-news.firebaseio.com/v0/item/"+comment_id+".json";
    commentRequest.onreadystatechange=function() {
	if (commentRequest.readyState == 4 && commentRequest.status == 200) {
	    //**************** Once I have comment Data ****************
	    var comment = JSON.parse(commentRequest.responseText);

	    if (!comment["dead"]) {
		var comment_text = comment["text"];
	    } else {
		var comment_text = "[dead]";
	    }

	    var time_ago = timeAgoFromEpochTime(comment["time"]);

	    // Append Comment
	    var hasKids = !(comment["kids"]===undefined);

	    var check_exists = !!((comment["by"]) && (comment["text"]));
	    if (check_exists) {
		if (hasKids) {	    
		    treemodel.append( {text: comment_text,
				       author: comment["by"],
				       time: time_ago,
				       elements : []});
		} else {
		    treemodel.append( {text: comment_text,
				       author: comment["by"],
				       time: time_ago});
		}
		
		//Get last appended comment
		var lvl1node = treemodel.get(treemodel.count - 1);
		
		if (hasKids) {
		    var i = 0;
		    for (i = 0; i < comment["kids"].length ; i++) {
			var child_id = comment["kids"][i];
			recursiveAppendComments(lvl1node, child_id);
		    } // End top for loop.
		}
	    }		
	    //****************
	}
    }// End get comemnt data
    commentRequest.open("GET", url, true);
    commentRequest.send();
}

function recursiveAppendComments(parent, comment_id){
    //Get Comment data
    var commentRequest = new XMLHttpRequest();
    var url = "https://hacker-news.firebaseio.com/v0/item/"+comment_id+".json";
    commentRequest.onreadystatechange=function() {
	if (commentRequest.readyState == 4 && commentRequest.status == 200) {
	    //**************** Once I have comment Data ****************
	    var comment = JSON.parse(commentRequest.responseText);
	    
	    if (!comment["dead"]) {
		var comment_text = comment["text"];
	    } else {
		var comment_text = "[dead]";
	    }

	    var time_ago = timeAgoFromEpochTime(comment["time"]);
	    
	    // Append Coment
	    var hasKids = !(comment["kids"]===undefined);
	    var check_exists = !!((comment["by"]) && (comment["text"]));	    
	    //console.log("Exists? " + check_exists);
	    if (check_exists) {
		if (hasKids) {
		    parent.elements.append( {text: comment_text,
					     author: comment["by"],
					     time: time_ago,
					     elements : []});
		} else {
		    parent.elements.append( {text: comment_text,
					     author: comment["by"],
					     time: time_ago});
		}
		
		//Get last appended comment
		parent = parent.elements.get(parent.elements.count - 1);
		
		
		if (hasKids) {
		    //Launch Recursion for all the children
		    var i = 0;
		    for (i = 0; i < comment["kids"].length ; i++) {
			var child_id = comment["kids"][i];
			recursiveAppendComments(parent, child_id);
		    } // End top for loop.
		    
		}
	    }
	    //****************
	}
    }// End get comemnt data
    commentRequest.open("GET", url, true);
    commentRequest.send();
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

