Class {
	#name : #GLMMorphicTabbedRenderer,
	#superclass : #GLMMorphicCompositeRenderer,
	#instVars : [
		'tabs'
	],
	#category : #'Glamour-Morphic-Renderer'
}

{ #category : #rendering }
GLMMorphicTabbedRenderer >> actOnPresentationUpdated: ann [
	| index presentations |
	presentations := ann presentation matchingPresentations.
	tabs pages size to: 1 by: -1 do: [ :i | tabs removePageIndex: i ].	
	presentations do: [ :each | 
		tabs 
			addLazyPage: [ self renderObject: each ]
			label: (self titleOrIconOf: each in: tabs)
			toolbar: (self renderToolbarForPresentation: each inMorph: tabs ) ].
	index := 1.
	presentations withIndexDo: [ :each :i | 
		ann presentation pane lastActivePresentation notNil and: [ 
			each title = ann presentation pane lastActivePresentation title ifTrue: [ 
				index := i ] ] ].
	tabs selectedPageIndex: index.
]

{ #category : #rendering }
GLMMorphicTabbedRenderer >> render: aPresentation [

	| presentations index |
	presentations := aPresentation matchingPresentations.
	presentations isEmpty ifTrue: [ ^ GLMMorphic emptyMorph ].
	(presentations size = 1 and: [ presentations first hasTitleIcon not ])
		ifTrue: [ ^ self renderWithTitleOrNil: presentations first ].
	tabs := LazyTabGroupMorph new.
	tabs
		vResizing: #spaceFill;
		hResizing: #spaceFill;
		cornerStyle: (self theme tabGroupCornerStyleIn: nil);
		font: self theme buttonFont.
	tabs announcer when: LazyTabPageChanged do: [:ann |
		aPresentation pane lastActivePresentation: (aPresentation matchingPresentations at: (ann pageIndex)) ].
	presentations do: [ :each | 
		tabs 
			addLazyPage: [ self renderObject: each ]
			label: (self titleOrIconOf: each in: tabs)
			toolbar: (self renderToolbarForPresentation: each inMorph: tabs ) ].
	index := 1.
	presentations withIndexDo: [ :each :i | 
		(aPresentation pane isLastActivePresentation: each) 
			ifTrue: [ index := i ] ].
	tabs selectedPageIndex: index.
	aPresentation on: GLMPresentationUpdated send: #actOnPresentationUpdated: to: self.
	^ tabs
]
