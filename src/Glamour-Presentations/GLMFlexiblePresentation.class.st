"
A presentation that flexibly changes it behavior depending on the current entity.

If the entity is a collection, this class renders as a ListPresentation, otherwise as a TextPresentation.
"
Class {
	#name : #GLMFlexiblePresentation,
	#superclass : #GLMFormatedPresentation,
	#category : #'Glamour-Presentations'
}

{ #category : #accessing }
GLMFlexiblePresentation >> currentPresentation [ 
	 
	^ (self displayValue isCollection and: [self displayValue isString not])
		ifTrue: [GLMListPresentation new pane: self pane]
		ifFalse: [GLMTextPresentation new pane: self pane]
]

{ #category : #rendering }
GLMFlexiblePresentation >> renderGlamorouslyOn: aRenderer [ 
	 
	^self currentPresentation renderGlamorouslyOn: aRenderer
]
