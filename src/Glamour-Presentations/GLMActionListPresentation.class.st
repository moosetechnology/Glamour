Class {
	#name : #GLMActionListPresentation,
	#superclass : #GLMFormatedPresentation,
	#instVars : [
		'isHorizontal'
	],
	#category : #'Glamour-Presentations'
}

{ #category : #scripting }
GLMActionListPresentation >> beHorizontal [
	self isHorizontal: true
]

{ #category : #accessing }
GLMActionListPresentation >> isHorizontal [
	^ isHorizontal ifNil: [isHorizontal := false]
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
