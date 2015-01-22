"
asdsdfsf
"
Trait {
	#name : #GLMPhlowTrait,
	#category : #'Glamour-Morphic-Brick-Traits'
}

{ #category : #'phlow-transmissions' }
GLMPhlowTrait >> addTransmission: aTransmission [

	^ self transmissions add: aTransmission
]

{ #category : #'private-phlow' }
GLMPhlowTrait >> slot: aSlot changedWith: aValue [

	self flag: 'should be removed and changed'.
	self transmissions do: [ :each | each origins do: [ :origin | origin slot = aSlot ifTrue: [ each transmit: aValue ] ] ]
]

{ #category : #'phlow-transmissions' }
GLMPhlowTrait >> transmissions [

	^ self explicitRequirement
]

{ #category : #'phlow-scripting' }
GLMPhlowTrait >> transmit [

	^ self addTransmission: GLMPhlowTransmission new
]
