// const width = 1200 // Increased width
// const height = 800 // Increased height

// // Get the institute slug from the HTML context
// const instituteSlug = document.getElementById('roadmap').dataset.slug

// // Define the fixed position for the "Start" node
// const fixedStartNodePosition = { x: width / 2, y: height / 4 }

// const svg = d3
//   .select('#roadmap')
//   .append('svg')
//   .attr('width', width)
//   .attr('height', height)
//   .style('background-color', 'black') // Set the background color to black

// const color = d3.scaleOrdinal(d3.schemeCategory10)

// d3.json(`/roadmap_data/${instituteSlug}/`).then(function (data) {
//   // Prepare nodes and links from the data
//   const nodes = []
//   const links = []

//   data.courses.forEach((course) => {
//     nodes.push({ id: course.name, group: 2 })
//     links.push({ source: data.name, target: course.name })

//     course.subcourses.forEach((subcourse) => {
//       nodes.push({ id: subcourse.name, group: 3 })
//       links.push({ source: course.name, target: subcourse.name })

//       subcourse.topics.forEach((topic) => {
//         nodes.push({ id: topic.name, group: 4 })
//         links.push({ source: subcourse.name, target: topic.name })
//       })
//     })
//   })

//   nodes.push({
//     id: data.name,
//     group: 1,
//     fx: fixedStartNodePosition.x,
//     fy: fixedStartNodePosition.y,
//   })

//   const simulation = d3
//     .forceSimulation(nodes)
//     .force(
//       'link',
//       d3
//         .forceLink(links)
//         .id((d) => d.id)
//         .distance(200)
//     ) // Increased link distance
//     .force('charge', d3.forceManyBody().strength(-1000)) // Adjusted strength
//     .force('center', d3.forceCenter(width / 2, height / 2))
//     .force('x', d3.forceX().strength(0.1)) // Limit horizontal motion
//     .force('y', d3.forceY().strength(0.1)) // Limit vertical motion

//   const link = svg
//     .append('g')
//     .attr('class', 'links')
//     .selectAll('line')
//     .data(links)
//     .enter()
//     .append('line')
//     .attr('class', 'link')
//     .style('stroke', '#999') // Light gray stroke color
//     .style('stroke-opacity', 0.6)
//     .style('stroke-width', 2)

//   const node = svg
//     .append('g')
//     .attr('class', 'nodes')
//     .selectAll('rect')
//     .data(nodes)
//     .enter()
//     .append('rect')
//     .attr('class', 'node')
//     .attr('width', 100) // Set width of the rectangle
//     .attr('height', 50) // Set height of the rectangle
//     .attr('fill', (d) => color(d.group))
//     .style('stroke', '#fff') // White stroke color for better visibility
//     .style('stroke-width', 1.5)
//     .call(
//       d3
//         .drag()
//         .on('start', dragstarted)
//         .on('drag', dragged)
//         .on('end', dragended)
//     )

//   node.append('title').text((d) => d.id)

//   node.on('click', function (event, d) {
//     alert(`You clicked on ${d.id}`)
//     // You can replace this with window.location.href = 'your_target_url';
//   })

//   // Add text labels to the nodes using foreignObject for text wrapping
//   const text = svg
//     .append('g')
//     .attr('class', 'labels')
//     .selectAll('foreignObject')
//     .data(nodes)
//     .enter()
//     .append('foreignObject')
//     .attr('width', 100) // Set width of the foreignObject
//     .attr('height', 50) // Set height of the foreignObject
//     .attr('x', (d) => d.x - 50) // Center foreignObject horizontally
//     .attr('y', (d) => d.y - 25) // Center foreignObject vertically
//     .append('xhtml:div')
//     .attr('class', 'label')
//     .style('width', '100px')
//     .style('height', '50px')
//     .style('display', 'flex')
//     .style('align-items', 'center')
//     .style('justify-content', 'center')
//     .style('text-align', 'center')
//     .style('color', '#fff') // White text color for better visibility
//     .style('font-size', '12px') // Adjust text size
//     .style('overflow', 'hidden')
//     .style('word-wrap', 'break-word')
//     .text((d) => d.id)

//   simulation.on('tick', () => {
//     link
//       .attr('x1', (d) => d.source.x)
//       .attr('y1', (d) => d.source.y)
//       .attr('x2', (d) => d.target.x)
//       .attr('y2', (d) => d.target.y)

