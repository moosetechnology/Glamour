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
JQSGLDropdown >> onSelectionChanged: aString [

	self optionAt: 'selectionChanged' put: aString
]

{ #category : #'as yet unclassified' }
JQSGLDropdown >> selectedIndex: anInteger [

	self optionAt: 'selectedIndex' put: anInteger
]
