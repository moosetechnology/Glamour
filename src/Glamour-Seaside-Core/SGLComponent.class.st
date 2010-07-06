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
	^ 'var glamourResize = function() {
	$("body > .sgl-table, body > .finder-container").each(function() {
		$(this).height($(window).height() - 20);
	});
};

$(glamourResize);
$(window).resize(glamourResize);'
]

{ #category : #accessing }
SGLComponent >> style [
	^ '/* html */
* {margin:0; padding:0;}

html, body {
	overflow: hidden;
	height: 100%;
}

body {
	font-size: 0.8em;
	margin: 8px;
}

body, table, td, th, input, select, textarea, button {
	font-family: Verdana, Arial, sans-serif;
}
input, select, textarea {
	outline: 0;
	margin: 0;
	padding: 0;
	width: 100%;
	height: 100%;
	border: none;
	outline: none;
	display: block;
	background-color: transparent;
}

.selected {
	background-color: #E3E0D0;
}
/* layout */

.finder-container {
	overflow-x: auto;
	overflow-y: hidden;
	height: 100%;
}

div.finder {
	width: 100%;
	height: 98%;
	overflow-x: auto;
	position: relative;
	display: -webkit-box; display: -moz-box; display: box;
	-webkit-box-align: stretch; -moz-box-align: stretch; box-align: stretch;
	-webkit-box-orient: horizontal; -moz-box-orient: horizontal; box-orient: horizontal;
}
div.finder > div.finder-pane {
	min-width: 150px;
	max-width: 500px;
	height: 100%;
	width: 100%;
	display: -webkit-box; display: -moz-box; display: box;
	-webkit-box-align: stretch; -moz-box-align: stretch; box-align: stretch;
	-webkit-box-orient: horizontal; -moz-box-orient: horizontal; box-orient: horizontal;
}

div.finder-pane > * {
	width: auto;
	height: 100%;
	-webkit-box-flex: 1; -moz-box-flex: 1; box-flex: 1;
}




/* jquery ui */
.ui-tabs {
	position: relative;
	display: -webkit-box; display: -moz-box; display: box;
	-webkit-box-align: stretch; -moz-box-align: stretch; box-align: stretch;
	-webkit-box-orient: vertical; -moz-box-orient: vertical; box-orient: vertical;
}
.ui-tabs > .ui-tabs-nav {
	-webkit-box-flex: 0; -moz-box-flex: 0; box-flex: 0;
}
.ui-tabs > .ui-tabs-panel {
	padding: 0;
	-webkit-box-flex: 1; -moz-box-flex: 1; box-flex: 1;
	display: -webkit-box; display: -moz-box; display: box;
	-webkit-box-align: stretch; -moz-box-align: stretch; box-align: stretch; 
	/* -webkit-box-orient: vertical; -moz-box-orient: vertical; box-orient: vertical; */
}

.ui-tabs-panel > * {
	-webkit-box-flex: 1; -moz-box-flex: 1; box-flex: 1;
}

/* presentations */

.empty-presentation{
	min-height:50px;
}

.presentation-container {
	
}

.presentation-container > * {
	-webkit-box-flex: 1; -moz-box-flex: 1; box-flex: 1;
}

.list-presentation {
	display: -webkit-box; display: -moz-box; display: box;
	-webkit-box-align: stretch; -moz-box-align: stretch; box-align: stretch;
	-webkit-box-orient: vertical; -moz-box-orient: vertical; box-orient: vertical;
	-webkit-box-flex: 1; -moz-box-flex: 1; box-flex: 1;
}

.list-presentation > div {
	-webkit-box-flex: 1; -moz-box-flex: 1; box-flex: 1;
	overflow: auto;
	min-height: 100px;
	min-width: 100px;
}

.list-presentation > div > div {
	-webkit-box-flex: 1; -moz-box-flex: 1; box-flex: 1;
}

.list-presentation > input {
	height: 25px;
	background-color: #EBEBEB;
	-webkit-box-flex: 0; -moz-box-flex: 0; box-flex: 0;
}

.ui-accordion-content > * {
	-webkit-box-flex: 1; -moz-box-flex: 1; box-flex: 1;
}


/* presentations with title */

.presentation-with-title, .presentation-content {
	position: relative;
	display: -webkit-box; display: -moz-box; display: box;
	-webkit-box-align: stretch; -moz-box-align: stretch; box-align: stretch;
	-webkit-box-orient: vertical; -moz-box-orient: vertical; box-orient: vertical;
}

.presentation-with-title {
	padding: 0.2em;
}

.presentation-title {
	display: block;
	border: 1px solid #4297D7;
	background-color: #E1E1E1;
	padding: 0.2em 0.2em 0;
}

.presentation-title {
	-webkit-box-flex: 0; -moz-box-flex: 0; box-flex: 0;
}

.presentation-title li {
	border-bottom:0 none !important;
	float:left;
	list-style:none outside none;
	margin:0 0.2em 1px 0;
	padding:0;
	position:relative;
	top:1px;
	white-space:nowrap;
}

.presentation-title li span {
	float: left;
	padding: 0.5em 1em;
}

.presentation-content {
	padding: 0;
	-webkit-box-flex: 1; -moz-box-flex: 1; box-flex: 1;
	background: none repeat scroll 0 0 transparent;
	border-width: 0;
}

.presentation-content > div {
	-webkit-box-flex: 1; -moz-box-flex: 1; box-flex: 1;
}


/* composite arrangements */
.stacked-arrangement, .tabbed-arrangement, .accordion-arrangement {
	position: relative;
	width: 100%;
	padding: 0;
}

.stacked-arrangement, .accordion-arrangement {
	position: relative;
	display: -webkit-box; display: -moz-box; display: box;
	-webkit-box-align: stretch; -moz-box-align: stretch; box-align: stretch;
	-webkit-box-orient: vertical; -moz-box-orient: vertical; box-orient: vertical;
}

.stacked-arrangement > *{
	-webkit-box-flex: 1; -moz-box-flex: 1; box-flex: 1;
}

.accordion-arrangement > .ui-accordion-content {
	-webkit-box-flex: 1; -moz-box-flex: 1; box-flex: 1;
	display: -webkit-box; display: -moz-box; display: box;
}

/* table layout */
.sgl-table {
	width: 100%;	
	position: relative;
}

.sgl-table-hbox, 
.sgl-table-hbox > *,
.sgl-table-vbox > * {
	position: relative;
	display: -webkit-box; display: -moz-box; display: box;
	-webkit-box-align: stretch; -moz-box-align: stretch; box-align: stretch;
	-webkit-box-orient: horizontal; -moz-box-orient: horizontal; box-orient: horizontal;
}

.sgl-table-hbox > *, 
.sgl-table-hbox > * > *,
.sgl-table-vbox > * > * {
	-webkit-box-flex: 1; -moz-box-flex: 1; box-flex: 1;
}

.sgl-table-vbox {
	position: relative;
	display: -webkit-box; display: -moz-box; display: box;
	-webkit-box-orient: vertical; -moz-box-orient: vertical; box-orient: vertical;
	-webkit-box-align: stretch; -moz-box-align: stretch; box-align: stretch;
}

.sgl-table-vbox > * {
	-webkit-box-flex: 1; -moz-box-flex: 1; box-flex: 1;
}

.sgl-table-split {
	width: 5px; height: 5px;
	-webkit-box-flex: 0; -moz-box-flex: 0; box-flex: 0;
}

/* magritte layout */
div.magritte { width: 100%; }
div.magritte th { width: 150px; }
div.magritte textarea { height: 250px; }
div.magritte table { width: 100%; padding: .3em 1em 0 .4em; }
div.magritte input, div.magritte textarea { width: 100%; border: 1px solid #d3d3d3; background: #e6e6e6; }
div.magritte .buttons { text-align: right; border-width: 1px 0 0 0; margin: .5em 0 0 0; padding: .3em 1em .5em .4em; }
div.magritte .submit { display: inline; margin: .5em .4em .5em 0; cursor: pointer; padding: .2em .6em .3em .6em; line-height: 1.4em; width: auto; overflow: visible; border: 1px solid #d3d3d3; background: #e6e6e6 url(/seaside/files/JQUiSmoothnessTheme/uibgglass75e6e6e61x400.png) 50% 50% repeat-x; font-weight: normal; color: #555555; outline: none; }'
]

{ #category : #updating }
SGLComponent >> updateRoot: aHtmlRoot [
	super updateRoot: aHtmlRoot.
	aHtmlRoot title: 'Seaside Glamorous Browser'.
	"aHtmlRoot javascript url: 'http://getfirebug.com/releases/lite/1.2/firebug-lite-compressed.js'"
]
