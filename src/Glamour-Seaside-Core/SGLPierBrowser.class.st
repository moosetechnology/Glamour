Class {
	#name : #SGLPierBrowser,
	#superclass : #SGLComponent,
	#category : #'Glamour-Seaside-Examples'
}

{ #category : #initialization }
SGLPierBrowser class >> initialize [
	self registerAsApplication: 'glamour/pier'
]

{ #category : #accessing }
SGLPierBrowser >> browser [
	| browser |
	browser := GLMTabulator new.
	browser column: [:c | c row: #navigation; row: #map ];
			column: #editor span: 4.
	browser showOn: #navigation; using: [
		browser tree
			children: [ :page | page enumerator contents ];
			format: [ :page | page title ] ].
	browser showOn: #map; using: [
		browser mondrian
			painting: [ :view :page |
				view nodeShape: (MORectangleShape new height: [ :each | each document text size // 50 + 20 ]; width: [ :each | each document text size // 50 + 20 ]).
				view nodes: page root enumerator all.
				view edgesFrom: #parent.
				view treeLayout ]
	].
	browser showOn: #editor; from: #navigation; using: [
		browser magritte ].
	browser showOn: #editor; from: #map; using: [
		browser magritte ].
	^ browser 
]

{ #category : #accessing }
SGLPierBrowser >> model [
	^ PRKernel instances anyOne root
]
