Class {
	#name : #GlamourConfig,
	#superclass : #Object,
	#instVars : [
		'project',
		'repo'
	],
	#category : #GlamourLoader
}

{ #category : #'as yet unclassified' }
GlamourConfig >> default [
	<version: 'default' attribute: #common>
	^self project versionSpec
		blessing: #development;
		description: 'Glamour default';
		packages: (
			self project packagesSpec
				add: 'Glamour-Helpers' repository: 'http://www.squeaksource.com/Glamour';
				add: 'Glamour-Squeak' repository: 'http://www.squeaksource.com/Glamour';
				add: 'Glamour-Core' repository: 'http://www.squeaksource.com/Glamour';
				add: 'Glamour-Presentations' repository: 'http://www.squeaksource.com/Glamour';
				add: 'Glamour-Browsers' repository: 'http://www.squeaksource.com/Glamour';
				add: 'Glamour-Scripting' repository: 'http://www.squeaksource.com/Glamour';
				add: 'Glamour-Tests' repository: 'http://www.squeaksource.com/Glamour';
				add: 'Glamour-Morphic' requires: 'Mondrian for Glamour' repository: 'http://www.squeaksource.com/Glamour';
				add: 'Momo' repository: 'http://www.squeaksource.com/Momo';
				add: 'Announcements' repository: 'http://www.squeaksource.com/Glamour';
				add: 'Mondrian for Glamour' project: 'Mondrian default' version: 'default';
				add: 'Glamour-Examples' repository: 'http://www.squeaksource.com/Glamour';
				yourself );
		requiredProjects: (self project projectsSpec
				add: (self project projectSpec
					name: 'Mondrian default';
					className: 'MondrianConfig';
					projectPackage: (self project packageSpec
						name: 'MondrianLoader';
						repositoryName: 'http://www.squeaksource.com/Mondrian';
						yourself);
					yourself));
		projectPackage:
			(self project packageSpec
				name: 'GlamourLoader';
				repositoryName: 'http://www.squeaksource.com/Glamour';
				yourself);
		yourself
]

{ #category : #'as yet unclassified' }
GlamourConfig >> ensureMetacello [
	Smalltalk at: #MetacelloProject ifAbsent: [
		repo := 'http://seaside.gemstone.com/ss/metacello'.
		self loadPackage: 'Metacello-Core-dkh.242' from: repo.
		self loadPackage: 'Metacello-MC-dkh.163' from: repo.
		self loadPackage: 'Metacello-MetacelloProject-dkh.218' from: repo.
		(Smalltalk at: #MetacelloMetacelloProject) instance updateProject.
		((Smalltalk at: #MetacelloMetacelloProject) instance version: '0.16') load ]
]

{ #category : #'as yet unclassified' }
GlamourConfig >> load [
	self ensureMetacello.
	(self project version: 'default') load
]

{ #category : #'as yet unclassified' }
GlamourConfig >> loadPackage: aString from: aPath [ 
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

{ #category : #'as yet unclassified' }
GlamourConfig >> packages10beta [
	<packages: '1.0-beta' attribute: #common>

	^self project packagesSpec
		add: 'Glamour-Helpers-tg.7' repository: 'http://www.squeaksource.com/Glamour';
		add: 'Glamour-Squeak-tg.6' repository: 'http://www.squeaksource.com/Glamour';
		add: 'Glamour-Core-tg.22' repository: 'http://www.squeaksource.com/Glamour';
		add: 'Glamour-Presentations-tg.20' repository: 'http://www.squeaksource.com/Glamour';
		add: 'Glamour-Browsers-tg.11' repository: 'http://www.squeaksource.com/Glamour';
		add: 'Glamour-Scripting-tg.21' repository: 'http://www.squeaksource.com/Glamour';
		add: 'Glamour-Tests-tg.19' repository: 'http://www.squeaksource.com/Glamour';
		add: 'Glamour-Morphic-tg.96' repository: 'http://www.squeaksource.com/Glamour';
		"will crush newer versions in image?"
		add: 'Announcements-tg.11' repository: 'http://www.squeaksource.com/Glamour';
		yourself 
]

{ #category : #accessing }
GlamourConfig >> project [
	^ project ifNil: [project := (Smalltalk at: #MetacelloMCProject) on: self]
]

{ #category : #'as yet unclassified' }
GlamourConfig >> version10beta [
	<version: '1.0-beta' attribute: #common>
	^self project versionSpec
		blessing: #development;
		description: 'Glamour 1.0 beta';
		packages: self packages10beta;
		projectPackage:
			(self project packageSpec
				name: 'GlamourLoader';
				repositoryName: 'http://www.squeaksource.com/Glamour';
				yourself);
		yourself
]
