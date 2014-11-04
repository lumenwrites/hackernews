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
    //automaticOrientation: true
    
    // Removes the old toolbar and enables new features of the new header.
    useDeprecatedToolbar: false
    
    width: units.gu(100)
    height: units.gu(75)
    
    property real margins: units.gu(2)
    property real buttonWidth: units.gu(9)
    
    
    function getTopStories() {
        var xmlhttp = new XMLHttpRequest();
        var url = "https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty";
        
        xmlhttp.onreadystatechange=function() {
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                listStories(xmlhttp.responseText);
            }
        }
        xmlhttp.open("GET", url, true);
        xmlhttp.send();
    }
    
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
    
    function appendStory(json) {
        var obj = JSON.parse(json);
        listview.model.append( {title: obj["title"],
        score: obj["score"],
        url: obj["url"],
        author: obj["by"],
        id: obj["id"],
    });
}

function listStories(json) {
    var obj = JSON.parse(json);
    //listview.model.append( {jsondata: obj.first +" "+ obj.last })
    var i = 0;
    for (i = 0; i < 50; i++) {
        getStoryData(obj[i]);
    }
    
    console.log("hi");
}    

Component.onCompleted: getTopStories();

Page {
    title: i18n.tr("Hacker News")
    
    Rectangle {
        color: Color.create ("#fffeddb")
        anchors.fill: parent
        clip: true

        Column {
            spacing: units.gu(1)
            
            anchors {
                margins: units.gu(2)
                fill: parent
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
                    x: units.gu(4)                    
                    progression: true
                    onClicked: Qt.openUrlExternally(url);                        

                    MouseArea {
                        width: comments_icon.width
                        height: comments_icon.height
                        Image {
                            id: comments_icon
                            x: - units.gu(5)
                            y: units.gu(2)                        
                            anchors {
                                margins: units.gu(8)
                            }
                            
                            height: units.gu(4)
                            width:  units.gu(4)
                            
                            smooth: true
                            source: "comments-icon.png"

                        }
                        onClicked: Qt.openUrlExternally("https://news.ycombinator.com/item?id="+id);
                    }
                    
                    text: title
                    subText: i18n.tr(score + " points by " + author)

                    // Button {
                        //     anchors { right : parent.right; verticalCenter : parent.verticalCenter;}
                        //     //text: ">"
                        //     //                iconSource: Qt.resolvedUrl("/usr/share/icons/ubuntu-mobile/actions/scalable/reload.svg")
                        //     onClicked: Qt.openUrlExternally(url);
                        //     // Icon {
                            //     //     width: 64
                            //     //     height: 64
                            //     //     name: "search"
                            //     //     color: UbuntuColors.white
                            //     // }
                            // }
                        //}
                        
                    }
                }
                
            }
        }
    }
    
}