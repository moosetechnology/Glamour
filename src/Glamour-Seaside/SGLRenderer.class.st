Class {
	#name : #SGLRenderer,
	#superclass : #AnObsoleteGLMRenderer,
	#category : #'Glamour-Seaside'
}

{ #category : #rendering }
SGLRenderer >> open: aRenderable [
	| application |
	application := WAAdmin 
		register: (SGLWindow on: aRenderable)
		asApplicationAt: 'glamour'.
	application configuration
		addParent: WADevelopmentConfiguration instance.
	application addLibrary: JQDeploymentLibrary
]
