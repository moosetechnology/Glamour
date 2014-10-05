Class {
	#name : #GLMTurboVerticalFillLinearLayout,
	#superclass : #GLMTurboVerticalLinearLayout,
	#category : #'Glamour-Morphic-Widgets-Turbo-Layouts'
}

{ #category : #'as yet unclassified' }
GLMTurboVerticalFillLinearLayout >> extentOf: aTrick in: owner [

	^ (owner width - aTrick layoutParams marginLeft - aTrick layoutParams marginRight) @ (aTrick height)
]
