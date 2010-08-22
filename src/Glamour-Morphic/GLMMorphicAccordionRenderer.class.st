Class {
	#name : #GLMMorphicAccordionRenderer,
	#superclass : #GLMMorphicCompositeRenderer,
	#category : #'Glamour-Morphic'
}

{ #category : #rendering }
GLMMorphicAccordionRenderer >> render: aPresentation [
	| presentations container expander |
	presentations := aPresentation matchingPresentations.
	presentations isEmpty ifTrue: [ ^ GLMMorphic emptyMorph ].
	presentations size = 1 ifTrue: [ ^ renderer render: presentations first ].
	container := GLMMorphic emptyMorph.
	container changeTableLayout.
	presentations do: [ :each | 
		expander := renderer theme 
			newExpanderIn: container 
			label: (renderer titleOrIconOf: each in: container)
			forAll: {(renderer render: each)}.
		container addMorphBack: expander.
		(aPresentation pane lastActivePresentation notNil and: [
			each title = aPresentation pane lastActivePresentation title ]) ifTrue: [
				expander expanded: true]].
	(aPresentation pane lastActivePresentation isNil and: [container submorphs notEmpty]) ifTrue: [
		container submorphs first expanded: true].
	^ container
]
