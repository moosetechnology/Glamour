Class {
	#name : #ConfigurationOfGlamourCore,
	#superclass : #Object,
	#instVars : [
		'project'
	],
	#classVars : [
		'LastVersionLoad'
	],
	#category : #ConfigurationOfGlamourCore
}

{ #category : #'development support' }
ConfigurationOfGlamourCore class >> DevelopmentSupport [

"See the methods in the 'development support' category on the class-side of MetacelloBaseConfiguration. Decide what development support methods you would like to use and copy them the the class-side of your configuration."
	<apiDocumentation>

]

{ #category : #private }
ConfigurationOfGlamourCore class >> baseConfigurationClassIfAbsent: aBlock [

	^Smalltalk
		at: #MetacelloBaseConfiguration
		ifAbsent: [ 
			self ensureMetacelloBaseConfiguration.
			Smalltalk at: #MetacelloBaseConfiguration ifAbsent: aBlock ].

]

{ #category : #private }
ConfigurationOfGlamourCore class >> ensureMetacello [

	(self baseConfigurationClassIfAbsent: []) ensureMetacello
]

{ #category : #private }
ConfigurationOfGlamourCore class >> ensureMetacelloBaseConfiguration [

	Smalltalk
		at: #MetacelloBaseConfiguration
		ifAbsent: [ 
			| repository version |
			repository := MCHttpRepository location: 'http://seaside.gemstone.com/ss/metacello' user: '' password: ''.
			repository
				versionReaderForFileNamed: 'Metacello-Base-DaleHenrichs.2.mcz'
				do: [ :reader | 
					version := reader version.
					version load.
					version workingCopy repositoryGroup addRepository: repository ] ]
]

{ #category : #'metacello tool support' }
ConfigurationOfGlamourCore class >> isMetacelloConfig [
	"Answer true and the Metacello tools will operate on you"
	
	^true
]

{ #category : #loading }
ConfigurationOfGlamourCore class >> load [
	"Load the #stable version defined for this platform. The #stable version is the version that is recommended to be used on this platform."

	"self load"

	<apiDocumentation>
	^(self project version: #stable) load
]

{ #category : #loading }
ConfigurationOfGlamourCore class >> loadBleedingEdge [
	"Load the latest versions of the mcz files defined for this project. It is not likely that the #bleedingEdge has been tested."

	"self loadBleedingEdge"

	<apiDocumentation>
	^(self project version: #bleedingEdge) load
]

{ #category : #loading }
ConfigurationOfGlamourCore class >> loadDevelopment [
	"Load the #development version defined for this platform. The #development version will change over time and is not expected to be stable."

	"self loadDevelopment"

	<apiDocumentation>
	^(self project version: #development) load
]

{ #category : #accessing }
ConfigurationOfGlamourCore class >> project [

	^self new project
]

{ #category : #'development support' }
ConfigurationOfGlamourCore class >> validate [
	"Check the configuration for Errors, Critical Warnings, and Warnings (see class comment for MetacelloMCVersionValidator for more information). 
	Errors identify specification issues that will result in unexpected behaviour when you load the configuration. 
	Critical Warnings identify specification issues that may result in unexpected behavior when you load the configuration.
	Warnings identify specification issues that are technically correct, but are worth take a look at."

	"self validate"

	<apiDocumentation>
	self ensureMetacello.
	^ ((Smalltalk at: #MetacelloToolBox) validateConfiguration: self debug: #() recurse: false) explore
]

{ #category : #baselines }
ConfigurationOfGlamourCore >> baseline10: spec [
	<version: '1.0-baseline'>
	
	spec for: #common do: [
		spec blessing: #baseline.
		spec description: 'Core version of Glamour that can directly be integrated in Pharo 4'.
		spec repository: 'http://www.smalltalkhub.com/mc/Moose/Glamour/main'.
		spec 
			package: 'Glamour-Announcements' ;
			package: 'Glamour-Helpers';
			package: 'Glamour-Core' with: [spec requires: #('Glamour-Helpers' 'Glamour-Announcements')];
			package: 'Glamour-Presentations' with: [spec requires: #('Glamour-Core')];
			package: 'Glamour-Rubric-Presentations' with: [spec requires: #('Rubric' 'Glamour-Presentations')];
			package: 'Glamour-Browsers' with: [spec requires: #('Glamour-Core')];
			package: 'Glamour-Examples' with: [spec requires: #('Glamour-Core')];
			package: 'Glamour-Morphic-Brick';
			package: 'Glamour-Morphic-Widgets' with: [spec requires: #('Rubric' 'Glamour-Morphic-Brick')];
			package: 'Glamour-Morphic-Renderer' with: [spec requires: #('Glamour-Morphic-Widgets' 'Glamour-Core')];
			package: 'Glamour-Morphic-Pager' with: [spec requires: #('Glamour-Morphic-Renderer')];
			package: 'Glamour-Morphic-Theme' with: [spec requires: 'Rubric'];
			package: 'Glamour-Tests-Core';
			package: 'Glamour-Tests-Morphic' with: [spec requires: #('Glamour-Morphic-Renderer')];
			package: 'Glamour-Tests-Rubric' with: [spec requires: #('Glamour-Tests-Morphic' 'Glamour-Rubric-Presentations')];
			package: 'Glamour-Tests-Resources'.
			
		spec group: 'Core' with: #(
						'Glamour-Announcements'
						'Glamour-Helpers'
						'Glamour-Core'
						'Glamour-Presentations'
						'Glamour-Browsers'
						'Glamour-Examples'
						'Glamour-Rubric-Presentations').
		spec group: 'Morphic' with: #(
						'Glamour-Morphic-Brick'
						'Glamour-Morphic-Widgets'
						'Glamour-Morphic-Renderer'
						'Glamour-Morphic-Theme'
						'Glamour-Morphic-Pager').		
		spec group: 'Tests' with: #(
						'Glamour-Tests-Core'
						'Glamour-Tests-Morphic'
						'Glamour-Tests-Rubric'
						'Glamour-Tests-Resources'). 
						
		spec group: 'default' with: #(
						'Core'
						'Morphic'
						'Tests').
						
		spec project: 'Rubric' with: [ 
			spec 
					className: 'ConfigurationOfRubric';
					file: 'ConfigurationOfRubric';
					version: #development;
					repository: 'http://www.smalltalkhub.com/mc/AlainPlantec/Rubric/main' ] ].
]

{ #category : #accessing }
ConfigurationOfGlamourCore >> customProjectAttributes [
	 "Edit to return a collection of any custom attributes e.g. for conditional loading: Array with: #'Condition1' with: #'Condition2.
	For more information see: http://code.google.com/p/metacello/wiki/CustomProjectAttrributes"

	^ #().
]

{ #category : #'symbolic versions' }
ConfigurationOfGlamourCore >> development: spec [
	<symbolicVersion: #'development'>

	spec for: #'common' version: '1.0-baseline'.

]

{ #category : #accessing }
ConfigurationOfGlamourCore >> project [

	^ project ifNil: [ 
		"Bootstrap Metacello if it is not already loaded"
		(self class baseConfigurationClassIfAbsent: []) ensureMetacello.
		"Construct Metacello project"
		project := MetacelloMCProject new projectAttributes: self customProjectAttributes. 
		(Smalltalk at: #MetacelloVersionConstructor) on: self project: project.
		project loadType: #linear. "change to #atomic if desired"
		project ]
]

{ #category : #versions }
ConfigurationOfGlamourCore >> version100: spec [
	<version: '1.0.0' imports: #('1.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.0.0'.
		spec author: 'AndreiChis'.
		spec timestamp: '10/28/2014 14:17'.
		spec 
			package: 'Glamour-Announcements' with: 'Glamour-Announcements-AndreiChis.8';
			package: 'Glamour-Helpers' with: 'Glamour-Helpers-AndreiChis.36';
			package: 'Glamour-Core' with: 'Glamour-Core-TudorGirba.285';
			package: 'Glamour-Presentations' with: 'Glamour-Presentations-AndreiChis.162';
			package: 'Glamour-Browsers' with: 'Glamour-Browsers-AndreiChis.106';
			package: 'Glamour-Tests-Core' with: 'Glamour-Tests-Core-TudorGirba.97';
			package: 'Glamour-Morphic-Widgets' with: 'Glamour-Morphic-Widgets-AliakseiSyrel.150';
			package: 'Glamour-Morphic-Renderer' with: [
				spec file: 'Glamour-Morphic-Renderer-AndreiChis.298'.
				spec repository: 'http://www.smalltalkhub.com/mc/PharoExtras/GTToolsIntegration/main' ];
			package: 'Glamour-Morphic-Brick' with: 'Glamour-Morphic-Brick-AliakseiSyrel.15';
			package: 'Glamour-Morphic-Pager' with: 'Glamour-Morphic-Pager-AndreiChis.71';
			package: 'Glamour-Morphic-Theme' with: 'Glamour-Morphic-Theme-TudorGirba.186';
			package: 'Glamour-Tests-Morphic' with: 'Glamour-Tests-Morphic-AndreiChis.118';
			package: 'Glamour-Examples' with: 'Glamour-Examples-TudorGirba.288';
			package: 'Glamour-Rubric-Presentations' with: 'Glamour-Rubric-Presentations-TudorGirba.33';
			package: 'Glamour-Tests-Rubric' with: 'Glamour-Tests-Rubric-AndreiChis.14';
			package: 'Glamour-Tests-Resources' with: 'Glamour-Tests-Resources-AndreiChis.3'. 
		
		spec 
			project: 'Rubric' with: '1.2.2' ].


]
