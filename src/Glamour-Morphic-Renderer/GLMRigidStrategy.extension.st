Extension { #name : #GLMRigidStrategy }

{ #category : #'*glamour-morphic-renderer' }
GLMRigidStrategy >> initializeContainer: aPanelMorph [
	
	aPanelMorph 
		hResizing: #shrinkWrap;
		vResizing: #shrinkWrap.
]

{ #category : #'*glamour-morphic-renderer' }
GLMRigidStrategy >> initializeFirstColumn: aPanelMorph [
	
	aPanelMorph 
		hResizing: #shrinkWrap;
		vResizing: #shrinkWrap.
]

{ #category : #'*glamour-morphic-renderer' }
GLMRigidStrategy >> initializePane: aMorphPane [
	
	aMorphPane
		hResizing: #rigid;
		vResizing: #rigid.
]

{ #category : #'*glamour-morphic-renderer' }
GLMRigidStrategy >> initializeSecondColumn: aPanelMorph [
	
	aPanelMorph 
		hResizing: #shrinkWrap;
		vResizing: #shrinkWrap.
]
