import QtQuick 2.1
import QtQuick.Controls 1.0
import Ubuntu.Components 1.1
//import Ubuntu.Components 1.1 as Toolkit
import Ubuntu.Components.ListItems 0.1 as ListItem
import Ubuntu.Web 0.2
import "logic.js" as Logic

Flickable {
    id: root
    property var model
    anchors.fill: parent
    contentHeight: content.height
    contentWidth: content.width    

    // Load recursive component for the first time. Top lvl.
    Loader {
        id: content
        sourceComponent: treeBranch
        property var elements: model
    }

    // Recursive Component
    Component {
        id: treeBranch
        Column {
            id: column
            width: root.width
            height: root.height
            spacing: units.gu(1)
            Repeater {
                // Iterate over all the children in this element.
                model: elements
                Column {
                    x: units.gu(4)
                    spacing: units.gu(1)
                    height: comment_text.paintedHeight + loader.implicitHeight + units.gu(1)
                    Text {
                        id: comment_text
                        text: model.text
                    }

                    Loader {
                        id: loader
                        height: implicitHeight
                        property var text: model.text
                        property var elements: model.elements
                        sourceComponent: !!model.elements ? treeBranch : undefined
                    }
                    }
                }
            }
        }
    }