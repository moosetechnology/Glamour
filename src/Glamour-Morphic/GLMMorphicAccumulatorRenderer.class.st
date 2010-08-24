Class {
	#name : #GLMMorphicAccumulatorRenderer,
	#superclass : #GLMMorphicBrowserRenderer,
	#category : #'Glamour-Morphic'
}

{ #category : #rendering }
GLMMorphicAccumulatorRenderer >> render: aBrowser [

	| tabs |
	aBrowser panes isEmpty ifTrue: [ ^ GLMMorphic emptyMorph ].
"	presentations size = 1 ifTrue: [ 
		^ self morph: (self render: presentations first) withTitleOrNilOf: aCompositePresentation ].
"	tabs := LazyTabGroupMorph new.
	tabs
		vResizing: #spaceFill;
		hResizing: #spaceFill;
		cornerStyle: (self theme tabGroupCornerStyleIn: nil);
		font: self theme labelFont;
		onPageIndexChange: [ :i | 
			aBrowser activeEntity: ((aBrowser panes at: i) port: #entity) value ].
	aBrowser panes do: [ :each | 
		tabs 
			addLazyPage: [ self renderPaneWithoutTitle: each ]
			label: (self titleOrIconOf: each presentations in: tabs) ].
	aBrowser 
		when: GLMPaneSelected
		do: [ :ann | 
			tabs selectedPageIndex: ann position ].
	aBrowser 
		when: GLMPaneAdded
		do: [ :ann | 
			tabs addLazyPage: (self renderPaneWithoutTitle: ann pane) label: (self titleOrIconOf: ann pane presentations in: tabs).
			tabs selectedPageIndex: tabs lazyPages size ].
	tabs selectedPageIndex: tabs lazyPages size.
	^ tabs
]
