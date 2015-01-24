"
asdasdasd
asd
as
d
as
d
"
Class {
	#name : #GLMNewScrollListBrick,
	#superclass : #GLMScrollPaneBrick,
	#instVars : [
		'adaptor',
		'visibleIndex'
	],
	#category : #'Glamour-Morphic-Brick-UI'
}

{ #category : #examples }
GLMNewScrollListBrick class >> example [
	|adaptor|
	adaptor := nil.
	adaptor := GLMBrickListAdaptor new
		sizeLogic: [ 2000 ];
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

{ #category : #examples }
GLMNewScrollListBrick class >> exampleCollection [

	GLMFoundationBrick new
		brickRoot: (self new adaptor: (GLMBrickListAdaptor new on: Smalltalk allClasses));
		extent: 300@400;
		openInWindow
]

{ #category : #examples }
GLMNewScrollListBrick class >> exampleDifferentHeights [
	|adaptor|
	adaptor := nil.
	adaptor := GLMBrickListAdaptor new
		sizeLogic: [ 50 ];
		morphAtLogic: [ :index :morph |
			(morph ifNil: [ GLMLabelBrick new ])
				color: Color random muchLighter;
				text: index asString, ' of ', adaptor count asString;
				textPosition: #center;
				enable;
				height: [ :b | (((index % 10)*10 + 30) +  (10000 * (2 / b width))) asInteger ];
				yourself ].

	GLMFoundationBrick new
		brickRoot: (self new adaptor: adaptor);
		extent: 800@400;
		openInWindow
]

{ #category : #examples }
GLMNewScrollListBrick class >> exampleInfinity [
	|adaptor|
	adaptor := nil.
	adaptor := GLMBrickListAdaptor new
		sizeLogic: [ Float infinity ];
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

{ #category : #accessing }
GLMNewScrollListBrick >> adaptor [

	^ adaptor
]

{ #category : #accessing }
GLMNewScrollListBrick >> adaptor: anAdaptor [

	adaptor := anAdaptor
]

{ #category : #adding }
GLMNewScrollListBrick >> addItemMorph: aMorph after: anotherMorph [

	self band addBrickBack: aMorph.
	self setBoundsOf: aMorph after: anotherMorph.
	(self isPartiallyVisible: aMorph) ifFalse: [ self band removeBrick: aMorph. ^ nil ].
	^ aMorph
]

{ #category : #adding }
GLMNewScrollListBrick >> addItemMorph: aMorph before: anotherMorph [

	self setBoundsOf: aMorph before: anotherMorph.
	self band addBrick: aMorph before: anotherMorph.
	(self isPartiallyVisible: aMorph) ifFalse: [ self band removeBrick: aMorph. ^ nil ].
	
	aMorph brickBounds top < 0
		ifTrue: [ self moveAllSubbricksBy: aMorph brickBounds top negated ]
		ifFalse: [ (self getIndex: aMorph) = 1 ifTrue: [
				self moveAllSubbricksBy: aMorph brickBounds top negated ] ].
	
	^ aMorph
]

{ #category : #scrolling }
GLMNewScrollListBrick >> calculateMaxVelocity [

	"max velocity must depend from the height of the band"
	^ (self height * 0.9) asInteger
]

{ #category : #layouting }
GLMNewScrollListBrick >> doLayout [
	
	self band hasSubbricks ifFalse: [ self updateVisible ].
	
	self layoutPolicy layout: self in: self brickBounds.
	self flag: 'Fix bug in Layouts'.
	self band doLayout.
	self band doLayout.
	self update.
]

{ #category : #accessing }
GLMNewScrollListBrick >> gatherInvisibleItems [

	self band submorphs isEmpty ifTrue: [ ^ OrderedCollection new ].
			
	^ (OrderedCollection newFrom: (self band submorphs)) select: [ :each | (self isPartiallyVisible: each) not ]
]

{ #category : #'lazy scrolling' }
GLMNewScrollListBrick >> getAndRemoveInvisibleMorph: aCollection [
	|brick|
	brick := self retrieveLast: aCollection.
	^ brick ifNotNil: [ self band removeBrick: brick. brick morph ]
]

{ #category : #accessing }
GLMNewScrollListBrick >> getIndex: aBrick [ 

	^ aBrick valueOfProperty: #brickScrollListIndex ifAbsent: [ ]
]

{ #category : #'lazy scrolling' }
GLMNewScrollListBrick >> getMorphAt: anInteger recycled: aMorph [
	|newMorph|
	
	newMorph := (self adaptor morphAt: anInteger convert: aMorph) asBrick.
	self setIndex: anInteger in: newMorph.
	^ newMorph
]

{ #category : #initialization }
GLMNewScrollListBrick >> initialize [
	super initialize.
	
	self band layoutPolicy: GLMBrickVerticalScrollListLayout new
]

{ #category : #scrolling }
GLMNewScrollListBrick >> invalidate [

	self scrollTo: self visibleIndex
]

{ #category : #layouting }
GLMNewScrollListBrick >> moveAllSubbricksBy: anInteger [

	self band subbricks do: [ :each | each brickBounds: (each brickBounds translateBy: 0@anInteger) ].
	self band brickBounds: (self band brickBounds translateBy: 0@anInteger negated).
]

{ #category : #'instance creation' }
GLMNewScrollListBrick >> newBand [
	^ super newBand height: [ :bandBrick |
		bandBrick subbricks isEmpty
		ifTrue: [ 0 ]
		ifFalse: [ bandBrick lastSubbrick brickBounds bottom ] ].
]

{ #category : #'instance creation' }
GLMNewScrollListBrick >> newVerticalScrollbar [

	^ GLMApproximateScrollbarBrick new
]

{ #category : #scrolling }
GLMNewScrollListBrick >> preventOverscrolling [

	self band subbricks isEmpty ifTrue: [ ^ self ].

	((self getIndex: self band firstSubbrick) = 1) ifTrue: [
		(self isVisible: self band firstSubbrick) ifTrue: [
			(self band firstSubbrick brickBounds top > 0) ifTrue: [
				self moveAllSubbricksBy: self band firstSubbrick brickBounds top negated.
				self band brickBounds: (self band brickBounds translateBy: (0@ self band brickBounds top negated)).
				^ self update ] ].
		
		(self band brickBounds origin y > self band firstSubbrick brickBounds top) ifTrue: [
			self band brickBounds: (self band brickBounds translateBy: (0@ self band brickBounds origin y) negated). ^ self update ] ].
	
	((self getIndex: self band lastSubbrick) = self adaptor count) ifTrue: [
		(((self band brickBounds corner y) < self height) and: [ (self isVisible: self band firstSubbrick) not ]) ifTrue: [
			self band brickBounds: (self band brickBounds translateBy: (0@ (self height - self band brickBounds corner y))). ^ self update ] ].
]

{ #category : #accessing }
GLMNewScrollListBrick >> retrieveLast: aCollection [

	^ aCollection isEmpty
		ifTrue: [ nil ]
		ifFalse: [ aCollection removeLast ]
]

{ #category : #scrolling }
GLMNewScrollListBrick >> scrollDown: anInteger [
	|delta|
	delta := anInteger.
	((self getIndex: self band lastSubbrick) = self adaptor count) ifTrue: [
		
		(((self getIndex: self band firstSubbrick) = 1) and: [ self isVisible: self band firstSubbrick ])
			ifTrue: [ (self isVisible: self band lastSubbrick) ifTrue: [ ^ self ] ].
		
		delta := delta := delta min: (self band brickBounds corner y - self height) ].

	band brickBounds: (band brickBounds translateBy: (0@ delta) negated).
]

{ #category : #scrolling }
GLMNewScrollListBrick >> scrollTo: anInteger [
	|brick index|
	index := (anInteger max: 0) min: self adaptor count.
	self band removeAllBricks.
	self band brickBounds: (self band brickBounds translateBy: (0@ self band brickBounds top negated)).
	visibleIndex := nil.
	brick := self getMorphAt: index  recycled: nil.
	brick brickBounds: (brick brickBounds withWidth: self band width).
	brick doLayout.
	
	brick brickBounds: ((0@(0 max: ((self height - brick height) / 2))) extent: brick extent).
	self band addBrickBack: brick.
	self update.
	scrollPosition := self band brickBounds top.
	self changed
	
	
	
	
]

{ #category : #scrolling }
GLMNewScrollListBrick >> scrollUp: anInteger [
	|delta|
	delta := anInteger.
	((self getIndex: self band firstSubbrick) = 1) ifTrue: [
		delta := delta min: (self band firstSubbrick brickBounds top - self band brickBounds origin y) ].
	
	self band brickBounds: (self band brickBounds translateBy: (0@ delta))
]

{ #category : #layouting }
GLMNewScrollListBrick >> setBoundsOf: aMorph after: afterMorph [
	
	aMorph brickBounds: (aMorph brickBounds withWidth: self band width).
	aMorph doLayout.
	aMorph brickBounds: (afterMorph brickBounds bottomLeft extent: aMorph extent)
]

{ #category : #layouting }
GLMNewScrollListBrick >> setBoundsOf: aMorph before: beforeMorph [
	|origin corner|
	
	aMorph brickBounds: (aMorph brickBounds withWidth: self band width).
	aMorph doLayout.
	
	corner := beforeMorph brickBounds topRight.
	origin  := beforeMorph brickBounds topLeft - (0@aMorph height).
	
	aMorph brickBounds: (origin corner: corner)
]

{ #category : #accessing }
GLMNewScrollListBrick >> setIndex: anInteger in: aBrick [ 

	aBrick setProperty: #brickScrollListIndex toValue: anInteger
]

{ #category : #scrolling }
GLMNewScrollListBrick >> update [

	self updateVisible.
	self band updateHeight.
	self preventOverscrolling.
	self verticalScrollbar update.
]

{ #category : #'lazy scrolling' }
GLMNewScrollListBrick >> updateVisible [
	|invisible|
	
	self adaptor ifNil: [ ^ self ].
	self adaptor count = 0 ifTrue: [ ^ self ].
	
	invisible := self gatherInvisibleItems.
	self updateVisibleTop: invisible.
	self updateVisibleBottom: invisible.
	
	invisible do: [ :each | self band removeBrick: each ].
	
	visibleIndex := self getIndex: self band firstSubbrick 
]

{ #category : #'lazy scrolling' }
GLMNewScrollListBrick >> updateVisibleBottom: invisibleBricks [
	|after|
	
	after := self band lastSubbrick.
	[ after isNotNil and: [ (self isPartiallyVisible: after) and: [ (self getIndex: after) < self adaptor count ] ] ] whileTrue: [
		after := self
			addItemMorph: (
				self
					getMorphAt: (self getIndex: after) + 1
					recycled: (self getAndRemoveInvisibleMorph: invisibleBricks))
			after: after ].
]

{ #category : #'lazy scrolling' }
GLMNewScrollListBrick >> updateVisibleTop: invisibleBricks [
	|before|
	
	before := self band hasSubbricks not
		ifFalse: [ self band firstSubbrick]
		ifTrue: [ self band addBrickBack: (self getMorphAt: self visibleIndex recycled: (self getAndRemoveInvisibleMorph: invisibleBricks)) ].
		
	[ before isNotNil and: [ (self isPartiallyVisible: before) and: [ (self getIndex: before) > 1 ] ] ] whileTrue: [
		before := self
			addItemMorph: (
				self
					getMorphAt: (self getIndex: before) - 1
					recycled: (self getAndRemoveInvisibleMorph: invisibleBricks))
			before: before  ]
	
]

{ #category : #accessing }
GLMNewScrollListBrick >> visibleIndex [

	^ visibleIndex ifNil: [ visibleIndex := 1 ]
]
