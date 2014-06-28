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
	|adapter|
	adapter := GLMPagerModel new.
	adapter isClassIconShown ifTrue: [ adapter circleButtonIconRenderBlock: [ :index |
		| source |
		source := GLMForm scaleForm: ((aBrowser panes at: index) port: #entity) value class systemIcon to: (adapter circleButtonSize @ adapter circleButtonSize) / 1.6.
		GLMForm increaseFormExtentCentered: source to: (adapter circleButtonSize @ adapter circleButtonSize).
	] ].
	
	container := GLMPagerMorph new
		name: 'scroller';
		vResizing: #spaceFill;
		hResizing: #spaceFill;
		adapter: adapter;
		beTransparent;
		yourself.

	"container maxPanes: aBrowser fixedSizePanes."
	self registerAnnouncementsFor: aBrowser.  
	aBrowser panes
		do: [ :each | container pushPane: (self renderObject: each) ].
	^ container
]
