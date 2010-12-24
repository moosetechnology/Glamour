Extension { #name : #MOViewRenderer }

{ #category : #'*glamour-scripting' }
MOViewRenderer >> openWithStatusbar [
	| browser |
	browser := GLMTabulator withStatusbar.
	browser 
		act: [:b | b panes last presentations first view canvas exportAsPNG] entitled: 'Export as PNG'.
	browser 
		act: [:b | 
			b panes last presentations first view canvas root decreaseZoom.
			b panes last presentations first view canvas root updateWindow ] 
		icon: MondrianIcons mondrianZoomOut
		entitled: 'Zoom out'.
	browser 
		act: [:b | 
			b panes last presentations first view canvas root increaseZoom.
			b panes last presentations first view canvas root updateWindow ] 
		icon: MondrianIcons mondrianZoomIn 
		entitled: 'Zoom in'.
	browser title: 'Mondrian painting'.
	browser column: #painting.
	browser transmit to: #painting; andShow: [ :a | 
		a mondrian view: self ].
	^ browser openOn: self
]
