Extension { #name : #Morph }

{ #category : #'*Glamour-Morphic-Brick' }
Morph >> isBrick [

	^ false
]

{ #category : #'*Glamour-Morphic-Brick' }
Morph >> privateBrickDoubleLink [

	^ self valueOfProperty: #brickDoubleLink ifAbsentPut: [ nil ]
]

{ #category : #'*Glamour-Morphic-Brick' }
Morph >> privateBrickDoubleLink: aDoubleLink [

	self setProperty: #brickDoubleLink toValue: aDoubleLink
]
