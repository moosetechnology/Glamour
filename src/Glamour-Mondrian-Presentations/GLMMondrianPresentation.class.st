"
A GLMMondrianPresentation delegates the actual presenation to the Mondrian visualization engine. The only parameter it takes is a painting block to which it passes an instance of a ViewRenderer.

Instance Variables
	painting:		aBlock that takes a ViewRenderer as the first parameter
"
Class {
	#name : #GLMMondrianPresentation,
	#superclass : #GLMPresentation,
	#instVars : [
		'painting',
		'view'
	],
	#category : #'Glamour-Mondrian-Presentations'
}

{ #category : #accessing }
GLMMondrianPresentation >> painting [ 
	 
	^painting
]

{ #category : #accessing }
GLMMondrianPresentation >> painting: anObject [ 
	 
	painting := anObject
]

{ #category : #rendering }
GLMMondrianPresentation >> renderGlamorouslyOn: aRenderer [
	self registerAnnouncements.
	^aRenderer renderMondrianPresentation: self
]

{ #category : #accessing }
GLMMondrianPresentation >> renderOn: aView [
	self flag: 'find a smarter solution that does not depend on isKindOf:'. 
	self painting glamourValue: (
		(self entity isKindOf: GLMMultiValue) 
				ifTrue: [(GLMMultiValue with: aView) , self entity , (GLMMultiValue with: self)] 
				ifFalse: [GLMMultiValue with: aView with: self entity with: self])
]

{ #category : #accessing }
GLMMondrianPresentation >> view [
	^ view ifNil: [view := MOViewRenderer new]
]

{ #category : #accessing }
GLMMondrianPresentation >> view: anObject [
	view := anObject
]
