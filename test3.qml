    import QtQuick 2.1
    
    Rectangle {
        function createCommentsModel() {
            treemodel.clear();

            function appendLoop() {

                var i = 0;
                for (i = 0; i < 3; i++) {
                    var lvl = 0;
                    treemodel.append ({
                        author: "author",
                        text: "Level: " + lvl + " Node: " + i,
                        elements: [],
                    });

                    // Recursion step by step:
                    // var thisLvl = treemodel.get(0);
                    // thisLvl.elements.append({"text": "Child", "elements":[]});
                    // thisLvl = thisLvl.elements.get(0)
                    // thisLvl.elements.append({"text": "Child", "elements":[]});

                    var thisLvl = treemodel.get(i);
                    var c = 0;
                    function appendRecursive(c, thisLvl, lvl) {
                        if (c < 2) {
                            thisLvl.elements.append ({
                                author: "author",                                
                                text: "Level: " + lvl + " Branch " + i +  " Node: " + c, 
                                elements: [],
                            });
                            thisLvl = thisLvl.elements.get(0);
                            lvl = lvl + 1;
                            appendRecursive(c + 1, thisLvl, lvl);
                        }
                        else {
                            // last Child
                            thisLvl.elements.append ({
                                author: "author",                                
                                text: "Level: " + lvl + " Branch " + i +  " Node: " + c, 
                                //elements: [],
                            });
                        }
                    }
                    
                    appendRecursive(0, thisLvl, lvl);
                    
                } //end for
            }

            appendLoop();

        } 

        
        width: 360
        height: 480

        Component.onCompleted: createCommentsModel ();

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
