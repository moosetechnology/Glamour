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
		render: self presentation.
	html anchor
		callback: [ ];
		with: 'Refresh'
]

{ #category : #accessing }
SGLComponent >> style [
	"Theme: http://kuler.adobe.com/#themeID/375397"

	^ 'body {
	color: #f6feff;
	background-color: #201e18;
	font-family: "Helvetica Neue", Helvetica, Arial;
	font-size: 14px;
}
a {
	color: #f5b741;
	text-decoration: none;
}

table.table-layout { width: 100%; border: 0; margin: 0; padding: 0; border-spacing: 0 0; border-collapse: collapse; }
table.table-layout td { vertical-align: top; border: 0; margin: 0; padding: 2px; }

select {
	width: 100%;
	height: 100%;
	outline: none;
	color: inherit;
	border: #444039 solid 1px;
	background-color: inherit;
}
textarea {
	width: 100%;
	height: 200px;
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
