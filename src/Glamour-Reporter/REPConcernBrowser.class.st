Class {
	#name : #REPConcernBrowser,
	#superclass : #GLMBrowserTemplate,
	#instVars : [
		'root'
	],
	#category : #'Glamour-Reporter'
}

{ #category : #'as yet unclassified' }
REPConcernBrowser class >> openOn: aConcern [
	^ self new openOn: aConcern
]

{ #category : #'as yet unclassified' }
REPConcernBrowser >> buildBrowser [
	browser := GLMTabulator withStatusbar.
	browser title: [ :concern | concern label ].
	browser column: [: c | 
		c row: #list span: 4; row: #explanation ]; column: #results span: 4.
	browser transmit to: #list; andShow: [:a |
		a tree 
			title: 'Index';
			display: [ :concern | concern children ];
			children: #children;
			format: [ :concern | concern status label ]].
	browser transmit to: #results; from: #list; andShow: [:a |
		a dynamic
			title: #label;
			display: [:each | each browser noTitle ] ].
	browser transmit to: #explanation; from: #list; andShow: [:a |
		a text 
			display: #explanation ].
	^ browser 
]
