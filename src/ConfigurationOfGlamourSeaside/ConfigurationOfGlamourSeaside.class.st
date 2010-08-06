Class {
	#name : #ConfigurationOfGlamourSeaside,
	#superclass : #Object,
	#instVars : [
		'project'
	],
	#category : #ConfigurationOfGlamourSeaside
}

{ #category : #private }
ConfigurationOfGlamourSeaside class >> ensureMetacello [
	Smalltalk at: #MetacelloProject ifAbsent: [
		Gofer new
				url: 'http://seaside.gemstone.com/ss/metacello';
				package: 'ConfigurationOfMetacello';
				load.
		(Smalltalk at: #ConfigurationOfMetacello) loadLatestVersion ]
]

{ #category : #'metacello tool support' }
ConfigurationOfGlamourSeaside class >> isMetacelloConfig [
	"Answer true and the Metacello tools will operate on you"
	
	^true
]

{ #category : #loading }
ConfigurationOfGlamourSeaside class >> loadDefault [
	(self project version: 'default') load
]

{ #category : #accessing }
ConfigurationOfGlamourSeaside class >> project [

	^self new project
]

{ #category : #baselines }
ConfigurationOfGlamourSeaside >> default: spec [ 
	<version: 'default'>
	
	spec for: #common do: [
		spec blessing: #baseline.
		spec repository: 'http://www.squeaksource.com/Glamour'.
		spec package: 'Glamour-Seaside' with: [
			spec requires: #('Seaside' 'Glamour') ]..
		spec package: 'JQWidgetBox-Core' with: [
			spec requires: #('Seaside').
			spec repository: 'http://www.squeaksource.com/JQueryWidgetBox'].
		spec package: 'JQWidgetBox-Dev' with: [
			spec requires: #('Seaside').
			spec repository: 'http://www.squeaksource.com/JQueryWidgetBox'].
		spec package: 'JQWidgetBox-MbMenu-Core' with: [
			spec repository: 'http://www.squeaksource.com/JQueryWidgetBox'.
			spec requires: #('Seaside').].
		spec group: 'Core' with: #(
						'Seaside'
						'Glamour-Seaside'
						'JQWidgetBox-Core'
						'JQWidgetBox-Dev'
						'JQWidgetBox-MbMenu-Core').
"		spec group: 'Tests' with: #(
						'Glamour-Tests'). 
"		spec
			project: 'Glamour' with: [
				spec
					className: 'ConfigurationOfGlamour';
					file: 'ConfigurationOfGlamour';
					version: 'default';
					repository: 'http://www.squeaksource.com/Glamour' ].
		spec
			project: 'Seaside' with: [
				spec
					className: 'ConfigurationOfSeaside30';
					file: 'ConfigurationOfSeaside30';
					version: '3.0.0-alpha5.15';
					repository: 'http://www.squeaksource.com/MetacelloRepository' ].

	]
]

{ #category : #accessing }
ConfigurationOfGlamourSeaside >> project [

	^ project ifNil: [ | constructor |
		"Bootstrap Metacello if it is not already loaded"
		self class ensureMetacello.
		"Construct Metacello project"
		constructor := (Smalltalk at: #MetacelloVersionConstructor) on: self.
		project := constructor project.
		project]
]
