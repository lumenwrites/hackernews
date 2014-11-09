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
    property int textWidth
    property string story_text
    anchors.fill: parent
    anchors.margins: units.gu(0)
    contentHeight: content.height
    contentWidth: content.width
    // Load recursive component for the first time. Top lvl.
    Loader {
        id: content
        height: implicitHeight
        sourceComponent: treeBranch
        property bool expanded: true
        property var elements: model
        property int textWidth : root.textWidth - units.gu(16)
    }
    
    // Recursive Component
    Component {
        id: treeBranch
        Column {
            id: column
            spacing: units.gu(1)
            Repeater {
                // Iterate over all the children in this element.
                model: elements
                Rectangle {
                    width: textWidth + units.gu(4)
                    height: expanded ? (comment_text.paintedHeight + loader.implicitHeight + units.gu(1)) : 0
                    clip: true
                    color:  Qt.rgba(0,0,0,0)

                    Rectangle {
                        width: units.gu(3.5)
                        height: parent.height
                        color: "gray"
                        opacity: 0.2
                    }
                    

                    MouseArea {
                            id: mouse
                            width: parent.width
                            height: parent.height
                            hoverEnabled: true
                            onClicked: {
                                loader.expanded = !loader.expanded
                            }
                        }
                        
                        Column {
                            x: units.gu(4)
                            spacing: units.gu(1)
                            height: comment_text.paintedHeight + loader.implicitHeight + units.gu(1)
                            
                            Text {
                                id: comment_text
                                text: "<i>" + model.author + "</i> <br/>" + model.text
                                width: textWidth
                                wrapMode: Text.WordWrap
                                font.pixelSize: units.gu(2)
                            }
                                
                                Loader {
                                    id: loader
                                    height: expanded ? implicitHeight : 0
                                    property var text: model.text
                                    property var elements: model.elements
                                    // decrease text width on the next iteration, because tabs
                                    property int textWidth : comment_text.width - units.gu(4)
                                    property bool expanded: true
                                    sourceComponent: model.elements ? treeBranch : undefined
                                    
                                }
                            } // END Column
                        } // END rectangle
                    }
                }
            }
        }