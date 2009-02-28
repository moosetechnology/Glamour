Class {
	#name : #SGLRenderer,
	#superclass : #GLMRenderer,
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

{ #category : #opening }
SGLRenderer >> doOpen: anObject [
	^ anObject
]

{ #category : #initialization }
SGLRenderer >> initialize [
	super initialize.
	uuid := IdentityDictionary new.
	properties := IdentityDictionary new.
	scripts := WASmallDictionary new
]

{ #category : #initialization }
SGLRenderer >> initializeIn: aComponent on: aRenderer [
	self initialize.
	component := aComponent.
	html := aRenderer
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
SGLRenderer >> renderMondrianPresentation: aMondrianPresentation [
	html text: 'mondrian'
]

{ #category : #widgets }
SGLRenderer >> renderPane: aPane [
	aPane whenMatchingPresentationsChanged: [ :ann |
		| id |
		id := self uuidFor: aPane.
		scripts at: id put: ((html jQuery id: id)
			html: [ :renderer | 
				html := renderer.
				self renderPaneContent: aPane ]) ].
	self renderPaneContent: aPane
]

{ #category : #widgets }
SGLRenderer >> renderPaneContent: aPane [
	| panes pane |
	panes := aPane matchingPresentations.
	panes isEmpty ifTrue: [ ^ self ].
	pane := properties at: aPane ifAbsentPut: [ panes first ].
	(panes includes: pane)
		ifFalse: [ pane := properties at: aPane put: panes first ].
	panes size > 1 ifTrue: [
		html unorderedList class: 'tabs'; with: [
			panes do: [ :each |
				html listItem class: 'tabs-current' if: pane = each; with: [ 
					html anchor
						url: 'javascript:void(0)';
						onClick: ((html jQuery id: (self uuidFor: aPane)) load
							html: [ :r | 
								html := r. 
								properties at: aPane put: each.
								self renderPaneContent: aPane ]);
						with: each title ] ] ] ].
	self render: pane
]

{ #category : #widgets }
SGLRenderer >> renderTableLayoutBrowser: aBrowser [
	aBrowser cell isRow
		ifTrue: [ self renderTableLayoutBrowserRow: aBrowser cell ]
		ifFalse: [ self renderTableLayoutBrowserColumn: aBrowser cell ]
]

{ #category : #widgets }
SGLRenderer >> renderTableLayoutBrowserColumn: aCell [
	| count pane tag |
	count := aCell children
		inject: 0
		into: [ :result :each | result + each span ].
	html table class: 'table-layout'; class: 'table-layout-column'; with: [
		aCell children do: [ :each |
			html tableRow: [
				tag := html tableData.
				tag style: 'height: ' , (300 * each span // count) asString , 'px'.
				each hasId 
					ifTrue: [
						pane := aCell browser paneNamed: each id.
						tag id: (self uuidFor: pane); with: [ self render: pane ] ]
					ifFalse: [ 
						tag with: [ self renderTableLayoutBrowserRow: each ] ] ] ] ]
]

{ #category : #widgets }
SGLRenderer >> renderTableLayoutBrowserRow: aCell [
	| count pane tag |
	count := aCell children
		inject: 0
		into: [ :result :each | result + each span ].
	html table class: 'table-layout'; class: 'table-layout-row'; with: [
		html tableRow: [
			aCell children do: [ :each |
				tag := html tableData.
				tag style: 'width: ' , (100 * each span // count) asString , '%'.
				each hasId
					ifTrue: [
						pane := aCell browser paneNamed: each id.
						tag id: (self uuidFor: pane); with: [ self render: pane ] ]
					ifFalse: [ 
						tag with: [ self renderTableLayoutBrowserColumn: each ] ] ] ] ]
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
	html text: 'workspace'
]

{ #category : #private }
SGLRenderer >> updateScript: aScript [
	aScript addAll: scripts values.
	scripts := WASmallDictionary new
]

{ #category : #private }
SGLRenderer >> uuidFor: anObject [
	^ uuid at: anObject ifAbsentPut: [ html nextId ]
]
