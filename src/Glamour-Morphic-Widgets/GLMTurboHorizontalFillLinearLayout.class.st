Class {
	#name : #GLMTurboHorizontalFillLinearLayout,
	#superclass : #GLMTurboHorizontalLinearLayout,
	#category : #'Glamour-Morphic-Widgets-Turbo-Layouts'
}

{ #category : #'as yet unclassified' }
GLMTurboHorizontalFillLinearLayout >> extentOf: aTrick in: owner [

	^ (aTrick width) @ (owner height - aTrick layoutParams marginTop - aTrick layoutParams marginBottom)
]
