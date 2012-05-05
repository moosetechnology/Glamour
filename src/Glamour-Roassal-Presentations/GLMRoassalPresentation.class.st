Class {
	#name : #GLMRoassalPresentation,
	#superclass : #GLMPresentation,
	#instVars : [
		'painting',
		'view',
		'canvas'
	],
	#category : #'Glamour-Roassal-Presentations'
}

{ #category : #rendering }
GLMRoassalPresentation >> renderGlamorouslyOn: aRenderer [
	self registerAnnouncements.
	^aRenderer renderRoassalPresentation: self
]

{ #category : #accessing }
GLMRoassalPresentation >> renderOn: aView [
	self flag: 'find a smarter solution that does not depend on isKindOf:'. 
	self viewBlock glamourValue: (
		(self entity isKindOf: GLMMultiValue) 
				ifTrue: [(GLMMultiValue with: aView) , self entity , (GLMMultiValue with: self)] 
				ifFalse: [GLMMultiValue with: aView with: self entity with: self])
]

{ #category : #accessing }
GLMRoassalPresentation >> view: anObject [
	view := anObject
]

{ #category : #accessing }
GLMRoassalPresentation >> viewBlock [
	^ view
]
