"
asdsdfsf
"
Trait {
	#name : #GLMPhlowTrait,
	#category : #'Glamour-Morphic-Brick-Traits'
}

{ #category : #'private-phlow' }
GLMPhlowTrait >> slot: aSlot changedWith: aValue [

	
]

{ #category : #phlow }
GLMPhlowTrait >> transmit [

	^ self addTransmission: (GLMTransmission new browser: self; yourself)
]
