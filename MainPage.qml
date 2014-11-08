import QtQuick 2.0
import Ubuntu.Components 1.1
//import Ubuntu.Components 1.1 as Toolkit
import Ubuntu.Components.ListItems 0.1 as ListItem
import Ubuntu.Web 0.2
import "logic.js" as Logic

    // **************** Comments Page Start ****************
    Page {
        title: "Commens " + story_id
        id: comments_page
        visible: false
        property int story_id
        property string article_url
        property string comments_url       

        Component.onCompleted: Logic.listComments(8863); //(story_id);

        head.actions: [
        Action {
            iconName: "system-restart-panel"
            text: i18n.tr("Refresh Comments Stories")
            onTriggered: {
                getTopStories()
                //testData();    
                console.log("Click refresh stories")
            }
        },
        // Action {
        //     iconSource: "icons/globe-icon.png"
        //     text: i18n.tr("Open Comments in the Browser")
        //     onTriggered: {
        //         Qt.openUrlExternally(comments_url);                
        //     }
        // },
        Action {
            iconSource: "icons/read-article-icon.png"
            text: i18n.tr("Open Article in the Browser")
            onTriggered: {
                console.log("Open " + comments_page.article_url);
                Qt.openUrlExternally(comments_page.article_url);                
            }
        }
        
        ]

        // WebView {
        //     id: web_comments
        //     anchors.fill: parent
        //     url: comments_page.comments_url
        //     scale: 1
        //     visible: true
        // }

        
        Rectangle {
            color: "#FEEDDB"
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
                    id: comments_model
                }
                
                ListView {
                    id: comments_listview
                    anchors.fill: parent
                    model: comments_model
                    delegate: ListItem.Subtitled {
                        anchors {
                            margins: units.gu(8)
                        }
                        width: parent.width
                        height: units.gu(8)
                        text: comment_text
                    }                    
                    
                }}            

        } // End Rectangle

    } // End Comments Page
    // **************** Comments Page End ****************