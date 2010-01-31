Class {
	#name : #GLMCompositePresentation,
	#superclass : #GLMPresentation,
	#traits : 'GLMTPresentationBuilder',
	#classTraits : 'GLMTPresentationBuilder classTrait',
	#instVars : [
		'presentations',
		'arrangement'
	],
	#category : #'Glamour-Core'
}

{ #category : #comparison }
GLMCompositePresentation >> = aPresentation [
	self flag: 'perhaps we want to add all variables here, not just presentations'.
	^ self class = aPresentation class and: [
		self presentations = aPresentation presentations ]
]

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
GLMCompositePresentation >> arrangement [
	^ arrangement ifNil: [arrangement := GLMTabbedArrangement of: self]
]

{ #category : #accessing }
GLMCompositePresentation >> arrangement: anArrangement [
	anArrangement composite: self.
	^ arrangement := anArrangement
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
GLMCompositePresentation >> pane: aPane [ 
	super pane: aPane.
	self presentations do: [:each | each pane: aPane ]
]

{ #category : #comparison }
GLMCompositePresentation >> postCopy [
	super postCopy.
	presentations ifNotNil: [
		presentations := presentations collect: [:each | each copy] ].
	arrangement ifNotNil: [
		arrangement := arrangement copy.
		arrangement composite: self ]
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
	"we delegate to the arrangement to dispatch the type of the actual arrangement of the nested presentations"
	self registerAnnouncements.
	^ self arrangement renderGlamorouslyOn: aRenderer
]

{ #category : #announcements }
GLMCompositePresentation >> resetAnnouncer [
	super resetAnnouncer.
	self presentations do: [:each | each resetAnnouncer ]
]

{ #category : #accessing }
GLMCompositePresentation >> select: aBlock [
	^ self presentations select: aBlock
]

{ #category : #accessing }
GLMCompositePresentation >> size [
	^ self presentations size
]

{ #category : #announcements }
GLMCompositePresentation >> unregisterFromAllAnnouncements [
	super unregisterFromAllAnnouncements.
	self presentations do: [:each | each unregisterFromAllAnnouncements ]
]

{ #category : #accessing }
GLMCompositePresentation >> withAllDo: aBlock [
	super withAllDo: aBlock.
	self do: aBlock
]
