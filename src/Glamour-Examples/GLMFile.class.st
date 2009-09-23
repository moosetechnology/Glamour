"
This is a very simple and limited implementation of the java.io.File class. I did that because FileDirectory is just impossible to use and remember. 
"
Class {
	#name : #GLMFile,
	#superclass : #Object,
	#instVars : [
		'pathName'
	],
	#category : #'Glamour-Examples'
}

{ #category : #accessing }
GLMFile class >> anyRoot [
	^ self roots detect: [:file | [file files notEmpty] on: Error do: [false]] 
]

{ #category : #'instance creation' }
GLMFile class >> pathName: aString [
	^ self new
		setPathName: aString;
		yourself 
]

{ #category : #accessing }
GLMFile class >> roots [
	^ (OSPlatform current platformFamily = #Windows)
		ifTrue: [FileDirectory root fileAndDirectoryNames collect: [:ea | self pathName: ea]]
		ifFalse: [Array with: (self pathName: FileDirectory root fullName)]
]

{ #category : #reading }
GLMFile >> contents [
	self isFile not ifTrue: [Error signal: 'Only files have content'].
	^ FileStream
		readOnlyFileNamed: pathName
		do: [:stream | stream contents]
]

{ #category : #enumerating }
GLMFile >> files [
	^ ([(FileDirectory on: pathName) fileAndDirectoryNames]
		on: InvalidDirectoryError do: [:err | Array new])
			collect: [:name | self class pathName: ((FileDirectory on: pathName) fullNameFor: name)]
]

{ #category : #testing }
GLMFile >> isDirectory [
	^ (pathName = '/') or: [(FileDirectory on: pathName) directoryEntry isDirectory]
]

{ #category : #testing }
GLMFile >> isFile [
	^ self isDirectory not
]

{ #category : #printing }
GLMFile >> name [
	^ self tail
]

{ #category : #printing }
GLMFile >> nameDistinguishingTypes [
	^ self isDirectory 
		ifTrue: [self name, '/']
		ifFalse: [self name]
]

{ #category : #printing }
GLMFile >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPut: $(;
		nextPutAll: self tail;
		nextPut: $)
]

{ #category : #private }
GLMFile >> setPathName: aString [
	pathName := aString
]

{ #category : #printing }
GLMFile >> tail [
	| name |
	name := (FileDirectory on: pathName) localName.
	^ name isEmpty
		ifTrue: [pathName]
		ifFalse: [name]
]
