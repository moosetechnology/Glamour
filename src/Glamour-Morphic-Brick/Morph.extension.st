Extension { #name : #Morph }

{ #category : #'*Glamour-Morphic-Brick' }
Morph >> asBrick [
	
	^ self owner
		ifNil: [ GLMMorphBrick on: self ]
		ifNotNil: [ self owner isBrick
			ifTrue: [ self owner ]
			ifFalse: [ GLMMorphBrick on: self ] ]
]

{ #category : #'*Glamour-Morphic-Brick' }
Morph >> exportAsPNGSilently [
	| fName time |
	time := (DateAndTime now asString copyReplaceAll: ':' with: '-') copyReplaceAll: '.' with: '-'.
	fName := self externalName, time , '.png'.
	PNGReadWriter putForm: self imageForm onFileNamed: fName
]

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
