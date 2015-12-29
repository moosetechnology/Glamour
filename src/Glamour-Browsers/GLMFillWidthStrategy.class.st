Class {
	#name : #GLMFillWidthStrategy,
	#superclass : #GLMDashboardExtentStrategy,
	#category : #'Glamour-Browsers-Dashboard'
}

{ #category : #'as yet unclassified' }
GLMFillWidthStrategy >> initializeContainer: aPanelMorph [
	
	aPanelMorph 
		hResizing: #spaceFill;
		vResizing: #shrinkWrap.
]

{ #category : #'as yet unclassified' }
GLMFillWidthStrategy >> initializeFirstColumn: aPanelMorph [
	
	aPanelMorph 
		hResizing: #spaceFill;
		vResizing: #shrinkWrap.
]

{ #category : #'as yet unclassified' }
GLMFillWidthStrategy >> initializePane: aMorphPane [
	
	aMorphPane
		hResizing: #spaceFill;
		vResizing: #rigid.
]

{ #category : #'as yet unclassified' }
GLMFillWidthStrategy >> initializeSecondColumn: aPanelMorph [
	
	aPanelMorph 
		hResizing: #spaceFill;
		vResizing: #shrinkWrap.
]
