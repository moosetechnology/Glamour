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
