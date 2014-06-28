Class {
	#name : #GLMPagerScrollButtonModel,
	#superclass : #GLMPagerButtonModel,
	#instVars : [
		'pageIndex'
	],
	#category : #'Glamour-Morphic-Pager-Model'
}

{ #category : #accessing }
GLMPagerScrollButtonModel >> pageIndex [
	^ pageIndex
]

{ #category : #accessing }
GLMPagerScrollButtonModel >> pageIndex: anObject [
	pageIndex := anObject
]
