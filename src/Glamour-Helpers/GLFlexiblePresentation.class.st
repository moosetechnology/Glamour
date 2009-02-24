"
A presentation that flexibly changes it behavior depending on the current entity.

If the entity is a collection, this class renders as a ListPresentation, otherwise as a TextPresentation.
"
Class {
	#name : #GLFlexiblePresentation,
	#superclass : #GLFormatedPresentation,
	#category : #'Glamour-Presentations'
}

{ #category : #accessing }
GLFlexiblePresentation >> currentPresentation [
	
	^self displayValue isCollection
		ifTrue: [GLListPresentation new pane: self pane]
		ifFalse: [GLTextPresentation new pane: self pane]
]

{ #category : #rendering }
GLFlexiblePresentation >> renderGlamorouslyOn: aRenderer [
	
	^self currentPresentation renderGlamorouslyOn: aRenderer
]
