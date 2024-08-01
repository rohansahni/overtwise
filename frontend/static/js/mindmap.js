
// const mindData = {
//   data: {
//     id: ' root',
//     topic: 'IITM',
//     children: [
//       {
//         id: 'events',
//         topic: 'Data Science',
//         'background-color': '#1abc9c',
//         children: [
//           {
//             id: 'reporting',
//             topic: 'Python',
//             'background-color': '#34495e',
//             tag: 'MATOMO_REPORTS',
//             children: [
//               {
//                 id: '111068',
//                 'background-color': '#ffc107',
//                 topic:
//                   '<a target="_blank" href="https://fogbugz.forteresearch.com/f/cases/111068/">Class 111068 - Introduction to Python</a>',
//                 href: 'https://fogbugz.forteresearch.com/f/cases/${ c.ixBug }/',
//                 'data-target': null,
//               },
//               {
//                 id: '111538',
//                 'background-color': '#ffc107',
//                 topic:
//                   '<a target="_blank" href="https://fogbugz.forteresearch.com/f/cases/111538/">Case 111538 - What are dictionaries?</a>',
//                 href: 'https://fogbugz.forteresearch.com/f/cases/${ c.ixBug }/',
//                 'data-target': null,
//               },
//               {
//                 id: '111539',
//                 'background-color': '#fdc107',
//                 topic:
//                   '<a target="_blank" href="https://fogbugz.forteresearch.com/f/cases/111538/">Class 111539 - What are tuples?</a>',
//                 href: 'https://fogbugz.forteresearch.com/f/cases/${ c.ixBug }/',
//                 'data-target': null,
//               },
//             ],
//           },
//           {
//             id: 'searching',
//             topic: 'Statistics',
//             'background-color': '#34495e',
//             tag: 'MATOMO_SEARCHING',
//             children: [
//               {
//                 id: '111069',
//                 'background-color': '#28a745',
//                 topic:
//                   '<a target="_blank" href="https://fogbugz.forteresearch.com/f/cases/111069/">Class 111069 - Introduction to Statistics</a>',
//                 href: 'https://fogbugz.forteresearch.com/f/cases/${ c.ixBug }/',
//                 'data-target': null,
//               },
//               {
//                 id: '111587',
//                 'background-color': '#ffc107',
//                 topic:
//                   '<a target="_blank" href="https://fogbugz.forteresearch.com/f/cases/111587/">Class 111587 - Descriptive vs Inferential Statistics</a>',
//                 href: 'https://fogbugz.forteresearch.com/f/cases/${ c.ixBug }/',
//                 'data-target': null,
//               },
//               {
//                 id: '111606',
//                 'background-color': '#ffc107',
//                 topic:
//                   '<a target="_blank" href="https://fogbugz.forteresearch.com/f/cases/111606/">Case 111606 - Customize Matomo to support filter, show more, pagination activity on BACKBONE pages</a>',
//                 href: 'https://fogbugz.forteresearch.com/f/cases/${ c.ixBug }/',
//                 'data-target': null,
//               },
//               {
//                 id: '111616',
//                 'background-color': '#28a745',
//                 topic:
//                   '<i title="View QA Downstream Notes" data-toggle="modal" data-target="#qaNotesModal111616" class="fa fa-file-text-o" style="cursor:pointer; margin-left: 5px;"></i><a target="_blank" href="https://fogbugz.forteresearch.com/f/cases/111616/">Case 111616 - Customize Matomo to support column selector and sort activity on REACT pages</a>',
//                 href: 'https://fogbugz.forteresearch.com/f/cases/${ c.ixBug }/',
//                 'data-target': '#qaNotesModal111616',
//               },
//             ],
//           },
//           {
//             id: 'other',
//             topic: 'Other',
//             'background-color': '#34495e',
//             tag: 'MATOMO_EVENTS',
//             children: [
//               {
//                 id: '111070',
//                 'background-color': '#28a745',
//                 topic:
//                   '<i title="View QA Downstream Notes" data-toggle="modal" data-target="#qaNotesModal111070" class="fa fa-file-text-o" style="cursor:pointer; margin-left: 5px;"></i><a target="_blank" href="https://fogbugz.forteresearch.com/f/cases/111070/">Case 111070 - Add customization so Matomo can analyze modal activity </a>',
//                 href: 'https://fogbugz.forteresearch.com/f/cases/${ c.ixBug }/',
//                 'data-target': '#qaNotesModal111070',
//               },
//             ],
//           },
//         ],
//       },
//       {
//         id: 'legal',
//         topic: 'Rollout',
//         'background-color': '#1abc9c',
//         tag: 'MATOMO_ROLLOUT',
//         children: [
//           {
//             id: '104570',
//             'background-color': '#007bff',
//             topic:
//               '<a target="_blank" href="https://fogbugz.forteresearch.com/f/cases/104570/">Case 104570 - Investigate adding Matomo to Base Platform</a>',
//             href: 'https://fogbugz.forteresearch.com/f/cases/${ c.ixBug }/',
//             'data-target': null,
//           },
//           {
//             id: '108842',
//             'background-color': '#dc3545',
//             topic:
//               '<a target="_blank" href="https://fogbugz.forteresearch.com/f/cases/108842/">Case 108842 - Matomo User-level tracking opt-in </a>',
//             href: 'https://fogbugz.forteresearch.com/f/cases/${ c.ixBug }/',
//             'data-target': null,
//           },
//           {
//             id: '110929',
//             'background-color': '#28a745',
//             topic:
//               '<i title="View QA Downstream Notes" data-toggle="modal" data-target="#qaNotesModal110929" class="fa fa-file-text-o" style="cursor:pointer; margin-left: 5px;"></i><a target="_blank" href="https://fogbugz.forteresearch.com/f/cases/110929/">Case 110929 - Add out-of-the-box Matomo analytics to Platform</a>',
//             href: 'https://fogbugz.forteresearch.com/f/cases/${ c.ixBug }/',
//             'data-target': '#qaNotesModal110929',
//           },
//           {
//             id: '110930',
//             'background-color': '#ffc107',
//             topic:
//               '<a target="_blank" href="https://fogbugz.forteresearch.com/f/cases/110930/">Case 110930 - Investigate using Matomo for/with MTT apps</a>',
//             href: 'https://fogbugz.forteresearch.com/f/cases/${ c.ixBug }/',
//             'data-target': null,
//           },
//           {
//             id: '111180',
//             'background-color': '#ffc107',
//             topic:
//               '<a target="_blank" href="https://fogbugz.forteresearch.com/f/cases/111180/">Case 111180 - Investigate default configurable privacy settings for Matomo</a>',
//             href: 'https://fogbugz.forteresearch.com/f/cases/${ c.ixBug }/',
//             'data-target': null,
//           },
//           {
//             id: '111670',
//             'background-color': '#007bff',
//             topic:
//               '<a target="_blank" href="https://fogbugz.forteresearch.com/f/cases/111670/">Case 111670 - Reminder to create a resource that documents Matomo mapping e.g., what categories represent</a>',
//             href: 'https://fogbugz.forteresearch.com/f/cases/${ c.ixBug }/',
//             'data-target': null,
//           },
//           {
//             id: '111918',
//             'background-color': '#dc3545',
//             topic:
//               '<a target="_blank" href="https://fogbugz.forteresearch.com/f/cases/111918/">Case 111918 - Matomo - remove numeric identifiers from tracked URLs</a>',
//             href: 'https://fogbugz.forteresearch.com/f/cases/${ c.ixBug }/',
//             'data-target': null,
//           },
//         ],
//       },
//     ],
//   },
// }

