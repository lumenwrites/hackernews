    import QtQuick 2.1
    
    Rectangle {
        function createCommentsModel() {
            treemodel.clear();
            var i = 0;
            for (i = 0; i < 5; i++) {
                treemodel.append ({
                    text: "Level 1, Node " + i,
                    elements: [],
                });
                //console.log(thisElement);
                var thisLvl = treemodel.get(i);

                var c = 0;
                for (c = 0; c < 5; c++) {
                    thisLvl.elements.append({"text": "Level 2, Node 1"});
                } //end for
                //treemodel.get(0).elements.append({"text": "Level 2, Node 1"});
                //thisElement.elements.append({"text": "Level 2, Node 1"});
            } //end for




            // treemodel.get(1).elements.append({"text": "Level 2, Node 1"});            
            // // treemodel.get(1).elements.append({"text": "Child", "elements" : [
            // // {text: "Level 3, Node 1" , elements: []}]});
            // treemodel.get(1).elements.append({"text": "Level 2, Node 2", "elements" : []});
            // treemodel.get(1).elements.get(0).elements.append({"text": "Level 3, Node 1"});

            // var subchild = treemodel.get(2).elements.append({"text": "Level 2, Node 1", "elements" : []});
            // subchild.elements.append({"text": "Level 3, Node 1", "elements" : []});            
        } 

        
        width: 360
        height: 480

        Component.onCompleted: createCommentsModel();

        ListModel {
            id: treemodel
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
     
        TreeView {
            anchors.fill: parent
            model: treemodel
        }
    }
