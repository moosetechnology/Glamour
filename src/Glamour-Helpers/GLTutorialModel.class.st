Class {
	#name : #GLTutorialModel,
	#superclass : #Object,
	#instVars : [
		'items'
	],
	#category : #'Glamour-Examples'
}

{ #category : #private }
GLTutorialModel >> addAllContainedItemsOf: aTutorialPundle to: aCollection [
	
	aCollection add: aTutorialPundle.
	aTutorialPundle childPundles
		do: [:each | self addAllContainedItemsOf: each to: aCollection]
]

{ #category : #accessing }
GLTutorialModel >> allPundles [
	
	items := OrderedCollection new.
	self
		addAllContainedItemsOf: self pundleRoot
		to: items.
	^items
]

{ #category : #accessing }
GLTutorialModel >> pundleRoot [
	
	^(GLTutorialPundle new)
		pundle: (PundleItem item: Registry);
		yourself
]
