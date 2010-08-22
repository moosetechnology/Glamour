Class {
	#name : #GLMMorphicTreeRenderer,
	#superclass : #GLMMorphicListingRenderer,
	#category : #'Glamour-Morphic'
}

{ #category : #rendering }
GLMMorphicTreeRenderer >> render: aPresentation [
	| container |
	container := super render: aPresentation.
	aPresentation shouldAllExpand ifTrue: [container submorphs first expandAll ].
	aPresentation shouldRootsExpand ifTrue: [container submorphs first expandRoots ].
	^ container
]
