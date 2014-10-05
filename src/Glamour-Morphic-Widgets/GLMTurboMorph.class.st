"
A GLMTurboMorph is connection layer between turbo widgets and morphic.

See GLMTurboTrick class comment for more info.

Instance Variables
	abcMorph:		<Object>
	canvas:		<Object>
	currentExtent:		<Object>
	forceRepaint:		<Object>
	morphsToRepaint:		<Object>

abcMorph
	- xxxxx

canvas
	- xxxxx

currentExtent
	- xxxxx

forceRepaint
	- xxxxx

morphsToRepaint
	- xxxxx

"
Class {
	#name : #GLMTurboMorph,
	#superclass : #Morph,
	#instVars : [
		'currentExtent',
		'rootTrick'
	],
	#category : #'Glamour-Morphic-Widgets-Turbo-Widgets'
}

{ #category : #'as yet unclassified' }
GLMTurboMorph >> doLayout [

	self root doLayout.
]

{ #category : #drawing }
GLMTurboMorph >> drawOn: aCanvas [	
	|canvas|
	canvas := aCanvas copy setOrigin: (aCanvas origin + self bounds origin) clipRect: aCanvas privateClipRect.
	
	self root drawOn: canvas area: (0@0 extent: self extent).
	
	"leave it for now to be able to render borders"
	super drawOn: aCanvas.
	
]

{ #category : #geometry }
GLMTurboMorph >> extent: aPoint [
	super extent: aPoint.
	
	self updateRootBounds.
	rootTrick doLayout.
]

{ #category : #geometry }
GLMTurboMorph >> globalBounds [

	^ self bounds
]

{ #category : #'events-processing' }
GLMTurboMorph >> handleMouseOver: evt [

	rootTrick privateHandleMouseEvent: evt where: (evt position - self bounds origin) onHandler: #MouseOver:where:
]

{ #category : #'event handling' }
GLMTurboMorph >> handlesMouseDown: evt [
	^ true
]

{ #category : #'event handling' }
GLMTurboMorph >> handlesMouseOverDragging: evt [
	^ true
]

{ #category : #initialization }
GLMTurboMorph >> initialize [
	super initialize.
	
	self beTransparent.
	
	rootTrick := GLMTurboTrick new.
	rootTrick owner: self.
	rootTrick root: self.
	rootTrick layoutManager: GLMTurboHorizontalProportionalLinearLayout new.
	self updateRootBounds.
]

{ #category : #testing }
GLMTurboMorph >> isVisibleInTheWorld [

	self owner ifNil: [ ^ false ].
	self world ifNil: [ ^ false ].
	
	^ self worldBounds intersects: self fullBoundsInWorld
	
]

{ #category : #'event handling' }
GLMTurboMorph >> mouseDown: evt [

	(rootTrick privateHandleMouseEvent: evt where: (evt position - self bounds origin) onHandler: #MouseDown:where:) ifFalse: [
		super mouseDown: evt.
		^ false.
	] ifTrue: [ ^ true ]
]

{ #category : #'event handling' }
GLMTurboMorph >> mouseEnter: evt [
]

{ #category : #'event handling' }
GLMTurboMorph >> mouseLeave: evt [
]

{ #category : #'event handling' }
GLMTurboMorph >> mouseMove: evt [

	rootTrick privateHandleMouseEvent: evt where: (evt position - self bounds origin) onHandler: #MouseDragging:where:
]

{ #category : #'event handling' }
GLMTurboMorph >> mouseUp: evt [

	(rootTrick privateHandleMouseEvent: evt where: (evt position - self bounds origin) onHandler: #MouseUp:where:) ifFalse: [
		super mouseUp: evt.
		^ false.
	] ifTrue: [ ^ true ]
]

{ #category : #initialize }
GLMTurboMorph >> outOfWorld: aWorld [
	super outOfWorld: aWorld.
	
	self root outOfWorld: aWorld.
]

{ #category : #geometry }
GLMTurboMorph >> relativeBounds [

	^ 0@0 extent: self extent
]

{ #category : #'as yet unclassified' }
GLMTurboMorph >> repaint: aTrick [

	self changed.
]

{ #category : #structure }
GLMTurboMorph >> root [

	^ rootTrick
]

{ #category : #'as yet unclassified' }
GLMTurboMorph >> updateRootBounds [

	rootTrick bounds: (0@0 extent: self extent).
]

{ #category : #geometry }
GLMTurboMorph >> worldBounds [

	^ self boundsInWorld
]
