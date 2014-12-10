"
A GLMScrollListBrick is a list to support of very large amount of items
"
Class {
	#name : #GLMScrollListBrick,
	#superclass : #GLMScrollPaneBrick,
	#instVars : [
		'adaptor'
	],
	#category : #'Glamour-Morphic-Brick-UI'
}

{ #category : #'as yet unclassified' }
GLMScrollListBrick class >> example [
	|adaptor|
	adaptor := nil.
	adaptor := GLMBrickListAdaptor new
		sizeLogic: [ 4000000000 ];
		morphAtLogic: [ :index :morph | 
			(morph ifNil: [ GLMLabelBrick new ])
				color: Color random muchLighter;
				text: index asString, ' of ', adaptor count asString;
				textPosition: #center;
				yourself ].

	GLMFoundationBrick new
		brickRoot: (self new adaptor: adaptor);
		extent: 300@400;
		openInWindow
]

{ #category : #'as yet unclassified' }
GLMScrollListBrick class >> exampleCollection [

	GLMFoundationBrick new
		brickRoot: (self new adaptor: (GLMBrickListAdaptor new on: (Smalltalk allClasses)));
		extent: 300@400;
		openInWindow
]

{ #category : #accessing }
GLMScrollListBrick >> adaptor [

	^ adaptor
]

{ #category : #accessing }
GLMScrollListBrick >> adaptor: anAdaptor [

	adaptor := anAdaptor
]

{ #category : #adding }
GLMScrollListBrick >> addItemMorph: aMorph after: anotherMorph [

	self band addBrickBack: aMorph.
	self setBoundsOf: aMorph after: anotherMorph.
	^ aMorph
]

{ #category : #adding }
GLMScrollListBrick >> addItemMorph: aMorph before: anotherMorph [

	self band addBrick: aMorph before: anotherMorph.
	self setBoundsOf: aMorph before: anotherMorph.
	^ aMorph
]

{ #category : #accessing }
GLMScrollListBrick >> calculateMaxVelocity [

	"max velocity must depend from the height of the band"
	^ (self height * 0.9) asInteger
]

{ #category : #layouting }
GLMScrollListBrick >> doLayout [
	
	self layoutPolicy layoutFloating: self verticalScrollbar in: self withArguments: nil.
	self update.
	self verticalScrollbar update.
]

{ #category : #accessing }
GLMScrollListBrick >> gatherInvisibleItems [

	self band submorphs isEmpty ifTrue: [ ^ OrderedCollection new ].
			
	^ (OrderedCollection newFrom: (self band submorphs)) select: [ :each | (self isPartiallyVisible: each) not ]
]

{ #category : #'lazy scrolling' }
GLMScrollListBrick >> getAndRemoveInvisibleMorph: aCollection [
	|brick|
	brick := self retrieveLast: aCollection.
	^ brick ifNotNil: [ self band removeBrick: brick. brick morph ]
]

{ #category : #accessing }
GLMScrollListBrick >> getIndex: aMorph [ 

	^ aMorph valueOfProperty: #brickScrollListIndex ifAbsent: [ nil ]
]

{ #category : #'lazy scrolling' }
GLMScrollListBrick >> getMorphAt: anInteger recycled: aMorph [
	|newMorph|
	
	newMorph := (self adaptor morphAt: anInteger convert: aMorph) asBrick.
	self setIndex: anInteger in: newMorph.
	^ newMorph
]

{ #category : #initialization }
GLMScrollListBrick >> initialize [
	super initialize.
	
	self band layoutPolicy: GLMBrickVerticalFillLayout new
]

{ #category : #'instance creation' }
GLMScrollListBrick >> newBand [
	^ super newBand heightBlock: [ :bandBrick |
		bandBrick subbricks isEmpty
		ifTrue: [ 0 ]
		ifFalse: [ bandBrick lastSubbrick brickBounds bottom ] ].
]

{ #category : #'instance creation' }
GLMScrollListBrick >> newVerticalScrollbar [

	^ GLMApproximateScrollbarBrick new
]

{ #category : #scrolling }
GLMScrollListBrick >> preventOverscrolling [

	self band subbricks isEmpty ifTrue: [ ^ self ].

	((self getIndex: self band firstSubbrick) = 1) ifTrue: [
		(self band brickBounds origin y > self band firstSubbrick brickBounds top) ifTrue: [
			self band brickBounds: (self band brickBounds translateBy: (0@ self band brickBounds origin y) negated) ] ].
	
	((self getIndex: self band lastSubbrick) = self adaptor count) ifTrue: [
		(((self band brickBounds corner y) < self height) and: [ (self isVisible: self band firstSubbrick) not ]) ifTrue: [
			self band brickBounds: (self band brickBounds translateBy: (0@ (self height - self band brickBounds corner y))) ] ].
]

{ #category : #accessing }
GLMScrollListBrick >> retrieveLast: aCollection [

	^ aCollection isEmpty
		ifTrue: [ nil ]
		ifFalse: [ aCollection removeLast ]
]

{ #category : #scrolling }
GLMScrollListBrick >> scrollDown: anInteger [

	((self getIndex: self band lastSubbrick) = self adaptor count) ifTrue: [
		(self band brickBounds corner y <= self height) ifTrue: [ ^ self ] ].

	band brickBounds: (band brickBounds translateBy: (0@ anInteger) negated)
]

{ #category : #scrolling }
GLMScrollListBrick >> scrollUp: anInteger [

	((self getIndex: self band firstSubbrick) = 1) ifTrue: [
		(self band brickBounds origin y >= self band firstSubbrick brickBounds top) ifTrue: [ ^ self ] ].
	
	self band brickBounds: (self band brickBounds translateBy: (0@ anInteger))
]

{ #category : #layouting }
GLMScrollListBrick >> setBoundsOf: aMorph after: afterMorph [

	aMorph brickBounds: (afterMorph brickBounds translateBy: (0@aMorph height))
]

{ #category : #layouting }
GLMScrollListBrick >> setBoundsOf: aMorph before: beforeMorph [

	aMorph brickBounds: (beforeMorph brickBounds translateBy: (0@aMorph height)negated)
]

{ #category : #accessing }
GLMScrollListBrick >> setIndex: anInteger in: aMorph [ 

	aMorph setProperty: #brickScrollListIndex toValue: anInteger
]

{ #category : #scrolling }
GLMScrollListBrick >> update [
	super update.
	
	self updateVisible.
	self band width: self width.
	self preventOverscrolling.
	self band doLayout
]

{ #category : #'lazy scrolling' }
GLMScrollListBrick >> updateVisible [
	|invisible|
	
	self adaptor ifNil: [ ^ self ].
	
	invisible := self gatherInvisibleItems.
	self updateVisibleTop: invisible.
	self updateVisibleBottom: invisible.
	
	invisible do: [ :each | self band removeBrick: each ]
	
	
	

]

{ #category : #'lazy scrolling' }
GLMScrollListBrick >> updateVisibleBottom: invisibleBricks [
	|after|
	
	after := self band lastSubbrick.
	
	[ (self isPartiallyVisible: after) and: [ (self getIndex: after) < self adaptor count ] ] whileTrue: [
		after := self
			addItemMorph: (
				self
					getMorphAt: (self getIndex: after) + 1
					recycled: (self getAndRemoveInvisibleMorph: invisibleBricks))
			after: after ]

]

{ #category : #'lazy scrolling' }
GLMScrollListBrick >> updateVisibleTop: invisibleBricks [
	|before|
	
	before := self band subbricks isEmpty
		ifFalse: [ self band firstSubbrick]
		ifTrue: [ self band addBrickBack: (self getMorphAt: 1 recycled: (self getAndRemoveInvisibleMorph: invisibleBricks)) ].
		
	[ (self isPartiallyVisible: before) and: [ (self getIndex: before) > 1 ] ] whileTrue: [
		before := self
			addItemMorph: (
				self
					getMorphAt: (self getIndex: before) - 1
					recycled: (self getAndRemoveInvisibleMorph: invisibleBricks))
			before: before  ]
	
]
