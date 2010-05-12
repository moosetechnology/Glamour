Class {
	#name : #REPQueryConcern,
	#superclass : #REPComputedConcern,
	#category : #'Glamour-Reporter'
}

{ #category : #accessing }
REPQueryConcern >> browser [
	^ (MooseFinder startOn: self result) noTitle
]

{ #category : #accessing }
REPQueryConcern >> statusValue [ 
	^ self result notNil and: [ self result isEmpty ]
]
