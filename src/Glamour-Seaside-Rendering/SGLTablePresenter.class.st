Class {
	#name : #SGLTablePresenter,
	#superclass : #SGLPresenter,
	#instVars : [
		'model'
	],
	#category : #'Glamour-Seaside-Rendering'
}

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

{ #category : #initialization }
SGLTablePresenter >> initializeFor: aPresentation [
	model := SGLTreeModel for: aPresentation.
]

{ #category : #accessing }
SGLTablePresenter >> model [
	
	^ model
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

	html div
		class: 'sgl-table-presentation';
		id: self presentationId;
		with: [ self renderInitialRootNodesOn2: html ].
]

{ #category : #rendering }
SGLTablePresenter >> renderInitialRootNodesOn2: html [
	
	html table
		with: [
			html tableRow with: [
				self renderTableHeadingWith: html].
			
			self model allRoots do: [:each |
				self renderRowFor: each on: html ] ]
	
	
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
SGLTablePresenter >> renderRowFor: aNode on: html [

	html tableRow with: [
		self model glamourPresentation columns do: [:aGlamourColumn|
			html tableData with: (self model glamourPresentation column: aGlamourColumn valueFor: aNode item ) ] ]
	
]

{ #category : #rendering }
SGLTablePresenter >> renderTableHeadingWith: html [

	self model glamourPresentation columns do: [:aColumn |
		html tableHeading with: (self model glamourPresentation titleValueOfColumn: aColumn) ]
]
