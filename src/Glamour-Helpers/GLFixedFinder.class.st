Class {
	#name : #GLFixedFinder,
	#superclass : #GLFinder,
	#instVars : [
		'paneCount'
	],
	#category : #'Glamour-Browsers'
}

{ #category : #accessing }
GLFixedFinder >> numberOfVisiblePanes [
	
	^paneCount
]

{ #category : #accessing }
GLFixedFinder >> numberOfVisiblePanes: anInteger [
	
	paneCount := anInteger
]
