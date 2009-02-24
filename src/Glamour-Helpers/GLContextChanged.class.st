Class {
	#name : #GLContextChanged,
	#superclass : #Announcement,
	#instVars : [
		'presentation',
		'property',
		'value',
		'oldValue'
	],
	#category : #'Glamour-Core'
}

{ #category : #accessing }
GLContextChanged >> oldValue [
	
	^oldValue
]

{ #category : #accessing }
GLContextChanged >> oldValue: anObject [
	
	oldValue := anObject
]

{ #category : #accessing }
GLContextChanged >> presentation [
	
	^presentation
]

{ #category : #accessing }
GLContextChanged >> presentation: aPresentation [
	
	presentation := aPresentation
]

{ #category : #accessing }
GLContextChanged >> property [
	
	^property
]

{ #category : #accessing }
GLContextChanged >> property: aSymbol [
	
	property := aSymbol
]

{ #category : #accessing }
GLContextChanged >> value [
	
	^value
]

{ #category : #accessing }
GLContextChanged >> value: anObject [
	
	value := anObject
]
