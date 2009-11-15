Class {
	#name : #ConfigurationOfGlamour,
	#superclass : #Object,
	#instVars : [
		'project'
	],
	#category : #ConfigurationOfGlamour
}

{ #category : #private }
ConfigurationOfGlamour class >> bootstrapPackage: aString from: aPath [ 
	| repository version |
	repository := MCHttpRepository
				location: aPath
				user: ''
				password: ''.
	repository
		versionReaderForFileNamed: aString , '.mcz'
		do: [:reader | 
			version := reader version.
			version load.
			version workingCopy repositoryGroup addRepository: repository]
]

{ #category : #private }
ConfigurationOfGlamour class >> ensureMetacello [
	"Minimum package versions from which to boot Metacello. Corresponds to version 1.0-beta.4"

	Smalltalk at: #MetacelloProject ifAbsent: [
		Smalltalk at: #Gofer ifAbsent: [
			"Minimum version of Gofer from which to bootstrap"
			self bootstrapPackage: 'Gofer-lr.67' from: 'http://source.lukas-renggli.ch/flair' ].
		Smalltalk at: #Gofer ifPresent: [:gofer |
			gofer new
				url: 'http://seaside.gemstone.com/ss/metacello';
				addVersion: 'Metacello-Core-dkh.273'; "Minimum version from which to bootstrap Metacello"
				addVersion: 'Metacello-MC-dkh.205'; "Minimum version from which to bootstrap Metacello"
				addPackage: 'Metacello-Configuration'; "Loads latest version of configuration package"
				load ].
		"load latest version of Metacello, load a specific version if desired"
		((Smalltalk at: #MetacelloConfiguration) project latestVersion) load: 'UI' ]
]

{ #category : #'metacello tool support' }
ConfigurationOfGlamour class >> isMetacelloConfig [
	"Answer true and the Metacello tools will operate on you"
	
	^true
]

{ #category : #loading }
ConfigurationOfGlamour class >> loadDefault [
	(self project version: 'default') load
]

{ #category : #accessing }
ConfigurationOfGlamour class >> project [

	^self new project
]

{ #category : #baselines }
ConfigurationOfGlamour >> default: spec [ 
	<version: 'default'>
	
	spec for: #common do: [
		spec blessing: #default.
		spec repository: 'http://www.squeaksource.com/Glamour'.
		spec 
			package: 'Glamour-Helpers' ;
			package: 'Glamour-Squeak' ;
			package: 'Glamour-Core' ;
			package: 'Glamour-Presentations' ;
			package: 'Glamour-Browsers' ;
			package: 'Glamour-Scripting' ;
			package: 'Glamour-Tests' ;
			package: 'Morphic-MorphTreeWidget' with: [spec repository: 'http://www.squeaksource.com/Momo'];
			package: 'Glamour-Morphic' with: [spec requires: #(Momo)];
			package: 'Glamour-Test-Morphic' ;
			package: 'Glamour-Examples'.
		spec group: 'Tests' with: #(
						'Glamour-Tests'
						'Glamour-Examples'
						'Glamour-Test-Morphic'). 
		spec
			project: 'Mondrian for Glamour' with: [
				spec
					className: 'ConfigurationOfMondrian';
					file: 'ConfigurationOfMondrian';
					version: 'default';
					repository: 'http://www.squeaksource.com/Mondrian' ].
	]
]

{ #category : #accessing }
ConfigurationOfGlamour >> project [

	^ project ifNil: [ | constructor |
		"Bootstrap Metacello if it is not already loaded"
		self class ensureMetacello.
		"Construct Metacello project"
		constructor := (Smalltalk at: #MetacelloVersionConstructor) on: self.
		project := constructor project.
		project]
]
