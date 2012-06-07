Class {
	#name : #GLMRoassalPresentation,
	#superclass : #GLMPresentation,
	#instVars : [
		'painting',
		'paintingBlock',
		'view'
	],
	#category : #'Glamour-Roassal-Presentations'
}

{ #category : #accessing }
GLMRoassalPresentation >> bitmap [ 
	^ self view bitmap 
]

{ #category : #scripting }
GLMRoassalPresentation >> painting: anObject [
	paintingBlock := anObject
]

{ #category : #accessing }
GLMRoassalPresentation >> paintingBlock [
	^ paintingBlock
]

{ #category : #rendering }
GLMRoassalPresentation >> renderGlamorouslyOn: aRenderer [
	self registerAnnouncements.
	^ aRenderer renderRoassalPresentation: self
]

{ #category : #accessing }
GLMRoassalPresentation >> renderOn: aView [
	self flag: 'find a smarter solution that does not depend on isKindOf:'. 
	self paintingBlock glamourValue: (
		(self entity isKindOf: GLMMultiValue) 
				ifTrue: [(GLMMultiValue with: aView) , self entity , (GLMMultiValue with: self)] 
				ifFalse: [GLMMultiValue with: aView with: self entity with: self]).
	self flag: 'This should be the responsibility of the the view'.
	view applyLayout.	
	self view: aView
]

{ #category : #accessing }
GLMRoassalPresentation >> view [
	^ view ifNil: [view := ROMondrianViewBuilder new]
]

{ #category : #accessing }
GLMRoassalPresentation >> view: anObject [
	view := anObject
]
