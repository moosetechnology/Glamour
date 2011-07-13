Class {
	#name : #GLMColor,
	#superclass : #Object,
	#category : #'Glamour-Helpers'
}

{ #category : #accessing }
GLMColor >> cssColor [

	"should return a css color code"
	^ self subclassResponsibility 
]

{ #category : #accessing }
GLMColor >> morphicColor [

	"should return an object kind of Color"
	^ self subclassResponsibility 
]
