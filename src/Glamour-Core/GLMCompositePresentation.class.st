Class {
	#name : #GLMCompositePresentation,
	#superclass : #GLMPresentation,
	#traits : 'GLMTPresentationBuilder',
	#classTraits : 'GLMTPresentationBuilder classTrait',
	#instVars : [
		'presentations'
	],
	#category : #'Glamour-Core'
}

{ #category : #accessing }
GLMCompositePresentation >> add: aPresentation [
	^ self presentations add: aPresentation
]

{ #category : #accessing }
GLMCompositePresentation >> allSatisfy: aBlock [
	^ self presentations allSatisfy: aBlock 
]

{ #category : #accessing }
GLMCompositePresentation >> anySatisfy: aBlock [
	^ self presentations anySatisfy: aBlock 
]

{ #category : #accessing }
GLMCompositePresentation >> at: aNumber [
	^ self presentations at: aNumber 
]

{ #category : #accessing }
GLMCompositePresentation >> collect: aBlock [
	^ self copy presentations: (self presentations collect: aBlock ); yourself
]

{ #category : #accessing }
GLMCompositePresentation >> do: aBlock [
	^ self presentations do: aBlock 
]

{ #category : #accessing }
GLMCompositePresentation >> first [
	^ self presentations first
]

{ #category : #accessing }
GLMCompositePresentation >> includes: aPresentation [
	^ self presentations includes: aPresentation 
]

{ #category : #accessing }
GLMCompositePresentation >> isEmpty [
	^ self presentations isEmpty
]

{ #category : #accessing }
GLMCompositePresentation >> last [
	^ self presentations last
]

{ #category : #accessing }
GLMCompositePresentation >> matchingPresentations [
	^ self presentations select: [:each | each matches]
]

{ #category : #accessing }
GLMCompositePresentation >> presentations [
	^ presentations ifNil: [presentations := OrderedCollection new]
]

{ #category : #accessing }
GLMCompositePresentation >> presentations: anObject [
	presentations := anObject
]

{ #category : #rendering }
GLMCompositePresentation >> renderGlamorouslyOn: aRenderer [
	^ aRenderer renderCompositePresentation: self
]

{ #category : #accessing }
GLMCompositePresentation >> select: aBlock [
	^ self presentations select: aBlock
]

{ #category : #accessing }
GLMCompositePresentation >> size [
	^ self presentations size
]
