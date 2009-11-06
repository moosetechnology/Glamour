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
	html select
		size: 10;
		list: (items ifNil: [ #() ]);
		labels: aPresentation format;
		selected: aPresentation selection;
		callback: [ :value | aPresentation selection: value ];
		onChange: (html jQuery ajax 
			serializeThis;
			script: [ :script | self updateScript: script ])
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
					self renderPaneContent: aPane ]) ].
	self renderPaneContent: aPane
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
		ifTrue: [ ^ self renderPaneEmpty ].
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
SGLRenderer >> renderPaneEmpty [
	html div
		class: 'ui-widget';
		class: 'ui-widget-content';
		class: 'ui-corner-all'
]

{ #category : #widgets }
SGLRenderer >> renderPaneSingle: aPane [
	html div
		class: 'ui-tabs-panel';
		class: 'ui-widget-content';
		class: 'ui-corner-all';
		with: [ self render: aPane ]
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
								with: each title ] ].
			"html div: [ self render: aPane ]" ] ]
]

{ #category : #widgets }
SGLRenderer >> renderTableLayoutBrowser: aBrowser [
	aBrowser cell isRow
		ifTrue: [ self renderTableLayoutBrowserRow: aBrowser cell ]
		ifFalse: [ self renderTableLayoutBrowserColumn: aBrowser cell ]
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

{ #category : #presentation }
SGLRenderer >> renderTextPresentation: aPresentation [
	html textArea
		value: aPresentation formatedDisplayValue;
		callback: [ :value | aPresentation text: value ];
		onChange: (html jQuery ajax 
			serializeThis;
			script: [ :script | self updateScript: script ])
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
