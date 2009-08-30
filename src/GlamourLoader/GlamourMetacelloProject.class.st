Class {
	#name : #GlamourMetacelloProject,
	#superclass : #MetacelloMCProject,
	#category : #GlamourLoader
}

{ #category : #'as yet unclassified' }
GlamourMetacelloProject >> packages10beta [
	<packages: '1.0-beta' attribute: #common>

	^self packagesSpec
		add: 'Glamour-Helpers-tg.7' repository: 'http://www.squeaksource.com/Glamour';
		add: 'Glamour-Squeak-tg.6' repository: 'http://www.squeaksource.com/Glamour';
		add: 'Glamour-Core-tg.22' repository: 'http://www.squeaksource.com/Glamour';
		add: 'Glamour-Presentations-tg.20' repository: 'http://www.squeaksource.com/Glamour';
		add: 'Glamour-Browsers-tg.11' repository: 'http://www.squeaksource.com/Glamour';
		add: 'Glamour-Scripting-tg.21' repository: 'http://www.squeaksource.com/Glamour';
		add: 'Glamour-Tests-tg.19' repository: 'http://www.squeaksource.com/Glamour';
		add: 'Glamour-Morphic-tg.96' repository: 'http://www.squeaksource.com/Glamour';
		add: 'Announcements-stephane_ducasse.14' repository: 'http://www.squeaksource.com/Glamour';
		yourself 
]

{ #category : #'as yet unclassified' }
GlamourMetacelloProject >> version10beta [
	<version: '1.0-beta' attribute: #common>

	^self versionSpec
		blessing: #development;
		description: 'Glamour 1.0 beta';
		projectPackage:
			(self packageSpec
				name: 'GlamourLoader';
				repositoryName: 'http://www.squeaksource.com/Glamour';
				yourself);
		yourself
]
