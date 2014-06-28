Class {
	#name : #GLMPager,
	#superclass : #GLMFinder,
	#instVars : [
		'scrollButtonIconRenderBlock'
	],
	#category : #'Glamour-Morphic-Pager-Glamour'
}

{ #category : #rendering }
GLMPager >> renderGlamorouslyOn: aRenderer [

	^ aRenderer renderPager: self
]

{ #category : #accessing }
GLMPager >> scrollButtonIconRenderBlock [

	^ scrollButtonIconRenderBlock
]

{ #category : #accessing }
GLMPager >> scrollButtonIconRenderBlock: aBlock [

	scrollButtonIconRenderBlock := aBlock
]
