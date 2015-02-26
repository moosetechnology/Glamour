Class {
	#name : #GLMRubTextAreaBrick,
	#superclass : #GLMRubEditingAreaBrick,
	#category : #'Glamour-Morphic-Brick-Widgets-Core'
}

{ #category : #initialization }
GLMRubTextAreaBrick >> initialize [
	super initialize.
	
	self rubricBackgroundColor: Color transparent
]

{ #category : #'instance creation' }
GLMRubTextAreaBrick >> newRubricMorph [

	^ super newRubricMorph
		beReadOnly;
		withoutAnyDecorator
]
