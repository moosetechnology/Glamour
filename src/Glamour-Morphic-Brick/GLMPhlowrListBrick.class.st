Class {
	#name : #GLMPhlowrListBrick,
	#superclass : #GLMPhlowrBrick,
	#instVars : [
		'scrollList',
		'styleLogic'
	],
	#category : #'Glamour-Morphic-Brick-Phlowr'
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
GLMPhlowrListBrick >> display: aBlockOrSymbol [
	
	self listBrick adaptor
		morphAtLogic: [ :index :morph | self styled cull: (aBlockOrSymbol cull: (self entity at: index)) asBrick ]
]

{ #category : #phlowr }
GLMPhlowrListBrick >> entity: anObject [
	super entity: anObject.
	
	self listBrick adaptor on: anObject
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
GLMPhlowrListBrick >> styled [
	^ styleLogic ifNil: [ styleLogic := #yourself ]
]

{ #category : #phlowr }
GLMPhlowrListBrick >> styled: aBlockOrSymbol [
	styleLogic := aBlockOrSymbol
]
