"
Used by BundleTransmission to annotate its originating ports whether they are active or passive.

When a BundleTransmission consideres a port as active, the browser will trigger it when the corresponding port changes.
"
Class {
	#name : #GLBundleOrigin,
	#superclass : #Object,
	#instVars : [
		'port',
		'active'
	],
	#category : #'Glamour-Core'
}

{ #category : #accessing }
GLBundleOrigin >> beActive [
	
	active := true
]

{ #category : #accessing }
GLBundleOrigin >> bePassive [
	
	active := false
]

{ #category : #testing }
GLBundleOrigin >> isActive [
	
	^active ifNil: [active := true]
]

{ #category : #testing }
GLBundleOrigin >> isPassive [
	
	^self isActive not
]

{ #category : #accessing }
GLBundleOrigin >> port [
	
	^port
]

{ #category : #accessing }
GLBundleOrigin >> port: aPort [
	
	port := aPort
]

{ #category : #'accessing-convenience' }
GLBundleOrigin >> value [
	
	^self port value
]
