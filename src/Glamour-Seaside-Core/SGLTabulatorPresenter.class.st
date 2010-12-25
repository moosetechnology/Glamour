Class {
	#name : #SGLTabulatorPresenter,
	#superclass : #SGLBrowserPresenter,
	#category : #'Glamour-Seaside-Rendering'
}

{ #category : #private }
SGLTabulatorPresenter >> computeTotalSpanForCell: aCell [
	|totalSpan|
	totalSpan := 0.
	aCell children do: [ :each |
		totalSpan := totalSpan + each span ].
	^ totalSpan 
]

{ #category : #rendering }
SGLTabulatorPresenter >> renderContentOn: html [
	|totalSpan|
	totalSpan := self computeTotalSpanForCell: self browser cell.
	self browser cell isRow
		ifTrue: [ self renderTableLayoutRow: self browser cell fromIndex: 1 withSpan: totalSpan on: html]
		ifFalse: [ self renderTableLayoutColumn: self browser cell fromIndex: 1 withSpan: totalSpan on: html ]
]

{ #category : #rendering }
SGLTabulatorPresenter >> renderTableColumn: aCell on: html [
	| tag |
	tag := html div.
	aCell hasId 
		ifTrue: [
			| pane |
			pane := self browser paneNamed: aCell id.
			tag id: (self renderer uuidFor: pane); with: [ self render: pane on: html ] ]
		ifFalse: [ 
			tag with: [ self renderTableLayoutRow: aCell fromIndex: 1 withSpan: (self computeTotalSpanForCell: aCell) on: html ] ] 
]

{ #category : #rendering }
SGLTabulatorPresenter >> renderTableLayoutColumn: aCell fromIndex: index withSpan: span on: html [
	| currentCell |
	currentCell  := aCell children at: index.
	html div 
		class: 'sgl-table'; 
		id: html nextId; 
		script: (self resizeHorizontalScriptWithCell: currentCell withSpan:  span - currentCell span on: html);
		with: [
			(aCell children size > 0) ifTrue: [
				self renderTableColumn: (aCell children at: index) on: html.
				(aCell children size = 1) ifFalse: [		
					(aCell children size = (index + 1)) 
						ifTrue: [ self renderTableColumn: (aCell children at: index+1) on: html ] 
						ifFalse: [ self renderTableLayoutColumn: aCell fromIndex: index+1withSpan: span - currentCell span on: html ] ] ] ]
]

{ #category : #rendering }
SGLTabulatorPresenter >> renderTableLayoutRow: aCell fromIndex: index withSpan: span on: html [
	| currentCell |
	currentCell  := aCell children at: index.
	html div 
		class: 'sgl-table'; 
		id: html nextId; 
		script: (self resizeVerticalScriptWithCell: currentCell withSpan:  span - currentCell span on: html);
		with: [
			(aCell children size > 0) ifTrue: [
				 self renderTableRow: (aCell children at: index) on: html.
				(aCell children size = 1) ifFalse: [		
					(aCell children size = (index + 1)) 
						ifTrue: [ self renderTableRow: (aCell children at: index+1) on: html ] 
						ifFalse: [ self renderTableLayoutRow: aCell fromIndex: index+1 withSpan: span - currentCell span on: html ] ] ] ]
]

{ #category : #rendering }
SGLTabulatorPresenter >> renderTableRow: aCell on: html [
	| tag |
	tag := html div.
	aCell hasId 
		ifTrue: [
			| pane |
			pane := self browser paneNamed: aCell id.
			tag id: (self renderer uuidFor: pane); with: [ self render: pane on: html ] ]
		ifFalse: [ 
			tag with: [ self renderTableLayoutColumn: aCell fromIndex: 1withSpan: (self computeTotalSpanForCell: aCell) on: html ] ] 

]

{ #category : #'jQuery-scripts' }
SGLTabulatorPresenter >> resizeHorizontalScriptWithCell: aCell withSpan: span on: html [
	^ html jQuery new glamourResize splitHorizontal 
		paneASpan: aCell span;
		remainingSpan: span 
]

{ #category : #'jQuery-scripts' }
SGLTabulatorPresenter >> resizeVerticalScriptWithCell: aCell withSpan: span on: html [
	^ html jQuery new glamourResize splitVertical
		paneASpan: aCell span;
		remainingSpan: span 
]
