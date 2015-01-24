"
asdasds
"
Class {
	#name : #GLMPhlowrListBrick,
	#superclass : #GLMPhlowrBrick,
	#instVars : [
		'#scrollList => GLMPhlowSlot'
	],
	#category : #'Glamour-Morphic-Brick-Phlow'
}

{ #category : #examples }
GLMPhlowrListBrick class >> example [
	
	^ GLMCompositeBrick exampleList
]

{ #category : #examples }
GLMPhlowrListBrick class >> example2 [
	
	^ GLMCompositeBrick exampleListWithCustomItem
]

{ #category : #phlowr }
GLMPhlowrListBrick >> display: anObject [
	
	self listBrick adaptor
		morphAtLogic: [ :index :morph | self styledLogic phlowValue: (self formatLogic phlowValue: (anObject phlowValue: (self entity at: index))) asBrick ]
]

{ #category : #phlowr }
GLMPhlowrListBrick >> entity: anObject [
	super entity: anObject.
	
	self listBrick adaptor on: anObject
]

{ #category : #phlowr }
GLMPhlowrListBrick >> format: anObject [

	self setProperty: #phlowFormat toValue: anObject
]

{ #category : #accessing }
GLMPhlowrListBrick >> formatLogic [

	^ self valueOfProperty: #phlowFormat ifAbsent: [ #yourself ]
]

{ #category : #initialization }
GLMPhlowrListBrick >> initialize [
	super initialize.
		
	self listBrick: self newScrollList
]

{ #category : #accessing }
GLMPhlowrListBrick >> listBrick [

	^ scrollList
]

{ #category : #accessing }
GLMPhlowrListBrick >> listBrick: aBrick [

	scrollList := aBrick.
	
	self listBrick adaptor: GLMBrickListAdaptor new.
	self listBrick layoutProperties vSpaceFill.
	self addBrickBack: self listBrick
]

{ #category : #'instance creation' }
GLMPhlowrListBrick >> newScrollList [

	^ GLMScrollListBrick new
]

{ #category : #phlowr }
GLMPhlowrListBrick >> styled: anObject [
	
	self setProperty: #phlowStyled toValue: anObject
]

{ #category : #accessing }
GLMPhlowrListBrick >> styledLogic [
	
	^ self valueOfProperty: #phlowStyled ifAbsent: [ #yourself ]
]
