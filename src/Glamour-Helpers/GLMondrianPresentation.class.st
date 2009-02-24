Class {
	#name : #GLMondrianPresentation,
	#superclass : #GLPresentation,
	#instVars : [
		'painting'
	],
	#category : #'Glamour-Presentations'
}

{ #category : #accessing }
GLMondrianPresentation >> painting [
	
	^painting
]

{ #category : #accessing }
GLMondrianPresentation >> painting: anObject [
	
	painting := anObject
]

{ #category : #rendering }
GLMondrianPresentation >> renderGlamorouslyOn: aRenderer [
	
	^aRenderer renderMondrianPresentation: self
]

{ #category : #accessing }
GLMondrianPresentation >> renderView [
	
	| view |
	view := ViewRenderer new.
	self painting
		glamourValue:
			((self entity isKindOf: GLMultiValue)
				ifTrue: [(GLMultiValue with: view) , self entity]
				ifFalse:
					[GLMultiValue
						with: view
						with: self entity]).
	^view
]
