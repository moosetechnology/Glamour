Class {
	#name : #SGLTabulatorPresenter,
	#superclass : #SGLBrowserPresenter,
	#category : #'Glamour-Seaside-Rendering'
}

{ #category : #rendering }
SGLTabulatorPresenter >> renderContentOn: html [
	self browser cell isRow
		ifTrue: [ self renderTableLayoutRow: self browser cell on: html]
		ifFalse: [ self renderTableLayoutColumn: self browser cell on: html ]
]

{ #category : #rendering }
SGLTabulatorPresenter >> renderTableLayoutColumn: aCell on: html [
	html div class: 'sgl-table'; class: 'sgl-table-vbox'; with: [
		aCell children 
			do: [ :each |
				| tag |
				tag := html div boxFlex: each span; style: 'position: relative;'.
				each hasId 
					ifTrue: [
						| pane |
						pane := self browser paneNamed: each id.
						tag id: (self renderer uuidFor: pane); with: [ self render: pane on: html ] ]
					ifFalse: [ 
						tag with: [ self renderTableLayoutRow: each on: html ] ] ]
			separatedBy: [ html div class: 'sgl-table-split' ] ]
]

{ #category : #rendering }
SGLTabulatorPresenter >> renderTableLayoutRow: aCell on: html [
	html div class: 'sgl-table'; class: 'sgl-table-hbox'; with: [
		aCell children 
			do: [ :each |
				| tag |
				tag := html div boxFlex: each span; style: 'position: relative;'.
				each hasId 
					ifTrue: [
						| pane |
						pane := self browser paneNamed: each id.
						tag id: (self renderer uuidFor: pane); with: [ self render: pane on: html ] ]
					ifFalse: [ 
						tag with: [ self renderTableLayoutColumn: each on: html ] ] ]
			separatedBy: [ html div class: 'sgl-table-split' ] ]
]
