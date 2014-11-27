"
A GLMBandBrick is a simple Brick with height and bounds to fit all subbricks.
Usually used within scroll panes

"
Class {
	#name : #GLMBandBrick,
	#superclass : #GLMBrick,
	#category : #'Glamour-Morphic-Brick-UI'
}

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
