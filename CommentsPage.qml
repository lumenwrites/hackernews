import QtQuick 2.0
import Ubuntu.Components 1.1
//import Ubuntu.Components 1.1 as Toolkit
import Ubuntu.Components.ListItems 0.1 as ListItem
import Ubuntu.Web 0.2
import "logic.js" as Logic

    // **************** Main Page Start ****************
    Page {
        id: main_page
        title: i18n.tr("Hacker News")
        visible: false

        //head.foregroundColor : ("#FEEDDB")
        // head.contents: Rectangle {
        //     width: parent.width
        //     height: parent.height
        //     anchors.margins: 0
        //     gradient: Gradient {
        //         GradientStop {
        //             position: 0.0
        //             color: "#C14D02"
        //         }
        //         GradientStop {
        //             position: 1.0
        //             color: "#DB5D08"
        //         }
        //     }
        //     color : ("#FEEDDB")
        //     Text {
        //         text: i18n.tr("Hacker News")
        //         anchors.verticalCenter: parent.verticalCenter
        //         anchors.horizontalCenter: parent.verticalCenter
        //         anchors.margins: units.gu(4)
        //         color: "white"
        //         font.pixelSize: units.gu(4)
        //     }
        // }

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
        },
        Action {
            iconSource: "icons/globe-icon.png"
            text: i18n.tr("Refresh Stories")
            onTriggered: {
                getTopStories()
                //testData();    
                console.log("Click refresh stories")
            }
        }
        ]
        
        
        Rectangle {
            color: "#FEEDDB"
            anchors.fill: parent
            clip: true

            Column {            
                spacing: units.gu(1)
                // Commented out to remove error in terminal
                // Uncomment if main view stops working:
                //width: parent.width - units.gu(4)
                //height: parent.height
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

                            // Open Comments in the browser:
                            //onClicked: Qt.openUrlExternally("https://news.ycombinator.com/item?id="+id);                            
                            // Open Comments page:
                            onClicked: pageStack.push(comments_page, {story_id: id,
												                      article_url: url,
												                      comments_url: comments_url
                              })
                        

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
                                source: "icons/comments-icon.png"
                            }
                        } // END MouseArea

                        text: title
                        subText: i18n.tr(score + " points by " + author)
                        // Open Article in the browser:
                        onClicked: Qt.openUrlExternally(url);
                    }
                }
            }
        }
    } // End Page
    // **************** Main Page End ****************