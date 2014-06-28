Class {
	#name : #GLMPager,
	#superclass : #GLMFinder,
	#instVars : [
		'scrollButtonIconRenderBlock'
	],
	#category : #'Glamour-Morphic-Pager-Glamour'
}

{ #category : #'as yet unclassified' }
GLMPager >> renderGlamorouslyOn: aRenderer [ 
	^ aRenderer renderPager: self
]

{ #category : #'as yet unclassified' }
GLMPager >> scrollButtonIconRenderBlock [

	^ scrollButtonIconRenderBlock
]

{ #category : #'as yet unclassified' }
GLMPager >> scrollButtonIconRenderBlock: aBlock [

	scrollButtonIconRenderBlock := aBlock
]