// function renderMindmap(mindData) {
//   const width = 1000
//   const margin = { top: 40, right: 40, bottom: 40, left: 40 }
//   const dx = 40
//   const dy = width / 6
//   const tree = d3.tree().nodeSize([dx, dy])
//   const diagonal = d3
//     .linkHorizontal()
//     .x((d) => d.y)
//     .y((d) => d.x)

//   const createChart = (data) => {
//     const root = d3.hierarchy(data)

//     root.x0 = dy / 2
//     root.y0 = 0
//     root.descendants().forEach((d, i) => {
//       d.id = i
//       d._children = d.children
//       if (d.depth > 5) d.children = null
//     })

//     const svg = d3
//       .create('svg')
//       .attr('viewBox', [-margin.left, -margin.top, width - margin.left, dx])
//       .style('font', '10px sans-serif')
//       .style('user-select', 'none')

//     const gLink = svg
//       .append('g')
//       .attr('fill', 'none')
//       .attr('stroke', '#999')
//       .attr('stroke-opacity', 1.0)
//       .attr('stroke-width', 1.5)

//     const gNode = svg
//       .append('g')
//       .attr('cursor', 'pointer')
//       .attr('pointer-events', 'all')

//     function update(source) {
//       const duration = d3.event && d3.event.altKey ? 2500 : 250
//       const nodes = root.descendants().reverse()
//       const links = root.links()

