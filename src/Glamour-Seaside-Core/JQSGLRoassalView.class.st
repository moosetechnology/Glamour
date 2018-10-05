Class {
	#name : #JQSGLRoassalView,
	#superclass : #JQWidget,
	#category : #'Glamour-Seaside-Core'
}

{ #category : #accessing }
JQSGLRoassalView >> contentURL: aString [
	self optionAt: 'contentURL' put: aString
]

{ #category : #accessing }
JQSGLRoassalView >> method [ 
	^ 'sglRoassal'
]
