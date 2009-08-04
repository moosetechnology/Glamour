Class {
	#name : #GLMListPresentation,
	#superclass : #GLMFormatedPresentation,
	#instVars : [
		'multipleSelection',
		'highlightPort',
		'itemActions',
		'searchBlock',
		'filterBlock',
		'menu',
		'allowsInput'
	],
	#category : #'Glamour-Presentations'
}

{ #category : #testing }
GLMListPresentation >> allowsInput [
	^ allowsInput ifNil: [ allowsInput := false ]
]

{ #category : #accessing }
GLMListPresentation >> filterStrategy [
	^filterBlock
]

{ #category : #testing }
GLMListPresentation >> isMultiple [ 
	^ multipleSelection ifNil: [multipleSelection := false]
]

{ #category : #testing }
GLMListPresentation >> isSingle [ 
	^ self isMultiple not
]

{ #category : #rendering }
GLMListPresentation >> renderGlamorouslyOn: aRenderer [ 
	 
	^aRenderer renderListPresentation: self
]
