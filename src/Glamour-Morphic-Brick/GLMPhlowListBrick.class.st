Class {
	#name : #GLMPhlowListBrick,
	#superclass : #GLMPhlowBrick,
	#instVars : [
		'#scrollList => GLMPhlowSlot'
	],
	#category : #'Glamour-Morphic-Brick-Phlow'
}

{ #category : #examples }
GLMPhlowListBrick class >> example [
	
	^ GLMCompositeBrick exampleList
]

{ #category : #examples }
GLMPhlowListBrick class >> example2 [
	
	^ GLMCompositeBrick exampleListWithCustomItem
]

{ #category : #phlow }
GLMPhlowListBrick >> display: anObject [

	self setProperty: #phlowDisplay toValue: anObject
]

{ #category : #'as yet unclassified' }
GLMPhlowListBrick >> displayLogic [

	^ self valueOfProperty: #phlowDisplay ifAbsent: [ #yourself ]
]

{ #category : #phlow }
GLMPhlowListBrick >> entity: anObject [

	super entity: anObject.
	self setAdaptor
]

{ #category : #phlow }
GLMPhlowListBrick >> format: anObject [

	self setProperty: #phlowFormat toValue: anObject
]

{ #category : #accessing }
GLMPhlowListBrick >> formatLogic [

	^ self valueOfProperty: #phlowFormat ifAbsent: [ #yourself ]
]

{ #category : #initialization }
GLMPhlowListBrick >> initialize [
	super initialize.
		
	self listBrick: self newScrollList
]

{ #category : #accessing }
GLMPhlowListBrick >> listBrick [

	^ scrollList
]

{ #category : #accessing }
GLMPhlowListBrick >> listBrick: aBrick [

	scrollList := aBrick.
	self listBrick
		vSpaceFill;
		hSpaceFill.
		
	self addBrickBack: self listBrick
]

{ #category : #'instance creation' }
GLMPhlowListBrick >> newScrollList [

	^ GLMScrollListBrick new
]

{ #category : #'as yet unclassified' }
GLMPhlowListBrick >> setAdaptor [
	| adaptor |
	adaptor := (GLMBrickListAdaptor on: self entity)
		morphAtLogic: [ :index :morph |
			self styledLogic
				phlowValue: (self formatLogic phlowValue: (self displayLogic phlowValue: (self entity at: index))) asBrick ].
	self listBrick adaptor: adaptor
]

{ #category : #phlow }
GLMPhlowListBrick >> styled: anObject [
	
	self setProperty: #phlowStyled toValue: anObject
]

{ #category : #accessing }
GLMPhlowListBrick >> styledLogic [
	
	^ self valueOfProperty: #phlowStyled ifAbsent: [ #yourself ]
]