Class {
	#name : #GLMListingPresentation,
	#superclass : #GLMFormatedPresentation,
	#instVars : [
		'tagsBlock',
		'searchBlock',
		'filterBlock',
		'amountToShowBlock',
		'allowsMultipleSelection',
		'tagsFilterBlock',
		'allowsDeselection',
		'tagsStyle',
		'helpMessage'
	],
	#category : #'Glamour-Presentations'
}

{ #category : #accessing }
GLMListingPresentation >> allowsDeselection [
	^ allowsDeselection ifNil: [allowsDeselection := false]
]

{ #category : #accessing }
GLMListingPresentation >> allowsDeselection: anObject [
	allowsDeselection := anObject
]

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
GLMListingPresentation >> childrenValueOf: anObject atLevel: anInteger [
	self flag: 'this is rather hackish, but needed to treat list and tree in the same way.'.
	^ OrderedCollection new
]

{ #category : #accessing }
GLMListingPresentation >> columns [
	self flag: 'this is rather hackish, but needed to treat list and tree in the same way.'.
	^ OrderedCollection new
]

{ #category : #accessing }
GLMListingPresentation >> filterStrategy [
	^filterBlock
]

{ #category : #accessing }
GLMListingPresentation >> grayRoundedTags [

	tagsStyle := #grayRoundedButton
]

{ #category : #testing }
GLMListingPresentation >> hasTags [
	^ tagsBlock notNil
]

{ #category : #testing }
GLMListingPresentation >> hasTagsFilter [
	^ tagsFilterBlock notNil
]

{ #category : #accessing }
GLMListingPresentation >> helpMessage [

	^ helpMessage ifNil: [
		helpMessage := 'Search Input'
		]

	
]

{ #category : #accessing }
GLMListingPresentation >> helpMessage: aString [

	helpMessage := aString.

	
]

{ #category : #testing }
GLMListingPresentation >> isMultiple [
	^ allowsMultipleSelection ifNil: [ allowsMultipleSelection := false ]
]

{ #category : #testing }
GLMListingPresentation >> isSingle [ 
	^ self isMultiple not
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
GLMListingPresentation >> tagsFilterBlock [
	^ tagsFilterBlock
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

{ #category : #accessing }
GLMListingPresentation >> tagsFor: anObject to: operation [
	| value hasTags tags |
	
	operation == #show 
	ifTrue: [ hasTags := self hasTags.
				tags := self tagsBlock ] 
	ifFalse: [ hasTags := self hasTagsFilter.
				 tags := self tagsFilterBlock ].
	
	hasTags ifFalse: [ ^ OrderedCollection new ].
	value := tags glamourValue: (anObject asGlamorousMultiValue, self entity asGlamorousMultiValue).
	^ value isString
		ifTrue: [ OrderedCollection with: value ]
		ifFalse: [ value asOrderedCollection ]
]

{ #category : #accessing }
GLMListingPresentation >> tagsStyle [

	^tagsStyle ifNil:[ self grayRoundedTags. tagsStyle ]
]

{ #category : #accessing }
GLMListingPresentation >> whiteRectangledTags [

	tagsStyle := #whiteRectangledButton
]
