Extension { #name : #Object }

{ #category : #'*Glamour-Helpers' }
Object >> asGlamorousArray [ 
	 
	^Array with: self
]

{ #category : #'*Glamour-Helpers' }
Object >> asGlamorousMultiValue [
	^ GLMMultiValue with: self
]

{ #category : #'*Glamour-Helpers' }
Object >> glamourString [ 
	"This method tries to circumvent the missing displayString from Squeak" 
	 
	^(self class canUnderstand: #asString) 
		ifTrue: [self asString] 
		ifFalse: [self displayString]
]

{ #category : #'*Glamour-Helpers' }
Object >> glamourValue: anObject [ 
	 
	| args | 
	args := anObject asGlamorousArray. 
	^self glamourValueWithArgs: args
]

{ #category : #'*Glamour-Helpers' }
Object >> glamourValueWithArgs: anArray [ 
	 
	^self
]

{ #category : #'*Glamour-Helpers' }
Object >> renderGlamorouslyOn: aRenderer [ 
	 
	^aRenderer renderObject: self
]
