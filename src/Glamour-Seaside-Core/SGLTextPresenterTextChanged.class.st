Class {
	#name : #SGLTextPresenterTextChanged,
	#superclass : #Announcement,
	#instVars : [
		'text'
	],
	#category : #'Glamour-Seaside-Core'
}

{ #category : #accessing }
SGLTextPresenterTextChanged >> text [
	^ text
]

{ #category : #accessing }
SGLTextPresenterTextChanged >> text: anObject [
	text := anObject
]
