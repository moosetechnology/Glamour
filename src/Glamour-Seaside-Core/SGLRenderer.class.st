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
				html div: [ html anchor: each title. self renderActionsFrom: each ].
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
		script: ( (html jQuery this tabs cache: true)
					onSelect: (html jQuery ajax callbackTabs: [ :event | 
                    			aBrowser activeEntity: ((aBrowser panes at: (event at: #index) + 1) port: #entity) value ]) );
		with: [
			html unorderedList: [
				aBrowser panes withIndexDo: [ :each :i |
					self renderAccumulator: aBrowser pane: each at: i] ] ]
]

{ #category : #widgets }
SGLRenderer >> renderAccumulator: aBrowser addPane: aPane [
	|tabs|
	tabs := (html jQuery id: (self uuidFor: aBrowser)).
	self scriptFor: aBrowser add: ( 
		(tabs tabs 
			add: (html jQuery ajax
						html: [ :renderer | 
							html := renderer.										
							self renderPaneWithoutTitle: aPane ];
						fullUrl) 			 
			label: ( self titleOrIconOf: aPane presentations) ),
		(tabs tabs select: aBrowser panes size-1) ).

]

{ #category : #'as yet unclassified' }
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
				with: ( self titleOrIconOf: aPane presentations).
				self renderActionsFrom: aPane presentations ].

]

{ #category : #'as yet unclassified' }
SGLRenderer >> renderAccumulator: aBrowser selectPaneAt: index [
	self scriptFor: aBrowser add:  (
		 (html jQuery id: (self uuidFor: aBrowser)) tabs select: index-1 ).
]

{ #category : #'as yet unclassified' }
SGLRenderer >> renderAction: anAction from: aPresentation [
	html image 
		form: anAction icon;
		id: html nextId;
		title: anAction title;
		onClick: ( html jQuery ajax
			callback: [:a | anAction actOn: aPresentation ] value: JQEvent new target;
			script: [:script| self updateScript: script ] )
]

{ #category : #'as yet unclassified' }
SGLRenderer >> renderActionsFrom: aPresentation [
	html div
		class: 'glm-ac-container';
		with: [   
			(aPresentation allActions select: [:action | action hasIcon ] ) do: [ :action | self renderAction: action from: aPresentation] ]
]

{ #category : #'as yet unclassified' }
SGLRenderer >> renderElement: anElement  onLevel: level [
	|id childrens|
	id := html nextId.
	childrens := anElement contents.
	html listItem  
		id: id;  
		class: 'glm-tree-node';
		class: 'glm-tree-leaf' if: childrens size == 0;
		class: 'glm-tree-open' if: (childrens size > 0 and: [anElement expanded]);
		class: 'glm-tree-closed' if: (childrens size > 0 and: [anElement expanded not]);
		with: [
			self renderElementTitleFor: anElement withContent: [
				(html jQuery id: id) append: [:h | 
					html:=h. 
					self renderElements: childrens asListOnLevel: level+1  ] ].
			(childrens size > 0 and: [ anElement expanded] ) ifTrue: [ 
				self renderElements: childrens asListOnLevel: level+1 ] ]
]

{ #category : #'as yet unclassified' }
SGLRenderer >> renderElementTitleFor: anElement withContent: aBlock [
	|rendered|
	rendered := anElement contents size > 0 and: [ anElement expanded].
	html div
		class: 'glm-tree-node-el';
		onClick: (html jQuery ajax script: [:s | 
			rendered 
				ifTrue: [
					anElement expanded 
						ifTrue: [anElement expanded: false] 
						ifFalse: [anElement expanded: true] ] 
				ifFalse: [
					s << aBlock value.
					anElement expanded: true.
					rendered := true ] ] );
		onClick: (
			(html jQuery ajax script: [:s | 
				"Update the selection load the modifications"
				anElement containerTree glamourPresentation selection: anElement item.
				self updateScript: s ] ) );
		with: [ 
			html span with: [
				html span
					with: anElement displayText. 
				self renderTagsOf: anElement ] ]
]

{ #category : #'as yet unclassified' }
SGLRenderer >> renderElements: elements asListOnLevel: level [
	html unorderedList 
		id: html nextId;
		script: (JSStream on: 'Glamour.tree.bindEvents("', html lastId,'" ,', level asString , ')');
		class: 'glm-tree-node-ct';
		with: [ elements do: [:each | 
			self renderElement: each onLevel: level +1 ] ] 
]

{ #category : #widgets }
SGLRenderer >> renderEmptyPresentation [
	html div
		class: 'ui-widget';
		class: 'ui-widget-content';
		class: 'ui-corner-all';
		class: 'empty-presentation'
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
		append: [ :r | html := r. self renderFinder: aBrowser pane: aPane ])
]

{ #category : #widgets }
SGLRenderer >> renderFinder: aBrowser pane: aPane [
	html div
		class: 'finder-pane ui-widget-content ui-corner-all';
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
	|model|
	model := SGLTreeModel new.
	model glamourPresentation: aPresentation.
	self renderListingPresentation: model
]

{ #category : #presentation }
SGLRenderer >> renderListingPresentation: aPresentationModel [
	| items listId|
	items := aPresentationModel roots.

	self widgetContainer
		class: 'list-presentation';
		id: (self uuidFor: aPresentationModel glamourPresentation);
		with: [
			listId := html nextId.
			html unorderedList   
				class: 'glm-tree-root-ct';
				id: listId;
				script: (JSStream on: 'Glamour.tree.bindEvents("', listId,'" , 0)');
				with: [ self renderRootElements: items from: aPresentationModel beginWith: 1] .
				
			(items size > aPresentationModel amountShown) ifTrue: [ "Add a button for loading the remaining elements"
				html submitButton
    		    			onClick: (html jQuery ajax
      		    	  		script: [ :s | 
							(items size > aPresentationModel amountShown) 
								ifTrue: [ "Load the required elements"
									s << (  (s jQuery id: (self uuidFor: aPresentationModel  glamourPresentation )) children: '.glm-tree-root-ct' ) 
										append: [:h |  
											html := h. 
											self renderRootElements: items from: aPresentationModel beginWith: aPresentationModel amountShown+1 ] ] .
							(items size > aPresentationModel amountShown) 
								ifFalse: [  "Disable the button for loading content"
									s << ( (s jQuery id: (self uuidFor: aPresentationModel glamourPresentation )) children: '.glm-tree-append-button'  ) attributeAt: 'disabled' put: true ].
							s << (JSStream on: 'Glamour.tree.addRootIcon("', listId, '")') ] );
					disabled: false;
					class: 'glm-tree-append-button';
         				with: 'Append' ] ] .
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

{ #category : #presentation }
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

{ #category : #'as yet unclassified' }
SGLRenderer >> renderRootElements: items from: aPresentationModel beginWith: startIndex [
	"Render the first 'amountToShow' elements starting from the one with the index 'startIndex'"
	
	|endIndex|
	(startIndex == 1 and: [aPresentationModel amountShown ~= 0 ] ) 
		ifTrue: [ endIndex  := aPresentationModel amountShown min: aPresentationModel roots size ] 
		ifFalse: [ endIndex := startIndex+aPresentationModel amountToShow-1 ].
	(startIndex to: endIndex) do: [ :each |   
			self renderElement: (items at: each)  onLevel: 1 ].
	(startIndex == 1 and: [aPresentationModel amountShown ~= 0 ] ) 
		ifTrue: [
			 aPresentationModel amountShown: (aPresentationModel amountShown max: endIndex) ]  
		ifFalse: [
			aPresentationModel amountShown: aPresentationModel amountToShow + aPresentationModel amountShown ] 
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
				self renderWithTitle: each ] ]
]

{ #category : #presentation }
SGLRenderer >> renderTabbedCompositePresentation: aCompositePresentation [
	| presentations index|
	presentations := aCompositePresentation matchingPresentations.
	presentations isEmpty ifTrue: [ ^ self renderEmptyPresentation ].
	presentations size = 1 ifTrue: [^ self renderWithTitleOrNil: presentations first ].
	index := 0.
	presentations withIndexDo: [ :each :i | 
		aCompositePresentation pane lastActivePresentation notNil and: [ 
			each title = aCompositePresentation pane lastActivePresentation title ifTrue: [ index := i-1 ] ] ].
	
	html div
		class: 'tabbed-arrangement';
		script: ( ( html jQuery new tabs cache: true )
					onSelect: (html jQuery ajax callbackTabs: [ :event | 
       		             	aCompositePresentation pane lastActivePresentation: (aCompositePresentation matchingPresentations at: (event at: #index)+1 ) ]) ); 
		with: [
			html unorderedList: [
				presentations withIndexDo: [ :each :i|
					html listItem 
						class: 'ui-tabs-selected' if: i = index; 
						with: [
							html anchor
								url: (html jQuery ajax
									html: [ :renderer | 
										html := renderer.										
										self render: each ];
									fullUrl);
								with: each title.
							self renderActionsFrom: each ] ] ] ]
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

{ #category : #widgets }
SGLRenderer >> renderTabulator: aBrowser [
	aBrowser cell isRow
		ifTrue: [ self renderTableLayoutRow: aBrowser cell inBrowser: aBrowser  ]
		ifFalse: [ self renderTableLayoutColumn: aBrowser cell inBrowser: aBrowser  ]
]

{ #category : #'as yet unclassified' }
SGLRenderer >> renderTag: aTag withFilter: aFilter for: aNode [
	html div
		class: 'glm-tree-tag ui-corner-top ui-corner-bottom';
		class: 'glm-tree-tag-selected' if: ( aNode containerTree tagsToFilterBy includes: aTag );
		onClick:  (html jQuery ajax script: [:s | 
			aNode containerTree toggleFilteringByTag: aTag.
			s << ( html jQuery id: (self uuidFor: aNode containerTree glamourPresentation ))
				replaceWith: [ :renderer |
					html := renderer.
					self renderListingPresentation: aNode containerTree ] ] )  ;
		onClick: JQEvent new stopPropagation, JQEvent new preventDefault;
		with: aTag asString 
]

{ #category : #'as yet unclassified' }
SGLRenderer >> renderTagsOf: aNode [
	| tags tagsFilter |
	tags:= aNode containerTree glamourPresentation tagsFor: aNode item to: #show.
	tagsFilter := aNode containerTree glamourPresentation tagsFor: aNode item to: #filter.
	html div
		class: 'glm-tree-tags';
		with: [
			tags withIndexDo:[ :each :index | 
				self renderTag: each withFilter: (tagsFilter at: index ifAbsentPut:[ each ] ) for: aNode  ] ]
]

{ #category : #presentation }
SGLRenderer >> renderTextPresentation: aPresentation [
	self widgetContainer
		class: 'presentation-container';
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
	|model|
	model := SGLTreeModel new.
	model glamourPresentation: aPresentation.
	model shouldRootsExpand: aPresentation shouldRootsExpand.
	model shouldAllExpand: aPresentation shouldAllExpand.
	self renderListingPresentation: model
]

{ #category : #'as yet unclassified' }
SGLRenderer >> renderWithTitle: aPresentation [
	self widgetContainer 
		class: 'presentation-with-title';
		with: [
			html unorderedList				
				class: 'ui-tabs-nav ui-corner-all ui-helper-reset';
				class: 'presentation-title';
				with: [
					html listItem 
						class: 'ui-state-default ui-corner-top ui-tabs-selected';
						with: [ 
							html span: (aPresentation titleValue ifNil: ['&nbsp']).
							self renderActionsFrom: aPresentation ]
					].
			html div				
				class: 'ui-tabs-panel ui-widget-content ui-corner-bottom';
				class: 'presentation-content';
				with: [
					self render: aPresentation] ] 
]

{ #category : #widgets }
SGLRenderer >> renderWithTitleOrNil: aPresentation [
	aPresentation hasTitle ifFalse: [^self render: aPresentation ].
	self renderWithTitle: aPresentation 
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

{ #category : #widgets }
SGLRenderer >> titleOrIconOf: aPresentation [
	^aPresentation titleValue ifNil: ['']
]

{ #category : #private }
SGLRenderer >> updateScript: aScript [
	aScript addAll: scripts values.
	aScript add: (JSStream on: 'Glamour.resize()').
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
