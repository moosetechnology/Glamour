Class {
	#name : #SGLTablePresenter,
	#superclass : #SGLPresenter,
	#instVars : [
		'model',
		'nodesId',
		'htmlId'
	],
	#category : #'Glamour-Seaside-Rendering'
}

{ #category : #accessing }
SGLTablePresenter >> associateNode: aNode withId: anId [
	nodesId at: aNode ifAbsentPut: anId
]

{ #category : #rendering }
SGLTablePresenter >> doSearch: aSearchRequest using: jqGridColumns [
	|filteredData sortedData pagedAndSortedData jqSortColumn|

	aSearchRequest filterCriteriaDo: 
		[:aFilterCrit|
			filteredData 
				removeAllSuchThat: 
					[:each|
						((aFilterCrit jqGridColumn dataValueFor: each)
							perform: aFilterCrit operation with: aFilterCrit filterValue) not]].
	sortedData := 
		filteredData asSortedCollection:
			[:a :b| 
				((jqSortColumn dataValueFor: a) <= (jqSortColumn dataValueFor: b))
					xor: aSearchRequest isSortDescending].
	pagedAndSortedData := sortedData
		copyFrom: aSearchRequest startElementIndex 
		to: ((aSearchRequest endElementIndex) min: filteredData size).
	^JQGridSearchResponse new
		page: aSearchRequest pageNumber;
		totalNumberOfPages: (filteredData size / aSearchRequest numberOfRowsPerPage);
		totalNumberOfRecords: filteredData size;
		rowContents: 
			(pagedAndSortedData 
					collect: [:eachInvoice|
						JQGridRowContent new
							id: eachInvoice id;
							rowObject: eachInvoice])
]

{ #category : #accessing }
SGLTablePresenter >> htmlId [
	^ htmlId 
]

{ #category : #accessing }
SGLTablePresenter >> htmlId: anObject [
	htmlId := anObject
]

{ #category : #accessing }
SGLTablePresenter >> idOfNode: aNode [
	^ nodesId at: aNode ifAbsent: [nil]
]

{ #category : #initialization }
SGLTablePresenter >> initializeFor: aPresentation [
	model := SGLTreeModel for: aPresentation.
	nodesId := Dictionary new.
]

{ #category : #accessing }
SGLTablePresenter >> model [
	
	^ model
]

{ #category : #accessing }
SGLTablePresenter >> nodeForId: anId [
	|value|
	value := nodesId keyAtValue: anId.
	^ value
]

{ #category : #rendering }
SGLTablePresenter >> onSelectActionURLForANodeWith: html [
	^ html jQuery ajax 
		sglTreeCallbackSelectURL:  [ :value :script |
			|nodes|
			nodes := ( (value at: 'selectedIds') contents findTokens: $, ) collect: [:each | 
				(self nodeForId: each) item].
			(self model glamourPresentation isMultiple not) 
				ifTrue: [self model explicitSelection: (nodes at: 1) ]
				ifFalse:  [self model explicitSelection: nodes].
			"(nodes size == 1) 
				ifTrue: [self explicitSelection: (nodes at: 1) ]
				ifFalse:  [self explicitSelection: nodes]."
			self updateSelectedNodes.
			self renderer updateScript: script ]
]

{ #category : #accessing }
SGLTablePresenter >> presentationId [

	 ^ self renderer uuidFor: self model glamourPresentation
]

{ #category : #rendering }
SGLTablePresenter >> renderColumnsOn: html [
	|columns index|
	
	columns := JQGridColumns new.
	index := 1.
	self model glamourPresentation columns do:[:aColumn|
		
		
		columns add: ((JQGridColumn 
			id: index
			label: (self model glamourPresentation titleValueOfColumn: aColumn) 
			selector: #id) width: 70; 
				 yourself).
				
		index := index + 1 ].
	
	^ columns

				
	
	
]

{ #category : #rendering }
SGLTablePresenter >> renderContentOn: html [

	(self widgetContainerWith: html)
		class: 'sgl-table-presentation';
		id: self presentationId;
		with: [ self renderInitialRootNodesOn2: html ].
]

{ #category : #rendering }
SGLTablePresenter >> renderInitialRootNodesOn2: html [
	
	html tbsTable
		beHover;
		id: html nextId;
		script: (self tableInitializationScriptWith: html);
		with: [
			html tableRow with: [
				self renderTableHeadingWith: html].
			
			self model allRoots withIndexDo: [ :each :index |
				self renderRowFor: each index: index on: html ] ]
	
	
]

{ #category : #rendering }
SGLTablePresenter >> renderInitialRootNodesOn: html [
	
	html table 
		id: 'grid'; 
		script: (html jQuery this grid
			searchCallback: [:aSearchRequest :jqGridColumns| self doSearch: aSearchRequest using: jqGridColumns];
			columns: (self renderColumnsOn: html);
"			altRows: true;
			rowNum: 20;
			rowList: {20. 50};
			pagerId: 'pager';
			sortname: 'id';
			toolbarSearch;"
			caption: 'JSON Example');
		with:''.

	
	
]

{ #category : #rendering }
SGLTablePresenter >> renderRowFor: aNode index: anInteger on: html [
	self associateNode: aNode withId: html nextId.
	html tableRow 
		id: (self idOfNode: aNode);
		with: [
			self model glamourPresentation columns do: [:aGlamourColumn|
				html tableData with: (self model glamourPresentation 
					column: aGlamourColumn 
					valueFor: "aNode item"
						(self model glamourPresentation isWithElementIndex
							ifTrue: [ 
								aNode item asGlamorousMultiValue,
								anInteger asGlamorousMultiValue ]
			 				ifFalse: [ aNode item ]) ) ] ]
	
]

{ #category : #rendering }
SGLTablePresenter >> renderRowFor: aNode on: html [
	self associateNode: aNode withId: html nextId.
	html tableRow 
		id: (self idOfNode: aNode);
		with: [
			self model glamourPresentation columns do: [:aGlamourColumn|
				html tableData with: (self model glamourPresentation column: aGlamourColumn valueFor: aNode item ) ] ]
	
]

{ #category : #rendering }
SGLTablePresenter >> renderTableHeadingWith: html [

	self model glamourPresentation columns do: [:aColumn |
		html tableHeading 
			style: 'width: ', aColumn width asString, 'px;';
			with: (self model glamourPresentation titleValueOfColumn: aColumn) ]
]

{ #category : #callbacks }
SGLTablePresenter >> selectNodesScript [
	^ (self renderer html jQuery expression:  ('#',self htmlId, ' > table') ) 
		glamourTable 
			option: 'selectedNodes' put: self selectedIds;
			yourself 

	
]

{ #category : #callbacks }
SGLTablePresenter >> selectedIds [
	|ids|
	ids := OrderedCollection new.
	self model selection ifNotNil: [ self model selection selectedNodes do: [:node |
		(node isNil not and: [node shouldBeDisplayed]) ifTrue: [ 
			ids add: (self idOfNode: node) ] ] ].
	^ ids
]

{ #category : #rendering }
SGLTablePresenter >> tableInitializationScriptWith: html [
	^ html jQuery new glamourTable
		selectURL: (self onSelectActionURLForANodeWith: html)
]

{ #category : #callbacks }
SGLTablePresenter >> updateSelectedNodes [
	self renderer 
		scriptFor: self model glamourPresentation 
		add: self selectNodesScript
]
