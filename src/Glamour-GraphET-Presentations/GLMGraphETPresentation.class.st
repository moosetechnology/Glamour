Class {
	#name : #GLMGraphETPresentation,
	#superclass : #GLMPresentation,
	#instVars : [
		'renderer',
		'canvas',
		'diagramBlock',
		'eyeSeeRenderer',
		'selectedElement',
		'chartetBuilder'
	],
	#category : #'Glamour-GraphET-Presentations'
}

{ #category : #accessing }
GLMGraphETPresentation >> canvas [
	^ canvas
]

{ #category : #accessing }
GLMGraphETPresentation >> canvas: anObject [
	canvas := anObject
]

{ #category : #accessing }
GLMGraphETPresentation >> chart [

	^ diagramBlock
]

{ #category : #accessing }
GLMGraphETPresentation >> chart: aBlock [
	"use this one to set the "
	diagramBlock := aBlock
]

{ #category : #accessing }
GLMGraphETPresentation >> chartetBuilder [
	^ chartetBuilder ifNil: [ chartetBuilder := GETDiagramBuilder new]
]

{ #category : #accessing }
GLMGraphETPresentation >> chartetBuilder: aBuilder [
	chartetBuilder := aBuilder 
]

{ #category : #accessing }
GLMGraphETPresentation >> defaultActions [
	self
		act: [ :eyesee | eyesee canvas exportAsPNG ] 
			entitled: 'Export as PNG'
]

{ #category : #accessing }
GLMGraphETPresentation >> diagram: aBlock [
	self chart: aBlock
]

{ #category : #'initialize-release' }
GLMGraphETPresentation >> initialize [
	super initialize.
	self defaultActions
]

{ #category : #rendering }
GLMGraphETPresentation >> renderGlamorouslyOn: aRenderer [
	self registerAnnouncements.
	^aRenderer renderChartetPresentation: self
]

{ #category : #accessing }
GLMGraphETPresentation >> renderOn: aBuilder [
	self flag: 'find a smarter solution that does not depend on isKindOf:'. 
	self chart glamourValue: (
		(self entity isKindOf: GLMMultiValue) 
				ifTrue: [(GLMMultiValue with: aBuilder) , self entity , (GLMMultiValue with: self)] 
				ifFalse: [GLMMultiValue with: aBuilder with: self entity with: self])
]

{ #category : #accessing }
GLMGraphETPresentation >> selectedElement [ 

	^ selectedElement 
]

{ #category : #accessing }
GLMGraphETPresentation >> selectedElement: anElement [

	^ selectedElement := anElement 
]
