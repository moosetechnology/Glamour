"
A GLMScrollListBrick is a list to support of very large amount of items
"
Class {
	#name : #GLMScrollListBrick,
	#superclass : #GLMScrollPaneBrick,
	#instVars : [
		'adapter'
	],
	#category : #'Glamour-Morphic-Brick-UI'
}

{ #category : #'as yet unclassified' }
GLMScrollListBrick class >> example [
	|foundation scrollPane|
	
	scrollPane := self new.
	
	foundation := GLMFoundationBrick new.
	foundation brickRoot: scrollPane.
	
	foundation extent: 200@200.
	foundation doLayout.
	scrollPane adapter: GLMBrickListAdapter new.
	foundation doLayout.
	
	foundation openInWindow
]

{ #category : #accessing }
GLMScrollListBrick >> adapter [

	^ adapter
]

{ #category : #accessing }
GLMScrollListBrick >> adapter: anAdapter [

	adapter := anAdapter.
	self fillEmptySpace
]

{ #category : #'as yet unclassified' }
GLMScrollListBrick >> fillEmptySpace [
	|invisible before after|
	
	self adapter ifNil: [ ^ self ].
	
	self band subbricks do: [ :each | each privateBrickDoubleLink ifNil: [ self halt ] ].
	
	invisible := self gatherInvisibleItems.
	
	before := self band subbricks isEmpty
		ifFalse: [ self band firstSubbrick]
		ifTrue: [ nil ].
		
	before ifNil: [
		|last|
		last := self retrieveLast: invisible.
		last ifNotNil: [ self band removeBrick: last. self setIndex: nil in: last ].
		before := self adapter itemMorphAt: 1 recycled: (last).
		before extent: (self width@before height).
		self setIndex: 1 in: before.
		self band addBrickBack: before ].
	
	[ (self isVisible: before) and: [ (self getIndex: before) > 1 ] ] whileTrue: [
		|newBefore last|
		last := self retrieveLast: invisible.
		
		last ifNotNil: [ last privateBrickDoubleLink ifNil: [ self halt ] ].
		
		last ifNotNil: [ self band removeBrick: last. self setIndex: nil in: last ].
		newBefore := self adapter itemMorphAt: (self getIndex: before) - 1 recycled: last.
		self band addBrick: newBefore before: before.
		self setBoundsOf: newBefore before: before.
		self setIndex: (self getIndex: before) - 1 in: newBefore.
		before := newBefore ].
	
	after := self band lastSubbrick.
	
	[ (self isVisible: after) and: [ (self getIndex: after) < self adapter itemsCount ] ] whileTrue: [
		|newAfter last|
		last := self retrieveLast: invisible.
		last ifNotNil: [ last privateBrickDoubleLink ifNil: [ self halt ] ].
		last ifNotNil: [ self band removeBrick: last ].
		
		newAfter := self adapter itemMorphAt: (self getIndex: after) + 1 recycled: last.
		self band addBrickBack: newAfter.
		self setBoundsOf: newAfter after: after.
		self setIndex: (self getIndex: after) + 1 in: newAfter.
		after := newAfter ].
	
	invisible do: [ :each | self band removeBrick: each ]
]

{ #category : #'as yet unclassified' }
GLMScrollListBrick >> gatherInvisibleItems [

	self band submorphs isEmpty ifTrue: [ ^ OrderedCollection newFrom: self band submorphs ].
			
	^ (OrderedCollection newFrom: (self band submorphs)) select: [ :each | (self isPartiallyVisible: each) not ]
]

{ #category : #'as yet unclassified' }
GLMScrollListBrick >> getIndex: aMorph [ 

	^ aMorph valueOfProperty: #brickScrollListIndex ifAbsent: [ nil ]
]

{ #category : #initialization }
GLMScrollListBrick >> initialize [
	super initialize.
	
	self band layoutPolicy: GLMBrickVerticalFillLayout new
]

{ #category : #'as yet unclassified' }
GLMScrollListBrick >> newBand [

	^ GLMListBandBrick new
]

{ #category : #'as yet unclassified' }
GLMScrollListBrick >> retrieveLast: aCollection [

	^ aCollection isEmpty
		ifTrue: [ nil ]
		ifFalse: [ aCollection removeLast ]
]

{ #category : #'as yet unclassified' }
GLMScrollListBrick >> scrollDown: anInteger [

	band brickBounds: (band brickBounds translateBy: (0@ anInteger) negated).
	band brickBounds: (band brickBounds bottom: (band brickBounds bottom + anInteger)).
	
	self fillEmptySpace.
	self band doLayout.
]

{ #category : #'as yet unclassified' }
GLMScrollListBrick >> scrollUp: anInteger [

	"actuall scrolling"
	band brickBounds: (band brickBounds translateBy: (0@ anInteger)).
	band brickBounds: (band brickBounds bottom: (band brickBounds bottom - anInteger)).
	self fillEmptySpace.
	self band doLayout.
]

{ #category : #'as yet unclassified' }
GLMScrollListBrick >> setBoundsOf: aMorph after: afterMorph [

	aMorph brickBounds: (afterMorph brickBounds translateBy: (0@aMorph height))
]

{ #category : #'as yet unclassified' }
GLMScrollListBrick >> setBoundsOf: aMorph before: beforeMorph [

	aMorph brickBounds: (beforeMorph brickBounds translateBy: (0@aMorph height)negated)
]

{ #category : #'as yet unclassified' }
GLMScrollListBrick >> setIndex: anInteger in: aMorph [ 

	aMorph setProperty: #brickScrollListIndex toValue: anInteger
]
