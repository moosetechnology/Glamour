Class {
	#name : #GLMFileTest,
	#superclass : #TestCase,
	#category : #'Glamour-Examples'
}

{ #category : #accessing }
GLMFileTest >> anyRoot [
	^ GLMFile anyRoot
]

{ #category : #tests }
GLMFileTest >> testGetASlashAtTheEndOfDirectoryNames [
	self assert: (self anyRoot files allSatisfy: [:file | file isFile or: [file nameDistinguishingTypes last = $/]])
]

{ #category : #tests }
GLMFileTest >> testNameIsNeverEmpty [
	self assert: (self anyRoot files allSatisfy: [:file | file name notEmpty])
]

{ #category : #tests }
GLMFileTest >> testNamesAreDifferent [
	self assert: (self anyRoot files collect: [:file | file name]) asSet size equals: (self anyRoot files size)
]

{ #category : #tests }
GLMFileTest >> testRootNameIsNeverEmpty [
	self assert: (GLMFile roots allSatisfy: [:file | file name notEmpty])
]

{ #category : #tests }
GLMFileTest >> testRootsAreDirectories [
	self assert: (GLMFile roots allSatisfy: [:ea | ea isDirectory])
]

{ #category : #tests }
GLMFileTest >> testRootsAreSFile [
	self assert: (GLMFile roots allSatisfy: [:root | root isKindOf: GLMFile])
]

{ #category : #tests }
GLMFileTest >> testThereAreSomeDirectoriesUnderRoot [
	self assert: (self anyRoot files anySatisfy: [:file | file isDirectory])
]

{ #category : #tests }
GLMFileTest >> testThereAreSomeFilesUnderRoot [
	self assert: (self anyRoot files anySatisfy: [:file | file isFile])
]

{ #category : #tests }
GLMFileTest >> testThereAreSomeRoots [
	self assert: GLMFile roots notEmpty.
	
]
