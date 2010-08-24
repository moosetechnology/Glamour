Class {
	#name : #SGLTextPresenterSelectionChanged,
	#superclass : #Announcement,
	#instVars : [
		'selectionInterval',
		'selectedText'
	],
	#category : #'Glamour-Seaside-Core'
}

{ #category : #accessing }
SGLTextPresenterSelectionChanged >> selectedText [
	^ selectedText
]

{ #category : #accessing }
SGLTextPresenterSelectionChanged >> selectedText: anObject [
	selectedText := anObject
]

{ #category : #accessing }
SGLTextPresenterSelectionChanged >> selectionInterval [
	^ selectionInterval
]

{ #category : #accessing }
SGLTextPresenterSelectionChanged >> selectionInterval: anObject [
	selectionInterval := anObject
]
