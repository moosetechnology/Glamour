"
A composite presentation offers means to control the composition of multiple presentations by providing the arrangement of these presentations.
"
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

{ #category : #scripting }
GLMCompositePresentation >> accordionArrangement [
	^ self arrangement: GLMAccordionArrangement new
]

{ #category : #accessing }
GLMCompositePresentation >> add: aPresentation [
	self pane notingPresentationChangeDo: [
		self presentations add: aPresentation.
		aPresentation pane: self pane ].
	^ aPresentation
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
GLMCompositePresentation >> clear [
	arrangement := nil.
	presentations := nil
]

{ #category : #accessing }
GLMCompositePresentation >> collect: aBlock [
	^ self copy presentations: (self presentations collect: aBlock ); yourself
]

{ #category : #scripting }
GLMCompositePresentation >> custom: aPresentation [
	^ self add: aPresentation
]

{ #category : #'scripting opening' }
GLMCompositePresentation >> defaultRenderer [ 
	 
	^GLMRenderer subclasses first new
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

{ #category : #'scripting opening' }
GLMCompositePresentation >> open [ 
	 
	^self openWith: self defaultRenderer
]

{ #category : #'scripting opening' }
GLMCompositePresentation >> openOn: anObject [ 
	 
	^self 
		openOn: anObject 
		with: self defaultRenderer
]

{ #category : #'scripting opening' }
GLMCompositePresentation >> openOn: anObject with: aRenderer [ 
	 
	self startOn: anObject. 
	^ self openWith: aRenderer
]

{ #category : #'scripting opening' }
GLMCompositePresentation >> openWith: aRenderer [ 
	 
	^ aRenderer open: self
]

{ #category : #accessing }
GLMCompositePresentation >> pane [
	^ pane ifNil: [
		pane := (GLMPane named: 'root' in: GLMNoBrowser new) 
				presentations: self; 
				yourself]
]

{ #category : #accessing }
GLMCompositePresentation >> pane: aPane [ 
	super pane: aPane.
	self presentations do: [:each | each pane: aPane ]
]

{ #category : #comparison }
GLMCompositePresentation >> postCopy [
	super postCopy.
	presentations ifNotNil: [ :arg | 
		presentations := presentations collect: [ :each | each copy ] ].
	arrangement ifNotNil: [ :arg | 
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

{ #category : #scripting }
GLMCompositePresentation >> stackedArrangement [
	^ self stackedVerticallyArrangement
]

{ #category : #scripting }
GLMCompositePresentation >> stackedVerticallyArrangement [
	^ self arrangement: (GLMStackedVerticallyArrangement of: self)
]

{ #category : #'scripting opening' }
GLMCompositePresentation >> startOn: anObject [ 
	
	self entity: anObject
]

{ #category : #scripting }
GLMCompositePresentation >> tabbedArrangement [
	^ self arrangement: GLMTabbedArrangement new
]

{ #category : #announcements }
GLMCompositePresentation >> unregisterFromAllAnnouncements [
	super unregisterFromAllAnnouncements.
	self presentations do: [:each | each unregisterFromAllAnnouncements ]
]

{ #category : #updating }
GLMCompositePresentation >> update [
	self pane ports do: [:each |
		(self validate: each value on: each) ifFalse: [each resetValue] ].
	self presentations do: [ :each | each update ].
	self announce: (GLMPresentationUpdated new presentation: self).
]

{ #category : #scripting }
GLMCompositePresentation >> verticallyStackedArrangement [
	^ self stackedVerticallyArrangement
]

{ #category : #enumerating }
GLMCompositePresentation >> withAllDo: aBlock [
	super withAllDo: aBlock.
	self do: aBlock
]

{ #category : #enumerating }
GLMCompositePresentation >> withAllPanesAndPresentationsDo: aBlock [
	super withAllPanesAndPresentationsDo: aBlock.
	self do: [:each | each withAllPanesAndPresentationsDo: aBlock ]
]
