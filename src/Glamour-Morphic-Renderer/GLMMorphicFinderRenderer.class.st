Class {
	#name : #GLMMorphicFinderRenderer,
	#superclass : #GLMMorphicBrowserRenderer,
	#category : #'Glamour-Morphic-Renderer'
}

{ #category : #rendering }
GLMMorphicFinderRenderer >> render: aBrowser [
	| container |
	container := GLMPaneScroller new
		name: 'scroller';
		vResizing: #spaceFill;
		hResizing: #spaceFill;
		yourself.
	aBrowser 
		when: GLMPaneRemoved
		do: [ :ann | container popPane.].
	aBrowser 
		when: GLMPaneAdded
		do: [ :ann | container pushPane: (self renderObject: ann pane) ].
	aBrowser 
		when: GLMPaneReplaced
		do: [ :ann | 
			container popAndReplacePane: (self renderObject: ann newPane) ].
	aBrowser panes
		do: [ :each | container pushPane: (self renderObject: each) ].
	^ container
]