//     node
//       .attr('x', (d) => d.x - 50) // Adjust position to center rectangle
//       .attr('y', (d) => d.y - 25) // Adjust position to center rectangle

//     text
//       .attr('x', (d) => d.x - 50) // Adjust position to center text
//       .attr('y', (d) => d.y - 25) // Adjust position to center text
//   })

//   function dragstarted(event, d) {
//     if (!event.active) simulation.alphaTarget(0.3).restart()
//     d.fx = d.x
//     d.fy = d.y
//   }

//   function dragged(event, d) {
//     d.fx = event.x
//     d.fy = event.y
//   }

//   function dragended(event, d) {
//     if (!event.active) simulation.alphaTarget(0)
//     if (d.group !== 1) {
//       // Keep the Start node fixed
//       d.fx = null
//       d.fy = null
//     }
//   }
// })



function init() {
  var $ = go.GraphObject.make; // for conciseness in defining templates

  myDiagram = $(
    go.Diagram,
    "myDiagramDiv", // must be the ID or reference to div
    {
      maxSelectionCount: 1, // users can select only one part at a time
      validCycle: go.Diagram.CycleDestinationTree, // make sure users can only create trees
      "clickCreatingTool.archetypeNodeData": {
        // allow double-click in background to create a new node
        name: "(new person)",
        title: "",
        comments: ""
      },
      "clickCreatingTool.insertPart": function (loc) {
        // scroll to the new node
        var node = go.ClickCreatingTool.prototype.insertPart.call(this, loc);
        if (node !== null) {
          this.diagram.select(node);
          this.diagram.commandHandler.scrollToPart(node);
          this.diagram.commandHandler.editTextBlock(node.findObject("NAMETB"));
        }
        return node;
      },
      layout: $(go.TreeLayout, {
        treeStyle: go.TreeLayout.StyleLastParents,
        arrangement: go.TreeLayout.ArrangementHorizontal,
        // properties for most of the tree:
        angle: 90,
        layerSpacing: 35,
        // properties for the "last parents":
        alternateAngle: 90,
        alternateLayerSpacing: 35,
        alternateAlignment: go.TreeLayout.AlignmentBus,
        alternateNodeSpacing: 20
      }),
      "undoManager.isEnabled": true // enable undo & redo
    }
  );

  // when the document is modified, add a "*" to the title and enable the "Save" button
  myDiagram.addDiagramListener("Modified", function (e) {
    var button = document.getElementById("SaveButton");
    if (button) button.disabled = !myDiagram.isModified;
    var idx = document.title.indexOf("*");
    if (myDiagram.isModified) {
      if (idx < 0) document.title += "*";
    } else {
      if (idx >= 0) document.title = document.title.substr(0, idx);
    }
  });

  // manage boss info manually when a node or link is deleted from the diagram
  myDiagram.addDiagramListener("SelectionDeleting", function (e) {
    var part = e.subject.first(); // e.subject is the myDiagram.selection collection,
    // so we'll get the first since we know we only have one selection
    myDiagram.startTransaction("clear boss");
    if (part instanceof go.Node) {
      var it = part.findTreeChildrenNodes(); // find all child nodes
      while (it.next()) {
        // now iterate through them and clear out the boss information
        var child = it.value;
        var bossText = child.findObject("boss"); // since the boss TextBlock is named, we can access it by name
        if (bossText === null) return;
        bossText.text = "";
      }
    } else if (part instanceof go.Link) {
      var child = part.toNode;
      var bossText = child.findObject("boss"); // since the boss TextBlock is named, we can access it by name
      if (bossText === null) return;
      bossText.text = "";
    }
    myDiagram.commitTransaction("clear boss");
  });

  // when a node is double-clicked, add a child to it
  function nodeDoubleClick(e, obj) {
    var clicked = obj.part;
    if (clicked !== null) {
      var thisemp = clicked.data;
      myDiagram.startTransaction("add employee");
      var newemp = {
        name: "(new person)",
        title: "",
        comments: "",
        parent: thisemp.key
      };
      myDiagram.model.addNodeData(newemp);
      myDiagram.commitTransaction("add employee");
    }
  }

  // this is used to determine feedback during drags
  function mayWorkFor(node1, node2) {
    if (!(node1 instanceof go.Node)) return false; // must be a Node
    if (node1 === node2) return false; // cannot work for yourself
    if (node2.isInTreeOf(node1)) return false; // cannot work for someone who works for you
    return true;
  }

  // This function provides a common style for most of the TextBlocks.
  // Some of these values may be overridden in a particular TextBlock.
  function textStyle() {
    return { font: "9pt  Avenir", stroke: "#333" };
  }

  // This converter is used by the Picture.
  function findHeadShot(key) {
    return "https://s.rfi.fr/media/display/2bf374be-111f-11ea-991a-005056a99247/w:1280/p:1x1/2636580_0.jpg";
  }

  // define the Node template
  myDiagram.nodeTemplate = $(
    go.Node,
    "Auto",
    { doubleClick: nodeDoubleClick },
    {
      // handle dragging a Node onto a Node to (maybe) change the reporting relationship
      mouseDragEnter: function (e, node, prev) {
        var diagram = node.diagram;
        var selnode = diagram.selection.first();
        if (!mayWorkFor(selnode, node)) return;
        var shape = node.findObject("SHAPE");
        if (shape) {
          shape._prevFill = shape.fill; // remember the original brush
          shape.fill = "darkred";
        }
      },
      mouseDragLeave: function (e, node, next) {
        var shape = node.findObject("SHAPE");
        if (shape && shape._prevFill) {
          shape.fill = shape._prevFill; // restore the original brush
        }
      },
      mouseDrop: function (e, node) {
        var diagram = node.diagram;
        var selnode = diagram.selection.first(); // assume just one Node in selection
        if (mayWorkFor(selnode, node)) {
          // find any existing link into the selected node
          var link = selnode.findTreeParentLink();
          if (link !== null) {
            // reconnect any existing link
            link.fromNode = node;
          } else {
            // else create a new link
            diagram.toolManager.linkingTool.insertLink(
              node,
              node.port,
              selnode,
              selnode.port
            );
          }
        }
      }
    },
    // for sorting, have the Node.text be the data.name
    new go.Binding("text", "name"),
    // bind the Part.layerName to control the Node's layer depending on whether it isSelected
    new go.Binding("layerName", "isSelected", function (sel) {
      return sel ? "Foreground" : "";
    }).ofObject(),
    // define the node's outer shape
    $(go.Shape, "RoundedRectangle", {
      name: "SHAPE",
      fill: "#FFF",
      stroke: "#00A3DA",
      strokeWidth: 2,
      // set the port properties:
      portId: "",
      fromLinkable: true,
      toLinkable: true,
      cursor: "pointer"
    }),
    $(
      go.Panel,
      "Horizontal",
      $(
        go.Picture,
        {
          name: "Picture",
          desiredSize: new go.Size(70, 70),
          margin: 1.5
        },
        new go.Binding("source", "key", findHeadShot)
      ),
      // define the panel where the text will appear
      $(
        go.Panel,
        "Table",
        {
          minSize: new go.Size(130, NaN),
          maxSize: new go.Size(150, NaN),
          margin: new go.Margin(6, 10, 0, 6),
          defaultAlignment: go.Spot.Left
        },
        $(go.RowColumnDefinition, { column: 2, width: 4 }),
        $(
          go.TextBlock,
          textStyle(), // the name
          {
            row: 0,
            column: 0,
            columnSpan: 5,
            font: "bold 12pt Avenir",
            editable: true,
            isMultiline: false,
            minSize: new go.Size(10, 16)
          },
          new go.Binding("text", "name").makeTwoWay()
        ),
        $(
          go.TextBlock,
          textStyle(),
          {
            row: 1,
            column: 0,
            columnSpan: 4,
            editable: true,
            isMultiline: false,
            minSize: new go.Size(10, 14),
            margin: new go.Margin(5, 0, 5, 0),
            stroke: "#00a3da"
          },
          new go.Binding("text", "title").makeTwoWay()
        ),
        $(
          go.TextBlock,
          textStyle(),
          { row: 2, column: 0 },
          new go.Binding("text", "key", function (v) {
            return v;
          })
        ),
        $(
          go.TextBlock,
          textStyle(), // the comments
          {
            row: 3,
            column: 0,
            columnSpan: 5,
            font: "italic 9pt sans-serif",
            wrap: go.TextBlock.WrapFit,
            editable: true, // by default newlines are allowed
            minSize: new go.Size(10, 14)
          },
          new go.Binding("text", "comments").makeTwoWay()
        )
      ) // end Table Panel
    ) // end Horizontal Panel
  ); // end Node

  // the context menu allows users to make a position vacant,
  // remove a role and reassign the subtree, or remove a department
  myDiagram.nodeTemplate.contextMenu = $(
    "ContextMenu",
    $("ContextMenuButton", $(go.TextBlock, "Vacate Position"), {
      click: function (e, obj) {
        var node = obj.part.adornedPart;
        if (node !== null) {
          var thisemp = node.data;
          myDiagram.startTransaction("vacate");
          // update the key, name, and comments
          myDiagram.model.setDataProperty(thisemp, "name", "(Vacant)");
          myDiagram.model.setDataProperty(thisemp, "comments", "");
          myDiagram.commitTransaction("vacate");
        }
      }
    }),
    $("ContextMenuButton", $(go.TextBlock, "Remove Role"), {
      click: function (e, obj) {
        // reparent the subtree to this node's boss, then remove the node
        var node = obj.part.adornedPart;
        if (node !== null) {
          myDiagram.startTransaction("reparent remove");
          var chl = node.findTreeChildrenNodes();
          // iterate through the children and set their parent key to our selected node's parent key
          while (chl.next()) {
            var emp = chl.value;
            myDiagram.model.setParentKeyForNodeData(
              emp.data,
              node.findTreeParentNode().data.key
            );
          }
          // and now remove the selected node itself
          myDiagram.model.removeNodeData(node.data);
          myDiagram.commitTransaction("reparent remove");
        }
      }
    }),
    $("ContextMenuButton", $(go.TextBlock, "Remove Department"), {
      click: function (e, obj) {
        // remove the whole subtree, including the node itself
        var node = obj.part.adornedPart;
        if (node !== null) {
          myDiagram.startTransaction("remove dept");
          myDiagram.removeParts(node.findTreeParts());
          myDiagram.commitTransaction("remove dept");
        }
      }
    })
  );

  // define the Link template
  myDiagram.linkTemplate = $(
    go.Link,
    go.Link.Orthogonal,
    { corner: 5, relinkableFrom: true, relinkableTo: true },
    $(go.Shape, { strokeWidth: 1, stroke: "#333" })
  ); // the link shape

  // read in the JSON-format data from the "mySavedModel" element
  load();

  // support editing the properties of the selected person in HTML
  if (window.Inspector)
    myInspector = new Inspector("myInspector", myDiagram, {
      properties: {
        key: { readOnly: true },
        comments: {}
      }
    });

  // Setup zoom to fit button
  document.getElementById("zoomToFit").addEventListener("click", function () {
    myDiagram.commandHandler.zoomToFit();
  });

  document.getElementById("centerRoot").addEventListener("click", function () {
    myDiagram.scale = 1;
    myDiagram.commandHandler.scrollToPart(myDiagram.findNodeForKey(1));
  });
} // end init

