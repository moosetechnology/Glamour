Class {
	#name : #GLMPagerCircleButtonModel,
	#superclass : #GLMPagerButtonModel,
	#instVars : [
		'pageIndex'
	],
	#category : #'Glamour-Morphic-Pager-Model'
}

{ #category : #accessing }
GLMPagerCircleButtonModel >> pageIndex [
	^ pageIndex
]

{ #category : #accessing }
GLMPagerCircleButtonModel >> pageIndex: anObject [
	pageIndex := anObject
]
