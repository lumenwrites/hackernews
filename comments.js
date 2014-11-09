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

	    // Append Comment
	    var hasKids = !(comment["kids"]===undefined);
	    if (hasKids) {	    
		treemodel.append( {text: comment_text,
				   author: comment["by"],
				   time: comment["time"],
				   elements : []});
	    } else {
		treemodel.append( {text: comment_text,
				   author: comment["by"],
				   time: comment["time"]});
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
	    // Append Coment
	    var hasKids = !(comment["kids"]===undefined);
	    if (hasKids) {
		parent.elements.append( {text: comment_text,
					 author: comment["by"],
					 time: comment["time"],
					 elements : []});
	    } else {
		parent.elements.append( {text: comment_text,
					 author: comment["by"],
					 time: comment["time"]});
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
	    //****************
	}
    }// End get comemnt data
    commentRequest.open("GET", url, true);
    commentRequest.send();
}
