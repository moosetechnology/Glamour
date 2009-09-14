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
	^ ((anEnvironment categories collect: [:name | name readStream upTo: $-]) asSet asSortedCollection)
			collect: [:name | self named: name environment: anEnvironment]
]

{ #category : #accessing }
GLMSTPackage >> classes [
	^ (self environment classNamesFor: self name)
		collect: [:className | GLMSTClass behavior: (self environment at: className) environment: self environment]
]

{ #category : #accessing }
GLMSTPackage >> subPackages [
	^ self environment categories
		select: [:name | name beginsWith: self name, '-']
		thenCollect: [:name | self class named: name environment: self environment]
]
