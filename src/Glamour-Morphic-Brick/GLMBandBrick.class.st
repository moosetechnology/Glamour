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
	self heightBlock ifNotNil: [ ^ self heightBlock value: self ].
		
	height := self layoutProperties verticalMargin.
	self subbricks do: [ :each | height := height + each layoutProperties marginTop + each layoutProperties marginBottom + each height ].
	^ height
]

{ #category : #initialization }
GLMBandBrick >> initialize [
	super initialize.
	
	self layoutPolicy: GLMBrickVerticalFillLinearLayout new.
]
