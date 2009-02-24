Extension { #name : #Object }

{ #category : #'*glamour-helpers' }
Object >> glamourValue: anObject [
	
	^self
		glamourValueWithArgs:
			((anObject isKindOf: GLMultiValue)
				ifTrue: [anObject asArray]
				ifFalse: [Array with: anObject])
]

{ #category : #'*glamour-helpers' }
Object >> glamourValueWithArgs: anArray [
	
	^self
]

{ #category : #'*glamour-helpers' }
Object >> renderGlamorouslyOn: aRenderer [
	
	^aRenderer renderObject: self
]
