Class {
	#name : #GLMPhlowrListBrick,
	#superclass : #GLMBrick,
	#instVars : [
		'titleBrick',
		'scrollList'
	],
	#category : #'Glamour-Morphic-Brick-Phlowr'
}

{ #category : #phlowr }
GLMPhlowrListBrick >> display: aBlockOrSymbol [
	
	self listBrick adaptor
		morphAtLogic: [ :index :morph | (aBlockOrSymbol value: (self entity at: index)) asBrick ]
]

{ #category : #phlowr }
GLMPhlowrListBrick >> entity [

	^ self listBrick adaptor origin
]

{ #category : #phlowr }
GLMPhlowrListBrick >> entity: anObject [

	self listBrick adaptor on: anObject
]

{ #category : #initialization }
GLMPhlowrListBrick >> initialize [
	super initialize.
		
	self
		layoutPolicy: GLMBrickVerticalFillProportionalLinearLayout new;
		titleBrick: self newTitleBrick;
		listBrick: self newScrollList
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

{ #category : #'instance creation' }
GLMPhlowrListBrick >> newTitleBrick [

	^ GLMLabelBrick new
]

{ #category : #phlowr }
GLMPhlowrListBrick >> title: aString [

	self titleBrick text: aString.
	
	titleBrick layoutProperties staticHeight: (
		aString isEmpty
			ifFalse: [ 30 ]
			ifTrue: [ 0 ])
]

{ #category : #accessing }
GLMPhlowrListBrick >> titleBrick [
	^ titleBrick
]

{ #category : #accessing }
GLMPhlowrListBrick >> titleBrick: aBrick [

	titleBrick := aBrick.
	titleBrick textPosition: #center.
	titleBrick layoutProperties staticHeight: 0.
	self addBrickBack: titleBrick
]
