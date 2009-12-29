Class {
	#name : #GLMSTBehavior,
	#superclass : #GLMSTNamedModel,
	#instVars : [
		'stBehavior',
		'instanceAndMetaMethods',
		'methods',
		'instVars'
	],
	#category : #'Glamour-Tools'
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

{ #category : #accessing }
GLMSTBehavior >> glmPackage [
	^ GLMSTPackage named: (PackageOrganizer default mostSpecificPackageOfClass: self stBehavior) packageName environment: self environment
]

{ #category : #accessing }
GLMSTBehavior >> instVars [
	^ instVars ifNil: [
		instVars := self stBehavior instVarNames collect: [:each | 
			GLMSTVariable new name: each; glmBehavior: self; yourself ] ]
]

{ #category : #accessing }
GLMSTBehavior >> instanceAndMetaMethods [
	^ instanceAndMetaMethods ifNil: [ instanceAndMetaMethods := (self methods, self metaSide methods) asSortedCollection: [:a :b | a name < b name] ]
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
GLMSTBehavior >> methods [
	^ methods ifNil: [
		methods := OrderedCollection new.
		self protocols do: [:each |
			methods addAll: each methods ].
		methods ]
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
GLMSTBehavior >> references [
	| association |
	association := Smalltalk associationAt: self name ifAbsent: [ ^ #() ].
	^ (self systemNavigation allCallsOn: association) collect: [ :each |
		GLMSTMethod fromMethodReference: each ]
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
