Extension { #name : #GLMFillWidthAndHeightStrategy }

{ #category : #'*glamour-morphic-renderer' }
GLMFillWidthAndHeightStrategy >> initializeContainer: aPanelMorph [
	
	aPanelMorph 
		hResizing: #spaceFill;
		vResizing: #shrinkWrap.
]

{ #category : #'*glamour-morphic-renderer' }
GLMFillWidthAndHeightStrategy >> initializeFirstColumn: aPanelMorph [
	
	aPanelMorph 
		hResizing: #spaceFill;
		vResizing: #spaceFill.
]

{ #category : #'*glamour-morphic-renderer' }
GLMFillWidthAndHeightStrategy >> initializePane: aMorphPane [
	
	aMorphPane
		hResizing: #spaceFill;
		vResizing: #spaceFill.
]

{ #category : #'*glamour-morphic-renderer' }
GLMFillWidthAndHeightStrategy >> initializeSecondColumn: aPanelMorph [
	
	aPanelMorph 
		hResizing: #spaceFill;
		vResizing: #spaceFill.
]
