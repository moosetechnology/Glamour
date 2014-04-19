Class {
	#name : #GLMMorphicPagerFinderRenderer,
	#superclass : #GLMMorphicFinderRenderer,
	#category : #'Glamour-Morphic-Pager-Glamour'
}

{ #category : #'as yet unclassified' }
GLMMorphicPagerFinderRenderer >> actOnPaneAdded: ann [
	container pushPane: (self renderObject: ann pane).
]

{ #category : #'as yet unclassified' }
GLMMorphicPagerFinderRenderer >> actOnPaneRemoved: ann [
	container popPane
]

{ #category : #'as yet unclassified' }
GLMMorphicPagerFinderRenderer >> actOnPaneReplaced: ann [
	container popAndReplacePane: (self renderObject: ann newPane)
]

{ #category : #'as yet unclassified' }
GLMMorphicPagerFinderRenderer >> render: aBrowser [
	container := GLMPagerMorph new
		name: 'scroller';
		vResizing: #spaceFill;
		hResizing: #spaceFill;
		adapter: GLMPagerModel new;
		beTransparent;
		yourself.
	"container maxPanes: aBrowser fixedSizePanes."
	self registerAnnouncementsFor: aBrowser.  
	aBrowser panes
		do: [ :each | container pushPane: (self renderObject: each) ].
	^ container
]
