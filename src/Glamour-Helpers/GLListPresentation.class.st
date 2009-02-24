Class {
	#name : #GLListPresentation,
	#superclass : #GLFormatedPresentation,
	#instVars : [
		'multipleSelection',
		'highlightPort'
	],
	#category : #'Glamour-Presentations'
}

{ #category : #accessing }
GLListPresentation >> beMultiple [
	
	multipleSelection := true
]

{ #category : #accessing }
GLListPresentation >> beSingle [
	
	multipleSelection := false
]

{ #category : #testing }
GLListPresentation >> isMultiple [
	
	^multipleSelection ifNil: [multipleSelection := false]
]

{ #category : #testing }
GLListPresentation >> isSingle [
	
	^self isMultiple not
]

{ #category : #rendering }
GLListPresentation >> renderGlamorouslyOn: aRenderer [
	
	^aRenderer renderListPresentation: self
]
