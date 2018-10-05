Extension { #name : #MOViewRenderer }

{ #category : #'*glamour-mondrian-presentations' }
MOViewRenderer >> asBrowserWithStatusbar [
	| browser |
	browser := GLMTabulator withStatusbar.
	browser title: 'Mondrian painting'.
	browser column: #painting.
	browser 
			act: [:b | (b paneNamed: #painting) presentations first canvas exportAsPNG] entitled: 'Export as PNG';
			act: [:b | 
				(b paneNamed: #painting) presentations first canvas root decreaseZoom.
				(b paneNamed: #painting) presentations first canvas changed ] 
			icon: MondrianIcons mondrianZoomOut
			entitled: 'Zoom out';
			act: [:b | 
				(b paneNamed: #painting) presentations first canvas root increaseZoom.
				(b paneNamed: #painting) presentations first canvas root updateWindow ] 
			icon: MondrianIcons mondrianZoomIn 
			entitled: 'Zoom in'.
	browser transmit to: #painting; andShow: [ :a | 
		a mondrian view: self ].
	^ browser
]

{ #category : #'*glamour-mondrian-presentations' }
MOViewRenderer >> openWithStatusbar [
	^ self asBrowserWithStatusbar openOn: self
]
