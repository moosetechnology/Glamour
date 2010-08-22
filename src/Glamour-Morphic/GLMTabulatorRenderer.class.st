Class {
	#name : #GLMTabulatorRenderer,
	#superclass : #GLMBrowserRenderer,
	#category : #'Glamour-Morphic'
}

{ #category : #rendering }
GLMTabulatorRenderer >> render: aBrowser [
	| container |
	container := GLMMorphic emptyMorph.
	aBrowser cell isRow 
		ifTrue: 
			[ self 
				renderCustomRow: aBrowser cell
				ofPane: aBrowser pane
				inUI: container
				inBrowser: aBrowser ]
		ifFalse: 
			[ self 
				renderCustomColumn: aBrowser cell
				ofPane: aBrowser pane
				inUI: container
				inBrowser: aBrowser ].

	^ container
]

{ #category : #private }
GLMTabulatorRenderer >> renderCustomColumn: aCell ofPane: aPane inUI: aMorph inBrowser: aBrowser [ 
	| pane totalSpans currentSpanPosition currentOffset |
	totalSpans := aCell children inject: 0 into: [ :sum :each | sum + each span ].
	currentSpanPosition := 0.
	currentOffset := 0.
	aCell children keysAndValuesDo: [ :index :each | 
		each hasId 
			ifTrue: [ pane := self renderObject: (aBrowser paneNamed: each id) ]
			ifFalse: [ 
				self 
					renderCustomRow: each
					ofPane: aPane
					inUI: (pane := GLMMorphic emptyMorph)
					inBrowser: aBrowser.
				pane addPaneSplitters ].
		pane layoutFrame: (LayoutFrame new
					topFraction: currentSpanPosition / totalSpans offset: currentOffset + 2;
					leftFraction: 0 offset: 0;
					bottomFraction: (currentSpanPosition + each span) / totalSpans offset: currentOffset + each size - 2;
					rightFraction: 1 offset: 0;
					yourself).
		aMorph addMorphBack: pane.
		currentSpanPosition := currentSpanPosition + each span.
		currentOffset := currentOffset + each size ].
	(aCell children last size > 0) ifTrue: [
		(aMorph submorphs atLast: 2) layoutFrame bottomOffset: (aMorph submorphs atLast: 2) layoutFrame bottomOffset - aCell children last size. 
		aMorph submorphs last layoutFrame topOffset: aMorph submorphs last layoutFrame topOffset - aCell children last size. 
		aMorph submorphs last layoutFrame bottomOffset: aMorph submorphs last layoutFrame bottomOffset - aCell children last size.].
	aMorph addPaneSplitters
]

{ #category : #private }
GLMTabulatorRenderer >> renderCustomRow: aCell ofPane: aPane inUI: aMorph inBrowser: aBrowser [ 
	| pane totalSpans currentSpanPosition currentOffset |
	totalSpans := aCell children inject: 0 into: [ :sum :each | sum + each span ].
	currentSpanPosition := 0.
	currentOffset := 0.
	aCell children keysAndValuesDo: [ :index :each | 
		each hasId 
			ifTrue: [ pane := self renderObject: (aBrowser paneNamed: each id) ]
			ifFalse: [ self 
					renderCustomColumn: each
					ofPane: aPane
					inUI: (pane := GLMMorphic emptyMorph)
					inBrowser: aBrowser.
				pane addPaneSplitters ].
		pane layoutFrame: (LayoutFrame new
				topFraction: 0 offset: 0;
				leftFraction: currentSpanPosition / totalSpans offset: currentOffset + 2;
				bottomFraction: 1 offset: 0;
				rightFraction: (currentSpanPosition + each span) / totalSpans offset: currentOffset + each size - 2;
				yourself).
		aMorph addMorphBack: pane.
		currentSpanPosition := currentSpanPosition + each span.
		currentOffset := currentOffset + each size ].
	(aCell children last size > 0) ifTrue: [
		(aMorph submorphs atLast: 2) layoutFrame rightOffset: (aMorph submorphs atLast: 2) layoutFrame rightOffset - aCell children last size. 
		aMorph submorphs last layoutFrame leftOffset: aMorph submorphs last layoutFrame leftOffset - aCell children last size. 
		aMorph submorphs last layoutFrame rightOffset: aMorph submorphs last layoutFrame rightOffset - aCell children last size.].
	aMorph addPaneSplitters
]