//       // Compute the new tree layout.
//       tree(root)

//       let left = root
//       let right = root
//       root.eachBefore((node) => {
//         if (node.x < left.x) left = node
//         if (node.x > right.x) right = node
//       })

//       const height = right.x - left.x + margin.top + margin.bottom

//       const transition = svg
//         .transition()
//         .duration(duration)
//         .attr('viewBox', [-margin.left, left.x - margin.top, width, height])
//         .tween(
//           'resize',
//           window.ResizeObserver ? null : () => () => svg.dispatch('toggle')
//         )

//       // Update the nodes…
//       const node = gNode.selectAll('g').data(nodes, (d) => d.id)

//       // Enter any new nodes at the parent's previous position.
//       const nodeEnter = node
//         .enter()
//         .append('g')
//         .attr('transform', (d) => `translate(${source.y0},${source.x0})`)
//         .attr('fill-opacity', 0)
//         .attr('stroke-opacity', 0)
//         .on('click', (d) => {
//           d.children = d.children ? null : d._children
//           update(d)
//         })

//       const desat = (c) => d3.hsl(c.h, c.s, c.l + 0.0)

//       // The circle
//       nodeEnter
//         .append('circle')
//         .attr('r', dx / 3)
//         .attr('fill', (d) => desat(d3.hsl(d.data['background-color'])))
//         .attr('fill-opacity', 1)
//         .attr('stroke', (d) => d.data['background-color'])
//         .attr('data-target', (d) =>
//           d.data['data-target'] ? d.data['data-target'] : null
//         )
//         .attr('data-toggle', (d) => (d.data['data-target'] ? 'modal' : null))

//       // Icon for QA text
//       nodeEnter
//         .filter((d) => d.data['data-target'])
//         .append('text')
//         .attr('x', -6)
//         .attr('y', 6)
//         .attr('font-family', 'FontAwesome')
//         .attr('font-size', '16px')
//         .attr('data-target', (d) => d.data['data-target'])
//         .attr('data-toggle', 'modal')
//         .text('\uf0f6')

//       // Link and text of each node
//       const labels = nodeEnter
//         .append('a')
//         .attr('href', (d) => d.data.href)
//         .append('text')
//         .attr('dy', '0.31em')
//         .attr('y', (d) => (d._children ? '-2em' : 0))
//         .attr('text-anchor', (d) => (d._children ? 'middle' : 'start'))
//         .html((d) => d.data.topic)
//         .attr('x', (d) => (d._children ? 0 : dx / 3 + 4))

//       window.setTimeout(() => labels.call(wrapText, 300), 0)

//       // Transition nodes to their new position.
//       const nodeUpdate = node
//         .merge(nodeEnter)
//         .transition(transition)
//         .attr('transform', (d) => `translate(${d.y},${d.x})`)
//         .attr('fill-opacity', 1)
//         .attr('stroke-opacity', 1)

//       // Transition exiting nodes to the parent's new position.
//       const nodeExit = node
//         .exit()
//         .transition(transition)
//         .remove()
//         .attr('transform', (d) => `translate(${source.y},${source.x})`)
//         .attr('fill-opacity', 0)
//         .attr('stroke-opacity', 0)

//       // Update the links…
//       const link = gLink.selectAll('path').data(links, (d) => d.target.id)

