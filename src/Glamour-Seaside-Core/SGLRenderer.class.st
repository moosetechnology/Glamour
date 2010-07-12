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
				html div: [ html anchor: each title ].
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
		script: (html jQuery this tabs cache: true);
					"onSelect: (html jQuery ajax callbackTabs: [ :event | 
                    	aBrowser activeEntity: ((aBrowser panes at: (event at: #index)) port: #entity) value ]) ); "
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
			label: (self titleOrIconOf: aPane presentations) ),
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
				with: ( self titleOrIconOf: aPane presentations) ].

]

{ #category : #'as yet unclassified' }
SGLRenderer >> renderAccumulator: aBrowser selectPaneAt: index [
	self scriptFor: aBrowser add:  (
		 (html jQuery id: (self uuidFor: aBrowser)) tabs select: index-1 ).
]

{ #category : #'as yet unclassified' }
SGLRenderer >> renderElement: anElement from: aPresentation [
	html listItem    
		onClick: (
			(html jQuery ajax
				script: [:s | 
					aPresentation selection: anElement.
					self updateScript: s ]) ,
			 ( (html jQuery expression: '#', (self uuidFor: aPresentation),  ' > ul > li') removeClass: 'selected'  ),
			 ( html jQuery new addClass: 'selected' ));
		with: anElement 
]

{ #category : #'as yet unclassified' }
SGLRenderer >> renderElement: anElement from: aPresentation withChildrens: childrens onLevel: level [
	|id listItem expanded childBlock|
	id := html nextId.
	expanded := childrens size > 0 and: [ (aPresentation shouldRootsExpand and: [level == 1]) or: [aPresentation shouldAllExpand] ].
	childBlock := [ :h |
		html := h.
		h unorderedList 
			id: html nextId;
			script: (JSStream on: 'Glamour.tree.bindEvents("', html lastId,'" ,', level asString , ')');
			class: 'glm-tree-node-ct';
			with: [ childrens do: [:each | 
				self renderElement: each from: aPresentation withChildrens: (aPresentation childrenValueOf: each) onLevel: level +1 ] ] ].
	listItem := html listItem  
		id: id;  
		class: 'glm-tree-node';
		class: 'glm-tree-leaf' if: childrens size == 0;
		class: 'glm-tree-open' if: expanded;
		class: 'glm-tree-closed' if: (childrens size > 0 and: [expanded not]).
	(childrens size >0 and:[ expanded not ] ) ifTrue: [
		listItem onClick: (html jQuery ajax script: [:s | 
			s << ( (html jQuery id: id) append: [:h | (childBlock value: h)  ] ).
			s add: (JSStream on: 'Glamour.disableClickEvent("',id,'")')  "Allow only one click" ]  ) ].
	listItem with: [
			html div
				class: 'glm-tree-node-el';
				onClick: (
					(html jQuery ajax
						script: [:s | 
							"Update the selection load the modifications"
							aPresentation selection: anElement.
							self updateScript: s ] ) );
				with: [ html span with: (aPresentation format value: anElement) ].
			(expanded) ifTrue: [ childBlock value: html ] ]
]

{ #category : #'as yet unclassified' }
SGLRenderer >> renderElements: items from: aPresentation beginWith: startIndex andShow: amountToShow [
	"Render the first 'amountToShow' elements starting from the one with the index 'startIndex'"
	
	(startIndex to: ( startIndex+amountToShow-1 )) do: [ :each |   
			self renderElement: (items at: each) from: aPresentation withChildrens: (aPresentation childrenValueOf:  (items at: each) ) onLevel: 1 ] 
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
	| items stepSize amountToShow amountShown size|
	aPresentation displayValue isCollection
		ifTrue: [ items :=  OrderedCollection newFrom: aPresentation displayValue ]
		ifFalse: [ items :=  OrderedCollection new add: aPresentation displayValue ].
	size := items size.
	stepSize := aPresentation amountToShow ifNil: [size].

	self widgetContainer
		class: 'list-presentation';
		id: (self uuidFor: aPresentation);
		with: [
			html unorderedList   
				with: [
					amountToShow := stepSize min: size.
					 (1 to: amountToShow) do: [ :each |  
						self renderElement: (items at: each) from: aPresentation  ] ] .
				
			amountShown := amountToShow.
			(size > amountShown) ifTrue: [ "Add a button for loading the remaining elements"
				html submitButton
    		    			onClick: (html jQuery ajax
      		    	  		script: [ :s | 
							(size > amountShown) 
								ifTrue: [
									amountToShow := amountShown+stepSize min: size.
									s << (  (s jQuery id: (self uuidFor: aPresentation)) children: 'ul' ) append: [:h |  
										html := h. 
										(amountShown+1 to: amountToShow ) do: [ :each |  self renderElement: (items at: each) from: aPresentation ].
									amountShown := amountToShow ] ] .
							(size > amountShown) 
								ifFalse: [  "Disable the button for loading content"
									s << ( (s jQuery id: (self uuidFor: aPresentation)) children: ':input'  ) attributeAt: 'disabled' put: true ] ] );
					disabled: false;
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
				self renderWithTitleOrNil: each ] ]
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
		script: ( html jQuery new tabs cache: true );
					"onSelect: (html jQuery ajax callbackTabs: [ :event | 
                    	aCompositePresentation pane lastActivePresentation: (aCompositePresentation matchingPresentations at: (event at: #index) ) ]) ); "
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
								with: each title ] ] ] ]
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
	| items stepSize amountToShow amountShown size|
	aPresentation displayValue isCollection
		ifTrue: [ items :=  OrderedCollection newFrom: aPresentation displayValue ]
		ifFalse: [ items :=  OrderedCollection new add: aPresentation displayValue ].
	size := items size.
	stepSize := aPresentation amountToShow ifNil: [size].

	self widgetContainer
		class: 'list-presentation';
		id: (self uuidFor: aPresentation);
		with: [
			html unorderedList   
				class: 'glm-tree-root-ct';
				id: html nextId;
				script: (JSStream on: 'Glamour.tree.bindEvents("', html lastId,'" , 0)');
				with: [
					amountToShow := stepSize min: size.
					self renderElements: items from: aPresentation beginWith: 1 andShow: amountToShow ] .
				
			amountShown := amountToShow.
			(size > amountShown) ifTrue: [ "Add a button for loading the remaining elements"
				html submitButton
    		    			onClick: (html jQuery ajax
      		    	  		script: [ :s | 
							(size > amountShown) 
								ifTrue: [
									amountToShow := stepSize min: size-amountShown.
									s << (  (s jQuery id: (self uuidFor: aPresentation)) children: 'ul' ) append: [:h |  
										html := h. 
										self renderElements: items from: aPresentation beginWith: amountShown+1 andShow: amountToShow ].
									amountShown := amountShown + amountToShow ] .
							(size > amountShown) 
								ifFalse: [  "Disable the button for loading content"
									s << ( (s jQuery id: (self uuidFor: aPresentation)) children: ':input'  ) attributeAt: 'disabled' put: true ] ] );
					disabled: false;
         				with: 'Append' ] ] .
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
