Class {
	#name : #GLMListingPresentation,
	#superclass : #GLMFormatedPresentation,
	#instVars : [
		'tagsBlock',
		'searchBlock',
		'filterBlock',
		'amountToShowBlock',
		'allowsMultipleSelection'
	],
	#category : #'Glamour-Presentations'
}

{ #category : #testing }
GLMListingPresentation >> allowsFilter [
	^ filterBlock notNil
]

{ #category : #testing }
GLMListingPresentation >> allowsInput [
	^ self allowsFilter or: [ self allowsSearch ]
]

{ #category : #testing }
GLMListingPresentation >> allowsSearch [
	^ searchBlock notNil
]

{ #category : #accessing }
GLMListingPresentation >> amountToShow [
	^ amountToShowBlock glamourValue: self entity
]

{ #category : #accessing }
GLMListingPresentation >> childrenValueOf: anObject [
	self flag: 'this is rather hackish, but needed to treat list and tree in the same way.'.
	^ OrderedCollection new
]

{ #category : #accessing }
GLMListingPresentation >> filterStrategy [
	^filterBlock
]

{ #category : #testing }
GLMListingPresentation >> hasTags [
	^ tagsBlock notNil
]

{ #category : #testing }
GLMListingPresentation >> isMultiple [
	^ allowsMultipleSelection ifNil: [ allowsMultipleSelection := false ]
]

{ #category : #testing }
GLMListingPresentation >> isSingle [ 
	^ self isMultiple not
]

{ #category : #testing }
GLMListingPresentation >> limitsAmount [
	^ amountToShowBlock notNil
]

{ #category : #accessing }
GLMListingPresentation >> searchStrategy [
	^ searchBlock
]

{ #category : #accessing }
GLMListingPresentation >> selectionPath [
	^ (self pane port: #selectionPath) value
]

{ #category : #accessing }
GLMListingPresentation >> selectionPath: anObject [
	(self pane port: #selectionPath) value: anObject
]

{ #category : #accessing }
GLMListingPresentation >> tagsBlock [
	^ tagsBlock
]

{ #category : #accessing }
GLMListingPresentation >> tagsBlock: anObject [
	tagsBlock := anObject
]

{ #category : #accessing }
GLMListingPresentation >> tagsFor: anObject [
	| value |
	self hasTags ifFalse: [ ^ OrderedCollection new ].
	value := self tagsBlock glamourValue: (anObject asGlamorousMultiValue, self entity asGlamorousMultiValue).
	^ value isString
		ifTrue: [ OrderedCollection with: value ]
		ifFalse: [ value asOrderedCollection ]
]
