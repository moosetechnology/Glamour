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
GLMBandBrick >> height [
	|height|
	height := self layoutProperties verticalMargin.
	self subbricks do: [ :each | height := height + each layoutProperties marginTop + each layoutProperties marginBottom + each height ].
	^ height
]

{ #category : #'as yet unclassified' }
GLMBandBrick >> initialize [
	super initialize.
	
	self layoutPolicy: GLMBrickVerticalFillLinearLayout new.
]
