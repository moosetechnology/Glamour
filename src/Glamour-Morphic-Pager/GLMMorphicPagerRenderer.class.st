Class {
	#name : #GLMMorphicPagerRenderer,
	#superclass : #GLMMorphicFinderRenderer,
	#category : #'Glamour-Morphic-Pager-Glamour'
}

{ #category : #'as yet unclassified' }
GLMMorphicPagerRenderer >> actOnPaneAdded: ann [
	container pushPane: (self renderObject: ann pane).
]

{ #category : #'as yet unclassified' }
GLMMorphicPagerRenderer >> actOnPaneRemoved: ann [
	container popPane
]

{ #category : #'as yet unclassified' }
GLMMorphicPagerRenderer >> actOnPaneReplaced: ann [
	container popAndReplacePane: (self renderObject: ann newPane)
]

{ #category : #'as yet unclassified' }
GLMMorphicPagerRenderer >> render: aBrowser [
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
