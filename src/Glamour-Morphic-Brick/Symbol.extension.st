Extension { #name : #Symbol }

{ #category : #'*Glamour-Morphic-Brick' }
Symbol >> brickValue: aBrick [

	^ self cull: aBrick
]

{ #category : #'*Glamour-Morphic-Brick' }
Symbol >> phlowValue: aBrick [

	^ self cull: aBrick
]

{ #category : #'*Glamour-Morphic-Brick' }
Symbol >> phlowValue: anObject value: otherObject [

	^ anObject perform: self withEnoughArguments: { otherObject }
]
