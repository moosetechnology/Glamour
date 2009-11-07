Class {
	#name : #GLMSTClass,
	#superclass : #GLMSTBehavior,
	#category : #'Glamour-Examples'
}

{ #category : #'as yet unclassified' }
GLMSTClass >> superclass [
	self class behavior: self stBehavior superclass environment: self environment

]
