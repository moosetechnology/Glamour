Class {
	#name : #GLMTurboHorizontalFillProportionalLinearLayout,
	#superclass : #GLMTurboHorizontalProportionalLinearLayout,
	#category : #'Glamour-Morphic-Widgets-Turbo-Layouts'
}

{ #category : #'as yet unclassified' }
GLMTurboHorizontalFillProportionalLinearLayout >> extentOf: aTrick in: owner [
	
	^ ((owner width * aTrick layoutParams horizontalPercent / 100) ceiling - aTrick layoutParams marginLeft - aTrick layoutParams marginRight) @ (owner height - aTrick layoutParams marginTop - aTrick layoutParams marginBottom)
]
