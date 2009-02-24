Extension { #name : #Symbol }

{ #category : #'*glamour-helper' }
Symbol >> glamourValueWithArgs: anArray [
	
	anArray size < 1 ifTrue: [^nil].
	^anArray first perform: self
]
