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
		addParent: WADevelopmentConfiguration instance.
	application addLibrary: JQDeploymentLibrary.
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
	"Theme: http://kuler.adobe.com/#themeID/375397"

	^ 'body, tabe, tr, td, input, textarea, select {
	color: #f6feff;
	background-color: #201e18;
	font-family: "Helvetica Neue", Helvetica, Arial;
	font-size: 16px;
}
a {
	color: #f5b741;
	text-decoration: none;
}

table.table-layout { 
	border: 0;
	margin: 0; 
	padding: 0;
	width: 100%;
	height: 100%; 
	border-spacing: 0;
	border-collapse: collapse;
}
table.table-layout tr {
	border: 0;
	margin: 0;
	padding: 0;
}
table.table-layout td,
table.table-layout th { 
	border: 0; 
	margin: 0; 
	padding: 0;
	text-align: left; 
	vertical-align: top; 
}

select {
	width: 100%;
	height: 100%;
	margin: -1px;
	outline: none;
	color: inherit;
	border: #444039 solid 1px;
	background-color: inherit;
}
textarea {
	width: 100%;
	height: 100%;
	margin: -1px;
	outline: none;
	color: inherit;
	border: #444039 solid 1px;
	background-color: inherit;
}

ul.tabs li.tabs-current {
	font-weight: bold;
}
'
]

{ #category : #updating }
SGLComponent >> updateRoot: aHtmlRoot [
	super updateRoot: aHtmlRoot.
	aHtmlRoot title: 'Seaside Glamorous Browser'
]
