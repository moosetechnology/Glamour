Class {
	#name : #GLMMorphicTableRenderer,
	#superclass : #GLMMorphicListingRenderer,
	#category : #'Glamour-Morphic-Renderer'
}

{ #category : #'as yet unclassified' }
GLMMorphicTableRenderer >> newTreeMorph [
	^ GLMPaginatedResizableMorphTreeMorph new.
]

{ #category : #'as yet unclassified' }
GLMMorphicTableRenderer >> render: aPresentation [
	| container |
	container := super render: aPresentation.
	"aPresentation shouldAllExpand ifTrue: [treeMorph expandAll ]."
	aPresentation shouldRootsExpand ifTrue: [treeMorph expandRoots . treeMorph makeLastColumnBounded ].
	"aPresentation shouldExpandToLevel ifTrue: [ treeMorph expandAllTo: aPresentation expandLevel ]."
	^ container
]
