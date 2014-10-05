Class {
	#name : #GLMTurboRoundCompositeButtonTrick,
	#superclass : #GLMTurboTrick,
	#instVars : [
		'buttons'
	],
	#category : #'Glamour-Morphic-Widgets-Turbo-UI'
}

{ #category : #'as yet unclassified' }
GLMTurboRoundCompositeButtonTrick >> addButton: aTrick [

	aTrick renderer: (GLMTurboRoundButtonRenderer new antialiasing: true; isRoundedRight: true; yourself).
	aTrick layoutParams marginBottom: 8.
	aTrick layoutParams marginTop: 8.
	
	self isEmpty
		ifTrue: [
			aTrick renderer isRoundedLeft: true.
		]
		ifFalse: [
			buttons last renderer isRoundedRight: false.
			buttons last changed.
		].

	buttons add: aTrick.
	self addTrickBack: aTrick.
	
	
]

{ #category : #'as yet unclassified' }
GLMTurboRoundCompositeButtonTrick >> buttons [
	^ buttons 
]

{ #category : #'as yet unclassified' }
GLMTurboRoundCompositeButtonTrick >> initialize [
	super initialize.
	
	self layoutManager: GLMTurboHorizontalFillProportionalLinearLayout new.
	
	buttons := OrderedCollection new.
]

{ #category : #'as yet unclassified' }
GLMTurboRoundCompositeButtonTrick >> isEmpty [
	
	^ buttons size = 0
]
