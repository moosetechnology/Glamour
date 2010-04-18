Class {
	#name : #GLMTreePresentation,
	#superclass : #GLMListingPresentation,
	#instVars : [
		'children',
		'rootsExpanded',
		'allExpanded'
	],
	#category : #'Glamour-Presentations'
}

{ #category : #validation }
GLMTreePresentation >> allDisplayedDo: aBlock [
	self displayValue do: [ :eachRoot | 
		self withChildrenOf: eachRoot do: aBlock ]
]

{ #category : #accessing }
GLMTreePresentation >> allExpanded [
	self shouldAllExpand: true
]

{ #category : #accessing }
GLMTreePresentation >> children [ 
	 
	^children
]

{ #category : #accessing }
GLMTreePresentation >> children: anObject [ 
	 
	children := anObject
]

{ #category : #accessing }
GLMTreePresentation >> childrenValueOf: anObject [
	^ self children glamourValue: (anObject asGlamorousMultiValue, self entity asGlamorousMultiValue)
]

{ #category : #accessing }
GLMTreePresentation >> childrenValueOf: anObject atLevel: anInteger [
	^ self children glamourValue: (
		anObject asGlamorousMultiValue, 
		self entity asGlamorousMultiValue,
		anInteger asGlamorousMultiValue)
]

{ #category : #validation }
GLMTreePresentation >> defaultValidate: anObject on: aPort [
	"we only allow objects that are in the display value"
	(aPort name == #selection) ifFalse: [ ^ true ].
	self entity isNil ifTrue: [ ^ false ].
	self allDisplayedDo: [:each | each = anObject ifTrue: [ ^ true ] ].
	^ false
]

{ #category : #rendering }
GLMTreePresentation >> renderGlamorouslyOn: aRenderer [	
	self registerAnnouncements.
	^ aRenderer renderTreePresentation: self
]

{ #category : #accessing }
GLMTreePresentation >> rootsExpanded [
	self shouldRootsExpand: true
]

{ #category : #accessing }
GLMTreePresentation >> shouldAllExpand [
	^ allExpanded ifNil: [false]
]

{ #category : #accessing }
GLMTreePresentation >> shouldAllExpand: anObject [
	allExpanded := anObject
]

{ #category : #accessing }
GLMTreePresentation >> shouldRootsExpand [
	^ rootsExpanded ifNil: [false]
]

{ #category : #accessing }
GLMTreePresentation >> shouldRootsExpand: anObject [
	rootsExpanded := anObject
]

{ #category : #validation }
GLMTreePresentation >> withChildrenOf: anObject do: aBlock [
	aBlock value: anObject.
	(self childrenValueOf: anObject) do: [ :each |
		self withChildrenOf: each do: aBlock ]
]
