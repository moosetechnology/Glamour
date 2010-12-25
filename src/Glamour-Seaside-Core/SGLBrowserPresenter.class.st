Class {
	#name : #SGLBrowserPresenter,
	#superclass : #SGLPresenter,
	#instVars : [
		'browser'
	],
	#category : #'Glamour-Seaside-Rendering'
}

{ #category : #accessing }
SGLBrowserPresenter >> browser [
	^browser
]

{ #category : #initialization }
SGLBrowserPresenter >> initializeFor: aBrowser [
	browser := aBrowser
]
