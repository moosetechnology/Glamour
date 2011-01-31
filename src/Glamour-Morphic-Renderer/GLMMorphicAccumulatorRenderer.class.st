Class {
	#name : #GLMMorphicAccumulatorRenderer,
	#superclass : #GLMMorphicBrowserRenderer,
	#category : #'Glamour-Morphic-Renderer'
}

{ #category : #rendering }
GLMMorphicAccumulatorRenderer >> render: aBrowser [
	| tabs |
	aBrowser panes isEmpty ifTrue: [ ^ GLMMorphic emptyMorph ].
	tabs := LazyTabGroupMorph new.
	tabs
		vResizing: #spaceFill;
		hResizing: #spaceFill;
		cornerStyle: (self theme tabGroupCornerStyleIn: nil);
		font: self theme labelFont.
	tabs announcer when: LazyTabPageChanged do: [:ann |  
		aBrowser activeEntity: ((aBrowser panes at: ann pageIndex) port: #entity) value ].
	tabs announcer when: LazyTabPageRemoved do: [:ann |  
		aBrowser removePaneIndex: ann pageIndex ].
	aBrowser panes do: [ :each | 
		self flag: 'add the toolbar of the each presentations'.
		tabs 
			addLazyPage: [ self renderPaneWithoutTitle: each ]
			label: (self titleOrIconOf: each presentations in: tabs)
			toolbar: (self renderToolbarForPresentation: each presentations inMorph: tabs )
			collapsable: true ].
	aBrowser 
		when: GLMPaneSelected
		do: [ :ann | 
			tabs selectedPageIndex: ann position ].
	aBrowser 
		when: GLMPaneAdded
		do: [ :ann | 
			tabs 
				addLazyPage: (self renderPaneWithoutTitle: ann pane) 
				label: (self titleOrIconOf: ann pane presentations in: tabs)
				toolbar: nil
				collapsable: true.
			tabs selectedPageIndex: tabs pages size ].
	tabs selectedPageIndex: tabs pages size.
	^ tabs
]
