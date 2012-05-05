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
