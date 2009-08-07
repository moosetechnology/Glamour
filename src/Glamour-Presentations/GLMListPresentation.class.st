Class {
	#name : #GLMListPresentation,
	#superclass : #GLMFormatedPresentation,
	#instVars : [
		'highlightPort',
		'itemActions',
		'searchBlock',
		'filterBlock',
		'menu',
		'allowsInput',
		'allowsMultipleSelection'
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
	^ allowsMultipleSelection ifNil: [ allowsMultipleSelection := false ]
]

{ #category : #testing }
GLMListPresentation >> isSingle [ 
	^ self isMultiple not
]

{ #category : #rendering }
GLMListPresentation >> renderGlamorouslyOn: aRenderer [ 
	^aRenderer renderListPresentation: self
]
