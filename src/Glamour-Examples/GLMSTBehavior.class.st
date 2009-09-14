Class {
	#name : #GLMSTBehavior,
	#superclass : #GLMSTNamedModel,
	#instVars : [
		'stBehavior'
	],
	#category : #'Glamour-Examples'
}

{ #category : #'instance creation' }
GLMSTBehavior class >> behavior: aBehavior environment: anEnvironment [
	^ self new
		stBehavior: aBehavior;
		environment: anEnvironment;
		yourself
]

{ #category : #accessing }
GLMSTBehavior >> comment [
	^ self stBehavior comment
]

{ #category : #accessing }
GLMSTBehavior >> definition [
	^ self stBehavior definition
]

{ #category : #testing }
GLMSTBehavior >> isMetaSide [ 
	^ self stBehavior class = Metaclass 
]

{ #category : #accessing }
GLMSTBehavior >> metaSide [
	^ (GLMSTClass named: self name) 
		stBehavior: self stBehavior class;
		yourself
]

{ #category : #accessing }
GLMSTBehavior >> name [
	^ self stBehavior name
]

{ #category : #accessing }
GLMSTBehavior >> protocols [
	^ (self environment protocolsFor: self stBehavior) collect: 
		[ :each | 
		GLMSTProtocol new
			name: each;
			glmBehavior: self;
			yourself ]
]

{ #category : #accessing }
GLMSTBehavior >> sourceCodeAt: aSelector [
	^ self stBehavior sourceCodeAt: aSelector
]

{ #category : #accessing }
GLMSTBehavior >> stBehavior [
	^ stBehavior
]

{ #category : #accessing }
GLMSTBehavior >> stBehavior: anObject [
	stBehavior := anObject
]

{ #category : #accessing }
GLMSTBehavior >> traits [
	^ self stBehavior traitComposition traits collect: [:each |
		GLMSTTrait new stBehavior: each; yourself]
]