//       // Enter any new links at the parent's previous position.
//       const linkEnter = link
//         .enter()
//         .append('path')
//         .attr('d', (d) => {
//           const o = { x: source.x0, y: source.y0 }
//           return diagonal({ source: o, target: o })
//         })

//       // Transition links to their new position.
//       link.merge(linkEnter).transition(transition).attr('d', diagonal)

//       // Transition exiting nodes to the parent's new position.
//       link
//         .exit()
//         .transition(transition)
//         .remove()
//         .attr('d', (d) => {
//           const o = { x: source.x, y: source.y }
//           return diagonal({ source: o, target: o })
//         })

//       // Stash the old positions for transition.
//       root.eachBefore((d) => {
//         d.x0 = d.x
//         d.y0 = d.y
//       })
//     }

//     update(root)

//     return svg.node()
//   }

//   const wrapText = function (text, width) {
//     text.each(function () {
//       var text = d3.select(this),
//         words = text.text().split(/\s+/).reverse(),
//         word,
//         line = [],
//         lineNumber = 0,
//         lineHeight = 1.1, // em
//         y = text.attr('y'),
//         dy = parseFloat(text.attr('dy')),
//         tspan = text
//           .text(null)
//           .append('tspan')
//           .attr('x', this.getAttribute('x'))
//           .attr('y', y)
//           .attr('dy', dy + 'em')
//       while ((word = words.pop())) {
//         line.push(word)
//         tspan.text(line.join(' '))
//         if (tspan.node().getComputedTextLength() > width) {
//           line.pop()
//           tspan.text(line.join(' '))
//           line = [word]
//           tspan = text
//             .append('tspan')
//             .attr('x', this.getAttribute('x'))
//             .attr('y', y)
//             .attr('dy', ++lineNumber * lineHeight + dy + 'em')
//             .text(word)
//         }
//       }
//     })
//   }

//   const dachart1 = createChart(mindData.data)
//   document.getElementById('the-mindmap').append(dachart1)
// }

const width = 1000
const height = 800
const svg = d3.select('svg')

const color = d3.scaleOrdinal(d3.schemeCategory10)

const simulation = d3
  .forceSimulation()
  .force(
    'link',
    d3.forceLink().id((d) => d.id)
  )
  .force('charge', d3.forceManyBody().strength(-400))
  .force('center', d3.forceCenter(width / 2, height / 2))

d3.json(`/get_institute_nodemap/${institute_slug}/`).then(function (graph) {
  const link = svg
    .append('g')
    .attr('class', 'links')
    .selectAll('line')
    .data(graph.links)
    .enter()
    .append('line')
    .attr('stroke', '#999')
    .attr('stroke-opacity', 0.6)
    .attr('stroke-width', (d) => Math.sqrt(d.value))

  const node = svg
    .append('g')
    .attr('class', 'nodes')
    .selectAll('g')
    .data(graph.nodes)
    .enter()
    .append('g')
    .call(
      d3
        .drag()
        .on('start', dragstarted)
        .on('drag', dragged)
        .on('end', dragended)
    )

  node
    .append('circle')
    .attr('r', (d) => d.size)
    .attr('fill', (d) => color(d.type))

  node
    .append('text')
    .attr('dx', 12)
    .attr('dy', '.35em')
    .text((d) => d.name)

  node.append('title').text((d) => d.name)

  simulation.nodes(graph.nodes).on('tick', ticked)

  simulation.force('link').links(graph.links)

  function ticked() {
    link
      .attr('x1', (d) => d.source.x)
      .attr('y1', (d) => d.source.y)
      .attr('x2', (d) => d.target.x)
      .attr('y2', (d) => d.target.y)

    node.attr('transform', (d) => `translate(${d.x},${d.y})`)
  }
})

function dragstarted(d) {
  if (!d3.event.active) simulation.alphaTarget(0.3).restart()
  d.fx = d.x
  d.fy = d.y
}

function dragged(d) {
  d.fx = d3.event.x
  d.fy = d3.event.y
}

function dragended(d) {
  if (!d3.event.active) simulation.alphaTarget(0)
  d.fx = null
  d.fy = null
}