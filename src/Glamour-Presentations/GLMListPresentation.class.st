Class {
	#name : #GLMListPresentation,
	#superclass : #GLMFormatedPresentation,
	#instVars : [
		'multipleSelection',
		'highlightPort',
		'itemActions',
		'isSearchable',
		'searchBlock',
		'filterBlock',
		'menu',
		'menuBlock'
	],
	#category : #'Glamour-Presentations'
}

{ #category : #accessing }
GLMListPresentation >> filterStrategy [
	^filterBlock
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

{ #category : #callbacks }
GLMListPresentation >> menu: aBlock [ 

	menuBlock := aBlock
]

{ #category : #accessing }
GLMListPresentation >> menuBlock [
	^menuBlock
]

{ #category : #rendering }
GLMListPresentation >> renderGlamorouslyOn: aRenderer [ 
	 
	^aRenderer renderListPresentation: self
]
