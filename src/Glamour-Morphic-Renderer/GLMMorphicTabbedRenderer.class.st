Class {
	#name : #GLMMorphicTabbedRenderer,
	#superclass : #GLMMorphicCompositeRenderer,
	#category : #'Glamour-Morphic-Renderer'
}

{ #category : #rendering }
GLMMorphicTabbedRenderer >> render: aPresentation [

	| presentations tabs index |
	presentations := aPresentation matchingPresentations.
	presentations isEmpty ifTrue: [ ^ GLMMorphic emptyMorph ].
	(presentations size = 1 and:[ presentations first hasTitleIcon not ])
	ifTrue: [ ^ self renderWithTitleOrNil: presentations first ].
	tabs := LazyTabGroupMorph new.
	tabs
		vResizing: #spaceFill;
		hResizing: #spaceFill;
		cornerStyle: (self theme tabGroupCornerStyleIn: nil);
		font: self theme labelFont;
		onPageIndexChange: [ :i | 
			aPresentation pane lastActivePresentation: (aPresentation matchingPresentations at: i) ].
	presentations do: [ :each | 
		tabs 
			addLazyPage: [ self renderObject: each ]
			label: (self titleOrIconOf: each in: tabs) ].
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
				addLazyPage: [ self renderObject: each ]
				label: (self titleOrIconOf: each in: tabs) ].
			index := 1.
			presentations withIndexDo: [ :each :i | 
				aPresentation pane lastActivePresentation notNil and: [ 
					each title = aPresentation pane lastActivePresentation title ifTrue: [ 
						index := i ] ] ].
		tabs selectedPageIndex: index.].

	^ tabs
]
