"
A GLMBandBrick is a simple Brick with height and bounds to fit all subbricks.
Usually used within scroll panes

"
Class {
	#name : #GLMBandBrick,
	#superclass : #GLMBrick,
	#category : #'Glamour-Morphic-Brick-UI'
}

{ #category : #'as yet unclassified' }
GLMBandBrick >> doLayout [
	|mBounds mOwner|
	"most of the time you don't want to call this method manually"
	"nice example to check is GLMLabelBrick>>doLayout"
	
	mOwner := self owner ifNil: [ self ] ifNotNil: [ self owner ].
	mBounds := mOwner isBrick ifTrue: [ mOwner brickGlobalInnerBounds ] ifFalse: [ mOwner globalBounds ].
	
	self layoutPolicy layout: self in: mBounds.

	subbricks do: [ :each | each isBrick ifTrue: [ each doLayout ] ]
]

{ #category : #geometry }
GLMBandBrick >> height [
	|height|
	self heightBlock ifNotNil: [ ^ self heightBlock cull: self ].
		
	height := self layoutProperties verticalPadding.
	self subbricks do: [ :each | height := height + each height + each layoutProperties verticalMargin ].
	^ height
]

{ #category : #initialization }
GLMBandBrick >> initialize [
	super initialize.
	
	self layoutPolicy: GLMBrickVerticalFillLinearLayout new.
]
