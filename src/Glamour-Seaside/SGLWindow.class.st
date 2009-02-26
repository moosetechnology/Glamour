Class {
	#name : #SGLWindow,
	#superclass : #WAComponent,
	#instVars : [
		'pane',
		'html',
		'uuid',
		'scripts'
	],
	#category : #'Glamour-Seaside'
}

{ #category : #rendering }
SGLWindow class >> on: aUI [
	^ self new pane: aUI
]

{ #category : #private }
SGLWindow >> description [
	^ 'Glamour'
]

{ #category : #private }
SGLWindow >> new [
	^ self
]

{ #category : #accessing }
SGLWindow >> pane: aPane [
	pane := aPane
]

{ #category : #rendering }
SGLWindow >> renderContentOn: aRenderer [
	html := aRenderer.
	uuid := IdentityDictionary new.
	scripts := OrderedCollection new.
	pane renderGlamorouslyOn: self
]

{ #category : #'rendering-presentation' }
SGLWindow >> renderListPresentation: aPresentation [
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

{ #category : #'rendering-presentation' }
SGLWindow >> renderMondrianPresentation: aMondrianPresentation [
	html text: 'mondrian'
]

{ #category : #'rendering-widgets' }
SGLWindow >> renderPane: aPane [
	| id |
	html div
		id: (id := self uuidFor: aPane);
		with: [
			aPane presentations
				do: [ :each | each renderGlamorouslyOn: self ] ].
	aPane whenMatchingPresentationsChanged: [ :ann |
		scripts add: ((html jQuery id: id) html: [ :r | 
			html := r.
			aPane presentations
				do: [ :each | each renderGlamorouslyOn: self ] ]) ]
]

{ #category : #'rendering-widgets' }
SGLWindow >> renderTableLayoutBrowser: aBrowser [
	html table class: (self uuidFor: aBrowser); with: [ 
		aBrowser cell isRow
			ifTrue: [ self renderTableLayoutBrowserRow: aBrowser ]
			ifFalse: [ self renderTableLayoutBrowserColumn: aBrowser ] ]
]

{ #category : #'rendering-widgets' }
SGLWindow >> renderTableLayoutBrowserColumn: aBrowser [
	| element |
	aBrowser cell children do: [ :each |
		html tableRow: [
			html tableData rowSpan: each span; with: [
				"each hasId ifTrue: [ "
					element := aBrowser paneNamed: each id.
					element renderGlamorouslyOn: self ] ] ] "]"
]

{ #category : #'rendering-widgets' }
SGLWindow >> renderTableLayoutBrowserRow: aBrowser [
	| element |
	html tableRow: [
		aBrowser cell children do: [ :each |
			html tableData colSpan: each span; with: [
				"each hasId ifTrue: [ "
					element := aBrowser paneNamed: each id.
					element renderGlamorouslyOn: self ] ] ] "]"
]

{ #category : #'rendering-presentation' }
SGLWindow >> renderTextPresentation: aPresentation [
	| toShow |
	self halt.
	toShow := aPresentation formatedDisplayValue.
	html textArea
		value: toShow;
		id: (self uuidFor: aPresentation);
		callback: [ :value | aPresentation text: value ];
		onChange: (html jQuery ajax 
			serializeThis;
			script: [ :script | self updateScript: script ])
]

{ #category : #'rendering-presentation' }
SGLWindow >> renderTreePresentation: aTreePresentation [
	html text: 'tree'
]

{ #category : #'rendering-presentation' }
SGLWindow >> renderWorkspacePresentation: aWorkspacePresentation [
	html text: 'workspace'
]

{ #category : #rendering }
SGLWindow >> style [
	^ 'div { border: 1px red solid; }
	td { border: 1px blue solid; }
	
	
div { width: 100%; }
select { width: 100%; height: 200px; }
textarea { width: 100%; height: 200px; }
'
]

{ #category : #rendering }
SGLWindow >> updateRoot: aHtmlRoot [
	super updateRoot: aHtmlRoot.
	aHtmlRoot title: 'Seaside Glamour'
]

{ #category : #private }
SGLWindow >> updateScript: aScript [
	aScript addAll: scripts.
	scripts := OrderedCollection new
]

{ #category : #private }
SGLWindow >> uuidFor: anObject [
	| key |
	^ uuid at: anObject ifAbsentPut: [
		[ key := WAExternalID new.
		  uuid includesKey: key ] 
			whileTrue.
	 	key ]
]
