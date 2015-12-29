Class {
	#name : #GLMFillWidthAndHeightStrategy,
	#superclass : #GLMDashboardExtentStrategy,
	#category : #'Glamour-Browsers-Dashboard'
}

{ #category : #'as yet unclassified' }
GLMFillWidthAndHeightStrategy >> initializeContainer: aPanelMorph [
	
	aPanelMorph 
		hResizing: #spaceFill;
		vResizing: #shrinkWrap.
]

{ #category : #'as yet unclassified' }
GLMFillWidthAndHeightStrategy >> initializeFirstColumn: aPanelMorph [
	
	aPanelMorph 
		hResizing: #spaceFill;
		vResizing: #spaceFill.
]

{ #category : #'as yet unclassified' }
GLMFillWidthAndHeightStrategy >> initializePane: aMorphPane [
	
	aMorphPane
		hResizing: #spaceFill;
		vResizing: #spaceFill.
]

{ #category : #'as yet unclassified' }
GLMFillWidthAndHeightStrategy >> initializeSecondColumn: aPanelMorph [
	
	aPanelMorph 
		hResizing: #spaceFill;
		vResizing: #spaceFill.
]
