Class {
	#name : #GLMMorphicStackerRenderer,
	#superclass : #GLMMorphicBrowserRenderer,
	#category : #'Glamour-Morphic'
}

{ #category : #rendering }
GLMMorphicStackerRenderer >> render: aBrowser [
	| tabs |
	aBrowser panes isEmpty ifTrue: [ ^ GLMMorphic emptyMorph ].
	tabs := LazyTabGroupMorph new.
	tabs
		vResizing: #spaceFill;
		hResizing: #spaceFill;
		cornerStyle: (self theme tabGroupCornerStyleIn: nil);
		font: self theme labelFont.
	aBrowser panes do: [ :each | 
		tabs 
			addLazyPage: [ self renderPaneWithoutTitle: each ]
			label: (self titleOrIconOf: each presentations in: tabs) ].
	tabs selectedPageIndex: 1.
	^ tabs
]
