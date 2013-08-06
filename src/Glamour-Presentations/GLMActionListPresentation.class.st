Class {
	#name : #GLMActionListPresentation,
	#superclass : #GLMFormatedPresentation,
	#instVars : [
		'isHorizontal'
	],
	#category : #'Glamour-Presentations'
}

{ #category : #scripting }
GLMActionListPresentation >> beVertical [
	self isHorizontal: false
]

{ #category : #testing }
GLMActionListPresentation >> hasActions [
	^false
]

{ #category : #accessing }
GLMActionListPresentation >> isHorizontal [
	^ isHorizontal ifNil: [isHorizontal := true]
]

{ #category : #accessing }
GLMActionListPresentation >> isHorizontal: anObject [
	isHorizontal := anObject
]

{ #category : #accessing }
GLMActionListPresentation >> isVertical [
	^ self isHorizontal not
]

{ #category : #rendering }
GLMActionListPresentation >> renderGlamorouslyOn: aRenderer [
	self registerAnnouncements.
	^ aRenderer renderActionListPresentation: self
]
