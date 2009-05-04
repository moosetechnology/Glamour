"
Used by BundleTransmission to annotate its originating ports whether they are active or passive.

When a BundleTransmission consideres a port as active, the browser will trigger it when the corresponding port changes.
"
Class {
	#name : #GLMBundleOrigin,
	#superclass : #Object,
	#instVars : [
		'port',
		'active'
	],
	#category : #'Glamour-Core'
}

{ #category : #accessing }
GLMBundleOrigin >> beActive [ 
	 
	active _ true
]

{ #category : #accessing }
GLMBundleOrigin >> bePassive [ 
	 
	active _ false
]

{ #category : #testing }
GLMBundleOrigin >> isActive [ 
	 
	^active ifNil: [active _ true]
]

{ #category : #testing }
GLMBundleOrigin >> isPassive [ 
	 
	^self isActive not
]

{ #category : #accessing }
GLMBundleOrigin >> port [ 
	 
	^port
]

{ #category : #accessing }
GLMBundleOrigin >> port: aPort [ 
	 
	port _ aPort
]

{ #category : #'accessing-convenience' }
GLMBundleOrigin >> value [ 
	 
	^self port value
]
