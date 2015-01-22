Extension { #name : #BlockClosure }

{ #category : #'*Glamour-Morphic-Brick' }
BlockClosure >> brickValue: aBrick [

	^ self cull: aBrick
]

{ #category : #'*Glamour-Morphic-Brick' }
BlockClosure >> phlowValue: aBrick [

	^ self cull: aBrick
]

{ #category : #'*Glamour-Morphic-Brick' }
BlockClosure >> phlowValue: anObject value: otherObject [

	^ self cull: anObject cull: otherObject
]
