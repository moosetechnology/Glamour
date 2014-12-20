"
A GLMBrickForm is an abstract vector form used for icons

"
Class {
	#name : #GLMBrickForm,
	#superclass : #GLMBrick,
	#category : #'Glamour-Morphic-Brick-UI'
}

{ #category : #initialization }
GLMBrickForm >> initialize [
	super initialize.
	
	self renderer: GLMBrickFormRenderer new
]

{ #category : #'creating path' }
GLMBrickForm >> pathOn: builder [

	self subclassResponsibility
]
