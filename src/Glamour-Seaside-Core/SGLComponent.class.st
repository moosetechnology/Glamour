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

{ #category : #updating }
SGLComponent >> updateRoot: aHtmlRoot [
	super updateRoot: aHtmlRoot.
	aHtmlRoot title: 'Seaside Glamorous Browser'.
	aHtmlRoot stylesheet url: (SGLFileLibrary urlOf: #styleCss).
	aHtmlRoot javascript url: (SGLFileLibrary urlOf: #glamourSeasideJs).
	aHtmlRoot javascript url: JQWidgetBoxDevelopmentLibrary / #mbMenuJs.
	aHtmlRoot stylesheet url: (SGLFileLibrary urlOf:  #mbMenuCss).
	aHtmlRoot javascript url: JQWidgetBoxDevelopmentLibrary / #jqueryhoverintentJs.
	"aHtmlRoot javascript url: 'http://getfirebug.com/releases/lite/1.2/firebug-lite-compressed.js'"
]