// Show the diagram's model in JSON format
function save() {
  document.getElementById("mySavedModel").value = myDiagram.model.toJson();
  myDiagram.isModified = false;
}
function load() {
  // console.log(document.getElementById('mySavedModel').value);
  myDiagram.model = go.Model.fromJson(
    jsonData
    // console.log(document.getElementById("mySavedModel").value);
    // document.getElementById("mySavedModel").value
  )
  // make sure new data keys are unique positive integers
  var lastkey = 1;
  myDiagram.model.makeUniqueKeyFunction = function (model, data) {
    var k = data.key || lastkey;
    while (model.findNodeDataForKey(k)) k++;
    data.key = lastkey = k;
    return k;
  };
}
window.addEventListener("DOMContentLoaded", init);

/*
myDiagram.add(
  $(go.Part, "Spot",
    { scale: 2 },
    $(go.Picture, "https://s.rfi.fr/media/display/2bf374be-111f-11ea-991a-005056a99247/w:1280/p:1x1/2636580_0.jpg",
      {
        name: 'Picture',
        desiredSize: new go.Size(55, 55),
        background: 'red'
      }
    ),
    $(go.Shape,
    {
      strokeWidth: 0,
      stroke: null,
      geometryString: "f M0 0 L100 0 L100 100 L0 100 z M5,50a45,45 0 1,0 90,0a45,45 0 1,0 -90,0 z",
      width: 56,
      height: 56,
      fill: 'black'
    })
  )
);
*/
