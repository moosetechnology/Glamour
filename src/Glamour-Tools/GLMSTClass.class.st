Class {
	#name : #GLMSTClass,
	#superclass : #GLMSTBehavior,
	#category : #'Glamour-Tools'
}

{ #category : #accessing }
GLMSTClass >> superclass [
	self class behavior: self stBehavior superclass environment: self environment

]
