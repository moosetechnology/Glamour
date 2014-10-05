"
A GLMTurboLayout is low level layout class providing api for positioning Tricks with specific order

"
Class {
	#name : #GLMTurboLayout,
	#superclass : #Object,
	#category : #'Glamour-Morphic-Widgets-Turbo-Layouts'
}

{ #category : #'as yet unclassified' }
GLMTurboLayout >> extentOf: aTrick in: owner [
	^ aTrick extent
]

{ #category : #accessing }
GLMTurboLayout >> position: aTrick [
	self subclassResponsibility
]
