Class {
	#name : #GLMMorphicFinderRenderer,
	#superclass : #GLMMorphicBrowserRenderer,
	#category : #'Glamour-Morphic-Renderer'
}

{ #category : #rendering }
GLMMorphicFinderRenderer >> addMorphFromObject: anObject toContainer: aContainerMorph [
	| renderedMorph |
	renderedMorph := (self renderObject: anObject)
				vResizing: #spaceFill;
				hResizing: #rigid;
				minimumExtent: 200@10;
				extent: 200@10;
				yourself.
	aContainerMorph addMorphBack: renderedMorph.
	aContainerMorph addMorphBack: (EdgeGripMorph new
		width: ProportionalSplitterMorph splitterWidth;
		hResizing: #rigid; "not the default this time, vResizing is also #spaceFill by default"
		target: renderedMorph)
]

{ #category : #rendering }
GLMMorphicFinderRenderer >> render: aBrowser [
	^ aBrowser fixedSize 
		ifTrue: [self renderWithFixedPanes: aBrowser]
		ifFalse: [self renderWithVariablePanes: aBrowser ]
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
