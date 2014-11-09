// **************** Comments JavaScript Start ****************

var thisCommentId = 0;
var thisBranchId = 0;
function listComments(story_id) {
    //to refresh
    thisCommentId = 0;
    thisBranchId = 0;
    treemodel.clear();
    
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

    treemodel.append( {text: comment["text"],
		       elements : []});

    var hasKids = !(comment["kids"]===undefined);

    if (hasKids) {
        var thisLvl = treemodel.get(thisBranchId);
	recursiveAppendChildren(thisLvl, comment["kids"][0]);
    } else {
	thisBranchId++; //has no kids, branch is over, moving on to the next one
    }

    
    function recursiveAppendChildren(thisLvl, child_id){
	// vvv Request child info
	var xmlhttp = new XMLHttpRequest();
	var url = "https://hacker-news.firebaseio.com/v0/item/"+child_id+".json?print=pretty";
	xmlhttp.onreadystatechange=function() {
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
		// ^^^ Request child info completed		

		// Parse Json
		var comment_obj = JSON.parse(xmlhttp.responseText);

		// Append a comment
		thisLvl.elements.append({
		    text: comment_obj["text"],
		    elements : []
		});

		//if it has kids - repeat
		var objHasKids = !(comment_obj["kids"]===undefined);
		if (objHasKids){
		    thisLvl = thisLvl.elements.get(0);
		    recursiveAppendChildren(thisLvl, comment_obj["kids"][0]);
		}
		// if doesn't have kids - do nothing yet
		else {
		  
		}
            }
	}
	//vvv open request
	xmlhttp.open("GET", url, true);
	xmlhttp.send()
	//^^^ close request;
	
	thisBranchId++;	//has no kids, branch is over, moving on to the next one
    }
}    


// **************** Comments JavaScript End ****************

// **************** Fake Generated Data Model ****************
        function fakeGeneratedDataModel() {
            treemodel.clear();

            function appendLoop() {

                var i = 0;
                for (i = 0; i < 3; i++) {
                    var lvl = 0;
                    treemodel.append ({
                        author: "author",
                        text: "Level: " + lvl + " Node: " + i,
                        elements: [],
                    });

 		    //Recursively append Children:
                    var thisLvl = treemodel.get(i);
                    var c = 0;
                    function appendRecursive(c, thisLvl, lvl) {
                        if (c < 2) {
                            thisLvl.elements.append ({
                                author: "author",                                
                                text: "Level: " + lvl + " Branch " + i +  " Node: " + c, 
                                elements: [],
                            });
                            thisLvl = thisLvl.elements.get(0);
                            lvl = lvl + 1;
                            appendRecursive(c + 1, thisLvl, lvl);
                        }
                        else {
                            // last Child
                            thisLvl.elements.append ({
                                author: "author",                                
                                text: "Level: " + lvl + " Branch " + i +  " Node: " + c, 
                                //elements: [],
                            });
                        }
                    }
                    
                    appendRecursive(0, thisLvl, lvl);
                    
                } //end for
            }

            appendLoop();

        } 
// **************** END Fake Generated Data Model ****************


// **************** Fake Json Data Model ****************
var storyJson = {
  "by" : "dhouston",
  "id" : 8863,
  "kids" : [ 8952, 9224, 8917, 8884, 8887, 8943, 8869, 8958, 9005, 9671, 8940, 9067, 8908, 9055, 8865, 8881, 8872, 8873, 8955, 10403, 8903, 8928, 9125, 8998, 8901, 8902, 8907, 8894, 8878, 8870, 8980, 8934, 8876 ],
  "score" : 111,
  "time" : 1175714200,
  "title" : "My YC app: Dropbox - Throw away your USB drive",
  "type" : "story",
  "url" : "http://www.getdropbox.com/u/2/screencast.html"
}

    treemodel.append( {text: comment["text"],
		       elements : []});


function fakeJsonDataModel(){
}
// **************** END Fake Json Data Model ****************
