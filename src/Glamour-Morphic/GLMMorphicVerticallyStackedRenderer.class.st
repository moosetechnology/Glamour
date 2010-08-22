Class {
	#name : #GLMMorphicVerticallyStackedRenderer,
	#superclass : #GLMMorphicCompositeRenderer,
	#category : #'Glamour-Morphic'
}

{ #category : #rendering }
GLMMorphicVerticallyStackedRenderer >> render: aPresentation [
	| presentations container |
	presentations := aPresentation matchingPresentations.
	presentations isEmpty ifTrue: [ ^ GLMMorphic emptyMorph ].	
	container := GLMMorphic emptyMorph.
	container changeTableLayout.
	presentations do: [ :each | 
		container addMorphBack: (renderer renderWithTitle: each) ].
	^ container
]
