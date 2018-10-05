Class {
	#name : #SGLTextPresenterSelectedTextChanged,
	#superclass : #Announcement,
	#instVars : [
		'selectedText'
	],
	#category : #'Glamour-Seaside-Rendering'
}

{ #category : #accessing }
SGLTextPresenterSelectedTextChanged >> selectedText [
	^ selectedText
]

{ #category : #accessing }
SGLTextPresenterSelectedTextChanged >> selectedText: anObject [
	selectedText := anObject
]
