Class {
	#name : #SGLTabulatorPresenter,
	#superclass : #SGLBrowserPresenter,
	#category : #'Glamour-Seaside-Rendering'
}

{ #category : #rendering }
SGLTabulatorPresenter >> renderContentOn: html [
	self browser cell isRow
		ifTrue: [ self renderTableLayoutRow: self browser cell withIndex: 1 on: html]
		ifFalse: [ self renderTableLayoutColumn: self browser cell withIndex: 1 on: html ]
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
			tag with: [ self renderTableLayoutRow: aCell withIndex: 1 on: html ] ] 
]

{ #category : #rendering }
SGLTabulatorPresenter >> renderTableLayoutColumn: aCell on: html [
	html div "class: 'sgl-table'; class: 'sgl-table-vbox';" 
	script: (html jQuery new glamourResize splitHorizontal);
	with: [
		aCell children 
			do: [ :each |
				| tag |
				tag := html div "boxFlex: each span; style: 'position: relative;'.".
				each hasId 
					ifTrue: [
						| pane |
						pane := self browser paneNamed: each id.
						tag id: (self renderer uuidFor: pane); with: [ self render: pane on: html ] ]
					ifFalse: [ 
						tag with: [ self renderTableLayoutRow: each on: html ] ] ]
			"separatedBy: [ html div class: 'sgl-table-split' ]" ]
]

{ #category : #rendering }
SGLTabulatorPresenter >> renderTableLayoutColumn: aCell withIndex: index on: html [
	html div 
		class: 'sgl-table'; 
		"class: 'sgl-table-hbox';"
		id: html nextId; 
		script: (html jQuery new glamourResize splitHorizontal);
		with: [
			(aCell children size > 0) ifTrue: [
				self renderTableColumn: (aCell children at: index) on: html.
				(aCell children size = 1) ifFalse: [		
					(aCell children size = (index + 1)) 
						ifTrue: [ self renderTableColumn: (aCell children at: index+1) on: html ] 
						ifFalse: [ self renderTableLayoutColumn: aCell withIndex: index+1 on: html ] ] ] ]
]

{ #category : #rendering }
SGLTabulatorPresenter >> renderTableLayoutRow: aCell on: html [
	html div" class: 'sgl-table'; class: 'sgl-table-hbox';" 
	script: (html jQuery new glamourResize splitVertical);
	with: [
		aCell children 
			do: [ :each |
				| tag |
				tag := html div "boxFlex: each span; style: 'position: relative;'.".
				each hasId 
					ifTrue: [
						| pane |
						pane := self browser paneNamed: each id.
						tag id: (self renderer uuidFor: pane); with: [ self render: pane on: html ] ]
					ifFalse: [ 
						tag with: [ self renderTableLayoutColumn: each on: html ] ] ]
			"separatedBy: [ html div class: 'sgl-table-split' ]" ]
]

{ #category : #rendering }
SGLTabulatorPresenter >> renderTableLayoutRow: aCell withIndex: index on: html [
	html div 
		class: 'sgl-table'; 
		"class: 'sgl-table-hbox';"
		id: html nextId; 
		script: (html jQuery new glamourResize splitVertical);
		with: [
			(aCell children size > 0) ifTrue: [
				 self renderTableRow: (aCell children at: index) on: html.
				(aCell children size = 1) ifFalse: [		
					(aCell children size = (index + 1)) 
						ifTrue: [ self renderTableRow: (aCell children at: index+1) on: html ] 
						ifFalse: [ self renderTableLayoutRow: aCell withIndex: index+1 on: html ] ] ] ]
]

{ #category : #rendering }
SGLTabulatorPresenter >> renderTableRow: aRow on: html [
	| tag |
	tag := html div.
	aRow hasId 
		ifTrue: [
			| pane |
			pane := self browser paneNamed: aRow id.
			tag id: (self renderer uuidFor: pane); with: [ self render: pane on: html ] ]
		ifFalse: [ 
			tag with: [ self renderTableLayoutColumn: aRow withIndex: 1 on: html ] ] 

]
