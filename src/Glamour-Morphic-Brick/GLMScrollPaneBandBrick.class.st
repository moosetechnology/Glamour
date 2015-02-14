Class {
	#name : #GLMScrollPaneBandBrick,
	#superclass : #GLMBandBrick,
	#instVars : [
		'scrollpane',
		'asyncTask',
		'isLayoutMorphs'
	],
	#category : #'Glamour-Morphic-Brick-Widgets-Scrollpane'
}

{ #category : #accessing }
GLMScrollPaneBandBrick >> asyncTask [

	^ asyncTask ifNil: [ asyncTask := GLMAsyncTask new ]
]

{ #category : #accessing }
GLMScrollPaneBandBrick >> isLayoutMorphs [

	^ isLayoutMorphs ifNil: [ ^ false ]
]

{ #category : #accessing }
GLMScrollPaneBandBrick >> layoutMorphs: aBoolean [
	"if you know, that morphs are used in scrollpane set me to true.
	each time layout changes I relayout all morphs after some delay
	implemented using async task, such that it can be canceled"
	isLayoutMorphs := aBoolean
]

{ #category : #'brick-layout-events' }
GLMScrollPaneBandBrick >> onChildrenLayouted [
	super onChildrenLayouted.
	
	self scrollpane ifNotNil: [ :s | s updateScrollbar ].
	
	self isLayoutMorphs ifFalse: [ ^ self ].
	self asyncTask
		perform: [ self updateMorphBounds ]
		delay: 400
		priority: Processor lowestPriority
]

{ #category : #accessing }
GLMScrollPaneBandBrick >> scrollpane [
	^ scrollpane
]

{ #category : #accessing }
GLMScrollPaneBandBrick >> scrollpane: anObject [
	scrollpane := anObject
]
