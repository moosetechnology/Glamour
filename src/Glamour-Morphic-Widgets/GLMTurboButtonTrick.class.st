Class {
	#name : #GLMTurboButtonTrick,
	#superclass : #GLMTurboLabelTrick,
	#category : #'Glamour-Morphic-Widgets-Turbo-UI'
}

{ #category : #'as yet unclassified' }
GLMTurboButtonTrick >> click [

	self announcer announce: (GLMTurboButtonClicked new data: self data).
	^ true
]

{ #category : #initialization }
GLMTurboButtonTrick >> initialize [
	super initialize.
	
	self label layoutParams paddingLeft: 5.
	self label layoutParams paddingRight: 2.
	self label position: #center.
	self dotsTrick layoutParams paddingRight: 0.
	
	self enable.
]

{ #category : #'as yet unclassified' }
GLMTurboButtonTrick >> press [
	super press.
	^ true.
]
