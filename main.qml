import QtQuick 2.0
import Ubuntu.Components 1.1
//import Ubuntu.Components 1.1 as Toolkit
import Ubuntu.Components.ListItems 0.1 as ListItem

/*!
    \brief MainView with a Label and Button elements.
*/

MainView {
    // objectName for functional testing purposes (autopilot-qt5)
    objectName: "mainView"
    
    // Note! applicationName needs to match the "name" field of the click manifest
    applicationName: "com.ubuntu.developer.rayalez.hackernews"
    
    /*
     This property enables the application to change orientation
     when the device is rotated. The default is false.
    */
    automaticOrientation: true
    
    // Removes the old toolbar and enables new features of the new header.
    // TODO: Move refresh button to the header:
    useDeprecatedToolbar: false
    
    width: units.gu(100)
    height: units.gu(75)
    
    property real margins: units.gu(2)
    property real buttonWidth: units.gu(9)

    //backgroundColor : Color.create ("#fffeddb")
    //backgroundColor : Color.create ("#fffeddb")



    //footerColor : color
    //headerColor : "#343C60"
    
    
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
						        author: obj["by"],
								id: obj["id"]});
    }    

    // Test Data
    property int refresh : 0
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

    Component.onCompleted: getTopStories();
    //Component.onCompleted: testData();    

    // **************** JavaScript End ****************
    
    Page {
        title: i18n.tr("Hacker News")
        
        //TODO: Find the list of icons, or add my own icon:
        head.actions: [
        Action {
            iconName: "system-restart-panel"
            text: i18n.tr("Refresh Stories")
            onTriggered: {
                getTopStories()
                //testData();    
                console.log("Click refresh stories")
            }
        }
        ]
        
        
        Rectangle {
            //color: Color.create ("#fffeddb")
            anchors.fill: parent
            clip: true

            Column {            
                spacing: units.gu(1)
                width: parent.width - units.gu(4)
                height: parent.height
                x: units.gu(4)

                anchors {
                    margins: units.gu(32)
                }
                
                ListModel {
                    id: model
                }
                
                ListView {
                    id: listview
                    anchors.fill: parent
                    model: model
                    delegate: ListItem.Subtitled {
                        anchors {
                            margins: units.gu(8)
                        }
                        width: parent.width
                        height: units.gu(8)
                        //x: units.gu(4)                    
                        progression: true
                        
                        MouseArea {
                            width: comments_icon.width
                            height: comments_icon.height
                            x: - units.gu(5)
                            y: units.gu(2)                        
                            onClicked: Qt.openUrlExternally("https://news.ycombinator.com/item?id="+id);

                            Image {
                                id: comments_icon
                                anchors {
                                    margins: units.gu(8)
                                }
                                height: units.gu(4)
                                width:  units.gu(4)
                                smooth: true
                                antialiasing: true
                                //mipmap: true
                                source: "comments-icon.png"
                            }
                        } // END MouseArea

                        text: title
                        subText: i18n.tr(score + " points by " + author)
                        onClicked: Qt.openUrlExternally(url);                        
                        
                    }
                }
            }
        }
    }
}
