Class {
	#name : #GLMSTPackage,
	#superclass : #GLMSTNamedModel,
	#category : #'Glamour-Examples'
}

{ #category : #'instance creation' }
GLMSTPackage class >> named: aString environment: anEnvironment [
	^ self new
		name: aString;
		environment: anEnvironment;
		yourself
]

{ #category : #'instance creation' }
GLMSTPackage class >> rootPackagesOn: anEnvironment [
	^ ((anEnvironment categories collect: [:string | string readStream upTo: $-]) asSet asSortedCollection)
			collect: [:string | self named: string environment: anEnvironment]
]

{ #category : #accessing }
GLMSTPackage >> allClasses [
	| all |
	all := self classes asOrderedCollection.
	self subPackages do: [:each | 
		all addAll: each allClasses ].
	^ all
]

{ #category : #accessing }
GLMSTPackage >> classes [
	^ (self environment classNamesFor: self name)
		collect: [:className | GLMSTClass behavior: (self environment at: className) environment: self environment ]
]

{ #category : #accessing }
GLMSTPackage >> subPackages [
	^ self environment categories
		select: [:string | string  beginsWith: self name, '-']
		thenCollect: [:string  | self class named: string environment: self environment]
]
