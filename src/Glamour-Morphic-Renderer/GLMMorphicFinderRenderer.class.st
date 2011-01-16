Class {
	#name : #GLMMorphicFinderRenderer,
	#superclass : #GLMMorphicBrowserRenderer,
	#category : #'Glamour-Morphic-Renderer'
}

{ #category : #rendering }
GLMMorphicFinderRenderer >> addMorphFromObject: anObject toContainer: aMorph [
	aMorph addMorphBack: ((self renderObject: anObject)
				vResizing: #spaceFill;
				hResizing: #shrinkWrap;
				yourself).
]

{ #category : #rendering }
GLMMorphicFinderRenderer >> render: aBrowser [
	^ self renderWithFixedPanes: aBrowser
]

{ #category : #rendering }
GLMMorphicFinderRenderer >> renderWithFixedPanes: aBrowser [
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

{ #category : #rendering }
GLMMorphicFinderRenderer >> renderWithVariablePanes: aBrowser [
	| container scrollPane |
	container := GLMMorphic emptyMorph.
	container 
		changeTableLayout;
		listDirection: #leftToRight;
		vResizing: #spaceFill;
		hResizing: #shrinkWrap.
	scrollPane := GeneralScrollPane new
		changeScrollerTableLayout;
		scrollTarget: container;
		yourself.
	aBrowser 
		when: GLMPaneRemoved
		do: [ :ann | container removeMorph: container submorphs last ].
	aBrowser 
		when: GLMPaneAdded
		do: [ :ann | 
			self addMorphFromObject: ann pane toContainer: container.
			scrollPane hScrollbar glmAnimateValue: 1.0 duration: 2000 ].
	aBrowser 
		when: GLMPaneReplaced
		do: [ :ann | 
			container removeMorph: container submorphs last.
			self addMorphFromObject: ann newPane toContainer: container.
			scrollPane hScrollbar glmAnimateValue: 1.0 duration: 200 ].
	aBrowser panes do: [ :each | self addMorphFromObject: each toContainer: container ].
	^ scrollPane
]
