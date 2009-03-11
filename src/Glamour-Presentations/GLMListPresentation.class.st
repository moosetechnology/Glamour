Class {
	#name : #GLMListPresentation,
	#superclass : #GLMFormatedPresentation,
	#instVars : [
		'multipleSelection',
		'highlightPort',
		'itemActions'
	],
	#category : #'Glamour-Presentations'
}

{ #category : #accessing }
GLMListPresentation >> beMultiple [ 
	 
	multipleSelection := true
]

{ #category : #accessing }
GLMListPresentation >> beSingle [ 
	 
	multipleSelection := false
]

{ #category : #testing }
GLMListPresentation >> isMultiple [ 
	 
	^multipleSelection ifNil: [multipleSelection := false]
]

{ #category : #testing }
GLMListPresentation >> isSingle [ 
	 
	^self isMultiple not
]

{ #category : #rendering }
GLMListPresentation >> renderGlamorouslyOn: aRenderer [ 
	 
	^aRenderer renderListPresentation: self
]
