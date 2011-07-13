"
This is the abstract class for a presentation that is supposed to show a list of elements. Thus, the displayValue should be a list.

Instance Variables:
	tagsBlock	<Object>
	searchBlock	<MocketryProxy | Object | SMProxy>
	filterBlock	<MocketryProxy | Object | SMProxy>
	amountToShowBlock	<Object>
	allowsMultipleSelection	<Boolean>
	tagsFilterBlock	<MocketryProxy | Object | SMProxy>
	allowsDeselection	<Boolean>
	tagsStyle	<String>
	helpMessage	<String>
"
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
		'helpMessage',
		'sortBlock',
		'textBackgroundColor'
	],
	#category : #'Glamour-Presentations'
}

{ #category : #scripting }
GLMListingPresentation >> allowDeselection [
	self allowsDeselection: true
]

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

{ #category : #scripting }
GLMListingPresentation >> beMultiple [
	allowsMultipleSelection := true
]

{ #category : #scripting }
GLMListingPresentation >> beSingle [
	allowsMultipleSelection := false
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

{ #category : #'accessing values' }
GLMListingPresentation >> displayValue [
	^ sortBlock 
		ifNil: [super displayValue]
		ifNotNil: [super displayValue sorted: sortBlock]
]

{ #category : #scripting }
GLMListingPresentation >> filterOn: aBlock [ 
	filterBlock := aBlock
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

{ #category : #scripting }
GLMListingPresentation >> searchOn: aBlock [
	searchBlock := aBlock
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

{ #category : #scripting }
GLMListingPresentation >> showOnly: aBlock [
	amountToShowBlock := aBlock
]

{ #category : #accessing }
GLMListingPresentation >> sortBlock [
	^ sortBlock
]

{ #category : #accessing }
GLMListingPresentation >> sortBlock: anObject [
	sortBlock := anObject
]

{ #category : #scripting }
GLMListingPresentation >> sorted [
	sortBlock := [:a :b | a < b]
]

{ #category : #scripting }
GLMListingPresentation >> sorted: aBlock [
	sortBlock := aBlock  
]

{ #category : #scripting }
GLMListingPresentation >> tags: anObject [
	"Displays a tag along the node with a text and/or an icon, as returned when evaluating anObject. Clicking on such a node's' tag would remove all nodes that don't have this tag (this behavior can be changed by sending the #tagsFilter: message)"
	tagsBlock := anObject.
	self hasTagsFilter ifFalse:[ tagsFilterBlock := anObject ]
]

{ #category : #accessing }
GLMListingPresentation >> tagsBlock [
	^ tagsBlock
]

{ #category : #accessing }
GLMListingPresentation >> tagsBlock: anObject [
	tagsBlock := anObject
]

{ #category : #scripting }
GLMListingPresentation >> tagsFilter: anObject [
	"Changes the default behavior of hiding all nodes that don't have the exact same tag as the one just clicked"
	tagsFilterBlock := anObject 
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
GLMListingPresentation >> textBackgroundColor [

	^ textBackgroundColor ifNil: [textBackgroundColor := GLMTransparentColor new]
]

{ #category : #accessing }
GLMListingPresentation >> textBackgroundColor:  aBlockOrAColor [

	textBackgroundColor := aBlockOrAColor
]

{ #category : #accessing }
GLMListingPresentation >> textBackgroundColorFor: anObject [
	^ self textBackgroundColor glamourValue: (anObject asGlamorousMultiValue, self entity asGlamorousMultiValue)
]

{ #category : #accessing }
GLMListingPresentation >> whiteRectangledTags [

	tagsStyle := #whiteRectangledButton
]
