Extension { #name : #Object }

{ #category : #'*Glamour-Helpers' }
Object >> glamourString [ 
	"This method tries to circumvent the missing displayString from Squeak" 
	 
	^(self class canUnderstand: #asString) 
		ifTrue: [self asString] 
		ifFalse: [self displayString]
]

{ #category : #'*Glamour-Helpers' }
Object >> glamourValue: anObject [ 
	 
	^self 
		glamourValueWithArgs: 
			((anObject isKindOf: GLMMultiValue) 
				ifTrue: [anObject asArray] 
				ifFalse: [Array with: anObject])
]

{ #category : #'*Glamour-Helpers' }
Object >> glamourValueWithArgs: anArray [ 
	 
	^self
]

{ #category : #'*Glamour-Helpers' }
Object >> renderGlamorouslyOn: aRenderer [ 
	 
	^aRenderer renderObject: self
]
