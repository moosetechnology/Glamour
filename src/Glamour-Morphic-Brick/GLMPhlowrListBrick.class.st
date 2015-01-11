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
	
	self scrollList adaptor
		morphAtLogic: [ :index :morph | (aBlockOrSymbol value: (self entity at: index)) asBrick ]
]

{ #category : #phlowr }
GLMPhlowrListBrick >> entity [

	^ self scrollList adaptor origin
]

{ #category : #phlowr }
GLMPhlowrListBrick >> entity: anObject [

	self scrollList adaptor on: anObject
]

{ #category : #initialization }
GLMPhlowrListBrick >> initialize [
	super initialize.
		
	self
		layoutPolicy: GLMBrickVerticalFillProportionalLinearLayout new;
		titleBrick: self newTitleBrick;
		scrollList: self newScrollList
]

{ #category : #'instance creation' }
GLMPhlowrListBrick >> newScrollList [

	^ GLMScrollListBrick new
]

{ #category : #'instance creation' }
GLMPhlowrListBrick >> newTitleBrick [

	^ GLMLabelBrick new
]

{ #category : #accessing }
GLMPhlowrListBrick >> scrollList [

	^ scrollList
]

{ #category : #accessing }
GLMPhlowrListBrick >> scrollList: aBrick [

	scrollList := aBrick.
	
	self scrollList adaptor: GLMBrickListAdaptor new.
	self scrollList layoutProperties verticalPercent: 100.
	self addBrickBack: self scrollList
]

{ #category : #phlowr }
GLMPhlowrListBrick >> title: aString [

	self titleBrick text: aString
]

{ #category : #accessing }
GLMPhlowrListBrick >> titleBrick [
	^ titleBrick
]

{ #category : #accessing }
GLMPhlowrListBrick >> titleBrick: aBrick [

	titleBrick := aBrick.
	titleBrick
		textPosition: #center.
		
	titleBrick layoutProperties
		verticalPercent: 0;
		minHeight: 30.
	self addBrickBack: titleBrick
]
