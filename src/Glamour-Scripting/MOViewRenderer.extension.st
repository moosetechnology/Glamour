Extension { #name : #MOViewRenderer }

{ #category : #'*glamour-scripting' }
MOViewRenderer >> openWithStatusbar [
	| browser |
	browser := GLMTabulator withStatusbar.
	browser title: 'Mondrian painting'.
	browser column: #painting.
	browser transmit to: #painting; andShow: [ :a | 
		a mondrian 
			view: self;
			act: [:m | m view canvas exportAsPNG] entitled: 'Export as PNG';
			act: [:m | 
				m view canvas root decreaseZoom.
				m view canvas  changed ] 
			icon: MondrianIcons mondrianZoomOut
			entitled: 'Zoom out';
			act: [:m | 
				m view canvas root increaseZoom.
				m view canvas root updateWindow ] 
			icon: MondrianIcons mondrianZoomIn 
			entitled: 'Zoom in'.].
	^ browser openOn: self
]
