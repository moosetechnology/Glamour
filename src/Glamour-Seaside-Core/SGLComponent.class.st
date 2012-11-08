Class {
	#name : #SGLComponent,
	#superclass : #WAComponent,
	#instVars : [
		'presentation'
	],
	#category : #'Glamour-Seaside-Core'
}

{ #category : #initialization }
SGLComponent class >> applyPreferencesOn: anApplication [
	anApplication preferenceAt: #sessionClass put: SGLSession.
	anApplication configuration
		addParent: WADevelopmentConfiguration instance;
		at: #rootDecorationClasses put: #().
	anApplication 
		addLibrary: JQGoogleLibrary;
		addLibrary: JQUiGoogleLibrary;
		addLibrary: JQSGLTheme.
		"addLibrary: JQRedmondTheme."

]

{ #category : #initialization }
SGLComponent class >> registerAsApplication: aString [
	| application |
	application := WAAdmin register: self asApplicationAt: aString.
	self applyPreferencesOn: application.
	^ application
]

{ #category : #accessing }
SGLComponent >> browser [
	"Override this method and answer a browser instance."
	
	self subclassResponsibility
]

{ #category : #accessing }
SGLComponent >> currentModel [
	"Return the model on which the browser will be opened."
	|model|
	
	model := self requestContext request at: #entity ifAbsent: nil.
	model isNil ifTrue: [^self model].
	^ self transformEntityPortValue: model
]

{ #category : #accessing }
SGLComponent >> model [
	"Override this method and answer a model instance."
	
	^ nil
]

{ #category : #private }
SGLComponent >> presentationForBrowser: aBrowser [
	| fields |
	fields := self requestContext request queryFields.
	
	presentation := aBrowser 
		startOn: self currentModel;
		yourself.
	(fields keys reject: [:key | key = #entity ]) do: [:key |
		(presentation pane port: key) value: (fields at: key) ].

	^ presentation
]

{ #category : #rendering }
SGLComponent >> renderContentOn: html [
	|browser|
	browser := self browser.
	self session addBrowser: browser.
	(SGLRenderer in: self on: html)
		render: (self presentationForBrowser: browser)
]

{ #category : #accessing }
SGLComponent >> transformEntityPortValue: aString [
	"Override to modify the value comming from the url that will be sent to the entity port"
	^ aString
]

{ #category : #updating }
SGLComponent >> updateRoot: aHtmlRoot [
	super updateRoot: aHtmlRoot.
	aHtmlRoot title: 'Seaside Glamorous Browser'.
	aHtmlRoot stylesheet url: (SGLFileLibrary urlOf: #styleCss).
	aHtmlRoot stylesheet url: (SGLFileLibrary urlOf:  #mbMenuCss).
	
	aHtmlRoot javascript url: (SGLJsLibrary urlOf: #splitterJs).
	"aHtmlRoot javascript url: (SGLJsLibrary urlOf: #jquerybaresizeJs)."
	aHtmlRoot javascript url: (SGLJsLibrary urlOf: #caretJs).
	aHtmlRoot javascript url: (SGLJsLibrary urlOf: #scrollToJs).
	aHtmlRoot javascript url: (SGLJsLibrary urlOf: #typeWatchJs).
	aHtmlRoot javascript url: (SGLJsLibrary urlOf: #sglTreeJs).
	aHtmlRoot javascript url: (SGLJsLibrary urlOf: #sglResizeJs).
	aHtmlRoot javascript url: (SGLJsLibrary urlOf: #sglStackJs).
	aHtmlRoot javascript url: (SGLJsLibrary urlOf: #glamourSeasideJs).
	
	aHtmlRoot javascript url: JQWidgetBoxDeploymentLibrary / #mbMenuJs.
	aHtmlRoot javascript url: JQWidgetBoxDeploymentLibrary / #jqueryhoverintentJs.
	"aHtmlRoot javascript url: 'http://getfirebug.com/releases/lite/1.2/firebug-lite-compressed.js'"
]
