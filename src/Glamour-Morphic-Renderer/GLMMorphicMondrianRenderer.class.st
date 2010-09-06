Class {
	#name : #GLMMorphicMondrianRenderer,
	#superclass : #GLMMorphicWidgetRenderer,
	#category : #'Glamour-Morphic-Renderer'
}

{ #category : #private }
GLMMorphicMondrianRenderer >> mondrianCanvasFor: aPresentation in: aScrollPane [ 
	| canvas view |
	view := aPresentation view.
	view root interaction menu: [ :x | self menuIn: MenuMorph new for: aPresentation ].
	aPresentation renderOn: view.
	canvas := MOCanvas new.
	canvas root: view root.
	canvas initializeHanders.
	canvas announcer
			when: MOElementSelection
			do: [ :ann | aPresentation selection: ann element model ].
	canvas announcer
			when: MOMouseEnter
			do: [ :ann | aPresentation status: ann element model ].
	canvas announcer
			when: MOMouseLeave
			do: [ :ann | aPresentation status: nil ].
	aPresentation when: GLMPresentationUpdated do: [:ann |
		aPresentation view: MOViewRenderer new.
		aScrollPane scroller removeMorph: aScrollPane scroller submorphs first.
		self mondrianCanvasFor: aPresentation in: aScrollPane ].
	aPresentation when: GLMContextChanged do: [ :ann | 
			ann property = #selection ifTrue: [ 
				canvas selected: (canvas root deepFindNodeWithEntity: ann value) ] ].
	aScrollPane scroller addMorph: canvas.	

	^ canvas
]

{ #category : #rendering }
GLMMorphicMondrianRenderer >> render: aPresentation [
	| canvasScrollPane |
	canvasScrollPane := ScrollPane new.
	self mondrianCanvasFor: aPresentation  in: canvasScrollPane.
	canvasScrollPane
		color: Color white;
		vResizing: #spaceFill;
		hResizing: #spaceFill.
	^ canvasScrollPane
]
