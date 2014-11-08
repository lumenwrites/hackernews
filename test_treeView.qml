import QtQuick 2.0
import Ubuntu.Components 1.1
import Ubuntu.Components.ListItems 0.1 as ListItem
import Ubuntu.Web 0.2
import "logic.js" as Logic

MainView {
    objectName: "mainView"
    applicationName: "com.ubuntu.developer.rayalez.hackernews"
    automaticOrientation: true
    useDeprecatedToolbar: false
    //width: units.gu(100)
    //height: units.gu(75)
    property real margins: units.gu(2)
    property real buttonWidth: units.gu(9)
    backgroundColor : ("#FEEDDB")

    Page {
        id: treePage
        title: i18n.tr("Tree View")

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
                    id: treeModel
                    ListElement { text: "Level 1, Node 1" }
                    ListElement {
                        text: "Level 1, Node 2"
                        elements: [
                        ListElement { text: "Level 2, Node 1"
                        elements: [
                        ListElement { text: "Level 3, Node 1" }
                        ]
                    },
                    ListElement { text: "Level 2, Node 2" }
                    ]
                }
                ListElement { text: "Level 1, Node 3" }
            }
            
            ListView {
                id: treeView
                anchors.fill: parent
                model: treeModel
                delegate: Text {
                    anchors {
                        margins: units.gu(8)
                    }
                    //width: parent.width
                    //height: units.gu(8)

                    text: "Text" + treeModel.text
                }
                
            } // END Page
        } // End MainView
    }
}
}