Class {
	#name : #GLMRigidStrategy,
	#superclass : #GLMDashboardExtentStrategy,
	#category : #'Glamour-Browsers-Dashboard'
}

{ #category : #'as yet unclassified' }
GLMRigidStrategy >> initializeContainer: aPanelMorph [
	
	aPanelMorph 
		hResizing: #shrinkWrap;
		vResizing: #shrinkWrap.
]

{ #category : #'as yet unclassified' }
GLMRigidStrategy >> initializeFirstColumn: aPanelMorph [
	
	aPanelMorph 
		hResizing: #shrinkWrap;
		vResizing: #shrinkWrap.
]

{ #category : #'as yet unclassified' }
GLMRigidStrategy >> initializePane: aMorphPane [
	
	aMorphPane
		hResizing: #rigid;
		vResizing: #rigid.
]

{ #category : #'as yet unclassified' }
GLMRigidStrategy >> initializeSecondColumn: aPanelMorph [
	
	aPanelMorph 
		hResizing: #shrinkWrap;
		vResizing: #shrinkWrap.
]
