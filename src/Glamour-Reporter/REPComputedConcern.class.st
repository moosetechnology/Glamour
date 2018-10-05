Class {
	#name : #REPComputedConcern,
	#superclass : #REPConcern,
	#instVars : [
		'result'
	],
	#category : #'Glamour-Reporter'
}

{ #category : #accessing }
REPComputedConcern >> computeResult [ 
	^ nil
]

{ #category : #accessing }
REPComputedConcern >> result [ 
	^ result ifNil: [ result := self computeResult ]
]
