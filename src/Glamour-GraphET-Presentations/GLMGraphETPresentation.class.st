Class {
	#name : #GLMGraphETPresentation,
	#superclass : #GLMPresentation,
	#instVars : [
		'renderer',
		'canvas',
		'eyeSeeRenderer',
		'selectedElement',
		'chartBlock',
		'graphetBuilder'
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

	^ chartBlock
]

{ #category : #accessing }
GLMGraphETPresentation >> chart: aBlock [
	"use this one to set the "
	chartBlock := aBlock
]

{ #category : #accessing }
GLMGraphETPresentation >> defaultActions [
	self
		act: [ :graphet | ROExportPNGCommand new executeOn: graphet graphetBuilder rawView ] 
			entitled: 'Export as PNG';
		act: [ :graphet | ROZoomOutMove new on: graphet graphetBuilder rawView ]
			icon: GLMUIThemeExtraIcons glamorousZoomOut
			entitled: 'Zoom out';
		act: [ :graphet | ROZoomInMove new on: graphet graphetBuilder rawView ]
			icon: GLMUIThemeExtraIcons glamorousZoomIn
			entitled: 'Zoom in'
]

{ #category : #accessing }
GLMGraphETPresentation >> diagram: aBlock [
	self chart: aBlock
]

{ #category : #accessing }
GLMGraphETPresentation >> graphetBuilder [
	^ graphetBuilder ifNil: [ graphetBuilder := GETDiagramBuilder new]
]

{ #category : #'initialize-release' }
GLMGraphETPresentation >> initialize [
	super initialize.
	self defaultActions
]

{ #category : #rendering }
GLMGraphETPresentation >> renderGlamorouslyOn: aRenderer [
	self registerAnnouncements.
	^aRenderer renderGraphETPresentation: self
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
