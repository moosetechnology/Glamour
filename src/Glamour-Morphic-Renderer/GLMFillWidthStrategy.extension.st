Extension { #name : #GLMFillWidthStrategy }

{ #category : #'*glamour-morphic-renderer' }
GLMFillWidthStrategy >> initializeContainer: aPanelMorph [
	
	aPanelMorph 
		hResizing: #spaceFill;
		vResizing: #shrinkWrap.
]

{ #category : #'*glamour-morphic-renderer' }
GLMFillWidthStrategy >> initializeFirstColumn: aPanelMorph [
	
	aPanelMorph 
		hResizing: #spaceFill;
		vResizing: #shrinkWrap.
]

{ #category : #'*glamour-morphic-renderer' }
GLMFillWidthStrategy >> initializePane: aMorphPane [
	
	aMorphPane
		hResizing: #spaceFill;
		vResizing: #rigid.
]

{ #category : #'*glamour-morphic-renderer' }
GLMFillWidthStrategy >> initializeSecondColumn: aPanelMorph [
	
	aPanelMorph 
		hResizing: #spaceFill;
		vResizing: #shrinkWrap.
]
