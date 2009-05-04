Class {
	#name : #GLMPortEvent,
	#superclass : #Object,
	#instVars : [
		'port',
		'transmission',
		'oldValue'
	],
	#category : #'Glamour-Core'
}

{ #category : #testing }
GLMPortEvent >> hasChanged [ 
	"Answer whether the port value changed due to the event." 
	 
	^self value ~= self oldValue
]

{ #category : #accessing }
GLMPortEvent >> oldValue [ 
	 
	^oldValue
]

{ #category : #accessing }
GLMPortEvent >> oldValue: anObject [ 
	 
	oldValue _ anObject
]

{ #category : #'accessing-convenience' }
GLMPortEvent >> pane [ 
	 
	^self port pane
]

{ #category : #accessing }
GLMPortEvent >> port [ 
	 
	^port
]

{ #category : #accessing }
GLMPortEvent >> port: aPort [ 
	 
	port _ aPort
]

{ #category : #'accessing-convenience' }
GLMPortEvent >> portName [ 
	 
	^self port name
]

{ #category : #accessing }
GLMPortEvent >> transmission [ 
	 
	^transmission
]

{ #category : #accessing }
GLMPortEvent >> transmission: aTransmission [ 
	 
	transmission _ aTransmission
]

{ #category : #'accessing-convenience' }
GLMPortEvent >> value [ 
	 
	^self port value
]
