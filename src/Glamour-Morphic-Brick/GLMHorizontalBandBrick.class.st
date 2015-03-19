"
A GLMHorizontalBandBrick is a simple Brick with width and bounds to fit all subbricks.
Usually used within horizontal scroll panes
"
Class {
	#name : #GLMHorizontalBandBrick,
	#superclass : #GLMBrick,
	#category : #'Glamour-Morphic-Brick-Widgets-Core'
}

{ #category : #initialization }
GLMHorizontalBandBrick >> initialize [
	super initialize.
	
	self
		useHorizontalLinearLayout;
		hShrinkWrap
]
