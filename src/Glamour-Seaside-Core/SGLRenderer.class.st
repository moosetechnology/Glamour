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
	scripts := OrderedCollection new.
	properties := IdentityDictionary new
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
	items := items ifNil: [ OrderedCollection new ].
	html select
		size: 10;
		list: items;
		labels: aPresentation format;
		selected: aPresentation selection;
		id: (self uuidFor: aPresentation);
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
	| id |
	html tableData 
		id: (id := self uuidFor: aPane);
		with: [ self renderPaneContent: aPane ].
	aPane whenMatchingPresentationsChanged: [ :ann |
		scripts add: ((html jQuery id: id) html: [ :renderer | 
			html := renderer.
			self renderPaneContent: aPane ]) ]
]

{ #category : #widgets }
SGLRenderer >> renderPaneContent: aPane [
	| panes pane |
	panes := aPane matchingPresentations.
	panes isEmpty ifTrue: [ ^ self ].
	pane := properties at: aPane ifAbsentPut: [ panes first ].
	panes size > 1 ifTrue: [
		html unorderedList class: 'tabs'; with: [
			panes do: [ :each |
				html listItem class: 'tabs-current' if: pane = each; with: [ 
					html anchor
						url: 'javascript:void(0)';
						onClick: ((html jQuery id: (self uuidFor: aPane)) load
							html: [ :renderer | 
								html := renderer. 
								properties at: aPane put: each.
								self renderPaneContent: aPane ]);
						with: each title ] ] ] ].
	self render: pane
]

{ #category : #widgets }
SGLRenderer >> renderTableLayoutBrowser: aBrowser [
	html table class: (self uuidFor: aBrowser); with: [ 
		aBrowser cell isRow
			ifTrue: [ self renderTableLayoutBrowserRow: aBrowser cell ]
			ifFalse: [ self renderTableLayoutBrowserColumn: aBrowser cell ] ]
]

{ #category : #widgets }
SGLRenderer >> renderTableLayoutBrowserColumn: aCell [
	html tableRow: [
		aCell children do: [ :each |
			each hasId 
				ifTrue: [ self render: (aCell browser paneNamed: each id) ]
				ifFalse: [ self renderTableLayoutBrowserRow: each ] ] ]
]

{ #category : #widgets }
SGLRenderer >> renderTableLayoutBrowserRow: aCell [
	html tableRow: [
		aCell children do: [ :each |
			each hasId 
				ifTrue: [ self render: (aCell browser paneNamed: each id) ]
				ifFalse: [ self renderTableLayoutBrowserColumn: each ] ] ]
]

{ #category : #presentation }
SGLRenderer >> renderTextPresentation: aPresentation [
	html textArea
		id: (self uuidFor: aPresentation);
		value: aPresentation formatedDisplayValue;
		callback: [ :value | aPresentation text: value ];
		onChange: (html jQuery ajax 
			serializeThis;
			script: [ :script | self updateScript: script ])
]

{ #category : #presentation }
SGLRenderer >> renderTreePresentation: aTreePresentation [
	html text: 'tree'
]

{ #category : #presentation }
SGLRenderer >> renderWorkspacePresentation: aWorkspacePresentation [
	html text: 'workspace'
]

{ #category : #private }
SGLRenderer >> updateScript: aScript [
	aScript addAll: scripts.
	scripts := OrderedCollection new
]

{ #category : #private }
SGLRenderer >> uuidFor: anObject [
	| key |
	^ uuid at: anObject ifAbsentPut: [
		[ key := WAExternalID new.
		  uuid includesKey: key ] 
			whileTrue.
	 	key ]
]
