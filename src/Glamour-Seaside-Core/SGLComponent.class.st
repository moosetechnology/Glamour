Class {
	#name : #SGLComponent,
	#superclass : #WAComponent,
	#instVars : [
		'presentation'
	],
	#category : #'Glamour-Seaside-Core'
}

{ #category : #initialization }
SGLComponent class >> registerAsApplication: aString [
	| application |
	application := WAAdmin register: self asApplicationAt: aString.
	application configuration
		addParent: WADevelopmentConfiguration instance;
		at: #rootDecorationClasses put: #().
	application 
		addLibrary: JQGoogleLibrary;
		addLibrary: JQUiGoogleLibrary;
		addLibrary: JQRedmondTheme.
	^ application
]

{ #category : #accessing }
SGLComponent >> browser [
	"Override this method and answer a browser instance."
	
	self subclassResponsibility
]

{ #category : #accessing }
SGLComponent >> model [
	"Override this method and answer a model instance."
	
	^ nil
]

{ #category : #private }
SGLComponent >> presentation [
	presentation isNil ifTrue: [
		presentation := self browser 
			startOn: self model;
			yourself ].
	^ presentation
]

{ #category : #rendering }
SGLComponent >> renderContentOn: html [
	(SGLRenderer in: self on: html)
		render: self presentation
]

{ #category : #accessing }
SGLComponent >> script [
	^ '
	var Glamour = {};
	
	Glamour.resize = function() {
		$("body > .sgl-table, body > .finder-container").each(function() {
			$(this).height($(window).height() - 20);
		});
	};

	Glamour.disableClickEvent = function(id) {
		document.getElementById(id).onclick = null;
	};

	Glamour.tree = {};
	Glamour.tree.bindEvents = function(listId, level) {
		var padding = "";
		
		// Create a padding
		for (var index = 0; index < level; index++) {
			padding += "<ins class=\"glm-tree-icon-padding\">&nbsp</ins>";
		}
		
		// Bind the events
		$("#"+listId+" > .glm-tree-node > .glm-tree-node-el").bind("click", function(){
			var parent = $(this).parent();
			
			Glamour.tree.collapsible(parent);
			Glamour.tree.selection(parent);
		}).find(":first").before("<span>"+padding+"</span>").before(Glamour.tree.icon) ; 
	}
	
	Glamour.tree.addRootIcon = function(listId) {
		$("#"+listId+" > .glm-tree-node > .glm-tree-node-el").find(":first").before(function() {
			if ( $(this).parent().children("ins").size() == 0 && $(this).parent().parent().hasClass("glm-tree-leaf") == false )
				return "<span></span>" + Glamour.tree.icon();
		}) ; 
	}
	
	Glamour.tree.icon = function() {
		
		if (  $(this).parent().parent().hasClass("glm-tree-leaf") == false ) {
			return  "<ins class=\"glm-tree-icon\">&nbsp;</ins>";
		}
	}
	
	Glamour.tree.selection = function(element) {
		element.addClass("glm-tree-node-selected");
		if (typeof Glamour.tree.selectedId !== "undefined" && Glamour.tree.selectedId !== element.attr("id") ) {
			$("#"+Glamour.tree.selectedId).removeClass("glm-tree-node-selected");
		} 
		
		Glamour.tree.selectedId = element.attr("id");
	}
	
	Glamour.tree.collapsible = function(element) {
		if ( element.hasClass("glm-tree-open") ) {
			element.removeClass("glm-tree-open");
			element.addClass("glm-tree-closed");
			element.children(".glm-tree-node-ct").hide();
		} else if ( element.hasClass("glm-tree-closed")  ) {
			element.removeClass("glm-tree-closed");
			element.addClass("glm-tree-open");
			element.children(".glm-tree-node-ct").show();
		}
	};

$(Glamour.resize);
$(window).resize(Glamour.resize);'
]

{ #category : #accessing }
SGLComponent >> style [
	^ ''
]

{ #category : #updating }
SGLComponent >> updateRoot: aHtmlRoot [
	super updateRoot: aHtmlRoot.
	aHtmlRoot title: 'Seaside Glamorous Browser'.
	aHtmlRoot stylesheet url: (ListingPresentationFileLibrary urlOf: #styleCss)
	"aHtmlRoot javascript url: 'http://getfirebug.com/releases/lite/1.2/firebug-lite-compressed.js'"
]
