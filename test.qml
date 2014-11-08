import QtQuick 2.0
import Ubuntu.Components 1.1

Component {
    property int commentId;
    property int level;
    property alias text: commentText.text
    //property alias author: commentAuthor.text
 
    Item {
        id: commentWrapper
        height: childrenRect.height

        // Indent comments. 
        Item {
            id: levelMarginElement
            width: (level > 6 ? 7 : level) * 5 // if more than 6 - 7 tabs.
            anchors.left: parent.left
        }

        // Comment?
        Item {
            anchors.left: levelMarginElement.right
            anchors.verticalCenter: commentWrapper.verticalCenter
 
            Text {
                id: commentText
            }
        }
    }
}