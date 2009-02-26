Class {
	#name : #SGLRenderer,
	#superclass : #GLMRenderer,
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

{ #category : #opening }
SGLRenderer >> doOpen: anObject [
	^ anObject
]

{ #category : #initialization }
SGLRenderer >> initialize [
	super initialize.
	uuid := IdentityDictionary new.
	scripts := OrderedCollection new
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
	html div id: (id := self uuidFor: aPane); with: [
		aPane matchingPresentations
			do: [ :each | self halt; render: each ] ].
	aPane whenMatchingPresentationsChanged: [ :ann |
		scripts add: ((html jQuery id: id) html: [ :renderer | 
			html := renderer.
			aPane matchingPresentations
				do: [ :each | self render: each ] ]) ]
]

{ #category : #widgets }
SGLRenderer >> renderTableLayoutBrowser: aBrowser [
	html table class: (self uuidFor: aBrowser); with: [ 
		aBrowser cell isRow
			ifTrue: [ self renderTableLayoutBrowserRow: aBrowser ]
			ifFalse: [ self renderTableLayoutBrowserColumn: aBrowser ] ]
]

{ #category : #widgets }
SGLRenderer >> renderTableLayoutBrowserColumn: aBrowser [
	aBrowser cell children do: [ :each |
		html tableRow: [
			html tableData rowSpan: each span; with: [
				each hasId
					ifTrue: [ self render: (aBrowser paneNamed: each id) ]
					ifFalse: [ html render: 'nothing' ] ] ] ]
]

{ #category : #widgets }
SGLRenderer >> renderTableLayoutBrowserRow: aBrowser [
	html tableRow: [
		aBrowser cell children do: [ :each |
			html tableData colSpan: each span; with: [
				each hasId 
					ifTrue: [ self render: (aBrowser paneNamed: each id) ]
					ifFalse: [ html render: 'nothing' ] ] ] ]
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
