Class {
	#name : #GLMMorphicStackerRenderer,
	#superclass : #GLMMorphicBrowserRenderer,
	#category : #'Glamour-Morphic-Renderer'
}

{ #category : #rendering }
GLMMorphicStackerRenderer >> render: aBrowser [
	| tabs |
	aBrowser panes isEmpty
		ifTrue: [ ^ GLMMorphic emptyMorph ].
	tabs := LazyTabGroupMorph new.
	tabs
		vResizing: #spaceFill;
		hResizing: #spaceFill;
		cornerStyle: (Smalltalk ui icons tabGroupCornerStyleIn: nil);
		font: Smalltalk ui icons labelFont.
	aBrowser panes
		do: [ :each | 
			self flag: 'add toolbar'.
			tabs
				addLazyPage: [ GLMMorphicPaneWithoutTitleRenderer new render: each ]
				label: (self titleOrIconOf: each presentations in: tabs)
				toolbar: (self renderToolbarForPresentation: each presentations inMorph: tabs) ].
	tabs selectedPageIndex: 1.
	aBrowser on: GLMBrowserClosed send: #actOnBrowserClosed: to: self.
	^ tabs
]
