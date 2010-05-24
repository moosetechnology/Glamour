"
This is the abstract class for the Glamour loggers. These classes are typically used for debugging hte highly dynamic Glamour model.
"
Class {
	#name : #GLMLogger,
	#superclass : #Object,
	#classInstVars : [
		'nullInstance',
		'instance'
	],
	#category : #'Glamour-Helpers'
}

{ #category : #'as yet unclassified' }
GLMLogger class >> instance [
	^ instance ifNil: [
		instance := self nullInstance ]
]

{ #category : #'as yet unclassified' }
GLMLogger class >> instance: aLogger [
	instance := aLogger 
]

{ #category : #'as yet unclassified' }
GLMLogger class >> nullInstance [ 
	^ nullInstance ifNil: [
		nullInstance := GLMNullLogger new ]
]

{ #category : #'as yet unclassified' }
GLMLogger class >> reset [
	instance := nil
]

{ #category : #logging }
GLMLogger >> logAnnouncement: anAnnouncement from: aGLMObject [ 
	
	
]
