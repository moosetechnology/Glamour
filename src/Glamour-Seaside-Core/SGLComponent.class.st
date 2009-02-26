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
	^ presentation ifNil: [
		presentation := self browser 
			startOn: self model;
			yourself ]
]

{ #category : #rendering }
SGLComponent >> renderContentOn: html [
	(SGLRenderer in: self on: html)
		open: self presentation
]

{ #category : #accessing }
SGLComponent >> style [
	^ 'div { border: 1px red solid; }
	td { border: 1px blue solid; }
	
div { width: 100%; }
select { width: 100%; height: 200px; }
textarea { width: 100%; height: 200px; }
'
]

{ #category : #updating }
SGLComponent >> updateRoot: aHtmlRoot [
	super updateRoot: aHtmlRoot.
	aHtmlRoot title: 'Seaside Glamorous Browser'
]
