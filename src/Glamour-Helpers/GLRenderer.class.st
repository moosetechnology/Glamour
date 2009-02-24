Class {
	#name : #GLRenderer,
	#superclass : #Object,
	#category : #'Glamour-Core'
}

{ #category : #rendering }
GLRenderer >> doOpen: aUI [
	
	^self subclassResponsibility
]

{ #category : #rendering }
GLRenderer >> open: aRenderable [
	
	^self doOpen: (self render: aRenderable)
]

{ #category : #rendering }
GLRenderer >> render: aRenderable [
	
	^aRenderable renderGlamorouslyOn: self
]

{ #category : #rendering }
GLRenderer >> renderPane: aPane [
	
	^nil
]

{ #category : #rendering }
GLRenderer >> renderPresentation: aPresentation [
	
	^nil
]
