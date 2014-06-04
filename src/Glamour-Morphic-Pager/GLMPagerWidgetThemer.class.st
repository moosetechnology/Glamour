Class {
	#name : #GLMPagerWidgetThemer,
	#superclass : #Object,
	#category : #'Glamour-Morphic-Pager-Morphic'
}

{ #category : #'as yet unclassified' }
GLMPagerWidgetThemer >> previewPaneStyleFor: aMorph [

	aMorph borderColor: (Color lightGray)
]

{ #category : #'as yet unclassified' }
GLMPagerWidgetThemer >> selectedPaneStyleFor: aMorph [

	aMorph borderColor: (Color transparent)
]
