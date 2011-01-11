Class {
	#name : #JQSGLExpander,
	#superclass : #JQWidget,
	#category : #'Glamour-Seaside-Core'
}

{ #category : #actions }
JQSGLExpander >> addPane: aRenderable [
	self action: 'addPane' arguments: (Array with: (self render: aRenderable)).
]

{ #category : #accessing }
JQSGLExpander >> method [
	^ 'sglExpander'
]
