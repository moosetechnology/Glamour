Class {
	#name : #GLMMorphicExpanderRenderer,
	#superclass : #GLMMorphicBrowserRenderer,
	#category : #'Glamour-Morphic-Renderer'
}

{ #category : #rendering }
GLMMorphicExpanderRenderer >> render: aBrowser [
	| treeMorph treeModel |
	treeModel := GLMExpanderTreeMorphModel new glamourExpander: aBrowser.
	treeMorph := LazyMorphTreeMorph new.
	treeMorph
		makeLastColumnUnbounded;
		doubleClickSelector: #onDoubleClick;
		getMenuSelector: #menu:shifted:;
		keystrokeActionSelector: #keyStroke:from:;
		cornerStyle: treeMorph preferredCornerStyle;
		borderStyle: (BorderStyle inset width: 1);
		hResizing: #spaceFill;
		vResizing: #spaceFill;
		layoutFrame: (LayoutFrame fractions: (0 @ 0 corner: 1 @ 1));
		preferedPaneColor: Color white;	
		model: treeModel;
		nodeListSelector: #roots;
		columns: ( OrderedCollection with: ( MorphTreeColumn new rowMorphGetSelector: #elementColumn )).
	treeMorph vShowScrollBar.
	^ treeMorph buildContents
]
