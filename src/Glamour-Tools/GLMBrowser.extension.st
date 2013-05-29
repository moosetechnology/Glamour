Extension { #name : #GLMBrowser }

{ #category : #'*glamour-tools' }
GLMBrowser >> openTree [
	| composer |
	composer := GLMCompositePresentation new.
	composer 
		act: [:b | b update] 
		icon: GLMUIThemeExtraIcons glamorousRefresh 
		entitled: 'Update'.
	composer tabulator with: [:t | 
		t column: #theOne.
		t transmit to: #theOne; andShow: [:a | 
			a roassal 
				updateOn: GLMTransmissionTriggered from: [ self announcer ];
				painting: [:view :b | self viewTreeOn: view ] ]].
	composer openOn: self
]

{ #category : #'*glamour-tools' }
GLMBrowser >> screenshot: aFilenameString on: anObject after: aBlock [
	 
	| window |
	window := self openOn: anObject.
	aBlock glamourValue: self asGlamorousMultiValue.
	World doOneCycle.
	PNGReadWriter putForm: window imageForm onFileNamed: aFilenameString.
	^ window
]

{ #category : #'*glamour-tools' }
GLMBrowser >> umlClassWithTitle: umlName view: view nodes: aNodes forEach: aOneArgForEachBlock [

	self 
		umlClassWithTitle: umlName 
		view: view 
		nodes: aNodes 
		forEachInstanceVariable: [:e | e]
		methods: aOneArgForEachBlock
]

{ #category : #'*glamour-tools' }
GLMBrowser >> umlClassWithTitle: umlName view: view nodes: aNodes 
forEachInstanceVariable: aOneArgForEachBlock1 methods: aOneArgForEachBlock2 [

	view shape rectangle color: Color white.
	view extensibleSizeWithPaddingGap: 0. 
	view nodes: aNodes forEach: [ :eachNode |
		view interaction 
				nodraggable;
				forward: ROAbstractMouseDragging;
				forward: ROMouseClick.
		view interaction popupText.
		view shape centeredLabel text: umlName.
		view node: eachNode.

		view interaction 
				nodraggable;
				forward: ROAbstractMouseDragging;
				forward: ROMouseClick.
		view shape rectangle.
		view nodes: (Array with: eachNode) forEach: aOneArgForEachBlock1.

		view interaction 
				nodraggable;
				forward: ROAbstractMouseDragging;
				forward: ROMouseClick.
		view shape rectangle color: Color white.
		view nodes: (Array with: eachNode) forEach: aOneArgForEachBlock2.
		
		view verticalLineLayout
				gapSize: 0;
				on: ROLayoutBegin
				do: [ :event | | maxWidth |
						maxWidth := event elements maxValue: #width. 
						event elements do: [ :eachElement | 
								eachElement width: maxWidth ] ];
				on: ROLayoutEnd
				do: [ :event | | strategy |
						strategy := ROFixedSizedParent new paddingGap: 0.
						event elements do: [ :eachElement |
								eachElement resizeStrategy: strategy ] ]
	].
]

{ #category : #'*glamour-tools' }
GLMBrowser >> viewAnnouncements [
	| view |
	view := ROMondrianViewBuilder new.
	self viewAnnouncementsOn: view.
	^ view open setLabel: 'Announcements'
]

{ #category : #'*glamour-tools' }
GLMBrowser >> viewAnnouncementsOn: view [
	view shape rectangle withoutBorder.
	view node: 'Glamour' forIt: [
		self viewTreeOn: view ].
	self umlClassWithTitle: #yourself view: view nodes: (Array with: 'Announced objects') forEach: [ :eachNode |
		view interaction
				nodraggable;
				forward: ROAbstractMouseDragging.
		view shape label text: [:p | (p class name removePrefix: 'GLM') removeSuffix: 'Renderer' ].
		view nodes: 
			(self pane withAllPanes flatCollect: [:each | 
			each glmSubscriptions collect: [:eachSub | eachSub subscriber]]) asSet.
		view interaction
				nodraggable;
				forward: ROAbstractMouseDragging.
		view shape label text: [:p | (p class name removePrefix: 'GLM') removeSuffix: 'Renderer' ].
		view nodes: 
			(self pane withAllPresentations flatCollect: [:each | 
			each glmSubscriptions collect: [:eachSub | eachSub subscriber]]) asIdentitySet.
		view verticalLineLayout ].
	
	view shape line 
			color: Color red twiceLighter;
			attachPoint: (ROHorizontalAttachPoint new).
	view edges: self pane withAllPanes from: #yourself toAll: [:each | 
			each glmSubscriptions collect: [:eachSub | eachSub subscriber]].
	view shape line 
			color: Color red twiceLighter;
			attachPoint: (ROHorizontalAttachPoint new).
	view edges: self pane withAllPresentations from: #yourself toAll: [:each | 
			each glmSubscriptions collect: [:eachSub | eachSub subscriber]].
	view horizontalLineLayout horizontalGap: 50
]

{ #category : #'*glamour-tools' }
GLMBrowser >> viewNestedOn: view [

	self 
		umlClassWithTitle: #name 
		view: view 
		nodes: self panes 
		forEachInstanceVariable: [ :each |
			view interaction
					nodraggable;
					forward: ROAbstractMouseDragging.
			view shape label text: #name.
			view nodes: each ports.
			view verticalLineLayout gapSize: 2 ]
		methods: [ :each | 
			each presentations presentations do: [:eachPresentation | 
				eachPresentation viewNestedOn: view ].
			view verticalLineLayout gapSize: 2 ].
	view 
		edges: self transmissions 
		fromAll: #origins
		to: #destination
]

{ #category : #'*glamour-tools' }
GLMBrowser >> viewSketch [

	| view |
	
	view := ROMondrianViewBuilder new.
	self viewSketchOn: view.
	^ view openWithStatusbar setLabel: 'Sketch'
]

{ #category : #'*glamour-tools' }
GLMBrowser >> viewSketchOn: view [
	| simpleName viewBrowser allTransmissions inTransmission|
	simpleName := [ :each | (each class name removePrefix: 'GLM') removeSuffix: 'Presentation' ].
	allTransmissions := (self withAllPresentations select: [ :each | each isKindOf: GLMBrowser ]) flatCollect: #transmissions.
	inTransmission := [:port | allTransmissions anySatisfy: [:tr | (tr origins includes: port) or: [tr destination = port]]].
	viewBrowser := [ :browser | 
		self umlClassWithTitle: simpleName view: view nodes: (Array with: browser) forEach: [ :each |
			view interaction
					nodraggable;
					forward: ROAbstractMouseDragging.
			view
				nodes: browser panes
				forEach: [ :inPane | 
					view interaction
							nodraggable;
							forward: ROAbstractMouseDragging.
					view nodes: (inPane ports select: inTransmission).
					view interaction
							nodraggable;
							forward: ROAbstractMouseDragging.
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
	
	view := ROMondrianViewBuilder new.
	self viewTreeOn: view.
	^ view openWithStatusbar setLabel: 'Tree'
]

{ #category : #'*glamour-tools' }
GLMBrowser >> viewTreeOn: view [
	| edges1 edges2 edges3 edges4 |
	
	self umlClassWithTitle: #name view: view nodes: self pane withAllPanes forEach: [ :each |
		view interaction
				nodraggable;
				forward: ROAbstractMouseDragging.
		view shape label text: #name.
		view nodes: each ports.
		view verticalLineLayout gapSize: 2 ].

	view shape label text: [:p | (p class name removePrefix: 'GLM') removeSuffix: 'Presentation' ].
	view nodes: self pane withAllPresentations.

	view shape orthoVerticalLine color: Color lightGray. 	
	edges1 := view edges: self pane withAllPanes from: #yourself to: [:each | each presentations ].

	view shape orthoVerticalLine color: Color lightGray. 
	edges2 := view edges: self pane withAllPanes from: #browser to: #yourself.

	view shape orthoVerticalLine color: Color lightGray. 
	edges3 := view edges: (self pane withAllPresentations select: [:each | each isKindOf: GLMDynamicPresentation]) from: #yourself to: #cachedPresentation.

	view shape orthoVerticalLine color: Color lightGray.
	edges4 := view edges: (self pane withAllPresentations select: [:each | each isKindOf: GLMCompositePresentation]) from: #yourself toAll: #presentations.


	view treeLayout layered userDefinedEdges: (edges1, edges2, edges3, edges4).

	view shape line color: Color blue. 
	view 
		edges: ((self pane withAllPresentations select: [:each | each isKindOf: GLMBrowser]) flatCollect: [:each | each transmissions])
		fromAll: #origins
		to: #destination.
		view shape line color: Color blue

]
