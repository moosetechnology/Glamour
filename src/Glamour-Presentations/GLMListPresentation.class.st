Class {
	#name : #GLMListPresentation,
	#superclass : #GLMTagablePresentation,
	#instVars : [
		'itemActions',
		'searchBlock',
		'filterBlock',
		'allowsMultipleSelection'
	],
	#category : #'Glamour-Presentations'
}

{ #category : #testing }
GLMListPresentation >> allowsInput [
	^ searchBlock notNil or: [ filterBlock notNil ]
]

{ #category : #accessing }
GLMListPresentation >> filterStrategy [
	^filterBlock
]

{ #category : #accessing }
GLMListPresentation >> hasTags [
	^ tag notNil
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

{ #category : #accessing }
GLMListPresentation >> tag [
	^ tag
]

{ #category : #accessing }
GLMListPresentation >> tag: anObject [
	tag := anObject
]

{ #category : #accessing }
GLMListPresentation >> tagFor: anObject [
	self tag glamourValue: (anObject asGlamorousMultiValue, self entity asGlamorousMultiValue)
]
