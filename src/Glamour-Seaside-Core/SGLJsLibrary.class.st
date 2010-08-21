Class {
	#name : #SGLJsLibrary,
	#superclass : #WAFileLibrary,
	#category : #'Glamour-Seaside-Core'
}

{ #category : #uploaded }
SGLJsLibrary >> glamourSeasideJs [
	^ '	
	jQuery.glamour = {};	
	
	; ( function($) {
		
		$.glamourTree = {
		
			compare : function(array1, array2) {
 	 			if(!array1 && !array2) return true;
				if(!array1 || !array2) return false;
				
				if (array1.length == array2.length) {
					for(var i = 0; i < array1.length;i++) {
						if(array1[i] != array2[i]) return false;
  					}
					return true;
				} else 
					return false
			} ,
			
			selectNodes: function(presentationId, nodesIds, resetReferenceNode) {
				var rootList = $("#"+presentationId+" > .glm-tree-root-ct")[0];
				var selectedNodes = [];
				var referenceNode;
				
				$.each(nodesIds, function(index, nodeId) {
					var $node = $("#"+nodeId);
				
					if ( $node.size() != 0 ) {
						selectedNodes.push($node);
					}
				});
				
				if ( resetReferenceNode ) {
					referenceNode = $.data(rootList, "referenceNode");
					if ( !referenceNode ) {
						if (selectedNodes.length != 0)  $.data(rootList, "referenceNode", selectedNodes[0]);
					}
				}
				
				performeSelection(rootList, selectedNodes);
			}
		};
	
		$.fn.glamourTree = function(action, options) {
			var opts;
			
			return this.each( function() {
				var childrenCount = 0;
				var rootList = $(this).closest(".glm-tree-root-ct")[0];

				switch (action) {
					case "initialize": {
						opts = initializeOperation(this, rootList, options);
						break;
					}
					
					case "update": {
						opts = updateOperation(this, rootList, options);
						break;
					}
					
					default: {
						return ;
					}
				}
				
				$(this).children(opts.childrenSelector).each( function() {
					var $node = $(this);
					var $content = $node.find(":first");
					
					childrenCount++;
					addPadding($content, opts.level);
					addIcon($content, $node);
					
					// Submit a request when the user selects a node.
					$content.bind("click", function(e) {
						var $referenceNode = $.data(rootList, "referenceNode");
					
						if ( e.shiftKey && opts.isMultiple ) {
							if ($referenceNode) {
								selectNodes(rootList, $referenceNode, $node, opts);
							} else {
								selectNode($node, rootList, opts);
							}
						} else {
							selectNode($node, rootList, opts);
						}
						
						return false;
					});
					
					// Submit a request when the uses expands/collapses a node.
					$content.children(".glm-tree-icon").bind("click", function() {						
						opts.onExpandToggled($node);
						toggleClass($node);
						return false;
					});
				});
				
				$.data(this, "childrenCount",  $.data(this, "childrenCount") + childrenCount );
			});
		};
		
		$.fn.glamourTree.defaults = {
			"level" :0 ,
			"childrenSelector" : ".glm-tree-node",
			"isMultiple" : false,
			"selectedNodes:" : [] 
		};
		
		function selectNodes(rootList, $referenceNode, $node, opts) {
			var $allNodeChildren = $("#"+$(rootList).attr("id")+" .glm-tree-node");
			var selectedNodes;
			var index, ids = "";
								
			"Obtain a list with all the selected nodes and send it to the server"
			if ( $allNodeChildren.index($referenceNode) < $allNodeChildren.index($node) ) {
				selectedNodes = obtainNodes($referenceNode, $node);
			} else {
				selectedNodes = obtainNodes($node, $referenceNode);									
			}
			
			for (index = 0; index < selectedNodes.length - 1; index++) {
				ids += selectedNodes[index].attr("id") + ",";
			}
			ids += selectedNodes[index].attr("id");
			
			opts.onSelect(ids);
		}
		
		function obtainNodes($fromNode, $toNode) {
			var selectedNodes = [$fromNode];
			var $childrenList, $nextSibling, $parent;
			
			while ($fromNode.attr("id") != $toNode.attr("id")) {
				
				$childrenList = $fromNode.children(".glm-tree-node-ct:visible");
				if ( $childrenList.size() > 0 ) {
					$fromNode = $childrenList.children(":eq(0)");
					selectedNodes.push($fromNode);
					continue;
				}
				
				$nextSibling = $fromNode.next();
				if ( $nextSibling.size() > 0 ) {
					$fromNode = $nextSibling;
					selectedNodes.push($fromNode);
					continue;
				} else {
					$parent = $fromNode.parent().parent();
					while ( $parent.next().size() == 0 ) {
						$parent = $parent.parent().parent();
					}
					$fromNode = $parent.next();
					selectedNodes.push($fromNode);
				}
			}
			
			return selectedNodes;
		};
		
		function selectNode($node, rootList, opts) {
			$.data(rootList, "referenceNode", $node);
			opts.onSelect($node.attr("id"));	
		};
		
		function performeSelection(rootList, nodes) {
			var savedSelectedNodes = $.data(rootList, "selectedNodes");
			
			$.each(savedSelectedNodes, function(index, $node) {
				$node.removeClass("glm-tree-node-selected");
			});
			$.each(nodes, function(index, $node) {
				$node.addClass("glm-tree-node-selected");
			});
			
			if ( nodes.length == 0 ) {
				$.data(rootList, "referenceNode", null);
			}
			$.data(rootList, "selectedNodes", nodes);
		};
		
		function initializeOperation(list, rootList, options) {
			var savedOpts = $.data(rootList, "options");
			var opts =  $.extend({}, $.fn.glamourTree.defaults, savedOpts, options);
				
			if ( savedOpts == null ) {
				$.data(rootList, "selectedNodes", []);	
				$.glamourTree.selectNodes(rootList.parentNode.id, opts.selectedNodes, true);
				opts.selectedNodes = [];
				$.data(rootList, "options", opts);
			 }
			$.data(list, "childrenCount", 0);
			return opts;
		};
		
		function updateOperation(list, rootList, options) {
			var savedOpts = $.data(rootList, "options");
			var opts = $.extend({},  savedOpts, options);

			opts.childrenSelector = ".glm-tree-node:gt(" + ( $.data(list, "childrenCount") - 1) + ")";
			return opts;
		};
		
		function addPadding($nodeContent, level) {
			var padding = "";
			
			for (var index = 0; index < level; index++) {
				padding += "<ins class=\"glm-tree-icon-padding\">&nbsp</ins>";
			}
			$nodeContent.find(":first").before("<span>"+padding+"</span>");
		};
		
		function addIcon($nodeContent, $node) {
			if ( $node.hasClass("glm-tree-leaf") == false ) {
				$nodeContent.children(":eq(1)").before("<ins class=\"glm-tree-icon\">&nbsp;</ins>");
			}
		};
		
		function toggleClass($node) {
			if ( $node.hasClass("glm-tree-open") ) {
				$node.removeClass("glm-tree-open");
				$node.addClass("glm-tree-closed");
				$node.children(".glm-tree-node-ct").hide();
			} else if ( $node.hasClass("glm-tree-closed")  ) {
				$node.removeClass("glm-tree-closed");
				$node.addClass("glm-tree-open");
				$node.children(".glm-tree-node-ct").show();
			}
		};
		
	} ) (jQuery);
		
	/**
	 * Glamour Actions:  plugin that adds  adds actions to the glamour presentations.
	 *
	 * Two possible opperations:
	 *
	 * "initialize" : 
	 *		$(selector).glamourActions("initialize", options);
	 *		optionsDefault = { hasActions: false }
	 *
	 * "add" : adds the actions options.actionsContent to the tab with the given index;
	 * if no index is given the actions are aded to the last tab;
	 * if the given tab already has actions assigned they are left unchanged. 
	 *		$(selector).glamourActions("add", index, options)
	 *		optionsDefault = { actionsContent: undefined }
	 *
	 */
	; ( function($) {

		$.fn.glamourActions = function() {
			var args = arguments;
			var opts;
			
			return this.each( function() {
				
				switch ( args[0] ) {
					case "initialize" : {
						this.hasGlamourActions = false;
						if ( args[1] && args[1].hasActions ) {
							initialize(this);
							this.hasGlamourActions = true;
						}
						break;
					}
					case "add" : {
						if ( this.hasGlamourActions ) {
							add(this, args[1], args[2]);
						}
						break;
					}
				}
				
			});
		}
		
		function initialize(tabs) {
			var $tabs = $(tabs);
			var $navigation = $tabs.children(".ui-tabs-nav");
			var $actions = $navigation.children(".glm-actions");
			
			
			$actions.css("float", "right");
			$tabs.children(".ui-tabs-nav").children(":not(.glm-actions)").each(function(index, tab){
				tab.glamourAction = $actions[index]; 
			});
			showActionsForSelectedTab(tabs, $(tabs).tabs( "option", "selected"));
			
			$tabs.bind("tabsshow", function(event, ui) {
				showActionsForSelectedTab(tabs, $.glamourTabs.indexOfTab($navigation.children(".ui-tabs-selected")[0], $(tabs) ) );
			});
			
			$tabs.bind("tabsdeleted", function(event, ui) {
				$(ui.tab.glamourAction).remove();
				delete ui.tab.glamourAction;
			})
		}
		
		function add(tabs, tabIndex, options) {
			var $navigation = $(tabs).children(".ui-tabs-nav");
			var index = typeof tabIndex !== "integer" ? $(tabs).tabs( "length" ) - 1 :  tabIndex;
			var $tab = $navigation.children(".ui-state-default:eq("+index+")");
			var $action;
			
			
			$navigation.append(options.actionsContent);
			$action = $navigation.children(":last");
			$action.css("float", "right");
			$tab[0].glamourAction = $action[0];
		}
		
		function showActionsForSelectedTab(tabs, index) {
			var $navigation = $(tabs).children(".ui-tabs-nav");
			var $selectedTab;
			
			$navigation.children(".glm-action-selected").hide().removeClass("glm-action-selected");
			if ( index > -1 ) {
				$selectedTab = $navigation.children(".ui-state-default:eq("+index+")");			
				$action = $( $selectedTab[0].glamourAction );
				$action.addClass("glm-action-selected");
				$action.show();
			}
		}
		
	})(jQuery);
	
	; ( function($) {		

		$.glamourTabs = {
			indexOfTab : function (tab, $tabs) {
				var $allItems = $tabs.children(".ui-tabs-nav").children(".ui-state-default");
			
				for (var index = 0; index < $allItems.length; index++ ) {
					if ($allItems[index] === tab)
						return index;
				}
			
				return -1;
			}
		}

		$.fn.glamourTabs = function() {
			var options = {}; 
			var args = arguments;
			var result;
			
			if ( args && args[0] === "add" ) {
				if ( typeof args[3] === "object") {
					options = args[3];
					delete args[3];
				} else if ( typeof args[4] === "object") {
					options = args[4];
					delete args[4];
				}
			}
			
			result = this.tabs.apply(this, args);
			
			this.each( function() {
				var $tabs = $(this);
				
				if ( !args ) {
					initialize(this, $.fn.glamourTabs.defaults);
				} else if ( typeof args[0] === "object"  ) {
					initialize(this, $.extend({}, $.fn.glamourTabs.defaults, args[0]) );
				} else if ( typeof args[0] === "string" ) {
					if (args[0] === "add") {
						add(this, args[3], options);
					}
				}
			});
			
			return result;
		}

		function initialize(tabs, options) {
			var navigation = $(tabs).children(".ui-tabs-nav:first");
			
			$(tabs).glamourActions("initialize", options);
			
			if ( options.closable ) {
				$(tabs).children(".ui-tabs-nav").children(".ui-state-default").each(function(index, tab) {			
					addCloseButton(tab, tabs);
				});
			}
			
			$(tabs).bind("tabsremovedlast", function(event) {
				if ( options.ifEmptyDo === "replace" ) {
					$(tabs).replaceWith(options.replaceWith);
				} else if ( options.ifEmptyDo === "remove" ) {
					$(tabs).remove();
				}
			});
			
			
			$(tabs).bind("tabsdeleted", function(event, ui) {
				if ( options.glmDelete ) {
					options.glmDelete(event, ui);
				}
				if ( $(ui.tab).hasClass("ui-tab-first") ) {
					navigation.children(".ui-state-default:first").addClass("ui-tab-first");
				} else if ( $(ui.tab).hasClass("ui-tab-last") ) {
					navigation.children(".ui-state-default:last").addClass("ui-tab-last");
				}	
			});
			
			
			//Set the width of the tab.
			navigation.css("min-width", navigation.glamourWidth()+$.glamourWidth.outerWidth(navigation)+1);
			
			setNavigationStyles(navigation)
		}
		
		function add(tabs, index, options) {
			var $tab;
			
			$(tabs).glamourActions("add", index, options);
			$tab = $(tabs).children(".ui-tabs-nav").children(".ui-state-default:eq("+ ( typeof index === "integer"? index : $(tabs).tabs("length") - 1 )+")");
			addCloseButton($tab[0], tabs);
			updateNavigationStyles($tab, tabs);
		}
		
		function addCloseButton(tab, tabs) {
			var $tab = $(tab);
			
			$tab.append("<span class=\"glm-tabs-close-button\"></span>");
			$tab.children(".glm-tabs-close-button").bind("click", function() {
				var index = $.glamourTabs.indexOfTab(tab, $(tabs) ); 
				
				$(tabs).tabs("remove",  index);
				// Trigger a custom event as in version JQuery-UI 1.8.2 the index of the deleted element is not correctly passed.
				$(tabs).triggerHandler("tabsdeleted", {"tab": tab, "index": index, "panel": tab});
				
				if ( $(tabs).tabs("length") == 0 ) {
					$(tabs).triggerHandler("tabsremovedlast");
				}
			});
		}
		
		function  setNavigationStyles($navigation) {
			$navigation.children().removeClass("ui-corner-top");
			$navigation.children(".ui-state-default:first").addClass("ui-tab-first");
			$navigation.children(".ui-state-default:last").addClass("ui-tab-last");
		}
		
		function updateNavigationStyles($newTab, tabs) {
			$newTab.removeClass("ui-corner-top");
			$newTab.prevUntil().removeClass("ui-tab-last");
			$newTab.addClass("ui-tab-last");
			if ( $(tabs).tabs("length") == 1 ) {
				$newTab.addClass("ui-tab-first");
			}
		}
		
		$.fn.glamourTabs.defaults = {
			"ifEmptyDo:" : "nothing",
			"replaceWith" : "<div class=\"ui-widget ui-widget-content ui-corner-all empty-presentation\"></div>" ,
			"hasActions" : true ,
			"closable" : false
		}
	
	})(jQuery);
		
	
	;(function($) {
	
		$.glamourWidth = {
			outerWidth : function(node) {
				var width = 0;
				
				width += parseInt(node.css("padding-left"), 10) + parseInt(node.css("padding-right"), 10); 
				width += parseInt(node.css("margin-left"), 10) + parseInt(node.css("margin-right"), 10); 
				width += parseInt(node.css("borderLeftWidth"), 10) + parseInt(node.css("borderRightWidth"), 10); 
				
				return width;
			}
		}
	
		$.fn.glamourWidth = function (childrenSelector) {
			var totalWidth = 0;
			var width = 0;
			
			childrenSelector = childrenSelector || ":visible";
			this.children(childrenSelector).each(function(){
				var width;

				if ( $(this).children().size() == 0 ) {
					width = $(this).outerWidth();
				} else {
					width =  $(this).glamourWidth();
					width = ( width > $(this).width() ? width : $(this).width());
					width +=$.glamourWidth.outerWidth($(this));
				}
				totalWidth +=width;
			});
			
			return totalWidth;
		}
	})(jQuery);
		
	(function($){
		$.fn.glamourText = function() {
			var args = arguments;
			
			return this.each( function() {
				if ( typeof args[0] === "object" ) {
					createWidget(this, args[0]);
				} else {
					$(this).val(args[1]);
				}
				
			})
		}
		
		function createWidget(text, opts) {

			if (typeof opts.change === "function" ) {
				$(text).typeWatch({ 
					highlight: false, 
					captureLength: -1, 
					callback: function() { opts.change(arguments[0])}
				} );
			}
		}
		
	})(jQuery)
		
	var Glamour = {};
	
	Glamour.resize = function() {
		$("body > .sgl-table, body > .finder-container").each(function() {
			$(this).height($(window).height() - 20);
		});
	};

	$(Glamour.resize);
	$(window).resize(Glamour.resize);'
]

{ #category : #uploaded }
SGLJsLibrary >> scrollToJs [
	^ '/**
 * jQuery.ScrollTo
 * Copyright (c) 2007-2009 Ariel Flesler - aflesler(at)gmail(dot)com | http://flesler.blogspot.com
 * Dual licensed under MIT and GPL.
 * Date: 5/25/2009
 *
 * @projectDescription Easy element scrolling using jQuery.
 * http://flesler.blogspot.com/2007/10/jqueryscrollto.html
 * Works with jQuery +1.2.6. Tested on FF 2/3, IE 6/7/8, Opera 9.5/6, Safari 3, Chrome 1 on WinXP.
 *
 * @author Ariel Flesler
 * @version 1.4.2
 *
 * @id jQuery.scrollTo
 * @id jQuery.fn.scrollTo
 * @param {String, Number, DOMElement, jQuery, Object} target Where to scroll the matched elements.
 *	  The different options for target are:
 *		- A number position (will be applied to all axes).
 *		- A string position (''44'', ''100px'', ''+=90'', etc ) will be applied to all axes
 *		- A jQuery/DOM element ( logically, child of the element to scroll )
 *		- A string selector, that will be relative to the element to scroll ( ''li:eq(2)'', etc )
 *		- A hash { top:x, left:y }, x and y can be any kind of number/string like above.
*		- A percentage of the container''s dimension/s, for example: 50% to go to the middle.
 *		- The string ''max'' for go-to-end. 
 * @param {Number} duration The OVERALL length of the animation, this argument can be the settings object instead.
 * @param {Object,Function} settings Optional set of settings or the onAfter callback.
 *	 @option {String} axis Which axis must be scrolled, use ''x'', ''y'', ''xy'' or ''yx''.
 *	 @option {Number} duration The OVERALL length of the animation.
 *	 @option {String} easing The easing method for the animation.
 *	 @option {Boolean} margin If true, the margin of the target element will be deducted from the final position.
 *	 @option {Object, Number} offset Add/deduct from the end position. One number for both axes or { top:x, left:y }.
 *	 @option {Object, Number} over Add/deduct the height/width multiplied by ''over'', can be { top:x, left:y } when using both axes.
 *	 @option {Boolean} queue If true, and both axis are given, the 2nd axis will only be animated after the first one ends.
 *	 @option {Function} onAfter Function to be called after the scrolling ends. 
 *	 @option {Function} onAfterFirst If queuing is activated, this function will be called after the first scrolling ends.
 * @return {jQuery} Returns the same jQuery object, for chaining.
 *
 * @desc Scroll to a fixed position
 * @example $(''div'').scrollTo( 340 );
 *
 * @desc Scroll relatively to the actual position
 * @example $(''div'').scrollTo( ''+=340px'', { axis:''y'' } );
 *
 * @dec Scroll using a selector (relative to the scrolled element)
 * @example $(''div'').scrollTo( ''p.paragraph:eq(2)'', 500, { easing:''swing'', queue:true, axis:''xy'' } );
 *
 * @ Scroll to a DOM element (same for jQuery object)
 * @example var second_child = document.getElementById(''container'').firstChild.nextSibling;
 *			$(''#container'').scrollTo( second_child, { duration:500, axis:''x'', onAfter:function(){
 *				alert(''scrolled!!'');																   
 *			}});
 *
 * @desc Scroll on both axes, to different values
 * @example $(''div'').scrollTo( { top: 300, left:''+=200'' }, { axis:''xy'', offset:-20 } );
 */
;(function( $ ){
	
	var $scrollTo = $.scrollTo = function( target, duration, settings ){
		$(window).scrollTo( target, duration, settings );
	};

	$scrollTo.defaults = {
		axis:''xy'',
		duration: parseFloat($.fn.jquery) >= 1.3 ? 0 : 1
	};

	// Returns the element that needs to be animated to scroll the window.
	// Kept for backwards compatibility (specially for localScroll & serialScroll)
	$scrollTo.window = function( scope ){
		return $(window)._scrollable();
	};

	// Hack, hack, hack :)
	// Returns the real elements to scroll (supports window/iframes, documents and regular nodes)
	$.fn._scrollable = function(){
		return this.map(function(){
			var elem = this,
				isWin = !elem.nodeName || $.inArray( elem.nodeName.toLowerCase(), [''iframe'',''#document'',''html'',''body''] ) != -1;

				if( !isWin )
					return elem;

			var doc = (elem.contentWindow || elem).document || elem.ownerDocument || elem;
			
			return $.browser.safari || doc.compatMode == ''BackCompat'' ?
				doc.body : 
				doc.documentElement;
		});
	};

	$.fn.scrollTo = function( target, duration, settings ){
		if( typeof duration == ''object'' ){
			settings = duration;
			duration = 0;
		}
		if( typeof settings == ''function'' )
			settings = { onAfter:settings };
			
		if( target == ''max'' )
			target = 9e9;
			
		settings = $.extend( {}, $scrollTo.defaults, settings );
		// Speed is still recognized for backwards compatibility
		duration = duration || settings.speed || settings.duration;
		// Make sure the settings are given right
		settings.queue = settings.queue && settings.axis.length > 1;
		
		if( settings.queue )
			// Let''s keep the overall duration
			duration /= 2;
		settings.offset = both( settings.offset );
		settings.over = both( settings.over );

		return this._scrollable().each(function(){
			var elem = this,
				$elem = $(elem),
				targ = target, toff, attr = {},
				win = $elem.is(''html,body'');

			switch( typeof targ ){
				// A number will pass the regex
				case ''number'':
				case ''string'':
					if( /^([+-]=)?\d+(\.\d+)?(px|%)?$/.test(targ) ){
						targ = both( targ );
						// We are done
						break;
					}
					// Relative selector, no break!
					targ = $(targ,this);
				case ''object'':
					// DOMElement / jQuery
					if( targ.is || targ.style )
						// Get the real position of the target 
						toff = (targ = $(targ)).offset();
			}
			$.each( settings.axis.split(''''), function( i, axis ){
				var Pos	= axis == ''x'' ? ''Left'' : ''Top'',
					pos = Pos.toLowerCase(),
					key = ''scroll'' + Pos,
					old = elem[key],
					max = $scrollTo.max(elem, axis);

				if( toff ){// jQuery / DOMElement
					attr[key] = toff[pos] + ( win ? 0 : old - $elem.offset()[pos] );

					// If it''s a dom element, reduce the margin
					if( settings.margin ){
						attr[key] -= parseInt(targ.css(''margin''+Pos)) || 0;
						attr[key] -= parseInt(targ.css(''border''+Pos+''Width'')) || 0;
					}
					
					attr[key] += settings.offset[pos] || 0;
					
					if( settings.over[pos] )
						// Scroll to a fraction of its width/height
						attr[key] += targ[axis==''x''?''width'':''height'']() * settings.over[pos];
				}else{ 
					var val = targ[pos];
					// Handle percentage values
					attr[key] = val.slice && val.slice(-1) == ''%'' ? 
						parseFloat(val) / 100 * max
						: val;
				}

				// Number or ''number''
				if( /^\d+$/.test(attr[key]) )
					// Check the limits
					attr[key] = attr[key] <= 0 ? 0 : Math.min( attr[key], max );

				// Queueing axes
				if( !i && settings.queue ){
					// Don''t waste time animating, if there''s no need.
					if( old != attr[key] )
						// Intermediate animation
						animate( settings.onAfterFirst );
					// Don''t animate this axis again in the next iteration.
					delete attr[key];
				}
			});

			animate( settings.onAfter );			

			function animate( callback ){
				$elem.animate( attr, duration, settings.easing, callback && function(){
					callback.call(this, target, settings);
				});
			};

		}).end();
	};
	
	// Max scrolling position, works on quirks mode
	// It only fails (not too badly) on IE, quirks mode.
	$scrollTo.max = function( elem, axis ){
		var Dim = axis == ''x'' ? ''Width'' : ''Height'',
			scroll = ''scroll''+Dim;
		
		if( !$(elem).is(''html,body'') )
			return elem[scroll] - $(elem)[Dim.toLowerCase()]();
		
		var size = ''client'' + Dim,
			html = elem.ownerDocument.documentElement,
			body = elem.ownerDocument.body;

		return Math.max( html[scroll], body[scroll] ) 
			 - Math.min( html[size]  , body[size]   );
			
	};

	function both( val ){
		return typeof val == ''object'' ? val : { top:val, left:val };
	};

})( jQuery );'
]

{ #category : #uploaded }
SGLJsLibrary >> typeWatchJs [
	^ '/*
 *	TypeWatch 2.0 - Original by Denny Ferrassoli / Refactored by Charles Christolini
 *
 *	Examples/Docs: www.dennydotnet.com
 *	
 *  Copyright(c) 2007 Denny Ferrassoli - DennyDotNet.com
 *  Coprright(c) 2008 Charles Christolini - BinaryPie.com
 *  
 *  Dual licensed under the MIT and GPL licenses:
 *  http://www.opensource.org/licenses/mit-license.php
 *  http://www.gnu.org/licenses/gpl.html
*/

(function(jQuery) {
	jQuery.fn.typeWatch = function(o){
		// Options
		var options = jQuery.extend({
			wait : 750,
			callback : function() { },
			highlight : true,
			captureLength : 2
		}, o);
			
		function checkElement(timer, override) {
			var elTxt = jQuery(timer.el).val();
		
			// Fire if text > options.captureLength AND text != saved txt OR if override AND text > options.captureLength
			if ((elTxt.length > options.captureLength && elTxt.toUpperCase() != timer.text) 
			|| (override && elTxt.length > options.captureLength)) {
				timer.text = elTxt.toUpperCase();
				timer.cb(elTxt);
			}
		};
		
		function watchElement(elem) {			
			// Must be text or textarea
			if (elem.type.toUpperCase() == "TEXT" || elem.nodeName.toUpperCase() == "TEXTAREA") {

				// Allocate timer element
				var timer = {
					timer : null, 
					text : jQuery(elem).val().toUpperCase(),
					cb : options.callback, 
					el : elem, 
					wait : options.wait
				};

				// Set focus action (highlight)
				if (options.highlight) {
					jQuery(elem).focus(
						function() {
							this.select();
						});
				}

				// Key watcher / clear and reset the timer
				var startWatch = function(evt) {
					var timerWait = timer.wait;
					var overrideBool = false;
					
					if (evt.keyCode == 13 && this.type.toUpperCase() == "TEXT") {
						timerWait = 1;
						overrideBool = true;
					}
					
					var timerCallbackFx = function()
					{
						checkElement(timer, overrideBool)
					}
					
					// Clear timer					
					clearTimeout(timer.timer);
					timer.timer = setTimeout(timerCallbackFx, timerWait);				
										
				};
				
				jQuery(elem).keydown(startWatch);
			}
		};
		
		// Watch Each Element
		return this.each(function(index){
			watchElement(this);
		});
		
	};

})(jQuery);'
]
