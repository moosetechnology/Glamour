Class {
	#name : #SGLRenderer,
	#superclass : #Object,
	#instVars : [
		'component',
		'html',
		'uuid',
		'scripts',
		'properties'
	],
	#category : #'Glamour-Seaside-Core'
}

{ #category : #'instance-creation' }
SGLRenderer class >> in: aComponent on: html [
	^ self basicNew initializeIn: aComponent on: html
]

{ #category : #initialization }
SGLRenderer >> initialize [
	super initialize.
	uuid := IdentityDictionary new.
	properties := IdentityDictionary new.
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

{ #category : #'as yet unclassified' }
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
      script: (html jQuery new accordion animated: false; active: index-1);
      with: [
         presentations withIndexDo: [ :each :i | 
				html div: [ html anchor: each title ].
				html div: [ self render: each ] ] ]
]

{ #category : #widgets }
SGLRenderer >> renderEmptyPresentation [
	html div
		class: 'ui-widget';
		class: 'ui-widget-content';
		class: 'ui-corner-all'
]

{ #category : #widgets }
SGLRenderer >> renderFinder: aBrowser [
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
				do: [ :each | self renderFinder: aBrowser pane: each ] ]
]

{ #category : #widgets }
SGLRenderer >> renderFinder: aBrowser addPane: aPane [
	self scriptFor: aBrowser add: ((html jQuery id: (self uuidFor: aBrowser))
		append: [ :r | html := r. self renderFinder: aBrowser pane: aPane ])
]

{ #category : #widgets }
SGLRenderer >> renderFinder: aBrowser pane: aPane [
	html div
		class: 'finder-pane';
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
SGLRenderer >> renderListPresentation: aPresentation [
	| items toShow |
	toShow := aPresentation displayValue.
	items := toShow isCollection
		ifTrue: [ toShow ]
		ifFalse: [ Array with: toShow ].
		
	self widgetContainer
		with: [
			html select
				size: 10;
				list: (items ifNil: [ #() ]);
				labels: aPresentation format;
				selected: aPresentation selection;
				callback: [ :value | aPresentation selection: value ];
					onChange: (html jQuery ajax 
						serializeThis;
						script: [ :script | self updateScript: script ]) ].
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
	| view canvas |
	view := MOViewRenderer new.
	aPresentation renderOn: view. 
	canvas := MOCanvas new. 
	canvas root: view root.
	canvas selected: (view 
		nodeForDomainValue: aPresentation selection 
		ifAbsent: [ nil ]).
	html image
		form: canvas imageForm;	
		style: 'position: relative';
		id: (self uuidFor: aPresentation);
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
SGLRenderer >> renderPane: aPane tabs: aCollection [
	html div
		script: (html jQuery this tabs);
		with: [
			html unorderedList: [
				aCollection do: [ :each |
					html listItem 
						class: 'ui-state-selected' if: aPane = each;
						with: [
							html anchor
								url: (html jQuery ajax
									html: [ :renderer | 
										html := renderer.
										properties at: aPane put: each.
										self render: each ];
									fullUrl);
								with: each title ] ] ] ]
]

{ #category : #widgets }
SGLRenderer >> renderPaneContent: aPane [
	| panes pane |
	panes := aPane matchingPresentations.
	panes isEmpty 
		ifTrue: [ ^ self renderEmptyPresentation ].
	panes size = 1
		ifTrue: [ ^ self renderPaneSingle: panes first ].
	pane := properties 
		at: aPane
		ifAbsentPut: [ panes first ].
	(panes includes: pane)
		ifFalse: [ pane := properties at: aPane put: panes first ].
	self renderPaneTabs: pane tabs: panes
]

{ #category : #widgets }
SGLRenderer >> renderPaneSingle: aPane [
	html div
		class: 'ui-widget';
		class: 'ui-widget-content';
		class: 'ui-corner-all';
		with: [ self renderWithTitleOrNil: aPane ]
]

{ #category : #widgets }
SGLRenderer >> renderPaneTabs: aPane tabs: aCollection [
	html div
		script: (html jQuery this tabs);
		with: [
			html unorderedList: [
				aCollection do: [ :each |
					html listItem 
						class: 'ui-state-selected' if: aPane = each;
						with: [
							html anchor
								url: (html jQuery ajax
									html: [ :renderer | 
										html := renderer.
										properties at: aPane put: each.
										self render: each ];
									fullUrl);
								with: each title ] ] ] ]
]

{ #category : #'as yet unclassified' }
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
				self renderWithTitleOrNil: each
				
				] ]
]

{ #category : #presentation }
SGLRenderer >> renderTabbedCompositePresentation: aCompositePresentation [
	| presentations index|
	presentations := aCompositePresentation matchingPresentations.
	presentations isEmpty ifTrue: [ ^ self renderEmptyPresentation ].
	presentations size = 1 ifTrue: [^ self renderWithTitleOrNil: presentations first ].
	
	index := 1.
	presentations withIndexDo: [ :each :i | 
		aCompositePresentation pane lastActivePresentation notNil and: [ 
			each title = aCompositePresentation pane lastActivePresentation title ifTrue: [ index := i ] ] ].
	
	html div
		class: 'tabbed-arrangement';
		script: (html jQuery this tabs);
		with: [
			html unorderedList: [
				presentations withIndexDo: [ :each :i|
					html listItem 
						class: 'ui-state-selected' if: i = index; 
						with: [
							html anchor
								url: (html jQuery ajax
									html: [ :renderer | 
										html := renderer.
										
										self render: each ];
									fullUrl);
								with: each title ] ] ] ]
]

{ #category : #widgets }
SGLRenderer >> renderTableLayoutBrowserColumn: aCell [
	html div class: 'sgl-table'; class: 'sgl-table-vbox'; with: [
		aCell children 
			do: [ :each |
				| tag |
				tag := html div boxFlex: each span; style: 'position: relative;'.
				each hasId 
					ifTrue: [
						| pane |
						pane := aCell browser paneNamed: each id.
						tag id: (self uuidFor: pane); with: [ self render: pane ] ]
					ifFalse: [ 
						tag with: [ self renderTableLayoutBrowserRow: each ] ] ]
			separatedBy: [ html div class: 'sgl-table-split' ] ]
]

{ #category : #widgets }
SGLRenderer >> renderTableLayoutBrowserRow: aCell [
	html div class: 'sgl-table'; class: 'sgl-table-hbox'; with: [
		aCell children 
			do: [ :each |
				| tag |
				tag := html div boxFlex: each span; style: 'position: relative;'.
				each hasId 
					ifTrue: [
						| pane |
						pane := aCell browser paneNamed: each id.
						tag id: (self uuidFor: pane); with: [ self render: pane ] ]
					ifFalse: [ 
						tag with: [ self renderTableLayoutBrowserColumn: each ] ] ]
			separatedBy: [ html div class: 'sgl-table-split' ] ]
]

{ #category : #widgets }
SGLRenderer >> renderTabulator: aBrowser [
	aBrowser cell isRow
		ifTrue: [ self renderTableLayoutBrowserRow: aBrowser cell ]
		ifFalse: [ self renderTableLayoutBrowserColumn: aBrowser cell ]
]

{ #category : #presentation }
SGLRenderer >> renderTextPresentation: aPresentation [
	self widgetContainer
		with: [
			html textArea
				value: aPresentation formatedDisplayValue;
				callback: [ :value | aPresentation text: value ];
				onChange: (html jQuery ajax 
					serializeThis;
					script: [ :script | self updateScript: script ]) ]
]

{ #category : #presentation }
SGLRenderer >> renderTreePresentation: aPresentation [
	| tag nodes |
	(tag := html select)
		size: 10;
		selected: aPresentation selection;
		callback: [ :value | aPresentation selection: value ];
		onChange: (html jQuery ajax 
			serializeThis;
			script: [ :script | self updateScript: script ]);
		with: [
			nodes := aPresentation displayValue.
			nodes isCollection
				ifFalse: [ nodes := Array with: nodes ].
			nodes do: [ :each |
				self 
					renderTreePresentation: aPresentation
					select: tag node: each level: 0 ] ]
]

{ #category : #presentation }
SGLRenderer >> renderTreePresentation: aPresentation select: aSelectTag node: anObject level: anInteger [
	html option
		selected: (aSelectTag isSelected: anObject);
		callback: [ aSelectTag performCallback: anObject ];
		with: [
			anInteger timesRepeat: [ html html: '&nbsp;' ].
			html text: (aPresentation format value: anObject) ].
	(aPresentation children value: anObject)
		do: [ :each | self renderTreePresentation: aPresentation select: aSelectTag node: each level: anInteger + 4 ]
]

{ #category : #widgets }
SGLRenderer >> renderWithTitleOrNil: aPresentation [
	aPresentation hasTitle ifFalse: [^self render: aPresentation ].
	
	self widgetContainer 
		class: 'presentation-with-title';
		with: [
			html unorderedList				
				class: 'ui-tabs-nav ui-corner-all ui-helper-reset';
				class: 'presentation-title';
				with: [
					html listItem 
						class: 'ui-state-default ui-corner-top';
						with: [ html span: aPresentation titleValue. ]
					].
			html div				
				class: 'ui-tabs-panel ui-widget-content ui-corner-bottom';
				class: 'presentation-content';
				with: [
					self render: aPresentation] ] 
]

{ #category : #presentation }
SGLRenderer >> renderWorkspacePresentation: aWorkspacePresentation [
	self renderTextPresentation: aWorkspacePresentation
]

{ #category : #private }
SGLRenderer >> scriptFor: anObject add: aScript [
	(scripts at: (self uuidFor: anObject) ifAbsentPut: [ JSScript new ]) , aScript
]

{ #category : #private }
SGLRenderer >> scriptFor: anObject put: aScript [
	scripts at: (self uuidFor: anObject) put: aScript
]

{ #category : #private }
SGLRenderer >> updateScript: aScript [
	aScript addAll: scripts values.
	aScript add: (JSStream on: 'glamourResize()').
	scripts := GRSmallDictionary new
]

{ #category : #private }
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
