"
I transform the selected elements into Finder widgets.
"
Class {
	#name : #JQSGLFinder,
	#superclass : #JQWidget,
	#category : #'Glamour-Seaside-Core'
}

{ #category : #actions }
JQSGLFinder >> addPane: aRenderable [
	self action: 'addPane' arguments: (Array with: (self render: aRenderable)).
]

{ #category : #'options-generated' }
JQSGLFinder >> duration: anInteger [
	self optionAt: 'duration' put: anInteger 
]

{ #category : #accessing }
JQSGLFinder >> method [ 
	^ 'sglFinder'
]

{ #category : #actions }
JQSGLFinder >> removeLastPane [
	self action: 'removeLastPane'
]

{ #category : #actions }
JQSGLFinder >> replaceLastPane: aRenderable [
	self action: 'replaceLastPane' arguments: (Array with: (self render: aRenderable)).
]

{ #category : #'options-generated' }
JQSGLFinder >> splitterSize: anInteger [
	self optionAt: 'splitterSize' put: anInteger 
]
