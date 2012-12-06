Class {
	#name : #JQSGLDropdown,
	#superclass : #JQWidget,
	#category : #'Glamour-Seaside-Core'
}

{ #category : #'as yet unclassified' }
JQSGLDropdown >> method [
	^ 'sglDropdown'
]

{ #category : #'as yet unclassified' }
JQSGLDropdown >> selectionChangedURL: aString [
	self optionAt: 'selectionChangedURL' put: aString
]
