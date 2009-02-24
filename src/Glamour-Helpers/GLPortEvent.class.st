Class {
	#name : #GLPortEvent,
	#superclass : #Object,
	#instVars : [
		'port',
		'transmission',
		'oldValue'
	],
	#category : #'Glamour-Core'
}

{ #category : #testing }
GLPortEvent >> hasChanged [
	"Answer whether the port value changed due to the event."
	
	^self value ~= self oldValue
]

{ #category : #accessing }
GLPortEvent >> oldValue [
	
	^oldValue
]

{ #category : #accessing }
GLPortEvent >> oldValue: anObject [
	
	oldValue := anObject
]

{ #category : #'accessing-convenience' }
GLPortEvent >> pane [
	
	^self port pane
]

{ #category : #accessing }
GLPortEvent >> port [
	
	^port
]

{ #category : #accessing }
GLPortEvent >> port: aPort [
	
	port := aPort
]

{ #category : #'accessing-convenience' }
GLPortEvent >> portName [
	
	^self port name
]

{ #category : #accessing }
GLPortEvent >> transmission [
	
	^transmission
]

{ #category : #accessing }
GLPortEvent >> transmission: aTransmission [
	
	transmission := aTransmission
]

{ #category : #'accessing-convenience' }
GLPortEvent >> value [
	
	^self port value
]
