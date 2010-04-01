Extension { #name : #MOViewRenderer }

{ #category : #'*glamour-scripting' }
MOViewRenderer >> openWithStatusbar [
	| browser |
	browser := GLMTabulator withStatusbar.
	browser title: 'Mondrian painting'.
	browser column: #painting.
	browser transmit to: #painting; andShow: [:a | 
		a mondrian view: self ].
	browser openOn: self
]
