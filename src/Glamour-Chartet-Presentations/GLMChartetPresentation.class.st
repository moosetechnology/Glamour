Class {
	#name : #GLMChartetPresentation,
	#superclass : #GLMPresentation,
	#instVars : [
		'renderer',
		'canvas',
		'diagramBlock',
		'eyeSeeRenderer',
		'selectedElement',
		'chartetBuilder'
	],
	#category : #'Glamour-Chartet-Presentations'
}

{ #category : #accessing }
GLMChartetPresentation >> canvas [
	^ canvas
]

{ #category : #accessing }
GLMChartetPresentation >> canvas: anObject [
	canvas := anObject
]

{ #category : #accessing }
GLMChartetPresentation >> chart [

	^ diagramBlock
]

{ #category : #accessing }
GLMChartetPresentation >> chart: aBlock [
	"use this one to set the "
	diagramBlock := aBlock
]

{ #category : #accessing }
GLMChartetPresentation >> chartetBuilder [
	^ chartetBuilder ifNil: [ chartetBuilder := GETDiagramBuilder new]
]

{ #category : #accessing }
GLMChartetPresentation >> chartetBuilder: aBuilder [
	chartetBuilder := aBuilder 
]

{ #category : #accessing }
GLMChartetPresentation >> defaultActions [
	self
		act: [ :eyesee | eyesee canvas exportAsPNG ] 
			entitled: 'Export as PNG'
]

{ #category : #accessing }
GLMChartetPresentation >> diagram: aBlock [
	self chart: aBlock
]

{ #category : #'initialize-release' }
GLMChartetPresentation >> initialize [
	super initialize.
	self defaultActions
]

{ #category : #rendering }
GLMChartetPresentation >> renderGlamorouslyOn: aRenderer [
	self registerAnnouncements.
	^aRenderer renderChartetPresentation: self
]

{ #category : #accessing }
GLMChartetPresentation >> renderOn: aBuilder [
	self flag: 'find a smarter solution that does not depend on isKindOf:'. 
	self chart glamourValue: (
		(self entity isKindOf: GLMMultiValue) 
				ifTrue: [(GLMMultiValue with: aBuilder) , self entity , (GLMMultiValue with: self)] 
				ifFalse: [GLMMultiValue with: aBuilder with: self entity with: self])
]

{ #category : #accessing }
GLMChartetPresentation >> selectedElement [ 

	^ selectedElement 
]

{ #category : #accessing }
GLMChartetPresentation >> selectedElement: anElement [

	^ selectedElement := anElement 
]
