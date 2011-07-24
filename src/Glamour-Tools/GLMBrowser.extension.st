Extension { #name : #GLMBrowser }

{ #category : #'*glamour-tools' }
GLMBrowser >> viewAnnouncements [

	| view |
	
	view := MOViewRenderer new.
	self viewAnnouncementsOn: view.
	view open
]

{ #category : #'*glamour-tools' }
GLMBrowser >> viewAnnouncementsOn: view [
	view shape rectangle withoutBorder.
	view node: 'Glamour' forIt: [
		self viewTreeOn: view ].
	view shape umlClassWithTitle: #yourself.
	view node: 'Announced objects' forIt: [
		view shape label text: [:p | (p class name removePrefix: 'GLM') removeSuffix: 'Renderer' ].
		view nodes: 
			(self pane withAllPanes flatCollect: [:each | 
			each glmSubscriptions collect: [:eachSub | eachSub subscriber]]) asSet.
		view shape label text: [:p | (p class name removePrefix: 'GLM') removeSuffix: 'Renderer' ].
		view nodes: 
			(self pane withAllPresentations flatCollect: [:each | 
			each glmSubscriptions collect: [:eachSub | eachSub subscriber]]) asIdentitySet.
		view verticalLineLayout ].
	
	view shape line 
			color: Color red twiceLighter;
			fromPositions: #(rightCenter);
			toPositions: #(leftCenter).
	view edges: self pane withAllPanes from: #yourself toAll: [:each | 
			each glmSubscriptions collect: [:eachSub | eachSub subscriber]].
	view shape line 
			color: Color red twiceLighter;
			fromPositions: #(rightCenter);
			toPositions: #(leftCenter).
	view edges: self pane withAllPresentations from: #yourself toAll: [:each | 
			each glmSubscriptions collect: [:eachSub | eachSub subscriber]].
	view horizontalLineLayout horizontalGap: 50
]

{ #category : #'*glamour-tools' }
GLMBrowser >> viewNestedOn: view [
	view shape umlClassWithTitle: #name.
	view nodes: self panes forEach: [:each |
		view node: each ports forIt: [
			view shape label text: #name.
			view nodes: each ports.
			view verticalLineLayout gapSize: 2 ].
		view node: each presentations forIt: [
			view shape umlClassWithTitle: [:eachPresentation | eachPresentation class name removePrefix: 'GLM'].
	"		view shape label text: [:p | (p class name removePrefix: 'GLM') removeSuffix: 'Presentation' ]."
			each presentations presentations do: [:eachPresentation | 
				eachPresentation viewNestedOn: view ].
			view verticalLineLayout gapSize: 2 ].
		view verticalLineLayout gapSize: 0; stretch ].
	view 
		edges: self transmissions 
		fromAll: #origins
		to: #destination
]

{ #category : #'*glamour-tools' }
GLMBrowser >> viewSketch [

	| view |
	
	view := MOViewRenderer new.
	self viewSketchOn: view.
	view openWithStatusbar
]

{ #category : #'*glamour-tools' }
GLMBrowser >> viewSketchOn: view [
	| simpleName viewBrowser allTransmissions inTransmission|
	simpleName := [ :each | (each class name removePrefix: 'GLM') removeSuffix: 'Presentation' ].
	allTransmissions := (self withAllPresentations select: [ :each | each isKindOf: GLMBrowser ]) flatCollect: #transmissions.
	inTransmission := [:port | allTransmissions anySatisfy: [:tr | (tr origins includes: port) or: [tr destination = port]]].
	viewBrowser := [ :browser | 
	view shape umlClassWithTitle: simpleName.
	view
		node: browser
		forIt: [ 
			view
				nodes: browser panes
				forEach: [ :inPane | 
					view nodes: (inPane ports select: inTransmission).
					view shape label text: simpleName.
					view
						nodes: inPane presentations presentations
						forEach: [ :inPresentation | 
							(inPresentation isKindOf: GLMBrowser)
								ifTrue: [ viewBrowser value: inPresentation ] ] ].
			((browser isKindOf: GLMTabulator) and: [ browser cell isSplitIntoRows ])
				ifTrue: [ view verticalLineLayout gapSize: 2 ] ] ].
	viewBrowser value: self.
	view shape line color: Color blue.
	view edges: allTransmissions fromAll: #origins to: #destination
]

{ #category : #'*glamour-tools' }
GLMBrowser >> viewTree [

	| view |
	
	view := MOViewRenderer new.
	self viewTreeOn: view.
	view openWithStatusbar
]

{ #category : #'*glamour-tools' }
GLMBrowser >> viewTreeOn: view [
	| edges1 edges2 edges3 edges4 |
	
	view shape umlClassWithTitle: #name.
	view nodes: self pane withAllPanes forEach: [ :each |
		view shape label text: #name.
		view nodes: each ports.
		view verticalLineLayout gapSize: 2 ].
	
	view shape label text: [:p | (p class name removePrefix: 'GLM') removeSuffix: 'Presentation' ].
	view nodes: self pane withAllPresentations.

	view shape verticalOrthogonalLine color: Color lightGray. 	
	edges1 := view edges: self pane withAllPanes from: #yourself to: [:each | each presentations ].

	view shape verticalOrthogonalLine color: Color lightGray. 
	edges2 := view edges: self pane withAllPanes from: #browser to: #yourself.

	view shape verticalOrthogonalLine color: Color lightGray. 
	edges3 := view edges: (self pane withAllPresentations select: [:each | each isKindOf: GLMDynamicPresentation]) from: #yourself to: #cachedPresentation.

	view shape verticalOrthogonalLine color: Color lightGray.
	edges4 := view edges: (self pane withAllPresentations select: [:each | each isKindOf: GLMCompositePresentation]) from: #yourself toAll: #presentations.


	view treeLayout layered userDefinedEdges: (edges1, edges2, edges3, edges4).

	view shape line color: Color blue. 
	view 
		edges: ((self pane withAllPresentations select: [:each | each isKindOf: GLMBrowser]) flatCollect: [:each | each transmissions])
		fromAll: #origins
		to: #destination.
		view shape line color: Color blue

]
