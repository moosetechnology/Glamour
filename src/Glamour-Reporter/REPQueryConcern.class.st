Class {
	#name : #REPQueryConcern,
	#superclass : #REPConcern,
	#category : #'Glamour-Reporter'
}

{ #category : #accessing }
REPQueryConcern >> browser [
	^ (MooseFinder startOn: self result) noTitle
]

{ #category : #accessing }
REPQueryConcern >> result [ 
	^ self check 
]
