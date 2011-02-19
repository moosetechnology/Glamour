Class {
	#name : #JQSGLFinder,
	#superclass : #JQWidget,
	#category : #'Glamour-Seaside-Core'
}

{ #category : #actions }
JQSGLFinder >> addPane: aRenderable [
	self action: 'addPane' arguments: (Array with: (self render: aRenderable)).
]

{ #category : #accessing }
JQSGLFinder >> method [ 
	^ 'sglFinder'
]

{ #category : #actions }
JQSGLFinder >> removeLastPane: aRenderable [
	self action: 'removeLastPane' arguments: (Array with: (self render: aRenderable)).
]

{ #category : #actions }
JQSGLFinder >> replaceLastPane: aRenderable [
	self action: 'replaceLastPane' arguments: (Array with: (self render: aRenderable)).
]
