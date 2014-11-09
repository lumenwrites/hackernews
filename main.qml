import QtQuick 2.0
import Ubuntu.Components 1.1
//import Ubuntu.Components 1.1 as Toolkit
import Ubuntu.Components.ListItems 0.1 as ListItem
import Ubuntu.Web 0.2
import "logic.js" as Logic
import "comments.js" as CommentsJs

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

    backgroundColor : ("#FEEDDB")
    //backgroundColor : Color.create ("#fffeddb")



    //footerColor : color
    //headerColor : "#343C60"
    
    Component.onCompleted: Logic.getTopStories();
    //Component.onCompleted: testData();        
    
PageStack {
    id: pageStack
    // Open Main Page:
    // Component.onCompleted: push(main_page)
    // Open Comments page:
    Component.onCompleted: push(comments_page, {story_id: 8863})

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

     // **************** Comments Page Start ****************
    Page {
        title: "Commens " + story_id
        id: comments_page
        visible: false
        property int story_id
        property string article_url
        property string comments_url       

        //Component.onCompleted: Logic.listComments(8863); //(story_id);

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
            //Component.onCompleted: Logic.createCommentsModel ();

            //Component.onCompleted: CommentsJs.fakeJsonDataModel();//listComments(8863);
            Component.onCompleted: CommentsJs.createCommentsModel(8863);
            Column {            
                spacing: units.gu(1)
                width: parent.width - units.gu(4)
                height: parent.height
                x: units.gu(4)

                anchors {
                    margins: units.gu(32)
                }
                
                
                ListModel {
                     id: treemodel
                }

                
                TreeView {
                    anchors.fill: parent
                    model: treemodel
                }

                // ListModel {
                //     id: comments_model
                // }

                // ListView {
                //     id: comments_listview
                //     anchors.fill: parent
                //     model: comments_model
                //     delegate: ListItem.Subtitled {
                //         anchors {
                //             margins: units.gu(8)
                //         }
                //         width: parent.width
                //         height: units.gu(8)
                //         text: comment_text
                //     }                    
                    
                // }
            }            

        } // End Rectangle

    } // End Comments Page
    // **************** Comments Page End ****************


} //End PageStack
}