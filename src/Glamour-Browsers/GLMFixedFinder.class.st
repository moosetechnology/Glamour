Class {
	#name : #GLMFixedFinder,
	#superclass : #GLMFinder,
	#instVars : [
		'paneCount'
	],
	#category : #'Glamour-Browsers'
}

{ #category : #accessing }
GLMFixedFinder >> numberOfVisiblePanes [ 
	 
	^paneCount
]

{ #category : #accessing }
GLMFixedFinder >> numberOfVisiblePanes: anInteger [ 
	 
	paneCount _ anInteger
]
