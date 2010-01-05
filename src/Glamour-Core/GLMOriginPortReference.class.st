"
Used by BundleTransmission to annotate its originating ports whether they are active or passive.

When a BundleTransmission consideres a port as active, the browser will trigger it when the corresponding port changes.
"
Class {
	#name : #GLMOriginPortReference,
	#superclass : #Object,
	#instVars : [
		'port',
		'active'
	],
	#category : #'Glamour-Core'
}

{ #category : #accessing }
GLMOriginPortReference >> beActive [ 
	 
	active := true
]

{ #category : #accessing }
GLMOriginPortReference >> bePassive [ 
	 
	active := false
]

{ #category : #testing }
GLMOriginPortReference >> isActive [ 
	 
	^active ifNil: [active := true]
]

{ #category : #testing }
GLMOriginPortReference >> isPassive [ 
	 
	^self isActive not
]

{ #category : #accessing }
GLMOriginPortReference >> port [ 
	 
	^port
]

{ #category : #accessing }
GLMOriginPortReference >> port: aPort [
	port := aPort
]

{ #category : #'accessing-convenience' }
GLMOriginPortReference >> value [ 
	 
	^self port value
]
