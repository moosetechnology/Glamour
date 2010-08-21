Class {
	#name : #SGLRenderer,
	#superclass : #Object,
	#instVars : [
		'component',
		'html',
		'uuid',
		'scripts'
	],
	#category : #'Glamour-Seaside-Core'
}

{ #category : #'instance-creation' }
SGLRenderer class >> in: aComponent on: html [
	^ self basicNew initializeIn: aComponent on: html
]

{ #category : #accessing }
SGLRenderer >> html [
	^ html
]

{ #category : #initialization }
SGLRenderer >> initialize [
	super initialize.
	uuid := IdentityDictionary new.
	"properties := IdentityDictionary new."
	scripts := GRSmallDictionary new
]

{ #category : #initialization }
SGLRenderer >> initializeIn: aComponent on: aRenderer [
	self initialize.
	component := aComponent.
	html := aRenderer
]

{ #category : #dispatching }
SGLRenderer >> render: aRenderable [
	aRenderable renderGlamorouslyOn: self
]

{ #category : #dispatching }
SGLRenderer >> render: aRenderable on: aRenderer [
	html := aRenderer.
	aRenderable renderGlamorouslyOn: self
]

{ #category : #presentation }
SGLRenderer >> renderAccordionCompositePresentation: aCompositePresentation [
	| presentations index |
	presentations := aCompositePresentation matchingPresentations.
	presentations isEmpty ifTrue: [ ^ self renderEmptyPresentation ].
	presentations size = 1 ifTrue: [ ^ self renderWithTitleOrNil: presentations first ].
	
	index := 1.
	presentations withIndexDo: [ :each :i | 
		aCompositePresentation pane lastActivePresentation notNil and: [ 
			each title = aCompositePresentation pane lastActivePresentation title ifTrue: [ index := i ] ] ].
	html div
		class: 'accordion-arrangement';
  	      script: (html jQuery new accordion animated: false; clearStyle: true; active: index-1);
   	      with: [
         		presentations withIndexDo: [ :each :i | 
				html div: [ 
					html anchor: each titleValue. 
					self renderActionsFrom: each on: html ].
				html div: [ self render: each ] ] ]
]

{ #category : #widgets }
SGLRenderer >> renderAccumulator: aBrowser [
	|panes|
	panes := aBrowser panes.
	panes isEmpty ifTrue: [ ^ self renderEmptyPresentation ].
	aBrowser 
		when: GLMPaneAdded
		do: [ :ann | self renderAccumulator: aBrowser addPane: ann pane ].
	aBrowser 
		when: GLMPaneSelected
		do: [ :ann | self renderAccumulator: aBrowser selectPaneAt: ann position ].
	html div
		id: (self uuidFor: aBrowser);
		class: 'accumulator';
		script: ( html jQuery this glamourTabs  
			cache: true; 
			hasActions: true;
			closable: true;
			onRemove: (html jQuery ajax
				callbackTabs: [:event|
					aBrowser removePaneIndex: (event at: #index) + 1];
				script: [: script | self updateScript: script ]);
			onSelect: (html jQuery ajax 
				callbackTabs: [ :event | 
    	  	      		aBrowser activeEntity: ((aBrowser panes at: (event at: #index) + 1) port: #entity) value ];
				script: [: script | self updateScript: script ]) );
		with: [
			html unorderedList: [
				aBrowser panes withIndexDo: [ :each :i |
					self renderAccumulator: aBrowser pane: each at: i] ] ]
]

{ #category : #widgets }
SGLRenderer >> renderAccumulator: aBrowser addPane: aPane [
	|tabs|
	self flag: 'There must be a better way to give the html to add:label:action: bellow '.
	tabs := (html jQuery id: (self uuidFor: aBrowser)).
	self scriptFor: aBrowser add: ( 
		(tabs glamourTabs 
			add: (html jQuery ajax
						html: [ :renderer | 
							html := renderer.										
							self renderPaneWithoutTitle: aPane ];
						fullUrl) 			 
			label: [ :aRenderer | self renderTitleOrIconOf: aPane presentations on: aRenderer ]
			actions: (html jQuery new render: [:aRenderer| 
				aRenderer listItem
						class: 'glm-actions';
						style: 'display: none;';
						with: [ self renderActionsFrom: aPane presentations on: aRenderer ]  ])),
		(tabs glamourTabs select: aBrowser panes size-1) ).

]

{ #category : #widgets }
SGLRenderer >> renderAccumulator: aBrowser pane: aPane at: index [
	html listItem
		class: 'ui-tabs-selected' if: aBrowser panes size = index;  
		with: [ 
			html anchor
				url: (html jQuery ajax
					html: [ :renderer | 
						html := renderer.										
						self renderPaneWithoutTitle: aPane ];
					fullUrl);
				with: [ self renderTitleOrIconOf: aPane presentations on: html ] ].
	html listItem
		class: 'glm-actions';
		style: 'display: none;';
		with: [ self renderActionsFrom: aPane presentations on: html ]
	

]

{ #category : #widgets }
SGLRenderer >> renderAccumulator: aBrowser selectPaneAt: index [
	self scriptFor: aBrowser add:  (
		 (html jQuery id: (self uuidFor: aBrowser)) tabs select: index-1 ).
]

{ #category : #presentation }
SGLRenderer >> renderActionListPresentation: anActionListPresentation [ 
	self flag: 'To implement'.
	self renderEmptyPresentation 
]

{ #category : #widgets }
SGLRenderer >> renderActionsFrom: aPresentation on: aRenderer [
	aRenderer render: (SGLActionPresenter for: aPresentation with: self) 
]

{ #category : #widgets }
SGLRenderer >> renderEmptyPresentation [
	html div
		class: 'ui-widget';
		class: 'ui-widget-content';
		class: 'ui-corner-all';
		class: 'glm-empty-presentation'
]

{ #category : #widgets }
SGLRenderer >> renderFinder: aBrowser [
   |container|
	aBrowser 
		when: GLMPaneRemoved
		do: [ :ann | self renderFinder: ann browser removePane: ann pane ].
	aBrowser
		when: GLMPaneAdded
		do: [ :ann | self renderFinder: ann browser addPane: ann pane ].
		
	html div
		id: (self uuidFor: aBrowser); 
		class: 'ui-widget'; class: 'finder';
		with: [
			aBrowser panes 
				do: [ :each | self renderFinder: aBrowser pane: each ] ] .
]

{ #category : #widgets }
SGLRenderer >> renderFinder: aBrowser addPane: aPane [
	self scriptFor: aBrowser add: ((html jQuery id: (self uuidFor: aBrowser))
		append: [ :r | html := r. self renderFinder: aBrowser pane: aPane ]).
	self scriptFor: aBrowser add: ( ( html jQuery id: (self uuidFor: aBrowser) ) glamourScrollTo target: ( '#', (self uuidFor: aPane) ) ) 
]

{ #category : #widgets }
SGLRenderer >> renderFinder: aBrowser pane: aPane [
	html div
		class: 'finder-pane ui-widget ui-widget-content';
		id: (self uuidFor: aPane);
		with: [ self render: aPane ]
]

{ #category : #widgets }
SGLRenderer >> renderFinder: aBrowser removePane: aPane [
	self scriptFor: aBrowser add: ((html jQuery id: (self uuidFor: aBrowser))
		contents;
		filter: ':last';
		remove)
]

{ #category : #presentation }
SGLRenderer >> renderLabelPresentation: aLabelPresentation [ 
	self flag: 'To implement'.
	self renderEmptyPresentation
	
]

{ #category : #presentation }
SGLRenderer >> renderListPresentation: aPresentation [
	|model|
	model := SGLTreeModel new.
	model glamourPresentation: aPresentation.
	self renderListingPresentation: model
]

{ #category : #presentation }
SGLRenderer >> renderListingPresentation: aPresentationModel [
	|aPresentation treePresenter|
	aPresentation := aPresentationModel glamourPresentation.
	treePresenter := (SGLTreePresenter for:  aPresentationModel with: self).
	treePresenter htmlId: (self uuidFor: aPresentation).
	
	"When the morph changes, we want to update the glamour model"
	aPresentationModel announcer on: GLMTreeMorphSelectionChanged do: [ :ann | 
		aPresentation announcer suspendAllWhile: [
			aPresentation selection: ann selectionValue.
			aPresentation selectionPath: ann selectionPathValue] ].
	"aPresentationModel announcer on: GLMTreeMorphStrongSelectionChanged do: [ :ann | 
		aPresentation strongSelection: ann strongSelectionValue ]."
	
	"When the glamour model changes, we want to update the morph"
	aPresentation when: GLMContextChanged do: [ :ann | 
			ann property = #selection ifTrue: [ 
				aPresentationModel announcer suspendAllWhile: [
					treePresenter model explicitSelection: ann value.
					treePresenter updateSelectedNodes ] ] ].
	aPresentation when: GLMPresentationUpdated do: [ :ann |
		treePresenter model updateRoots ].
	
	html render: treePresenter
]

{ #category : #presentation }
SGLRenderer >> renderMagrittePresentation: aPresentation [
	| form |
	form := aPresentation displayValue asComponent
		addValidatedForm;
		onAnswer: [ :answer | aPresentation selection: answer ].
	html div
		class: 'magritte';
		with: form
]

{ #category : #presentation }
SGLRenderer >> renderMondrianPresentation: aPresentation [
	| view canvas id|
	view := MOViewRenderer new.
	aPresentation renderOn: view. 
	canvas := MOCanvas new. 
	canvas root: view root.
	canvas selected: (view 
		nodeForDomainValue: aPresentation selection 
		ifAbsent: [ nil ]).
	html div
		id: (self uuidFor: aPresentation);
		class: 'glm-mondrian-presentation';
		with: [
	html image
		form: canvas imageForm;	
		onClick: (html jQuery ajax 
			callback: [ :value |
			| coordinates element |
			coordinates := (value contents findTokens: $,)
				collect: [ :each | each asNumber ].
			element := canvas root elementAt: coordinates first @ coordinates second.
			aPresentation selection: (element isNil
				ifFalse: [ element model ]) ]
		value: (JSStream on: 'event.layerX+","+event.layerY');
		script: [ :script |
			self scriptFor: aPresentation put: ((html jQuery id: (self uuidFor: aPresentation))
				replaceWith: [ :r | html := r. self renderMondrianPresentation: aPresentation ]).
			self updateScript: script ])
	]
]

{ #category : #presentation }
SGLRenderer >> renderMorphPresentation: aMorphPresentation [ 
	self flag: 'To implement'.
	self renderEmptyPresentation.
]

{ #category : #widgets }
SGLRenderer >> renderPane: aPane [
	aPane whenMatchingPresentationsChanged: [ :ann |
		self 
			scriptFor: aPane
			put: ((html jQuery id: (self uuidFor: aPane))
				html: [ :renderer |
					html := renderer.
					self renderWithTitleOrNil: aPane presentations]) ].
	self renderWithTitleOrNil: aPane presentations
]

{ #category : #widgets }
SGLRenderer >> renderPaneWithoutTitle: aPane [
	aPane whenMatchingPresentationsChanged: [ :ann |
		self 
			scriptFor: aPane
			put: ((html jQuery id: (self uuidFor: aPane))
				html: [ :renderer |
					html := renderer.
					self render: aPane presentations]) ].
	self render: aPane presentations
]

{ #category : #presentation }
SGLRenderer >> renderStackedVerticallyCompositePresentation: aCompositePresentation [
	| presentations|
	presentations := aCompositePresentation matchingPresentations.
	presentations isEmpty ifTrue: [ ^ self renderEmptyPresentation ].	
	presentations size = 1 ifTrue: [^ self renderWithTitleOrNil: presentations first ].
	
	html div 
		class: 'ui-widget ui-widget-content ui-corner-all';
		class: 'stacked-arrangement';
		with: [
			presentations do: [ :each | 
				self renderWithTitle: each andAddCloseButton: true ] ]
]

{ #category : #widgets }
SGLRenderer >> renderStacker: aBrowser [ 
	self flag: 'To implement'.
	self renderEmptyPresentation
]

{ #category : #presentation }
SGLRenderer >> renderTabbedCompositePresentation: aCompositePresentation [
	html render: (SGLTabbedCompositePresenter for: aCompositePresentation with: self)
]

{ #category : #widgets }
SGLRenderer >> renderTableLayoutColumn: aCell inBrowser: aBrowser [
	html div class: 'sgl-table'; class: 'sgl-table-vbox'; with: [
		aCell children 
			do: [ :each |
				| tag |
				tag := html div boxFlex: each span; style: 'position: relative;'.
				each hasId 
					ifTrue: [
						| pane |
						pane := aBrowser paneNamed: each id.
						tag id: (self uuidFor: pane); with: [ self render: pane ] ]
					ifFalse: [ 
						tag with: [ self renderTableLayoutRow: each inBrowser: aBrowser  ] ] ]
			separatedBy: [ html div class: 'sgl-table-split' ] ]
]

{ #category : #widgets }
SGLRenderer >> renderTableLayoutRow: aCell inBrowser: aBrowser [
	html div class: 'sgl-table'; class: 'sgl-table-hbox'; with: [
		aCell children 
			do: [ :each |
				| tag |
				tag := html div boxFlex: each span; style: 'position: relative;'.
				each hasId 
					ifTrue: [
						| pane |
						pane := aBrowser paneNamed: each id.
						tag id: (self uuidFor: pane); with: [ self render: pane ] ]
					ifFalse: [ 
						tag with: [ self renderTableLayoutColumn: each inBrowser: aBrowser ] ] ]
			separatedBy: [ html div class: 'sgl-table-split' ] ]
]

{ #category : #presentation }
SGLRenderer >> renderTablePresentation: aPresentation [
	self flag: 'To implement'.
	self renderEmptyPresentation.

]

{ #category : #widgets }
SGLRenderer >> renderTabulator: aBrowser [
	aBrowser cell isRow
		ifTrue: [ self renderTableLayoutRow: aBrowser cell inBrowser: aBrowser  ]
		ifFalse: [ self renderTableLayoutColumn: aBrowser cell inBrowser: aBrowser  ]
]

{ #category : #presentation }
SGLRenderer >> renderTextPresentation: aTextPresentation [
	| model textPresenter |
	model := SGLTextModel new.
	model glamourPresentation: aTextPresentation.
	textPresenter := (SGLTextPresenter for:  model with: self).
	textPresenter htmlId: (self uuidFor: aTextPresentation).
	
	"When the presenter changes, we want to update the glamour model"
	model announcer on: SGLTextPresenterTextChanged do: [ :ann | 
		aTextPresentation announcer suspendAllWhile: [
			aTextPresentation text: ann text ] ].
	
	"When the glamour model changes, we want to update the presenter"
	aTextPresentation when: GLMContextChanged do: [ :ann | 
		model announcer suspendAllWhile: [
			( #(#text "#selectionInterval #selectionText" ) includes:  ann property) 
				ifTrue: [
					textPresenter model  perform: (ann property, ':') asSymbol with: ann value.
					textPresenter updateText ] ] ].
	aTextPresentation when: GLMPresentationUpdated do: [:ann | ].
	
	"We populate the text port. Must be done after setting the anouncers
	in order to trigger them"
	model text: aTextPresentation formatedDisplayValue.
	
	html render: textPresenter
]

{ #category : #widgets }
SGLRenderer >> renderTitleOrIconOf: aPresentation on: aRenderer [
	aPresentation hasTitleIcon
		ifTrue: [ 
			aRenderer image
				form: aPresentation titleIconValue  ] 
		ifFalse:  [ aRenderer render: (aPresentation titleValue ifNil: ['']) ]
]

{ #category : #presentation }
SGLRenderer >> renderTreePresentation: aPresentation [
	|model|
	model := SGLTreeModel new.
	model glamourPresentation: aPresentation.
	model shouldRootsExpand: aPresentation shouldRootsExpand.
	model shouldAllExpand: aPresentation shouldAllExpand.
	self renderListingPresentation: model
]

{ #category : #widgets }
SGLRenderer >> renderWithTitle: aPresentation [
	self renderWithTitle: aPresentation andAddCloseButton: false 
]

{ #category : #widgets }
SGLRenderer >> renderWithTitle: aPresentation andAddCloseButton: aBoolean [ 
	"Renders a presentation with its title and if the presentation is removed executes 'anAction'."

	|id|
	id := html nextId.
	self widgetContainer 
		script: ( html jQuery new glamourTabs
			ifEmptyDo: 'remove';
			hasActions: true;
			closable: aBoolean );
		class: 'presentation-with-title';
		with: [
			html unorderedList				
				class: 'presentation-title';
				with: [
					html listItem: [ 
							html anchor
								url: '#', id asString;
								with: [self renderTitleOrIconOf: aPresentation on: html]  ].
					html listItem 
						class: 'glm-actions';
						with: [self renderActionsFrom: aPresentation on: html].
					].
			html div
				id: id;				
				class: 'presentation-content';
				with: [
					self render: aPresentation] ] 
]

{ #category : #widgets }
SGLRenderer >> renderWithTitleOrNil: aPresentation [
	(aPresentation hasTitleIcon or: [aPresentation hasTitle]) ifFalse: [^self render: aPresentation ].
	self renderWithTitle: aPresentation 
]

{ #category : #presentation }
SGLRenderer >> renderWorkspacePresentation: aWorkspacePresentation [
	self renderTextPresentation: aWorkspacePresentation
]

{ #category : #script }
SGLRenderer >> scriptFor: anObject add: aScript [
	(scripts at: (self uuidFor: anObject) ifAbsentPut: [ JSScript new ]) , aScript
]

{ #category : #script }
SGLRenderer >> scriptFor: anObject put: aScript [
	scripts at: (self uuidFor: anObject) put: aScript
]

{ #category : #script }
SGLRenderer >> updateScript: aScript [
	aScript addAll: scripts values.
	aScript add: (JSStream on: 'Glamour.resize()').
	scripts := GRSmallDictionary new
]

{ #category : #script }
SGLRenderer >> uuidFor: anObject [
	^ uuid at: anObject ifAbsentPut: [ html nextId ]
]

{ #category : #widgets }
SGLRenderer >> widgetContainer [
	^ html div
		class: 'ui-widget';
		class: 'ui-widget-content';
		class: 'ui-corner-all';
		yourself
]
