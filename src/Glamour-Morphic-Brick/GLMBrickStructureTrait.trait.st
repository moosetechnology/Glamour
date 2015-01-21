"
asd

"
Trait {
	#name : #GLMBrickStructureTrait,
	#category : #'Glamour-Morphic-Brick-Traits'
}

{ #category : #'brick-structure-adding/removing' }
GLMBrickStructureTrait >> addAllBricks: aCollection [

	aCollection do: [ :each | self addBrickBack: each ]
]

{ #category : #'brick-structure-adding/removing' }
GLMBrickStructureTrait >> addBrick: aBrick before: otherBrick [
	| brick link otherLink otherLinkPredeccessor |
	brick := aBrick asBrick.
	
	otherLink := otherBrick brickDoubleLink.
	otherLink = self firstSubbrick brickDoubleLink
		ifTrue: [ ^ self addBrickFirst: brick ].
		
	link := brick asDoubleLink.
	otherLinkPredeccessor := otherLink previousLink.
	otherLink previousLink: link.
	link nextLink: otherLink.
	link previousLink: otherLinkPredeccessor.
	otherLinkPredeccessor nextLink: link.
	
	self subbricks add: brick before: otherBrick.
	brick owner: self.
	
	^ aBrick
]

{ #category : #'brick-structure-adding/removing' }
GLMBrickStructureTrait >> addBrickBack: aBrick [
	|link brick|
	
	brick := aBrick asBrick.
	link := brick asDoubleLink.
	aBrick brickDoubleLink: link.
	
	self hasSubbricks ifTrue: [
		self lastSubbrick brickDoubleLink nextLink: link.	
		link previousLink: self lastSubbrick brickDoubleLink.
	].
	
	self subbricks add: brick.
	brick owner: self.
	
	^ aBrick
]

{ #category : #'brick-structure-adding/removing' }
GLMBrickStructureTrait >> addBrickFirst: aBrick [
	| link head tail brick|
	
	brick := aBrick asBrick.
	head := nil.
	tail := nil.
	self hasSubbricks ifTrue: [
		head := self firstSubbrick brickDoubleLink.
		tail := self lastSubbrick brickDoubleLink ].
	
	link := brick asDoubleLink.
	link nextLink: head.
	head ifNotNil: [ head previousLink: link ].
	
	self subbricks addFirst: brick.
	brick owner: self.
	
	^ aBrick
]

{ #category : #'brick-structure-converting' }
GLMBrickStructureTrait >> asBrick [
	^ self
]

{ #category : #'brick-structure-converting' }
GLMBrickStructureTrait >> asBrickedMorph [

	^ GLMFoundationBrick new brickRoot: self
]

{ #category : #'private-structure' }
GLMBrickStructureTrait >> brickDoubleLink [

	^ self valueOfProperty: #brickDoubleLink ifAbsentPut: [ nil ]
]

{ #category : #'private-structure' }
GLMBrickStructureTrait >> brickDoubleLink: aDoubleLink [

	self setProperty: #brickDoubleLink toValue: aDoubleLink
]

{ #category : #'brick-structure' }
GLMBrickStructureTrait >> brickRoot [

	^ self owner ifNotNil: [ self owner brickRoot ] ifNil: [ ^ self ]
]

{ #category : #'brick-structure' }
GLMBrickStructureTrait >> firstSubbrick [

	^ self subbricks first
]

{ #category : #'brick-structure-testing' }
GLMBrickStructureTrait >> hasSubbrick: aBrick [

	^ aBrick owner = self
]

{ #category : #'brick-structure-testing' }
GLMBrickStructureTrait >> hasSubbricks [

	^ self subbricks isEmpty not
]

{ #category : #'brick-structure-testing' }
GLMBrickStructureTrait >> isBrick [

	^ true
]

{ #category : #'brick-structure-testing' }
GLMBrickStructureTrait >> isFirstInOwner [

	^ self brickDoubleLink hasPredecessor not
]

{ #category : #'brick-structure-testing' }
GLMBrickStructureTrait >> isLastInOwner [

	^ self brickDoubleLink hasSuccessor not
]

{ #category : #'brick-structure' }
GLMBrickStructureTrait >> lastSubbrick [

	^ self subbricks last
]

{ #category : #'brick-structure-converting' }
GLMBrickStructureTrait >> morph [
	^ self
]

{ #category : #'brick-structure' }
GLMBrickStructureTrait >> owner [

	^ self explicitRequirement
]

{ #category : #'private-structure' }
GLMBrickStructureTrait >> owner: aBrick [

	^ self explicitRequirement
]

{ #category : #'brick-structure-adding/removing' }
GLMBrickStructureTrait >> removeAllBricks [

	self subbricks do: [:each |
		each brickDoubleLink: nil.
		each owner: nil ].
	self subbricks removeAll
]

{ #category : #'brick-structure-adding/removing' }
GLMBrickStructureTrait >> removeBrick: aBrick [
	| predecessor successor link head tail|
	
	link := aBrick brickDoubleLink.
	head := self firstSubbrick brickDoubleLink.
	tail := self lastSubbrick brickDoubleLink.
	
	predecessor := link previousLink.
	successor := link nextLink.
	predecessor
		ifNotNil: [ predecessor nextLink: successor ].
	successor
		ifNotNil: [ successor previousLink: predecessor ].
	link clearLinks.
	
	aBrick privateBrickDoubleLink: nil.
	
	self subbricks remove: aBrick.
	aBrick owner: nil.
	
	^ aBrick
]

{ #category : #'brick-structure' }
GLMBrickStructureTrait >> subbrickAfter [

	"Return the subbbrick after (behind) me, or nil"
	| link |
	link := self brickDoubleLink.
	link ifNil: [ ^ nil ].
	link nextLink ifNil: [ ^ nil ].
	^ link nextLink value
]

{ #category : #'brick-structure' }
GLMBrickStructureTrait >> subbrickBefore [

	"Return the subbrick before me, or nil"
	| link |
	link := self brickDoubleLink.
	link ifNil: [ ^ nil ].
	link previousLink ifNil: [ ^ nil ].
	^ link previousLink value
]

{ #category : #'brick-structure' }
GLMBrickStructureTrait >> subbricks [

	^ self explicitRequirement
]

{ #category : #'brick-structure' }
GLMBrickStructureTrait >> subbricksCount [

	^ self subbricks size
]
