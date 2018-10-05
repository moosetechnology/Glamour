Class {
	#name : #GLMEyeSeePresentation,
	#superclass : #GLMPresentation,
	#instVars : [
		'renderer',
		'canvas',
		'diagramBlock',
		'eyeSeeRenderer',
		'selectedElement'
	],
	#category : #'Glamour-EyeSee-Presentations'
}

{ #category : #accessing }
GLMEyeSeePresentation >> canvas [
	^ canvas
]

{ #category : #accessing }
GLMEyeSeePresentation >> canvas: anObject [
	canvas := anObject
]

{ #category : #accessing }
GLMEyeSeePresentation >> defaultActions [
	self
		act: [ :eyesee | eyesee canvas exportAsPNG ] 
			entitled: 'Export as PNG'
]

{ #category : #accessing }
GLMEyeSeePresentation >> diagram [
	^ diagramBlock 
]

{ #category : #accessing }
GLMEyeSeePresentation >> diagram: aBlock [
	"use this one to set the "
	diagramBlock := aBlock
]

{ #category : #accessing }
GLMEyeSeePresentation >> eyeseeRenderer [
	^ eyeSeeRenderer ifNil: [ eyeSeeRenderer := ESDiagramRenderer new]
]

{ #category : #accessing }
GLMEyeSeePresentation >> eyeseeRenderer: anESDiagramRenderer [
	eyeSeeRenderer := anESDiagramRenderer
]

{ #category : #'initialize-release' }
GLMEyeSeePresentation >> initialize [
	super initialize.
	self defaultActions
]

{ #category : #rendering }
GLMEyeSeePresentation >> renderGlamorouslyOn: aRenderer [
	self registerAnnouncements.
	^aRenderer renderEyeSeePresentation: self
]

{ #category : #accessing }
GLMEyeSeePresentation >> renderOn: aRenderer [
	self flag: 'find a smarter solution that does not depend on isKindOf:'. 
	self diagram glamourValue: (
		(self entity isKindOf: GLMMultiValue) 
				ifTrue: [(GLMMultiValue with: aRenderer) , self entity , (GLMMultiValue with: self)] 
				ifFalse: [GLMMultiValue with: aRenderer with: self entity with: self]).
	self canvas: aRenderer canvas
]

{ #category : #accessing }
GLMEyeSeePresentation >> selectedElement [ 

	^ selectedElement 
]

{ #category : #accessing }
GLMEyeSeePresentation >> selectedElement: anElement [

	^ selectedElement := anElement 
]
