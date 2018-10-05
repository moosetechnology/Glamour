Class {
	#name : #JQSGLTable,
	#superclass : #JQWidget,
	#category : #'Glamour-Seaside-Core'
}

{ #category : #accessing }
JQSGLTable >> method [ 
	^ 'sglTable'
]

{ #category : #accessing }
JQSGLTable >> selectURL: aString [
	self optionAt: 'selectURL' put: aString
]
