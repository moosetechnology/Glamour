Class {
	#name : #GLMMorphicTabbedRenderer,
	#superclass : #GLMMorphicCompositeRenderer,
	#category : #'Glamour-Morphic'
}

{ #category : #rendering }
GLMMorphicTabbedRenderer >> render: aPresentation [

	| presentations tabs index |
	presentations := aPresentation matchingPresentations.
	presentations isEmpty ifTrue: [ ^ GLMMorphic emptyMorph ].
	(presentations size = 1 and:[ presentations first hasTitleIcon not ])
	ifTrue: [ ^ renderer renderWithTitleOrNil: presentations first ].
	tabs := LazyTabGroupMorph new.
	tabs
		vResizing: #spaceFill;
		hResizing: #spaceFill;
		cornerStyle: (renderer theme tabGroupCornerStyleIn: nil);
		font: renderer theme labelFont;
		onPageIndexChange: [ :i | 
			aPresentation pane lastActivePresentation: (aPresentation matchingPresentations at: i) ].
	presentations do: [ :each | 
		tabs 
			addLazyPage: [ renderer render: each ]
			label: (renderer titleOrIconOf: each in: tabs) ].
	index := 1.
	presentations withIndexDo: [ :each :i | 
		aPresentation pane lastActivePresentation notNil and: [ 
			each title = aPresentation pane lastActivePresentation title ifTrue: [ 
				index := i ] ] ].
	tabs selectedPageIndex: index.
	aPresentation when: GLMPresentationUpdated do: [:ann |
		tabs clear.	
		presentations do: [ :each | 
			tabs 
				addLazyPage: [ renderer render: each ]
				label: (renderer titleOrIconOf: each in: tabs) ].
			index := 1.
			presentations withIndexDo: [ :each :i | 
				aPresentation pane lastActivePresentation notNil and: [ 
					each title = aPresentation pane lastActivePresentation title ifTrue: [ 
						index := i ] ] ].
		tabs selectedPageIndex: index.].

	^ tabs
]
