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
			act: [:m | m canvas exportAsPNG] entitled: 'Export as PNG';
			act: [:m | 
				m canvas root decreaseZoom.
				m canvas  changed ] 
			icon: MondrianIcons mondrianZoomOut
			entitled: 'Zoom out';
			act: [:m | 
				m canvas root increaseZoom.
				m canvas root updateWindow ] 
			icon: MondrianIcons mondrianZoomIn 
			entitled: 'Zoom in'.].
	^ browser openOn: self
]
