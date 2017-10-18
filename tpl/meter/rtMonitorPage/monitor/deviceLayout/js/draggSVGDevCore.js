(function($){
	$.fn.extend({
		//初始化 绘制设备
		drawSvg: function(options) {
			var opts = $.extend({}, $.fn.drawSvg.defaults, options);
			$this = $(this);

			init();

			function init() {
				$this.empty();
				layout();
				var zoom = d3.behavior.zoom()
					.scaleExtent([opts.zoomMin, opts.zoomMax])
					.on('zoom', function(){
						d3.select("." + opts.layoutClass + '_svg').attr("transform", "translate(" + d3.event.translate + ") scale(" + d3.event.scale + ")");
					})
					.translate([opts.translateWidth, opts.translateHeight]);
				var tree = d3.layout.tree()
					.nodeSize([opts.nodeWidth, opts.nodeHeight])
					.separation(function(a, b){
						//return (a.parent == b.parent ? 1 : 2) / a.depth;
						return .5;
					})
					.children(function(node){
						return node.children;
					});
				var rootSvg = d3.select('#' + $this.eq(0).attr('id')).append('svg')
					.attr('width', opts.layoutWidth)
					.attr('height', opts.layoutHeight)
					.attr("preserveAspectRatio", "xMidYMid meet")
					.attr('class', opts.layoutClass + '_svg')
					//.call(zoom)
					.append('g')
					.attr('class', opts.layoutClass + '_g')
					.attr("transform", rootTrans());
				var nodes = tree.nodes(opts.treeData),
					links = tree.links(nodes);
				// Style links (edges)
				rootSvg.selectAll("path.link")
					.data(links)
					.enter()
					.append("path")
					.attr("class", "link")
					.attr("d", elbow);

				// Style nodes
				var node = rootSvg.selectAll("g." + opts.className)
					.data(nodes)
					.enter()
					.append("g")
					.attr("class", opts.className)
					.attr("id", function(d) {return opts.idPrefix + '_' + d.serialNumber;})
					//tip组件
					.attr('data-toggle', 'tooltip')
					.attr('data-placement', 'right')
					.attr('title', function(d) {return d.name;})
					.attr("transform", nodeTrans);

				$('.' + opts.className).tooltip({
					'container': 'body'
				});
				var nodeSvg = node
					.append("svg")
					.attr('xmlns', 'http://www.w3.org/2000/svg')
					.attr({
						x: -(opts.boxWidth/2),
						y: -(opts.boxHeight/2),
						width: opts.boxWidth,
						height: opts.boxHeight
					})
					.attr("class", opts.className + '_svg')
					.attr("id", function(d) {return opts.idPrefix + '_svg_' + d.serialNumber;});
				d3.xml(opts.templateUrl, "image/svg+xml", //加载文件
					function(xml) {
						drawNodes(nodeSvg, xml);
					}
				);
				virtualNode ();
			}
			//计算svg 宽 高
			function layout() {
				if (opts.horizontalFlag) {
					opts.layoutWidth = opts.maxLevel ? opts.translateWidth * opts.maxLevel : opts.layoutWidth;
					opts.layoutHeight = opts.maxDepth ? opts.translateHeight * opts.maxDepth : opts.layoutHeight;
					opts.translateWidth = opts.layoutWidth / 2;
				} else {
					opts.layoutHeight = opts.maxLevel ? opts.translateWidth * opts.maxLevel : opts.layoutWidth;
					opts.layoutWidth = opts.maxDepth ? opts.translateHeight * opts.maxDepth : opts.layoutHeight;
					opts.translateHeight = opts.layoutHeight / 2;
				}
			}
			//计算父节点偏移量
			function rootTrans() {
				if (opts.horizontalFlag) {
					return "translate(" + opts.translateWidth + "," + opts.translateHeight/2 + ")";
				} else {
					return "translate(" + opts.translateWidth/2 + "," + opts.translateHeight + ")";
				}
			}
			//计算节点偏移量
			function nodeTrans(d) {
				if (opts.horizontalFlag) {
					return "translate(" + d.x + "," + d.y + ")";
				} else {
					return "translate(" + d.y + "," + d.x + ")";
				}
			}
			//计算连接线
			function elbow(d) {
				if (opts.horizontalFlag) {
					return "M" + d.source.x + "," + d.source.y
						+ "V" + (d.source.y + (d.target.y-d.source.y)/2)
						+ "H" + d.target.x
						+ "V" + d.target.y;
				} else {
					return "M" + d.source.y + "," + d.source.x
						+ "H" + (d.source.y + (d.target.y-d.source.y)/2)
						+ "V" + d.target.x
						+ "H" + d.target.y;
				}
			}
			//绘制自定义节点
			function drawNodes(nodes, xml) {
				$(xml).find('rect').each(function(index, ele){
					var rect = nodes.append('rect');
					$.each($(ele).get(0).attributes, function(i, ab) {
						rect.attr(ab.name, ab.value);
					});
				});
				$(xml).find('line').each(function(index, ele){
					var line = nodes.append('line');
					$.each($(ele).get(0).attributes, function(i, ab) {
						line.attr(ab.name, ab.value);
					});
				})
			}

			function virtualNode () {
				if(opts.virtualFlag) {
					d3.select('#' + opts.idPrefix + '_' + '-1').classed({
						show: false,
						hide: true
					});
				}
			}
		},
		//绘制设备状态
		drawSvgStatus: function(options) {
			var opts = $.extend({}, $.fn.drawSvgStatus.defaults, options);

			init();

			function init() {
				$.each(opts.statusData, function (i, v) {
					d3.select('#' + opts.idPrefix + '_' + v.deviceId)
						.classed(opts.statusClass[v.status]);
				});
			}
		},
		//绘制选择设备状态
		selectDrawSvgStatus: function(options) {
			var opts = $.extend({}, $.fn.selectDrawSvgStatus.defaults, options);

			init();

			function init() {

				$.each(opts.statusData, function(i, v){
					if(opts.status.contains(v.status)) {
						d3.select('#' + opts.idPrefix + '_' + v.deviceId).classed({
							show: true,
							hide: false
						});
					} else {
						d3.select('#' + opts.idPrefix + '_' + v.deviceId).classed({
							show: false,
							hide: true
						});
					}
				});
			}
		}
	});

	var commonOpts = {
		className: 'd3_tree_node',
		idPrefix: 'd3_tree_node'
	}

	// 插件的defaults
	$.fn.drawSvg.defaults = {
		horizontalFlag: true,//横向 竖向
		className: commonOpts.className,
		idPrefix: commonOpts.idPrefix,
		layoutWidth: 1000,
		layoutHeight: 600,
		layoutClass: 'd3_tree_layout',
		boxWidth: 40,
		boxHeight: 40,
		nodeWidth: 84,
		nodeHeight: 84,
		zoomMin: 0.5,
		zoomMax: 2,
		translateWidth: 84,
		translateHeight: 84
	};
	$.fn.drawSvgStatus.defaults = {
		statusClass : [
			{
				'normal': true,
				'fault': false,
				'alarm': false,
				'break': false
			},{
				'normal': false,
				'fault': true,
				'alarm': false,
				'break': false
			},{
				'normal': false,
				'fault': false,
				'alarm': true,
				'break': false
			},{
				'normal': false,
				'fault': false,
				'alarm': false,
				'break': true
			},
		],
		className: commonOpts.className,
		idPrefix: commonOpts.idPrefix,
	};
	$.fn.selectDrawSvgStatus.defaults = {
		status: [0, 1, 2, 3],
		className: commonOpts.className,
		idPrefix: commonOpts.idPrefix,
	};

})(jQuery)