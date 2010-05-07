Extension { #name : #MOViewRenderer }

{ #category : #'*glamour-scripting' }
MOViewRenderer >> openWithStatusbar [
	| browser |
	browser := GLMTabulator withStatusbar.
	browser act: [:b | b panes last presentations first view canvas exportAsPNG] entitled: 'Export as PNG'.
	browser title: 'Mondrian painting'.
	browser column: #painting.
	browser transmit to: #painting; andShow: [ :a | 
		a mondrian view: self ].
	browser openOn: self
]
