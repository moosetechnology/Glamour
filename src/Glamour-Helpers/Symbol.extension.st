Extension { #name : #Symbol }

{ #category : #'*Glamour-Helpers' }
Symbol >> glamourValueWithArgs: anArray [ 
	 
	anArray size < 1 ifTrue: [^nil]. 
	^anArray first perform: self
]
