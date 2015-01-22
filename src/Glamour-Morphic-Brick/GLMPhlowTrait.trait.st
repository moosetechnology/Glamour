"
asdsdfsf
"
Trait {
	#name : #GLMPhlowTrait,
	#category : #'Glamour-Morphic-Brick-Traits'
}

{ #category : #phlow }
GLMPhlowTrait >> transmit [

	^ self addTransmission: (GLMTransmission new browser: self; yourself)
]
