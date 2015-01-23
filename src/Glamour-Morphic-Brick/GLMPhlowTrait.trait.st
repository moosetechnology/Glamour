"
asdsdfsf
"
Trait {
	#name : #GLMPhlowTrait,
	#category : #'Glamour-Morphic-Brick-Traits'
}

{ #category : #'phlow-connections' }
GLMPhlowTrait >> addConnection: aConnection [

	^ self connections add: aConnection
]

{ #category : #'phlow-connections' }
GLMPhlowTrait >> connections [

	^ self explicitRequirement
]

{ #category : #'private-phlow' }
GLMPhlowTrait >> slot: aSlot changedWith: aValue [

	self connections
		select: [ :each | each origin slot = aSlot ]
		thenDo: [ :each | each transmit ]
]

{ #category : #'phlow-scripting' }
GLMPhlowTrait >> transmit [

	^ GLMPhlowTransmission phlow: self
]
