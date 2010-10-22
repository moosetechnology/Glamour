Class {
	#name : #SGLJsLibrary,
	#superclass : #WAFileLibrary,
	#category : #'Glamour-Seaside-Core'
}

{ #category : #uploaded }
SGLJsLibrary >> caretJs [
	^ '/*
 *
 * Copyright (c) 2010 C. F., Wong (<a href="http://cloudgen.w0ng.hk">Cloudgen Examplet Store</a>)
 * Licensed under the MIT License:
 * http://www.opensource.org/licenses/mit-license.php
 *
 */
ï»¿(function($,len,createRange,duplicate){
	$.fn.caret=function(options,opt2){
		var start,end,t=this[0],browser=$.browser.msie;
		if(typeof options==="object" && typeof options.start==="number" && typeof options.end==="number") {
			start=options.start;
			end=options.end;
		} else if(typeof options==="number" && typeof opt2==="number"){
			start=options;
			end=opt2;
		} else if(typeof options==="string"){
			if((start=t.value.indexOf(options))>-1) end=start+options[len];
			else start=null;
		} else if(Object.prototype.toString.call(options)==="[object RegExp]"){
			var re=options.exec(t.value);
			if(re != null) {
				start=re.index;
				end=start+re[0][len];
			}
		}
		if(typeof start!="undefined"){
			if(browser){
				var selRange = this[0].createTextRange();
				selRange.collapse(true);
				selRange.moveStart(''character'', start);
				selRange.moveEnd(''character'', end-start);
				selRange.select();
			} else {
				this[0].selectionStart=start;
				this[0].selectionEnd=end;
			}
			this[0].focus();
			return this
		} else {
			// Modification as suggested by ÐÐ½Ð´ÑÐµÐ¹ Ð®ÑÐºÐ¸Ð½
           if(browser){
				var selection=document.selection;
                if (this[0].tagName.toLowerCase() != "textarea") {
                    var val = this.val(),
                    range = selection[createRange]()[duplicate]();
                    range.moveEnd("character", val[len]);
                    var s = (range.text == "" ? val[len]:val.lastIndexOf(range.text));
                    range = selection[createRange]()[duplicate]();
                    range.moveStart("character", -val[len]);
                    var e = range.text[len];
                } else {
                    var range = selection[createRange](),
                    stored_range = range[duplicate]();
                    stored_range.moveToElementText(this[0]);
                    stored_range.setEndPoint(''EndToEnd'', range);
                    var s = stored_range.text[len] - range.text[len],
                    e = s + range.text[len]
                }
			// End of Modification
            } else {
				var s=t.selectionStart,
					e=t.selectionEnd;
			}
			var te=t.value.substring(s,e);
			return {start:s,end:e,text:te,replace:function(st){
				return t.value.substring(0,s)+st+t.value.substring(e,t.value[len])
			}}
		}
	}
})(jQuery,"length","createRange","duplicate");'
]

{ #category : #uploaded }
SGLJsLibrary >> glamourSeasideJs [
	^ '	
	jQuery.glamour = {};	
		
	/**
	 * Glamour Actions:  plugin that adds actions to the glamour presentations.
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
			navigation.css("min-width", navigation.glamourWidth()+$.glamourWidth.outerWidth(navigation)+2);
			
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
		
	;(function($){
		jQuery.widget("ui.glamourText", {
			options: {
				triggerSelectCallback: true,
				triggerChangeCallback: false
			}, 
			
			_init: function() {
				var self = this;

				this.element.typeWatch({ 
					highlight: false, 
					captureLength: -1, 
					callback: function() { self._triggerChange.call(self, arguments[0])}
				} );
				
				this.element.select(function(){
					self._triggerSelect.call(self, "selection");
				});
			},
			
			_triggerSelect: function(port, start, end, selection) {
				var caret;

				caret = this.element.caret();
				this._trigger( "select", 0, this._normalizeEventData({
					"port": port,
					selection: (selection == "" || selection) ? selection : caret.text,
					end: (end == 0 || end) ? end : caret.end,
					start: ( (start == 0 || start) ? start : caret.start ) + 1
				}) );
			},
			
			_triggerChange: function(newText) {
				this._trigger( "change", 0, this._normalizeEventData({text: newText, port: "text"}) );
			},
			
			_normalizeEventData: function(eventData) {
				return $.extend(
					{},
					{text: "", start: 0, end: 0, selection: ""},
					eventData);
			},
			
			_getData: function(type) {
				switch (type) {
					case "change" : {
						return this.option.change;
					}
					case "select": {
						return this.option.select;
					}
				}
			},
			
			changeText: function(newText, shouldTriggerChange) {
				this.element.val(newText);
				if ( shouldTriggerChange ) {
					this._triggerChange.call(this, newText);
				}
			},
			
			changeSelectionInterval: function(start, end) {
				(start <= end ? this.element.caret({"start": start - 1, "end": end}) : this.element.caret({"start": end - 1, "end": start}) )
				if ( this.options.triggerSelectCallback ) {
					this._triggerSelect.call(this, "selectionInterval", start - 1, end);
				}
			},
			
			changeSelectedText: function(selection) {
				this.element.caret(selection);
				if ( this.options.triggerSelectCallback ) {
					this._triggerSelect.call(this, "selectedText", null, null, selection);
				}
			}
			
		});
	})(jQuery);
		
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
SGLJsLibrary >> sglTreeJs [
	^ '
	;( function($) {
		$.widget("ui.sglTree", {
			options: {
				allowMultipleSelection: false,
				selectedNodes: [],
				appendURL: null,
				selectURL: null,
				select: null,
				toggleExpandURL: null,
				toggleExpand: null,
				maximumSize: 0,    // the maximum number of root nodes this tree can have;
				stepSize:  0 // the number of roots added by an append operation
			},
			
			_create: function() {
				this._addMarkupAndBindingsForTree(this.element, 1);
				this.currentSize = this.element.children(".sgl-tree-node").size();
			},
			
			_init: function() {
				this._handleSelectedNodesOption(this.options.selectedNodes, true);
				this._addOrRemoveAppendButton();
			},
			
			_setOption: function(key, value) {
				
				switch (key) {
					case "selectedNodes": {
						this._handleSelectedNodesOption(value, true);
						break
					}
				}
			},
			
			_handleSelectedNodesOption:  function(value, triggerEvent) {
				var containsReference = false;
				var referenceNodeId;
				var $selectedNodes = [];
				var ids = [];
			

				// Set the referenceNode.
				if ( value.length == 0 ) {
					this.referenceNode = null;
				} else if ( value.length == 1 || ! this.referenceNode ) {
					this.referenceNode = $("#"+value[0]);
				} else {
					referenceNodeId = this.referenceNode.attr("id");
					$.each(value, function(index, id) {
						if (id==referenceNodeId) containsReference=true;
					});
					if (!containsReference) {
						this.referenceNode = $("#"+value[0]);
					}
				}
		
				// Obtain the selected nodes.
				$.each(value, function(index, nodeId) {
					var $node = $("#"+nodeId);
				
					if ( $node.size() != 0 ) {
						$selectedNodes.push($node);
						ids.push(nodeId);
					}
				});
				this._performNodesSelection($selectedNodes);
				
				// Trigger an event.
				if (triggerEvent) {
					this._trigger("select", null, {"nodes": $selectedNodes, "ids": ids});
				}
				
				this.options.selectedNodes = ids;
			},
			
			_performNodesSelection: function ($nodes) {
				var $parents;

				$.each(this.options.selectedNodes, function(index, nodeId) {
					$("#"+nodeId).removeClass("sgl-tree-node-selected");
				});
				
				$.each($nodes, function(index, $node) {
					$node.addClass("sgl-tree-node-selected");
					// Expand the parents
					$node.parentsUntil(".sgl-tree-root").filter(".sgl-tree-node-closed").each(function(index, node){
						$(node).children(".sgl-tree-node-el").children(".sgl-tree-node-icon").trigger("click");
					});
		
				});
				
				if ( $nodes.length )  {
					// Scroll to the last added element if it is not visible
					this._scrollToNode($nodes[$nodes.length-1]);
				}
			},
			
			_scrollToNode: function ($node) {
				var nodeTopOffset = $node.offset().top;
				var listTopOffset = this.element.offset().top;

				if (  (nodeTopOffset < listTopOffset) || ( listTopOffset + this.element.height() < nodeTopOffset + $node.height() ) ) {
					this.element.scrollTo($node); 
				}
			},
			
			_addOrRemoveAppendButton: function() {
				var isRendered = this.element.next(".sgl-tree-append-button").size();
				var that = this;
				var button =  "<input type=\"button\" class=\"sgl-tree-append-page-button sgl-tree-append-button\"value=\"Append\" />";
				
				
				if (isRendered) {
					if ( this.currentSize >= this.options.maximumSize) {
						this.element.next(".sgl-tree-append-button").remove();
					}
				} else {
					if ( this.options.stepSize && this.currentSize < this.options.maximumSize ) {
						this.element.after(button);
						this.element.next(".sgl-tree-append-page-button").bind("click", function(){
							$.ajax({
								"dataType": "script",
								"url": that.options.appendRootsURL,
								"data": [
									"stepSize="+that.options.stepSize
									].join("&")
							});
						});
					}
				}
			},
			
			_addMarkupAndBindingsForTree: function($tree, level) {
				var that = this;
				
				$tree.addClass("sgl-tree-container");
				if (level == 1) {
					$tree.addClass("sgl-tree-root");
				}
				$tree.children().each(function(){
					that._addMarkupAndBindingsForNode($(this), level);
				});
			},
			
			_addMarkupAndBindingsForNode: function($node, level){
				var that = this;
				var $nodeContent = $node.children(":first");
				var $subtree = $node.children("ul");
				var hasSubtree = $subtree.size() > 0;
				var padding ;
				
				// Add the necessary CSS classes.
				$node.addClass("sgl-tree-node");
				if ( $node.hasClass("sgl-tree-node-leaf") || $node.hasClass("sgl-tree-node-closed") || $node.hasClass("sgl-tree-node-opened") ) {
					if ( $node.hasClass("sgl-tree-node-closed") ) {
						$subtree.hide();
					} else if ( $node.hasClass("sgl-tree-node-opened")  ) {
						$subtree.show();
					}
				} else {
					if ( hasSubtree ) {
						$node.addClass( $subtree.is(":visible") ? "sgl-tree-node-opened" : "sgl-tree-node-closed" );
					} else {
						$node.addClass("sgl-tree-node-leaf");
					}
				}

				// Add the markup and the bindings.
				if ( $nodeContent.size() ) {
					$nodeContent.addClass("sgl-tree-node-el");
					$nodeContent.children(":first").addClass("sgl-tree-node-title");					
					
					padding = "";
					for (var index = 0; index < level - 1; index++) {
						padding += "<ins class=\"sgl-tree-node-icon-padding\">&nbsp</ins>";
					}
					$nodeContent.children(":first").before("<span>"+padding+"</span>");
					
					$nodeContent.bind("click", function(event) {
						that._handleSelectionClickEvent(event, $node);
					});
					
					if ( ! $node.hasClass("sgl-tree-node-leaf") ) {
						$nodeContent.children(":eq(1)").before("<ins class=\"sgl-tree-node-icon\">&nbsp;</ins>");
						// Bind the toggleExpand event.
						$nodeContent.children(".sgl-tree-node-icon").bind("click", function(event) {
							that._handleToggleExpandClickEvent(event, $node);
							return false;
						});
					}
				}
				
				if ( hasSubtree ) {
					this._addMarkupAndBindingsForTree($subtree, level+1);
				}
			},
			
			_handleToggleExpandClickEvent: function(event, $node){
				var that = this;
				var expansionHandler = function(id) {
					if ( that.options.toggleExpandURL ) {
						$.ajax({
							"dataType": "script",
							"url": that.options.toggleExpandURL,
							"data": [
								"id="+encodeURIComponent(id)
								].join("&")
						});
					} else {
						that.toggleExpand($node, true, event);
					}
				}
				
				if ( $node.children("ul").size() == 0  ) {
					$.ajax({
						"dataType": "html",
						"url": this.options.appendURL,
						"data": [
							"id="+encodeURIComponent($node.attr("id"))
							].join("&"),
						"success": function(data, textStatus, XMLHttpRequest) {
							
							that.appendSubtree($node, data);
							expansionHandler($node.attr("id"));
						}
					});
				} else {
					expansionHandler($node.attr("id"));
				}
			},
			
			_handleSelectionClickEvent: function(event, $node) {
				var ids = [$node.attr("id")];
				var $selectedNodes ;
				

				if ( event.shiftKey && this.options.allowMultipleSelection ) {
					if (this.referenceNode) {
						$node.focus();
						$selectedNodes = this._obtainSelectedNodesForMultipleSelection($node, this.referenceNode);
						ids = [];
						$.each($selectedNodes, function(index, $node) {
							ids.push($node.attr("id"));
						});
					} 
				}
				if ( this.options.selectURL ) {
					$.ajax({
						"dataType": "script",
						"url": this.options.selectURL,
						"data": [
							"selectedIds="+encodeURIComponent(ids.join(","))
							].join("&")
					});
				} else {
					this._handleSelectedNodesOption(ids, true);
				}
			},
			
			_obtainSelectedNodesForMultipleSelection: function($node, $referenceNode) {
				var $allNodeChildren = $("#"+this.element.attr("id")+" .sgl-tree-node");
				var $selectedNodes;

				"Obtain a list with all the selected nodes and send it to the server"
				if ( $allNodeChildren.index($referenceNode) < $allNodeChildren.index($node) ) {
					$selectedNodes = this._obtainNodesBetweenLimits($referenceNode, $node);
				} else {
					$selectedNodes = this._obtainNodesBetweenLimits($node, $referenceNode);									
				}
			
				return $selectedNodes;
			},
			
			_obtainNodesBetweenLimits: function ($fromNode, $toNode) {
				var selectedNodes = [$fromNode];
				var $childrenList, $nextSibling, $parent;
			
				while ($fromNode.attr("id") != $toNode.attr("id")) {
				
					$childrenList = $fromNode.children(".sgl-tree-container:visible");
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
			},
			
			appendSubtree: function(nodeOrId, data) {
				var $node;
				var $subtree;
				var level;
				
				if ( typeof nodeOrId === "string" ) {					
					$node= $("#"+nodeOrId);				
				} else {					
					$node = nodeOrId;				
				}	
				$node.children(":last").after(data);
				$subtree = $node.children("ul");
				level = $node.children(".sgl-tree-node-el").children(":first").children(".sgl-tree-node-icon-padding").size() + 1;
				this._addMarkupAndBindingsForTree($subtree, level+1);
			},
			
			appendRoots: function(data) {
				var that = this;
				var addedChildren;
				
				this.element.append(data);
				addedChildren = this.element.children(":not(.sgl-tree-node)");
				addedChildren.each(function() {
					that._addMarkupAndBindingsForNode($(this), 1);
				});
				
				this.currentSize = this.element.children(".sgl-tree-node").size();
				this._addOrRemoveAppendButton();
			},
			
			toggleExpand: function(nodeOrId, triggerEvent, originalEvent) {
				var $node;
				
				if ( typeof nodeOrId === "string" ) {					
					$node= $("#"+nodeOrId);				
				} else {					
					$node = nodeOrId;				
				}																
				if ( $node.hasClass("sgl-tree-node-opened") ) {					
					$node.removeClass("sgl-tree-node-opened");					
					$node.addClass("sgl-tree-node-closed");					
					$node.children(".sgl-tree-container").hide();				
				} else if ( $node.hasClass("sgl-tree-node-closed")  ) {					
					$node.removeClass("sgl-tree-node-closed");				
					$node.addClass("sgl-tree-node-opened");					
					$node.children(".sgl-tree-container").show();				
				}
				
				// Trigger an event.
				if (triggerEvent) {
					this._trigger("toggleExpand", originalEvent, {"node": $node[0]});
				}
			}
			
		}) ;
	}) (jQuery) ;
	'
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
				jQuery(elem).change(startWatch);
			}
		};
		
		// Watch Each Element
		return this.each(function(index){
			watchElement(this);
		});
		
	};

})(jQuery);'
]
