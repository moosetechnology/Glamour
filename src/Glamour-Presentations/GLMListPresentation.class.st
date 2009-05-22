Class {
	#name : #GLMListPresentation,
	#superclass : #GLMFormatedPresentation,
	#instVars : [
		'multipleSelection',
		'highlightPort',
		'itemActions',
		'isSearchable',
		'searchBlock'
	],
	#category : #'Glamour-Presentations'
}

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
