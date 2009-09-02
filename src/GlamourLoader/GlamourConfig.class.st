Class {
	#name : #GlamourConfig,
	#superclass : #Object,
	#instVars : [
		'project'
	],
	#category : #GlamourLoader
}

{ #category : #'as yet unclassified' }
GlamourConfig >> default [
	^self project versionSpec
		blessing: #development;
		description: 'Glamour current version';
		packages: (
			self project packagesSpec
				add: 'Glamour-Helpers' repository: 'http://www.squeaksource.com/Glamour';
				add: 'Glamour-Squeak' repository: 'http://www.squeaksource.com/Glamour';
				add: 'Glamour-Core' repository: 'http://www.squeaksource.com/Glamour';
				add: 'Glamour-Presentations' repository: 'http://www.squeaksource.com/Glamour';
				add: 'Glamour-Browsers' repository: 'http://www.squeaksource.com/Glamour';
				add: 'Glamour-Scripting' repository: 'http://www.squeaksource.com/Glamour';
				add: 'Glamour-Tests' repository: 'http://www.squeaksource.com/Glamour';
				add: 'Glamour-Morphic' repository: 'http://www.squeaksource.com/Glamour';
				add: 'Announcements' repository: 'http://www.squeaksource.com/Glamour';
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
		ScriptLoader  loadLatestPackage: 'Metacello-All' from: 'http://seaside.gemstone.com/ss/metacello'.
		(Smalltalk at: #MetacelloMetacelloProject) updateProject.
		(Smalltalk at: #MetacelloMetacelloProject) latestVersion load ]
]

{ #category : #'as yet unclassified' }
GlamourConfig >> load [
	self ensureMetacello.
	self default asVersion load
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
