Class {
	#name : #GLMPortEvent,
	#superclass : #Object,
	#instVars : [
		'port',
		'transmission',
		'oldValue',
		'transmissionContext'
	],
	#category : #'Glamour-Core'
}

{ #category : #'as yet unclassified' }
GLMPortEvent class >> on: aPort previouslyValued: anObject [ 
	^ self new 
		initializeOn: aPort
		previouslyValued: anObject
]

{ #category : #'as yet unclassified' }
GLMPortEvent class >> on: aPort previouslyValued: anObject in: aTransmissionContext [ 
	^self new initializeOn: aPort previouslyValued: anObject in: aTransmissionContext 
]

{ #category : #testing }
GLMPortEvent >> hasChanged [ 
	"Answer whether the port value changed due to the event." 
	 
	^self value ~= self oldValue
]

{ #category : #'as yet unclassified' }
GLMPortEvent >> initializeOn: aPort previouslyValued: anObject [ 
	self initializeOn: aPort previouslyValued: anObject in: OrderedCollection new
]

{ #category : #'as yet unclassified' }
GLMPortEvent >> initializeOn: aPort previouslyValued: anObject in: aTransmissionContext [ 
	port := aPort.
	oldValue := anObject.
	transmissionContext := aTransmissionContext
]

{ #category : #accessing }
GLMPortEvent >> oldValue [ 
	 
	^oldValue
]

{ #category : #'accessing-convenience' }
GLMPortEvent >> pane [ 
	 
	^self port pane
]

{ #category : #accessing }
GLMPortEvent >> port [ 
	 
	^port
]

{ #category : #'accessing-convenience' }
GLMPortEvent >> portName [ 
	 
	^self port name
]

{ #category : #accessing }
GLMPortEvent >> transmission [ 
	 
	^transmission
]

{ #category : #'as yet unclassified' }
GLMPortEvent >> transmissionContext [
	^OrderedCollection withAll: transmissionContext
]

{ #category : #'accessing-convenience' }
GLMPortEvent >> value [ 
	 
	^self port value
]
