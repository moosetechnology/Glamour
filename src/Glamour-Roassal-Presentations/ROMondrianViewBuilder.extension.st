Extension { #name : #ROMondrianViewBuilder }

{ #category : #'*glamour-roassal-presentations' }
ROMondrianViewBuilder >> asBrowserWithStatusbar [
	| browser |
	browser := GLMTabulator withStatusbar.
	browser title: 'Roassal painting'.
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
		a roassal view: self ].
	^ browser
]

{ #category : #'*glamour-roassal-presentations' }
ROMondrianViewBuilder >> openWithStatusbar [
	^ self asBrowserWithStatusbar openOn: self
]
