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
	self session addBrowser: self browser.
	(SGLRenderer in: self on: html)
		render: self presentation
]

{ #category : #updating }
SGLComponent >> updateRoot: aHtmlRoot [
	super updateRoot: aHtmlRoot.
	aHtmlRoot title: 'Seaside Glamorous Browser'.
	aHtmlRoot stylesheet url: (SGLFileLibrary urlOf: #styleCss).
	aHtmlRoot stylesheet url: (SGLFileLibrary urlOf:  #mbMenuCss).
	
	aHtmlRoot javascript url: (SGLJsLibrary urlOf: #caretJs).
	aHtmlRoot javascript url: (SGLJsLibrary urlOf: #scrollToJs).
	aHtmlRoot javascript url: (SGLJsLibrary urlOf: #typeWatchJs).
	aHtmlRoot javascript url: (SGLJsLibrary urlOf: #glamourSeasideJs).
	
	aHtmlRoot javascript url: JQWidgetBoxDeploymentLibrary / #mbMenuJs.
	aHtmlRoot javascript url: JQWidgetBoxDeploymentLibrary / #jqueryhoverintentJs.
	"aHtmlRoot javascript url: 'http://getfirebug.com/releases/lite/1.2/firebug-lite-compressed.js'"
]
