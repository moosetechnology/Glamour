Class {
	#name : #GLMMagrittePresentation,
	#superclass : #GLMPresentation,
	#instVars : [
		'magritteDescription'
	],
	#category : #'Glamour-Magritte-Presentations'
}

{ #category : #accessing }
GLMMagrittePresentation >> description: anObject [
	"convenience method for scripting"
	
	magritteDescription := anObject
]

{ #category : #accessing }
GLMMagrittePresentation >> magritteDescription [
	"By default the we read it via the #description selector"
	^ magritteDescription ifNil: [ magritteDescription := #description ]
]

{ #category : #rendering }
GLMMagrittePresentation >> renderGlamorouslyOn: aRenderer [ 
	^ aRenderer renderMagrittePresentation: self
]
