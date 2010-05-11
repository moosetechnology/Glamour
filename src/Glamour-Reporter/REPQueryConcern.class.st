Class {
	#name : #REPQueryConcern,
	#superclass : #REPConcern,
	#instVars : [
		'result'
	],
	#category : #'Glamour-Reporter'
}

{ #category : #accessing }
REPQueryConcern >> browser [
	^ (MooseFinder startOn: self result) noTitle
]

{ #category : #accessing }
REPQueryConcern >> computeResult [ 
	self subclassResponsibility
]

{ #category : #accessing }
REPQueryConcern >> result [ 
	^ result ifNil: [ result := self computeResult ]
]

{ #category : #accessing }
REPQueryConcern >> statusValue [ 
	^ self result notNil and: [ self result isEmpty ]
]
