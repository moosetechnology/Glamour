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
		addLibrary: JQDeploymentLibrary;
		addLibrary: JQUiDeploymentLibrary;
		addLibrary: JQSmoothnessTheme.	
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
	$("body > table.table-layout").each(function() {
		$(this).height($(window).height() - 20);
	});
};

$(glamourResize);
$(window).resize(glamourResize);'
]

{ #category : #accessing }
SGLComponent >> style [
	^ '/* html */
html, body {
	overflow: hidden;
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
}

/* layout */
table.table-layout,
table.table-layout tr,
table.table-layout td,
table.table-layout th {
	border: 0;
	margin: 0; 
	padding: 0;
}
table.table-layout {
	width: 100%;
	height: 100%;
	border-spacing: 0;
	border-collapse: collapse;
}
table.table-layout td,
table.table-layout th {
	text-align: left;
	position: relative;
	vertical-align: top; 
}

/* jquery ui */
.ui-widget,
.ui-widget-content {
	height: 100%;
	position: relative;
}
.ui-tabs .ui-tabs-panel {
	padding: 0;
}

/* magritte */
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
	aHtmlRoot title: 'Seaside Glamorous Browser'
]
