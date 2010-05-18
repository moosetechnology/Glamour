Class {
	#name : #REPReport,
	#superclass : #GLMBrowserTemplate,
	#category : #'Glamour-Reporter'
}

{ #category : #'as yet unclassified' }
REPReport class >> open [ 
	^ self new open
]

{ #category : #private }
REPReport >> build: spec [ 
	"override this method to build your spec"
	^ self subclassResponsibility
]

{ #category : #private }
REPReport >> model [ 
	"override this method to point to the model of the specification"
	^ self subclassResponsibility
]

{ #category : #public }
REPReport >> open [ 
	^ self spec open
]

{ #category : #accessing }
REPReport >> spec [ 
	| spec |
	spec := REPConcernSpecification on: self model.
	self build: spec.
	^ spec
]
