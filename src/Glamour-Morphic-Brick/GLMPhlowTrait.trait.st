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

	self transmissions
		select: [ :each | each origin slot = aSlot ]
		thenDo: [ :each | each transmit ]
]

{ #category : #'phlow-transmissions' }
GLMPhlowTrait >> transmissions [

	^ self explicitRequirement
]

{ #category : #'phlow-scripting' }
GLMPhlowTrait >> transmit [

	^ GLMPhlowTransmissionBuilder phlow: self
]
