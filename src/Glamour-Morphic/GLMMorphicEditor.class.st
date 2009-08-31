Class {
	#name : #GLMMorphicEditor,
	#superclass : #SystemWindow,
	#category : #'Glamour-Morphic'
}

{ #category : #'as yet unclassified' }
GLMMorphicEditor >> addPreviewButton [
	
]

{ #category : #'as yet unclassified' }
GLMMorphicEditor >> addTextEditor [

]

{ #category : #'as yet unclassified' }
GLMMorphicEditor >> openInWorld: aWorld [ 
	super openInWorld: aWorld.
	self setLabel: 'Glamour Editor'.
	self addTextEditor.
	self addPreviewButton.
]
