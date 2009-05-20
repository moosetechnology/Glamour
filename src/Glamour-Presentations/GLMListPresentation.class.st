Class {
	#name : #GLMListPresentation,
	#superclass : #GLMFormatedPresentation,
	#instVars : [
		'multipleSelection',
		'highlightPort',
		'itemActions',
		'isSearchable'
	],
	#category : #'Glamour-Presentations'
}

{ #category : #accessing }
GLMListPresentation >> beMultiple [ 
	 
	multipleSelection _ true
]

{ #category : #accessing }
GLMListPresentation >> beSearchable [
	isSearchable := true
]

{ #category : #accessing }
GLMListPresentation >> beSingle [ 
	 
	multipleSelection _ false
]

{ #category : #testing }
GLMListPresentation >> isMultiple [ 
	^ multipleSelection ifNil: [multipleSelection := false]
]

{ #category : #testing }
GLMListPresentation >> isSearchable [
	^ isSearchable ifNil: [isSearchable := false]
]

{ #category : #testing }
GLMListPresentation >> isSingle [ 
	^ self isMultiple not
]

{ #category : #rendering }
GLMListPresentation >> renderGlamorouslyOn: aRenderer [ 
	 
	^aRenderer renderListPresentation: self
]
