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
		addLibrary: JQUiSmoothnessTheme.	
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
	
	self subclassResponsibility
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


'
]

{ #category : #updating }
SGLComponent >> updateRoot: aHtmlRoot [
	super updateRoot: aHtmlRoot.
	aHtmlRoot title: 'Seaside Glamorous Browser'
]
