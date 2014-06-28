"
A GLMMorphicPagerRenderer is xxxxxxxxx.

"
Class {
	#name : #GLMMorphicPagerRenderer,
	#superclass : #GLMMorphicFinderRenderer,
	#category : #'Glamour-Morphic-Pager-Glamour'
}

{ #category : #callbacks }
GLMMorphicPagerRenderer >> actOnPaneAdded: ann [
	container pushPane: (self renderObject: ann pane).
]

{ #category : #callbacks }
GLMMorphicPagerRenderer >> actOnPaneRemoved: ann [
	container popPane
]

{ #category : #callbacks }
GLMMorphicPagerRenderer >> actOnPaneReplaced: ann [
	container popAndReplacePane: (self renderObject: ann newPane)
]

{ #category : #accessing }
GLMMorphicPagerRenderer >> defaultScrollButtonIconRenderBlock [

	^ [ :object | {Form new. Form new} ]
]

{ #category : #rendering }
GLMMorphicPagerRenderer >> render: aBrowser [
	|adapter|
	adapter := GLMPagerModel new.
	
	aBrowser scrollButtonIconRenderBlock ifNotNil: [
		"result value of the block is raw icon of the Form class"
		adapter scrollButtonIconRenderBlock: [ :index | aBrowser scrollButtonIconRenderBlock cull: ((aBrowser panes at: index) port: #entity) value ]
	].
	
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
