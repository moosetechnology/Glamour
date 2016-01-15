"
Core configuration of Glamour for integrating with Pharo.

self loadDevelopment
"
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
ConfigurationOfGlamourCore >> baseline30: spec [
	<version: '3.0-baseline'>
	
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
			package: 'Glamour-Morphic-Brick' with: [spec requires: #('Glamour-Core')];
			package: 'Glamour-Morphic-Widgets' with: [spec requires: #('Rubric' 'Glamour-Morphic-Brick')];
			package: 'Glamour-Morphic-Renderer' with: [spec requires: #('Glamour-Morphic-Widgets' 'Glamour-Core')];
			package: 'Glamour-Morphic-Pager' with: [spec requires: #('Glamour-Morphic-Renderer' 'Glamour-Morphic-Brick')];
			package: 'Glamour-Morphic-Theme' with: [spec requires: 'Rubric'];
			package: 'Glamour-Tests-Core';
			package: 'Glamour-Tests-Morphic' with: [spec requires: #('Glamour-Morphic-Renderer' 'Glamour-Morphic-Brick' 'Glamour-Morphic-Pager')];
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

{ #category : #baselines }
ConfigurationOfGlamourCore >> baseline31: spec [
	<version: '3.1-baseline'>
	
	spec for: #common do: [
		spec blessing: #baseline.
		spec description: 'Brick Tests'.
		spec repository: 'http://www.smalltalkhub.com/mc/Moose/Glamour/main'.
		spec 
			package: 'Glamour-Announcements' ;
			package: 'Glamour-Helpers';
			package: 'Glamour-Core' with: [spec requires: #('Glamour-Helpers' 'Glamour-Announcements')];
			package: 'Glamour-Presentations' with: [spec requires: #('Glamour-Core')];
			package: 'Glamour-Rubric-Presentations' with: [spec requires: #('Rubric' 'Glamour-Presentations')];
			package: 'Glamour-Browsers' with: [spec requires: #('Glamour-Core')];
			package: 'Glamour-Examples' with: [spec requires: #('Glamour-Core')];
			package: 'Glamour-Morphic-Brick' with: [spec requires: #('Glamour-Core')];
			package: 'Glamour-Morphic-Brick-Tests' with: [spec requires: #('Glamour-Morphic-Brick')];
			package: 'Glamour-Morphic-Widgets' with: [spec requires: #('Rubric' 'Glamour-Morphic-Brick')];
			package: 'Glamour-Morphic-Renderer' with: [spec requires: #('Glamour-Morphic-Widgets' 'Glamour-Core')];
			package: 'Glamour-Morphic-Pager' with: [spec requires: #('Glamour-Morphic-Renderer' 'Glamour-Morphic-Brick')];
			package: 'Glamour-Morphic-Theme' with: [spec requires: 'Rubric'];
			package: 'Glamour-Tests-Core';
			package: 'Glamour-Tests-Morphic' with: [spec requires: #('Glamour-Morphic-Renderer' 'Glamour-Morphic-Brick' 'Glamour-Morphic-Pager')];
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
						'Glamour-Tests-Resources'
						'Glamour-Morphic-Brick-Tests'). 
						
		spec project: 'Rubric' with: [ 
			spec 
					className: #ConfigurationOfRubric;
					versionString: #'development';
					repository: 'http://www.smalltalkhub.com/mc/AlainPlantec/Rubric/main' ] .
				
		spec group: 'default' with: #(
						'Core'
						'Morphic'
						'Tests' ) ].
]

{ #category : #baselines }
ConfigurationOfGlamourCore >> baseline32: spec [
	<version: '3.2-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec repository: 'http://smalltalkhub.com/mc/Moose/Glamour/main'.
		spec project: 'Rubric' with: [
				spec
					className: #ConfigurationOfRubric;
					versionString: #'development';
					repository: 'http://www.smalltalkhub.com/mc/Pharo/Rubric/main' ].
		spec 
			package: 'Glamour-Announcements';
			package: 'Glamour-Helpers';
			package: 'Glamour-Core' with: [
				spec requires: #('Glamour-Helpers' 'Glamour-Announcements' ). ];
			package: 'Glamour-Presentations' with: [
				spec requires: #('Glamour-Core' ). ];
			package: 'Glamour-Browsers' with: [
				spec requires: #('Glamour-Core' ). ];
			package: 'Glamour-Examples' with: [
				spec requires: #('Glamour-Core' ). ];
			package: 'Glamour-Morphic-Brick' with: [
				spec requires: #('Glamour-Core' ). ];
			package: 'Glamour-Morphic-Brick-Tests' with: [
				spec requires: #('Glamour-Morphic-Brick' ). ];
			package: 'Glamour-Tests-Core';
			package: 'Glamour-Tests-Resources';
			package: 'Glamour-Morphic-Theme' with: [
				spec requires: #('Rubric' ). ];
			package: 'Glamour-Morphic-Widgets' with: [
				spec requires: #('Rubric' 'Glamour-Morphic-Brick' ). ];
			package: 'Glamour-Morphic-Renderer' with: [
				spec requires: #('Glamour-Morphic-Widgets' 'Glamour-Core' ). ];
			package: 'Glamour-Morphic-Pager' with: [
				spec requires: #('Glamour-Morphic-Renderer' 'Glamour-Morphic-Brick' ). ];
			package: 'Glamour-Tests-Morphic' with: [
				spec requires: #('Glamour-Morphic-Renderer' 'Glamour-Morphic-Brick' 'Glamour-Morphic-Pager' ). ];
			package: 'Glamour-Rubric-Presentations' with: [
				spec requires: #('Rubric' 'Glamour-Presentations' ). ];
			package: 'Glamour-Tests-Rubric' with: [
				spec requires: #('Glamour-Tests-Morphic' 'Glamour-Rubric-Presentations' ). ].
		spec 
			group: 'Core' with: #('Glamour-Announcements' 'Glamour-Helpers' 'Glamour-Core' 'Glamour-Presentations' 'Glamour-Browsers' 'Glamour-Examples' 'Glamour-Rubric-Presentations' );
			group: 'Morphic' with: #('Glamour-Morphic-Brick' 'Glamour-Morphic-Widgets' 'Glamour-Morphic-Renderer' 'Glamour-Morphic-Theme' 'Glamour-Morphic-Pager' );
			group: 'Tests' with: #('Glamour-Tests-Core' 'Glamour-Tests-Morphic' 'Glamour-Tests-Rubric' 'Glamour-Tests-Resources' 'Glamour-Morphic-Brick-Tests' );
			group: 'default' with: #('Core' 'Morphic' 'Tests' ). ].

]

{ #category : #baselines }
ConfigurationOfGlamourCore >> baseline33: spec [
	<version: '3.3-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec description: 'Load FastTable renderer for Glamour'.
		spec repository: 'http://smalltalkhub.com/mc/Moose/Glamour/main'.
		
		spec project: 'Rubric' with: [
				spec
					className: #ConfigurationOfRubric;
					versionString: #'development';
					repository: 'http://www.smalltalkhub.com/mc/Pharo/Rubric/main' ].
		spec project: 'FastTable' with: [
				spec
					className: #ConfigurationOfFastTable;
					versionString: #'development';
					repository: 'http://smalltalkhub.com/mc/estebanlm/FastTable/main/' ].
		spec 
			package: 'Glamour-Announcements';
			package: 'Glamour-Helpers';
			package: 'Glamour-FastTable' with: [
				spec requires: #('FastTable' ). ];
			package: 'Glamour-Core' with: [
				spec requires: #('Glamour-Helpers' 'Glamour-Announcements' ). ];
			package: 'Glamour-Presentations' with: [
				spec requires: #('Glamour-Core' ). ];
			package: 'Glamour-Browsers' with: [
				spec requires: #('Glamour-Core' ). ];
			package: 'Glamour-Examples' with: [
				spec requires: #('Glamour-Core' ). ];
			package: 'Glamour-Morphic-Brick' with: [
				spec requires: #('Glamour-Core' ). ];
			package: 'Glamour-Morphic-Brick-Tests' with: [
				spec requires: #('Glamour-Morphic-Brick' ). ];
			package: 'Glamour-Tests-Core';
			package: 'Glamour-Tests-Resources';
			package: 'Glamour-Morphic-Theme' with: [
				spec requires: #('Rubric' ). ];
			package: 'Glamour-Morphic-Widgets' with: [
				spec requires: #('Rubric' 'Glamour-Morphic-Brick' ). ];
			package: 'Glamour-Morphic-Renderer' with: [
				spec requires: #('Glamour-Morphic-Widgets' 'Glamour-Core' ). ];
			package: 'Glamour-Morphic-Pager' with: [
				spec requires: #('Glamour-Morphic-Renderer' 'Glamour-Morphic-Brick' ). ];
			package: 'Glamour-Tests-Morphic' with: [
				spec requires: #('Glamour-Morphic-Renderer' 'Glamour-Morphic-Brick' 'Glamour-Morphic-Pager' ). ];
			package: 'Glamour-Rubric-Presentations' with: [
				spec requires: #('Rubric' 'Glamour-Presentations' ). ];
			package: 'Glamour-Tests-Rubric' with: [
				spec requires: #('Glamour-Tests-Morphic' 'Glamour-Rubric-Presentations' ). ].
		spec 
			group: 'Core' with: #('Glamour-Announcements' 'Glamour-Helpers' 'Glamour-Core' 'Glamour-Presentations' 'Glamour-Browsers' 'Glamour-Examples' 'Glamour-Rubric-Presentations' );
			group: 'Morphic' with: #('Glamour-Morphic-Brick' 'Glamour-Morphic-Widgets' 'Glamour-Morphic-Renderer' 'Glamour-Morphic-Theme' 'Glamour-Morphic-Pager' 'Glamour-FastTable' );
			group: 'Tests' with: #('Glamour-Tests-Core' 'Glamour-Tests-Morphic' 'Glamour-Tests-Rubric' 'Glamour-Tests-Resources' 'Glamour-Morphic-Brick-Tests' );
			group: 'default' with: #('Core' 'Morphic' 'Tests' ). ].

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

	spec for: #'common' version: '3.3-baseline'.

	spec for: #'pharo4.x' version: '3.2-baseline'.

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

{ #category : #'symbolic versions' }
ConfigurationOfGlamourCore >> stable: spec [
	<symbolicVersion: #'stable'>

	spec for: #'common' version: '3.9'.

	spec for: #'pharo3.x' version: '3.0.7'.

	spec for: #'pharo4.x' version: '3.1.4.Moose51'.

]

{ #category : #versions }
ConfigurationOfGlamourCore >> version300: spec [
	<version: '3.0.0' imports: #('3.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 3.0.0'.
		spec author: 'AndreiChis'.
		spec timestamp: '10/28/2014 14:17'.
		spec 
			package: 'Glamour-Announcements' with: 'Glamour-Announcements-AndreiChis.8';
			package: 'Glamour-Helpers' with: 'Glamour-Helpers-AndreiChis.36';
			package: 'Glamour-Core' with: 'Glamour-Core-TudorGirba.285';
			package: 'Glamour-Presentations' with: 'Glamour-Presentations-AndreiChis.166';
			package: 'Glamour-Browsers' with: 'Glamour-Browsers-AndreiChis.106';
			package: 'Glamour-Tests-Core' with: 'Glamour-Tests-Core-AndreiChis.99';
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

{ #category : #versions }
ConfigurationOfGlamourCore >> version3010: spec [
	<version: '3.0.10' imports: #('3.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 3.0.10'.
		spec author: 'AndreiChis'.
		spec timestamp: '01/16/2015 19:07'.
		spec 
			package: 'Glamour-Announcements' with: 'Glamour-Announcements-AndreiChis.8';
			package: 'Glamour-Browsers' with: 'Glamour-Browsers-BernardoContreras.107';
			package: 'Glamour-Core' with: 'Glamour-Core-AndreiChis.288';
			package: 'Glamour-Examples' with: 'Glamour-Examples-TudorGirba.290';
			package: 'Glamour-Helpers' with: 'Glamour-Helpers-AndreiChis.36';
			package: 'Glamour-Morphic-Brick' with: 'Glamour-Morphic-Brick-AliakseiSyrel.118';
			package: 'Glamour-Morphic-Pager' with: 'Glamour-Morphic-Pager-AndreiChis.83';
			package: 'Glamour-Morphic-Renderer' with:'Glamour-Morphic-Renderer-AndreiChis.306';
			package: 'Glamour-Morphic-Theme' with: 'Glamour-Morphic-Theme-TudorGirba.196';
			package: 'Glamour-Morphic-Widgets' with: 'Glamour-Morphic-Widgets-AndreiChis.160';
			package: 'Glamour-Presentations' with: 'Glamour-Presentations-AndreiChis.169';
			package: 'Glamour-Rubric-Presentations' with: 'Glamour-Rubric-Presentations-AndreiChis.37';
			package: 'Glamour-Tests-Core' with: 'Glamour-Tests-Core-AndreiChis.101';
			package: 'Glamour-Tests-Morphic' with: 'Glamour-Tests-Morphic-AndreiChis.120';
			package: 'Glamour-Tests-Resources' with: 'Glamour-Tests-Resources-AndreiChis.3';
			package: 'Glamour-Tests-Rubric' with: 'Glamour-Tests-Rubric-AndreiChis.14'. 
		
		spec 
			project: 'Rubric' with: '1.2.8' ].


]

{ #category : #versions }
ConfigurationOfGlamourCore >> version301: spec [
	<version: '3.0.1' imports: #('3.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 3.0.1'.
		spec author: 'AndreiChis'.
		spec timestamp: '11/13/2014 13:54'.
		spec 
			package: 'Glamour-Announcements' with: 'Glamour-Announcements-AndreiChis.8';
			package: 'Glamour-Helpers' with: 'Glamour-Helpers-AndreiChis.36';
			package: 'Glamour-Core' with: 'Glamour-Core-BernardoContreras.286';
			package: 'Glamour-Presentations' with: 'Glamour-Presentations-AndreiChis.166';
			package: 'Glamour-Browsers' with: 'Glamour-Browsers-AndreiChis.106';
			package: 'Glamour-Tests-Core' with: 'Glamour-Tests-Core-AndreiChis.99';
			package: 'Glamour-Morphic-Widgets' with: 'Glamour-Morphic-Widgets-AliakseiSyrel.150';
			package: 'Glamour-Morphic-Renderer' with: [
				spec file: 'Glamour-Morphic-Renderer-AndreiChis.298'.
				spec repository: 'http://www.smalltalkhub.com/mc/PharoExtras/GTToolsIntegration/main' ];
			package: 'Glamour-Morphic-Brick' with: 'Glamour-Morphic-Brick-AndreiChis.17';
			package: 'Glamour-Morphic-Pager' with: 'Glamour-Morphic-Pager-MarcusDenker.72';
			package: 'Glamour-Morphic-Theme' with: 'Glamour-Morphic-Theme-TudorGirba.186';
			package: 'Glamour-Tests-Morphic' with: 'Glamour-Tests-Morphic-AndreiChis.118';
			package: 'Glamour-Examples' with: 'Glamour-Examples-MarcusDenker.289';
			package: 'Glamour-Rubric-Presentations' with: 'Glamour-Rubric-Presentations-TudorGirba.33';
			package: 'Glamour-Tests-Rubric' with: 'Glamour-Tests-Rubric-AndreiChis.14';
			package: 'Glamour-Tests-Resources' with: 'Glamour-Tests-Resources-AndreiChis.3'. 
		
		spec 
			project: 'Rubric' with: '1.2.3' ].


]

{ #category : #versions }
ConfigurationOfGlamourCore >> version302: spec [
	<version: '3.0.2' imports: #('3.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 3.0.2'.
		spec author: 'AndreiChis'.
		spec timestamp: '11/14/2014 11:48'.
		spec 
			package: 'Glamour-Announcements' with: 'Glamour-Announcements-AndreiChis.8';
			package: 'Glamour-Helpers' with: 'Glamour-Helpers-AndreiChis.36';
			package: 'Glamour-Core' with: 'Glamour-Core-BernardoContreras.286';
			package: 'Glamour-Presentations' with: 'Glamour-Presentations-AndreiChis.166';
			package: 'Glamour-Browsers' with: 'Glamour-Browsers-AndreiChis.106';
			package: 'Glamour-Tests-Core' with: 'Glamour-Tests-Core-AndreiChis.99';
			package: 'Glamour-Morphic-Widgets' with: 'Glamour-Morphic-Widgets-AndreiChis.151';
			package: 'Glamour-Morphic-Renderer' with: [
				spec file: 'Glamour-Morphic-Renderer-AndreiChis.301'.
				spec repository: 'http://www.smalltalkhub.com/mc/PharoExtras/GTToolsIntegration/main' ];
			package: 'Glamour-Morphic-Brick' with: 'Glamour-Morphic-Brick-AndreiChis.17';
			package: 'Glamour-Morphic-Pager' with: 'Glamour-Morphic-Pager-MarcusDenker.72';
			package: 'Glamour-Morphic-Theme' with: 'Glamour-Morphic-Theme-TudorGirba.186';
			package: 'Glamour-Tests-Morphic' with: 'Glamour-Tests-Morphic-AndreiChis.118';
			package: 'Glamour-Examples' with: 'Glamour-Examples-MarcusDenker.289';
			package: 'Glamour-Rubric-Presentations' with: 'Glamour-Rubric-Presentations-TudorGirba.33';
			package: 'Glamour-Tests-Rubric' with: 'Glamour-Tests-Rubric-AndreiChis.14';
			package: 'Glamour-Tests-Resources' with: 'Glamour-Tests-Resources-AndreiChis.3'. 
		
		spec 
			project: 'Rubric' with: '1.2.4' ].


]

{ #category : #versions }
ConfigurationOfGlamourCore >> version303: spec [
	<version: '3.0.3' imports: #('3.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 3.0.3'.
		spec author: 'AndreiChis'.
		spec timestamp: '12/07/2014 13:58'.
		spec 
			package: 'Glamour-Announcements' with: 'Glamour-Announcements-AndreiChis.8';
			package: 'Glamour-Helpers' with: 'Glamour-Helpers-AndreiChis.36';
			package: 'Glamour-Core' with: 'Glamour-Core-BernardoContreras.286';
			package: 'Glamour-Presentations' with: 'Glamour-Presentations-AndreiChis.166';
			package: 'Glamour-Browsers' with: 'Glamour-Browsers-BernardoContreras.107';
			package: 'Glamour-Tests-Core' with: 'Glamour-Tests-Core-AndreiChis.99';
			package: 'Glamour-Morphic-Widgets' with: 'Glamour-Morphic-Widgets-AndreiChis.153';
			package: 'Glamour-Morphic-Renderer' with: [
				spec file: 'Glamour-Morphic-Renderer-AndreiChis.301'.
				spec repository: 'http://www.smalltalkhub.com/mc/PharoExtras/GTToolsIntegration/main' ];
			package: 'Glamour-Morphic-Brick' with: 'Glamour-Morphic-Brick-AliakseiSyrel.82';
			package: 'Glamour-Morphic-Pager' with: 'Glamour-Morphic-Pager-AliakseiSyrel.78';
			package: 'Glamour-Morphic-Theme' with: 'Glamour-Morphic-Theme-TudorGirba.194';
			package: 'Glamour-Tests-Morphic' with: 'Glamour-Tests-Morphic-AndreiChis.118';
			package: 'Glamour-Examples' with: 'Glamour-Examples-TudorGirba.290';
			package: 'Glamour-Rubric-Presentations' with: 'Glamour-Rubric-Presentations-TudorGirba.33';
			package: 'Glamour-Tests-Rubric' with: 'Glamour-Tests-Rubric-AndreiChis.14';
			package: 'Glamour-Tests-Resources' with: 'Glamour-Tests-Resources-AndreiChis.3'. 
		
		spec 
			project: 'Rubric' with: '1.2.5' ].


]

{ #category : #versions }
ConfigurationOfGlamourCore >> version304: spec [
	<version: '3.0.4' imports: #('3.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 3.0.4'.
		spec author: 'AndreiChis'.
		spec timestamp: '12/09/2014 12:08'.
		spec 
			package: 'Glamour-Announcements' with: 'Glamour-Announcements-AndreiChis.8';
			package: 'Glamour-Helpers' with: 'Glamour-Helpers-AndreiChis.36';
			package: 'Glamour-Core' with: 'Glamour-Core-BernardoContreras.286';
			package: 'Glamour-Presentations' with: 'Glamour-Presentations-AndreiChis.166';
			package: 'Glamour-Browsers' with: 'Glamour-Browsers-BernardoContreras.107';
			package: 'Glamour-Tests-Core' with: 'Glamour-Tests-Core-AndreiChis.99';
			package: 'Glamour-Morphic-Widgets' with: 'Glamour-Morphic-Widgets-AndreiChis.153';
			package: 'Glamour-Morphic-Renderer' with: [
				spec file: 'Glamour-Morphic-Renderer-AndreiChis.301'.
				spec repository: 'http://www.smalltalkhub.com/mc/PharoExtras/GTToolsIntegration/main' ];
			package: 'Glamour-Morphic-Brick' with: 'Glamour-Morphic-Brick-AliakseiSyrel.82';
			package: 'Glamour-Morphic-Pager' with: 'Glamour-Morphic-Pager-AliakseiSyrel.78';
			package: 'Glamour-Morphic-Theme' with: 'Glamour-Morphic-Theme-TudorGirba.194';
			package: 'Glamour-Tests-Morphic' with: 'Glamour-Tests-Morphic-AndreiChis.118';
			package: 'Glamour-Examples' with: 'Glamour-Examples-TudorGirba.290';
			package: 'Glamour-Rubric-Presentations' with: 'Glamour-Rubric-Presentations-TudorGirba.33';
			package: 'Glamour-Tests-Rubric' with: 'Glamour-Tests-Rubric-AndreiChis.14';
			package: 'Glamour-Tests-Resources' with: 'Glamour-Tests-Resources-AndreiChis.3'. 
		
		spec 
			project: 'Rubric' with: '1.2.5' ].


]

{ #category : #versions }
ConfigurationOfGlamourCore >> version305: spec [
	<version: '3.0.5' imports: #('3.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 3.0.5'.
		spec author: 'AndreiChis'.
		spec timestamp: '12/10/2014 13:38'.
		spec 
			package: 'Glamour-Announcements' with: 'Glamour-Announcements-AndreiChis.8';
			package: 'Glamour-Helpers' with: 'Glamour-Helpers-AndreiChis.36';
			package: 'Glamour-Core' with: 'Glamour-Core-BernardoContreras.286';
			package: 'Glamour-Presentations' with: 'Glamour-Presentations-AndreiChis.166';
			package: 'Glamour-Browsers' with: 'Glamour-Browsers-BernardoContreras.107';
			package: 'Glamour-Tests-Core' with: 'Glamour-Tests-Core-AndreiChis.99';
			package: 'Glamour-Morphic-Widgets' with: 'Glamour-Morphic-Widgets-AndreiChis.153';
			package: 'Glamour-Morphic-Renderer' with: [
				spec file: 'Glamour-Morphic-Renderer-AndreiChis.305'.
				spec repository: 'http://www.smalltalkhub.com/mc/PharoExtras/GTToolsIntegration/main' ];
			package: 'Glamour-Morphic-Brick' with: 'Glamour-Morphic-Brick-AliakseiSyrel.86';
			package: 'Glamour-Morphic-Pager' with: 'Glamour-Morphic-Pager-AliakseiSyrel.80';
			package: 'Glamour-Morphic-Theme' with: 'Glamour-Morphic-Theme-TudorGirba.194';
			package: 'Glamour-Tests-Morphic' with: 'Glamour-Tests-Morphic-AndreiChis.118';
			package: 'Glamour-Examples' with: 'Glamour-Examples-TudorGirba.290';
			package: 'Glamour-Rubric-Presentations' with: 'Glamour-Rubric-Presentations-TudorGirba.33';
			package: 'Glamour-Tests-Rubric' with: 'Glamour-Tests-Rubric-AndreiChis.14';
			package: 'Glamour-Tests-Resources' with: 'Glamour-Tests-Resources-AndreiChis.3'. 
		
		spec 
			project: 'Rubric' with: '1.2.5' ].


]

{ #category : #versions }
ConfigurationOfGlamourCore >> version306: spec [
	<version: '3.0.6' imports: #('3.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 3.0.6'.
		spec author: 'TudorGirba'.
		spec timestamp: '12/22/2014 21:38'.
		spec 
			package: 'Glamour-Announcements' with: 'Glamour-Announcements-AndreiChis.8';
			package: 'Glamour-Helpers' with: 'Glamour-Helpers-AndreiChis.36';
			package: 'Glamour-Core' with: 'Glamour-Core-EstebanLorenzano.287';
			package: 'Glamour-Presentations' with: 'Glamour-Presentations-AndreiChis.166';
			package: 'Glamour-Browsers' with: 'Glamour-Browsers-BernardoContreras.107';
			package: 'Glamour-Tests-Core' with: 'Glamour-Tests-Core-EstebanLorenzano.100';
			package: 'Glamour-Morphic-Widgets' with: 'Glamour-Morphic-Widgets-AndreiChis.153';
			package: 'Glamour-Morphic-Renderer' with: [
				spec file: 'Glamour-Morphic-Renderer-AndreiChis.305'.
				spec repository: 'http://www.smalltalkhub.com/mc/PharoExtras/GTToolsIntegration/main' ];
			package: 'Glamour-Morphic-Brick' with: 'Glamour-Morphic-Brick-AliakseiSyrel.88';
			package: 'Glamour-Morphic-Pager' with: 'Glamour-Morphic-Pager-AliakseiSyrel.82';
			package: 'Glamour-Morphic-Theme' with: 'Glamour-Morphic-Theme-TudorGirba.194';
			package: 'Glamour-Tests-Morphic' with: 'Glamour-Tests-Morphic-AndreiChis.118';
			package: 'Glamour-Examples' with: 'Glamour-Examples-TudorGirba.290';
			package: 'Glamour-Rubric-Presentations' with: 'Glamour-Rubric-Presentations-TudorGirba.33';
			package: 'Glamour-Tests-Rubric' with: 'Glamour-Tests-Rubric-AndreiChis.14';
			package: 'Glamour-Tests-Resources' with: 'Glamour-Tests-Resources-AndreiChis.3'. 
		
		spec 
			project: 'Rubric' with: '1.2.6' ].


]

{ #category : #versions }
ConfigurationOfGlamourCore >> version307: spec [
	<version: '3.0.7' imports: #('3.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 3.0.7'.
		spec author: 'AndreiChis'.
		spec timestamp: '12/27/2014 13:41'.
		spec 
			package: 'Glamour-Announcements' with: 'Glamour-Announcements-AndreiChis.8';
			package: 'Glamour-Helpers' with: 'Glamour-Helpers-AndreiChis.36';
			package: 'Glamour-Core' with: 'Glamour-Core-EstebanLorenzano.287';
			package: 'Glamour-Presentations' with: 'Glamour-Presentations-AndreiChis.166';
			package: 'Glamour-Browsers' with: 'Glamour-Browsers-BernardoContreras.107';
			package: 'Glamour-Tests-Core' with: 'Glamour-Tests-Core-EstebanLorenzano.100';
			package: 'Glamour-Morphic-Widgets' with: 'Glamour-Morphic-Widgets-AndreiChis.153';
			package: 'Glamour-Morphic-Renderer' with:'Glamour-Morphic-Renderer-AndreiChis.303';
			package: 'Glamour-Morphic-Brick' with: 'Glamour-Morphic-Brick-AliakseiSyrel.88';
			package: 'Glamour-Morphic-Pager' with: 'Glamour-Morphic-Pager-AliakseiSyrel.82';
			package: 'Glamour-Morphic-Theme' with: 'Glamour-Morphic-Theme-TudorGirba.194';
			package: 'Glamour-Tests-Morphic' with: 'Glamour-Tests-Morphic-AndreiChis.118';
			package: 'Glamour-Examples' with: 'Glamour-Examples-TudorGirba.290';
			package: 'Glamour-Rubric-Presentations' with: 'Glamour-Rubric-Presentations-TudorGirba.33';
			package: 'Glamour-Tests-Rubric' with: 'Glamour-Tests-Rubric-AndreiChis.14';
			package: 'Glamour-Tests-Resources' with: 'Glamour-Tests-Resources-AndreiChis.3'. 
		
		spec 
			project: 'Rubric' with: '1.2.6' ].


]

{ #category : #versions }
ConfigurationOfGlamourCore >> version308: spec [
	<version: '3.0.8' imports: #('3.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 3.0.8'.
		spec author: 'AndreiChis'.
		spec timestamp: '01/07/2015 17:33'.
		spec 
			package: 'Glamour-Announcements' with: 'Glamour-Announcements-AndreiChis.8';
			package: 'Glamour-Browsers' with: 'Glamour-Browsers-BernardoContreras.107';
			package: 'Glamour-Core' with: 'Glamour-Core-EstebanLorenzano.287';
			package: 'Glamour-Examples' with: 'Glamour-Examples-TudorGirba.290';
			package: 'Glamour-Helpers' with: 'Glamour-Helpers-AndreiChis.36';
			package: 'Glamour-Morphic-Brick' with: 'Glamour-Morphic-Brick-AliakseiSyrel.92';
			package: 'Glamour-Morphic-Pager' with: 'Glamour-Morphic-Pager-AliakseiSyrel.82';
			package: 'Glamour-Morphic-Renderer' with:'Glamour-Morphic-Renderer-AndreiChis.304';
			package: 'Glamour-Morphic-Theme' with: 'Glamour-Morphic-Theme-TudorGirba.195';
			package: 'Glamour-Morphic-Widgets' with: 'Glamour-Morphic-Widgets-AndreiChis.154';
			package: 'Glamour-Presentations' with: 'Glamour-Presentations-AndreiChis.166';
			package: 'Glamour-Rubric-Presentations' with: 'Glamour-Rubric-Presentations-AndreiChis.35';
			package: 'Glamour-Tests-Core' with: 'Glamour-Tests-Core-EstebanLorenzano.100';
			package: 'Glamour-Tests-Morphic' with: 'Glamour-Tests-Morphic-AndreiChis.119';
			package: 'Glamour-Tests-Resources' with: 'Glamour-Tests-Resources-AndreiChis.3';
			package: 'Glamour-Tests-Rubric' with: 'Glamour-Tests-Rubric-AndreiChis.14'. 
		
		spec 
			project: 'Rubric' with: '1.2.7' ].


]

{ #category : #versions }
ConfigurationOfGlamourCore >> version309: spec [
	<version: '3.0.9' imports: #('3.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 3.0.9'.
		spec author: 'AndreiChis'.
		spec timestamp: '01/08/2015 21:33'.
		spec 
			package: 'Glamour-Announcements' with: 'Glamour-Announcements-AndreiChis.8';
			package: 'Glamour-Browsers' with: 'Glamour-Browsers-BernardoContreras.107';
			package: 'Glamour-Core' with: 'Glamour-Core-EstebanLorenzano.287';
			package: 'Glamour-Examples' with: 'Glamour-Examples-TudorGirba.290';
			package: 'Glamour-Helpers' with: 'Glamour-Helpers-AndreiChis.36';
			package: 'Glamour-Morphic-Brick' with: 'Glamour-Morphic-Brick-AliakseiSyrel.96';
			package: 'Glamour-Morphic-Pager' with: 'Glamour-Morphic-Pager-AndreiChis.83';
			package: 'Glamour-Morphic-Renderer' with:'Glamour-Morphic-Renderer-AndreiChis.304';
			package: 'Glamour-Morphic-Theme' with: 'Glamour-Morphic-Theme-TudorGirba.195';
			package: 'Glamour-Morphic-Widgets' with: 'Glamour-Morphic-Widgets-AndreiChis.154';
			package: 'Glamour-Presentations' with: 'Glamour-Presentations-AndreiChis.166';
			package: 'Glamour-Rubric-Presentations' with: 'Glamour-Rubric-Presentations-AndreiChis.35';
			package: 'Glamour-Tests-Core' with: 'Glamour-Tests-Core-AndreiChis.101';
			package: 'Glamour-Tests-Morphic' with: 'Glamour-Tests-Morphic-AndreiChis.120';
			package: 'Glamour-Tests-Resources' with: 'Glamour-Tests-Resources-AndreiChis.3';
			package: 'Glamour-Tests-Rubric' with: 'Glamour-Tests-Rubric-AndreiChis.14'. 
		
		spec 
			project: 'Rubric' with: '1.2.7' ].


]

{ #category : #versions }
ConfigurationOfGlamourCore >> version310: spec [
	<version: '3.1.0' imports: #('3.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 3.1.0 - Pharo 4 release'.
		spec author: 'AndreiChis'.
		spec timestamp: '04/08/2015 19:07'.
		spec 
			package: 'Glamour-Announcements' with: 'Glamour-Announcements-AndreiChis.8';
			package: 'Glamour-Browsers' with: 'Glamour-Browsers-TorstenBergmann.109';
			package: 'Glamour-Core' with: 'Glamour-Core-StefanReichhart.299';
			package: 'Glamour-Examples' with: 'Glamour-Examples-TorstenBergmann.291';
			package: 'Glamour-Helpers' with: 'Glamour-Helpers-AndreiChis.39';
			package: 'Glamour-Morphic-Brick' with: 'Glamour-Morphic-Brick-StefanReichhart.398';
			package: 'Glamour-Morphic-Brick-Tests' with: 'Glamour-Morphic-Brick-Tests-AliakseiSyrel.13';
			package: 'Glamour-Morphic-Pager' with: 'Glamour-Morphic-Pager-AndreiChis.103';
			package: 'Glamour-Morphic-Renderer' with:'Glamour-Morphic-Renderer-AndreiChis.319';
			package: 'Glamour-Morphic-Theme' with: 'Glamour-Morphic-Theme-StefanReichhart.212';
			package: 'Glamour-Morphic-Widgets' with: 'Glamour-Morphic-Widgets-AndreiChis.177';
			package: 'Glamour-Presentations' with: 'Glamour-Presentations-AndreiChis.175';
			package: 'Glamour-Rubric-Presentations' with: 'Glamour-Rubric-Presentations-AndreiChis.41';
			package: 'Glamour-Tests-Core' with: 'Glamour-Tests-Core-AliakseiSyrel.104';
			package: 'Glamour-Tests-Morphic' with: 'Glamour-Tests-Morphic-AndreiChis.124';
			package: 'Glamour-Tests-Resources' with: 'Glamour-Tests-Resources-AndreiChis.3';
			package: 'Glamour-Tests-Rubric' with: 'Glamour-Tests-Rubric-AndreiChis.14'. 
		
		spec 
			project: 'Rubric' with: '1.2.10' ].


]

{ #category : #versions }
ConfigurationOfGlamourCore >> version3110: spec [
	<version: '3.1.10' imports: #('3.2-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'update'.
		spec author: 'AndreiChis'.
		spec timestamp: '9/1/2015 11:22'.
		spec project: 'Rubric' with: '1.18.4'.
		spec 
			package: 'Glamour-Announcements' with: 'Glamour-Announcements-AndreiChis.8';
			package: 'Glamour-Helpers' with: 'Glamour-Helpers-AndreiChis.39';
			package: 'Glamour-Core' with: 'Glamour-Core-SeanDeNigris.303';
			package: 'Glamour-Presentations' with: 'Glamour-Presentations-AndreiChis.177';
			package: 'Glamour-Browsers' with: 'Glamour-Browsers-TorstenBergmann.109';
			package: 'Glamour-Examples' with: 'Glamour-Examples-MarcusDenker.293';
			package: 'Glamour-Morphic-Brick' with: 'Glamour-Morphic-Brick-AndreiChis.401';
			package: 'Glamour-Morphic-Brick-Tests' with: 'Glamour-Morphic-Brick-Tests-AliakseiSyrel.13';
			package: 'Glamour-Tests-Core' with: 'Glamour-Tests-Core-BernardoContreras.105';
			package: 'Glamour-Tests-Resources' with: 'Glamour-Tests-Resources-AndreiChis.3';
			package: 'Glamour-Morphic-Theme' with: 'Glamour-Morphic-Theme-AndreiChis.216';
			package: 'Glamour-Morphic-Widgets' with: 'Glamour-Morphic-Widgets-AndreiChis.180';
			package: 'Glamour-Morphic-Renderer' with: 'Glamour-Morphic-Renderer-MarcusDenker.326';
			package: 'Glamour-Morphic-Pager' with: 'Glamour-Morphic-Pager-AndreiChis.103';
			package: 'Glamour-Tests-Morphic' with: 'Glamour-Tests-Morphic-AndreiChis.124';
			package: 'Glamour-Rubric-Presentations' with: 'Glamour-Rubric-Presentations-CyrilFerlicot.43';
			package: 'Glamour-Tests-Rubric' with: 'Glamour-Tests-Rubric-AndreiChis.14'. ].

]

{ #category : #versions }
ConfigurationOfGlamourCore >> version311: spec [
	<version: '3.1.1' imports: #('3.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 3.1.1 - Pharo 4 release'.
		spec author: 'AndreiChis'.
		spec timestamp: '04/11/2015 17:54'.
		spec 
			package: 'Glamour-Announcements' with: 'Glamour-Announcements-AndreiChis.8';
			package: 'Glamour-Browsers' with: 'Glamour-Browsers-TorstenBergmann.109';
			package: 'Glamour-Core' with: 'Glamour-Core-StefanReichhart.299';
			package: 'Glamour-Examples' with: 'Glamour-Examples-TorstenBergmann.291';
			package: 'Glamour-Helpers' with: 'Glamour-Helpers-AndreiChis.39';
			package: 'Glamour-Morphic-Brick' with: 'Glamour-Morphic-Brick-StefanReichhart.398';
			package: 'Glamour-Morphic-Brick-Tests' with: 'Glamour-Morphic-Brick-Tests-AliakseiSyrel.13';
			package: 'Glamour-Morphic-Pager' with: 'Glamour-Morphic-Pager-AndreiChis.103';
			package: 'Glamour-Morphic-Renderer' with:'Glamour-Morphic-Renderer-AndreiChis.320';
			package: 'Glamour-Morphic-Theme' with: 'Glamour-Morphic-Theme-StefanReichhart.212';
			package: 'Glamour-Morphic-Widgets' with: 'Glamour-Morphic-Widgets-AndreiChis.177';
			package: 'Glamour-Presentations' with: 'Glamour-Presentations-AndreiChis.176';
			package: 'Glamour-Rubric-Presentations' with: 'Glamour-Rubric-Presentations-AndreiChis.41';
			package: 'Glamour-Tests-Core' with: 'Glamour-Tests-Core-AliakseiSyrel.104';
			package: 'Glamour-Tests-Morphic' with: 'Glamour-Tests-Morphic-AndreiChis.124';
			package: 'Glamour-Tests-Resources' with: 'Glamour-Tests-Resources-AndreiChis.3';
			package: 'Glamour-Tests-Rubric' with: 'Glamour-Tests-Rubric-AndreiChis.14'. 
		
		spec 
			project: 'Rubric' with: '1.2.10' ].


]

{ #category : #versions }
ConfigurationOfGlamourCore >> version312: spec [
	<version: '3.1.2' imports: #('3.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 3.1.2'.
		spec author: 'AndreiChis'.
		spec timestamp: '04/29/2015 11:07'.
		spec 
			package: 'Glamour-Announcements' with: 'Glamour-Announcements-AndreiChis.8';
			package: 'Glamour-Browsers' with: 'Glamour-Browsers-TorstenBergmann.109';
			package: 'Glamour-Core' with: 'Glamour-Core-StefanReichhart.299';
			package: 'Glamour-Examples' with: 'Glamour-Examples-TorstenBergmann.291';
			package: 'Glamour-Helpers' with: 'Glamour-Helpers-AndreiChis.39';
			package: 'Glamour-Morphic-Brick' with: 'Glamour-Morphic-Brick-StefanReichhart.398';
			package: 'Glamour-Morphic-Brick-Tests' with: 'Glamour-Morphic-Brick-Tests-AliakseiSyrel.13';
			package: 'Glamour-Morphic-Pager' with: 'Glamour-Morphic-Pager-AndreiChis.103';
			package: 'Glamour-Morphic-Renderer' with:'Glamour-Morphic-Renderer-AndreiChis.321';
			package: 'Glamour-Morphic-Theme' with: 'Glamour-Morphic-Theme-StefanReichhart.212';
			package: 'Glamour-Morphic-Widgets' with: 'Glamour-Morphic-Widgets-AndreiChis.177';
			package: 'Glamour-Presentations' with: 'Glamour-Presentations-AndreiChis.177';
			package: 'Glamour-Rubric-Presentations' with: 'Glamour-Rubric-Presentations-AndreiChis.41';
			package: 'Glamour-Tests-Core' with: 'Glamour-Tests-Core-AliakseiSyrel.104';
			package: 'Glamour-Tests-Morphic' with: 'Glamour-Tests-Morphic-AndreiChis.124';
			package: 'Glamour-Tests-Resources' with: 'Glamour-Tests-Resources-AndreiChis.3';
			package: 'Glamour-Tests-Rubric' with: 'Glamour-Tests-Rubric-AndreiChis.14'. 
		
		spec 
			project: 'Rubric' with: '1.2.12' ].


]

{ #category : #versions }
ConfigurationOfGlamourCore >> version313: spec [
	<version: '3.1.3' imports: #('3.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 3.1.3'.
		spec author: 'AndreiChis'.
		spec timestamp: '05/05/2015'.
		spec 
			package: 'Glamour-Announcements' with: 'Glamour-Announcements-AndreiChis.8';
			package: 'Glamour-Browsers' with: 'Glamour-Browsers-TorstenBergmann.109';
			package: 'Glamour-Core' with: 'Glamour-Core-StefanReichhart.299';
			package: 'Glamour-Examples' with: 'Glamour-Examples-TorstenBergmann.291';
			package: 'Glamour-Helpers' with: 'Glamour-Helpers-AndreiChis.39';
			package: 'Glamour-Morphic-Brick' with: 'Glamour-Morphic-Brick-StefanReichhart.398';
			package: 'Glamour-Morphic-Brick-Tests' with: 'Glamour-Morphic-Brick-Tests-AliakseiSyrel.13';
			package: 'Glamour-Morphic-Pager' with: 'Glamour-Morphic-Pager-AndreiChis.103';
			package: 'Glamour-Morphic-Renderer' with:'Glamour-Morphic-Renderer-usmanbhatti.323';
			package: 'Glamour-Morphic-Theme' with: 'Glamour-Morphic-Theme-StefanReichhart.212';
			package: 'Glamour-Morphic-Widgets' with: 'Glamour-Morphic-Widgets-AndreiChis.177';
			package: 'Glamour-Presentations' with: 'Glamour-Presentations-AndreiChis.177';
			package: 'Glamour-Rubric-Presentations' with: 'Glamour-Rubric-Presentations-AndreiChis.41';
			package: 'Glamour-Tests-Core' with: 'Glamour-Tests-Core-AliakseiSyrel.104';
			package: 'Glamour-Tests-Morphic' with: 'Glamour-Tests-Morphic-AndreiChis.124';
			package: 'Glamour-Tests-Resources' with: 'Glamour-Tests-Resources-AndreiChis.3';
			package: 'Glamour-Tests-Rubric' with: 'Glamour-Tests-Rubric-AndreiChis.14'. 
		
		spec 
			project: 'Rubric' with: '1.2.14' ].


]

{ #category : #versions }
ConfigurationOfGlamourCore >> version313Moose51: spec [
	<version: '3.1.3.Moose51' imports: #('3.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 3.1.3.Moose51 - fixes text color attributes related bug in rubric presentation in Moose 5.1'.
		spec author: 'UsmanBhatti'.
		spec timestamp: '09/04/2015'.
		spec 
			package: 'Glamour-Announcements' with: 'Glamour-Announcements-AndreiChis.8';
			package: 'Glamour-Browsers' with: 'Glamour-Browsers-TorstenBergmann.109';
			package: 'Glamour-Core' with: 'Glamour-Core-StefanReichhart.299';
			package: 'Glamour-Examples' with: 'Glamour-Examples-TorstenBergmann.291';
			package: 'Glamour-Helpers' with: 'Glamour-Helpers-AndreiChis.39';
			package: 'Glamour-Morphic-Brick' with: 'Glamour-Morphic-Brick-StefanReichhart.398';
			package: 'Glamour-Morphic-Brick-Tests' with: 'Glamour-Morphic-Brick-Tests-AliakseiSyrel.13';
			package: 'Glamour-Morphic-Pager' with: 'Glamour-Morphic-Pager-AndreiChis.103';
			package: 'Glamour-Morphic-Theme' with: 'Glamour-Morphic-Theme-StefanReichhart.212';
			package: 'Glamour-Morphic-Widgets' with: 'Glamour-Morphic-Widgets-AndreiChis.177';
			package: 'Glamour-Presentations' with: 'Glamour-Presentations-AndreiChis.177';
			package: 'Glamour-Rubric-Presentations' with: 'Glamour-Rubric-Presentations-AndreiChis.41';
			package: 'Glamour-Tests-Core' with: 'Glamour-Tests-Core-AliakseiSyrel.104';
			package: 'Glamour-Tests-Morphic' with: 'Glamour-Tests-Morphic-AndreiChis.124';
			package: 'Glamour-Tests-Resources' with: 'Glamour-Tests-Resources-AndreiChis.3';
			package: 'Glamour-Tests-Rubric' with: 'Glamour-Tests-Rubric-AndreiChis.14'. 
		
		spec repository: 'http://smalltalkhub.com/mc/Moose/Moose51/main'.
		spec
			package: 'Glamour-Morphic-Renderer' with:'Glamour-Morphic-Renderer.Moose51-usmanbhatti.324'.
		
		spec 
			project: 'Rubric' with: '1.2.14.Moose51' ].


]

{ #category : #versions }
ConfigurationOfGlamourCore >> version314: spec [
	<version: '3.1.4' imports: #('3.2-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'bugfix: shortcut string for windows and linux is "ctrl", not "alt"'.
		spec author: 'EstebanLorenzano'.
		spec timestamp: '5/29/2015 16:12'.
		spec project: 'Rubric' with: '1.2.15'.
		spec 
			package: 'Glamour-Announcements' with: 'Glamour-Announcements-AndreiChis.8';
			package: 'Glamour-Helpers' with: 'Glamour-Helpers-AndreiChis.39';
			package: 'Glamour-Core' with: 'Glamour-Core-EstebanLorenzano.300';
			package: 'Glamour-Presentations' with: 'Glamour-Presentations-AndreiChis.177';
			package: 'Glamour-Browsers' with: 'Glamour-Browsers-TorstenBergmann.109';
			package: 'Glamour-Examples' with: 'Glamour-Examples-TorstenBergmann.291';
			package: 'Glamour-Morphic-Brick' with: 'Glamour-Morphic-Brick-StefanReichhart.398';
			package: 'Glamour-Morphic-Brick-Tests' with: 'Glamour-Morphic-Brick-Tests-AliakseiSyrel.13';
			package: 'Glamour-Tests-Core' with: 'Glamour-Tests-Core-AliakseiSyrel.104';
			package: 'Glamour-Tests-Resources' with: 'Glamour-Tests-Resources-AndreiChis.3';
			package: 'Glamour-Morphic-Theme' with: 'Glamour-Morphic-Theme-StefanReichhart.212';
			package: 'Glamour-Morphic-Widgets' with: 'Glamour-Morphic-Widgets-AndreiChis.177';
			package: 'Glamour-Morphic-Renderer' with: 'Glamour-Morphic-Renderer-AndreiChis.321';
			package: 'Glamour-Morphic-Pager' with: 'Glamour-Morphic-Pager-AndreiChis.103';
			package: 'Glamour-Tests-Morphic' with: 'Glamour-Tests-Morphic-AndreiChis.124';
			package: 'Glamour-Rubric-Presentations' with: 'Glamour-Rubric-Presentations-AndreiChis.41';
			package: 'Glamour-Tests-Rubric' with: 'Glamour-Tests-Rubric-AndreiChis.14'. ].

]

{ #category : #versions }
ConfigurationOfGlamourCore >> version314Moose51: spec [
	<version: '3.1.4.Moose51' imports: #('3.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 3.1.4.Moose51 - Improvement of the Dashboard'.
		spec author: 'CyrilFerlicot'.
		spec timestamp: '12/15/2015'.
		spec 
			package: 'Glamour-Announcements' with: 'Glamour-Announcements-AndreiChis.8';
			package: 'Glamour-Core' with: 'Glamour-Core-StefanReichhart.299';
			package: 'Glamour-Examples' with: 'Glamour-Examples-TorstenBergmann.291';
			package: 'Glamour-Helpers' with: 'Glamour-Helpers-AndreiChis.39';
			package: 'Glamour-Morphic-Brick' with: 'Glamour-Morphic-Brick-StefanReichhart.398';
			package: 'Glamour-Morphic-Brick-Tests' with: 'Glamour-Morphic-Brick-Tests-AliakseiSyrel.13';
			package: 'Glamour-Morphic-Pager' with: 'Glamour-Morphic-Pager-AndreiChis.103';
			package: 'Glamour-Morphic-Theme' with: 'Glamour-Morphic-Theme-StefanReichhart.212';
			package: 'Glamour-Morphic-Widgets' with: 'Glamour-Morphic-Widgets-AndreiChis.177';
			package: 'Glamour-Presentations' with: 'Glamour-Presentations-AndreiChis.177';
			package: 'Glamour-Rubric-Presentations' with: 'Glamour-Rubric-Presentations-AndreiChis.41';
			package: 'Glamour-Tests-Resources' with: 'Glamour-Tests-Resources-AndreiChis.3';
			package: 'Glamour-Tests-Rubric' with: 'Glamour-Tests-Rubric-AndreiChis.14'. 
		
		spec repository: 'http://smalltalkhub.com/mc/Moose/Moose51/main'.
		spec
			package: 'Glamour-Browsers' with: 'Glamour-Browsers.Moose51-CyrilFerlicot.110';
			package: 'Glamour-Tests-Core' with: 'Glamour-Tests-Core.Moose51-CyrilFerlicot.105';
			package: 'Glamour-Tests-Morphic' with: 'Glamour-Tests-Morphic.Moose51-CyrilFerlicot.125';
			package: 'Glamour-Morphic-Renderer' with:'Glamour-Morphic-Renderer.Moose51-CyrilFerlicot.325'.
		
		spec 
			project: 'Rubric' with: '1.2.14.Moose51' ].


]

{ #category : #versions }
ConfigurationOfGlamourCore >> version315: spec [
	<version: '3.1.5' imports: #('3.2-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 3.1.5'.
		spec author: 'FranckWarlouzet'.
		spec timestamp: '6/30/2015 11:16'.
		spec project: 'Rubric' with: '1.12'.
		spec 
			package: 'Glamour-Announcements' with: 'Glamour-Announcements-AndreiChis.8';
			package: 'Glamour-Helpers' with: 'Glamour-Helpers-AndreiChis.39';
			package: 'Glamour-Core' with: 'Glamour-Core-EstebanLorenzano.300';
			package: 'Glamour-Presentations' with: 'Glamour-Presentations-AndreiChis.177';
			package: 'Glamour-Browsers' with: 'Glamour-Browsers-TorstenBergmann.109';
			package: 'Glamour-Examples' with: 'Glamour-Examples-CyrilFerlicot.292';
			package: 'Glamour-Morphic-Brick' with: 'Glamour-Morphic-Brick-StefanReichhart.398';
			package: 'Glamour-Morphic-Brick-Tests' with: 'Glamour-Morphic-Brick-Tests-AliakseiSyrel.13';
			package: 'Glamour-Tests-Core' with: 'Glamour-Tests-Core-AliakseiSyrel.104';
			package: 'Glamour-Tests-Resources' with: 'Glamour-Tests-Resources-AndreiChis.3';
			package: 'Glamour-Morphic-Theme' with: 'Glamour-Morphic-Theme-MarcusDenker.214';
			package: 'Glamour-Morphic-Widgets' with: 'Glamour-Morphic-Widgets-FranckWarlouzet.178';
			package: 'Glamour-Morphic-Renderer' with: 'Glamour-Morphic-Renderer-CyrilFerlicot.322';
			package: 'Glamour-Morphic-Pager' with: 'Glamour-Morphic-Pager-AndreiChis.103';
			package: 'Glamour-Tests-Morphic' with: 'Glamour-Tests-Morphic-AndreiChis.124';
			package: 'Glamour-Rubric-Presentations' with: 'Glamour-Rubric-Presentations-CyrilFerlicot.43';
			package: 'Glamour-Tests-Rubric' with: 'Glamour-Tests-Rubric-AndreiChis.14'. ].

]

{ #category : #versions }
ConfigurationOfGlamourCore >> version316: spec [
	<version: '3.1.6' imports: #('3.2-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 3.1.6'.
		spec author: 'FranckWarlouzet'.
		spec timestamp: '6/29/2015 16:34'.
		spec project: 'Rubric' with: '1.10'.
		spec 
			package: 'Glamour-Announcements' with: 'Glamour-Announcements-AndreiChis.8';
			package: 'Glamour-Helpers' with: 'Glamour-Helpers-AndreiChis.39';
			package: 'Glamour-Core' with: 'Glamour-Core-EstebanLorenzano.300';
			package: 'Glamour-Presentations' with: 'Glamour-Presentations-AndreiChis.177';
			package: 'Glamour-Browsers' with: 'Glamour-Browsers-TorstenBergmann.109';
			package: 'Glamour-Examples' with: 'Glamour-Examples-CyrilFerlicot.292';
			package: 'Glamour-Morphic-Brick' with: 'Glamour-Morphic-Brick-StefanReichhart.398';
			package: 'Glamour-Morphic-Brick-Tests' with: 'Glamour-Morphic-Brick-Tests-AliakseiSyrel.13';
			package: 'Glamour-Tests-Core' with: 'Glamour-Tests-Core-AliakseiSyrel.104';
			package: 'Glamour-Tests-Resources' with: 'Glamour-Tests-Resources-AndreiChis.3';
			package: 'Glamour-Morphic-Theme' with: 'Glamour-Morphic-Theme-MarcusDenker.214';
			package: 'Glamour-Morphic-Widgets' with: 'Glamour-Morphic-Widgets-FranckWarlouzet.178';
			package: 'Glamour-Morphic-Renderer' with: 'Glamour-Morphic-Renderer-CyrilFerlicot.322';
			package: 'Glamour-Morphic-Pager' with: 'Glamour-Morphic-Pager-AndreiChis.103';
			package: 'Glamour-Tests-Morphic' with: 'Glamour-Tests-Morphic-AndreiChis.124';
			package: 'Glamour-Rubric-Presentations' with: 'Glamour-Rubric-Presentations-CyrilFerlicot.43';
			package: 'Glamour-Tests-Rubric' with: 'Glamour-Tests-Rubric-AndreiChis.14'. ].

]

{ #category : #versions }
ConfigurationOfGlamourCore >> version317: spec [
	<version: '3.1.7' imports: #('3.2-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 3.1.7'.
		spec author: 'AndreiChis'.
		spec timestamp: '7/1/2015 14:16'.
		spec project: 'Rubric' with: '1.12'.
		spec 
			package: 'Glamour-Announcements' with: 'Glamour-Announcements-AndreiChis.8';
			package: 'Glamour-Helpers' with: 'Glamour-Helpers-AndreiChis.39';
			package: 'Glamour-Core' with: 'Glamour-Core-EstebanLorenzano.301';
			package: 'Glamour-Presentations' with: 'Glamour-Presentations-AndreiChis.177';
			package: 'Glamour-Browsers' with: 'Glamour-Browsers-TorstenBergmann.109';
			package: 'Glamour-Examples' with: 'Glamour-Examples-CyrilFerlicot.292';
			package: 'Glamour-Morphic-Brick' with: 'Glamour-Morphic-Brick-StefanReichhart.398';
			package: 'Glamour-Morphic-Brick-Tests' with: 'Glamour-Morphic-Brick-Tests-AliakseiSyrel.13';
			package: 'Glamour-Tests-Core' with: 'Glamour-Tests-Core-AliakseiSyrel.104';
			package: 'Glamour-Tests-Resources' with: 'Glamour-Tests-Resources-AndreiChis.3';
			package: 'Glamour-Morphic-Theme' with: 'Glamour-Morphic-Theme-MarcusDenker.214';
			package: 'Glamour-Morphic-Widgets' with: 'Glamour-Morphic-Widgets-FranckWarlouzet.178';
			package: 'Glamour-Morphic-Renderer' with: 'Glamour-Morphic-Renderer-CyrilFerlicot.322';
			package: 'Glamour-Morphic-Pager' with: 'Glamour-Morphic-Pager-AndreiChis.103';
			package: 'Glamour-Tests-Morphic' with: 'Glamour-Tests-Morphic-AndreiChis.124';
			package: 'Glamour-Rubric-Presentations' with: 'Glamour-Rubric-Presentations-CyrilFerlicot.43';
			package: 'Glamour-Tests-Rubric' with: 'Glamour-Tests-Rubric-AndreiChis.14'. ].

]

{ #category : #versions }
ConfigurationOfGlamourCore >> version318: spec [
	<version: '3.1.8' imports: #('3.2-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'Fixed cycle issue in Glamour

----
I try to load GT tools to minimal Pharo image (with Morphic) and I have problems to do that because it has a dependency cycle it these methods:

  GLMBrickDarkThemer>>#actionThemer
  GLMBrickThemer>>#actionThemer

These methods try to extend classes in Glamour-Morphic-Brick package but they belong to Glamour-Core package that is prerequisite of the first package. 
-----'.
		spec author: 'AndreiChis'.
		spec timestamp: '7/3/2015 13:51'.
		spec project: 'Rubric' with: '1.14'.
		spec 
			package: 'Glamour-Announcements' with: 'Glamour-Announcements-AndreiChis.8';
			package: 'Glamour-Helpers' with: 'Glamour-Helpers-AndreiChis.39';
			package: 'Glamour-Core' with: 'Glamour-Core-AndreiChis.302';
			package: 'Glamour-Presentations' with: 'Glamour-Presentations-AndreiChis.177';
			package: 'Glamour-Browsers' with: 'Glamour-Browsers-TorstenBergmann.109';
			package: 'Glamour-Examples' with: 'Glamour-Examples-CyrilFerlicot.292';
			package: 'Glamour-Morphic-Brick' with: 'Glamour-Morphic-Brick-AndreiChis.400';
			package: 'Glamour-Morphic-Brick-Tests' with: 'Glamour-Morphic-Brick-Tests-AliakseiSyrel.13';
			package: 'Glamour-Tests-Core' with: 'Glamour-Tests-Core-BernardoContreras.105';
			package: 'Glamour-Tests-Resources' with: 'Glamour-Tests-Resources-AndreiChis.3';
			package: 'Glamour-Morphic-Theme' with: 'Glamour-Morphic-Theme-AndreiChis.216';
			package: 'Glamour-Morphic-Widgets' with: 'Glamour-Morphic-Widgets-FranckWarlouzet.178';
			package: 'Glamour-Morphic-Renderer' with: 'Glamour-Morphic-Renderer-usmanbhatti.323';
			package: 'Glamour-Morphic-Pager' with: 'Glamour-Morphic-Pager-AndreiChis.103';
			package: 'Glamour-Tests-Morphic' with: 'Glamour-Tests-Morphic-AndreiChis.124';
			package: 'Glamour-Rubric-Presentations' with: 'Glamour-Rubric-Presentations-CyrilFerlicot.43';
			package: 'Glamour-Tests-Rubric' with: 'Glamour-Tests-Rubric-AndreiChis.14'. ].

]

{ #category : #versions }
ConfigurationOfGlamourCore >> version319: spec [
	<version: '3.1.9' imports: #('3.2-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'update'.
		spec author: 'AndreiChis'.
		spec timestamp: '8/12/2015 15:22'.
		spec project: 'Rubric' with: '1.16.6'.
		spec 
			package: 'Glamour-Announcements' with: 'Glamour-Announcements-AndreiChis.8';
			package: 'Glamour-Helpers' with: 'Glamour-Helpers-AndreiChis.39';
			package: 'Glamour-Core' with: 'Glamour-Core-AndreiChis.302';
			package: 'Glamour-Presentations' with: 'Glamour-Presentations-AndreiChis.177';
			package: 'Glamour-Browsers' with: 'Glamour-Browsers-TorstenBergmann.109';
			package: 'Glamour-Examples' with: 'Glamour-Examples-MarcusDenker.293';
			package: 'Glamour-Morphic-Brick' with: 'Glamour-Morphic-Brick-AndreiChis.401';
			package: 'Glamour-Morphic-Brick-Tests' with: 'Glamour-Morphic-Brick-Tests-AliakseiSyrel.13';
			package: 'Glamour-Tests-Core' with: 'Glamour-Tests-Core-BernardoContreras.105';
			package: 'Glamour-Tests-Resources' with: 'Glamour-Tests-Resources-AndreiChis.3';
			package: 'Glamour-Morphic-Theme' with: 'Glamour-Morphic-Theme-AndreiChis.216';
			package: 'Glamour-Morphic-Widgets' with: 'Glamour-Morphic-Widgets-AndreiChis.180';
			package: 'Glamour-Morphic-Renderer' with: 'Glamour-Morphic-Renderer-AndreiChis.325';
			package: 'Glamour-Morphic-Pager' with: 'Glamour-Morphic-Pager-AndreiChis.103';
			package: 'Glamour-Tests-Morphic' with: 'Glamour-Tests-Morphic-AndreiChis.124';
			package: 'Glamour-Rubric-Presentations' with: 'Glamour-Rubric-Presentations-CyrilFerlicot.43';
			package: 'Glamour-Tests-Rubric' with: 'Glamour-Tests-Rubric-AndreiChis.14'. ].

]

{ #category : #versions }
ConfigurationOfGlamourCore >> version320: spec [
	<version: '3.2.0' imports: #('3.2-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'Add GLMPresentation>>##hasTransformation - like #hasTitle, but for #display:'.
		spec author: 'SeanDeNigris'.
		spec timestamp: '8/22/2015 15:22'.
		spec project: 'Rubric' with: '1.18.4'.
		spec 
			package: 'Glamour-Announcements' with: 'Glamour-Announcements-AndreiChis.8';
			package: 'Glamour-Helpers' with: 'Glamour-Helpers-AndreiChis.39';
			package: 'Glamour-Core' with: 'Glamour-Core-SeanDeNigris.303';
			package: 'Glamour-Presentations' with: 'Glamour-Presentations-AndreiChis.177';
			package: 'Glamour-Browsers' with: 'Glamour-Browsers-TorstenBergmann.109';
			package: 'Glamour-Examples' with: 'Glamour-Examples-MarcusDenker.293';
			package: 'Glamour-Morphic-Brick' with: 'Glamour-Morphic-Brick-AndreiChis.401';
			package: 'Glamour-Morphic-Brick-Tests' with: 'Glamour-Morphic-Brick-Tests-AliakseiSyrel.13';
			package: 'Glamour-Tests-Core' with: 'Glamour-Tests-Core-BernardoContreras.105';
			package: 'Glamour-Tests-Resources' with: 'Glamour-Tests-Resources-AndreiChis.3';
			package: 'Glamour-Morphic-Theme' with: 'Glamour-Morphic-Theme-AndreiChis.216';
			package: 'Glamour-Morphic-Widgets' with: 'Glamour-Morphic-Widgets-AndreiChis.180';
			package: 'Glamour-Morphic-Renderer' with: 'Glamour-Morphic-Renderer-MarcusDenker.326';
			package: 'Glamour-Morphic-Pager' with: 'Glamour-Morphic-Pager-AndreiChis.103';
			package: 'Glamour-Tests-Morphic' with: 'Glamour-Tests-Morphic-AndreiChis.124';
			package: 'Glamour-Rubric-Presentations' with: 'Glamour-Rubric-Presentations-CyrilFerlicot.43';
			package: 'Glamour-Tests-Rubric' with: 'Glamour-Tests-Rubric-AndreiChis.14'. ].

]

{ #category : #versions }
ConfigurationOfGlamourCore >> version321: spec [
	<version: '3.2.1' imports: #('3.2-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'Removed use of subscribe:send:to: for when:send:to:'.
		spec author: 'CyrilFerlicot'.
		spec timestamp: '9/11/2015 21:05'.
		spec project: 'Rubric' with: '1.18.4'.
		spec 
			package: 'Glamour-Announcements' with: 'Glamour-Announcements-AndreiChis.8';
			package: 'Glamour-Helpers' with: 'Glamour-Helpers-AndreiChis.39';
			package: 'Glamour-Core' with: 'Glamour-Core-SeanDeNigris.303';
			package: 'Glamour-Presentations' with: 'Glamour-Presentations-AndreiChis.177';
			package: 'Glamour-Browsers' with: 'Glamour-Browsers-TorstenBergmann.109';
			package: 'Glamour-Examples' with: 'Glamour-Examples-MarcusDenker.293';
			package: 'Glamour-Morphic-Brick' with: 'Glamour-Morphic-Brick-CyrilFerlicot.402';
			package: 'Glamour-Morphic-Brick-Tests' with: 'Glamour-Morphic-Brick-Tests-AliakseiSyrel.13';
			package: 'Glamour-Tests-Core' with: 'Glamour-Tests-Core-BernardoContreras.105';
			package: 'Glamour-Tests-Resources' with: 'Glamour-Tests-Resources-AndreiChis.3';
			package: 'Glamour-Morphic-Theme' with: 'Glamour-Morphic-Theme-AndreiChis.216';
			package: 'Glamour-Morphic-Widgets' with: 'Glamour-Morphic-Widgets-AndreiChis.180';
			package: 'Glamour-Morphic-Renderer' with: 'Glamour-Morphic-Renderer-MarcusDenker.326';
			package: 'Glamour-Morphic-Pager' with: 'Glamour-Morphic-Pager-CyrilFerlicot.104';
			package: 'Glamour-Tests-Morphic' with: 'Glamour-Tests-Morphic-AndreiChis.124';
			package: 'Glamour-Rubric-Presentations' with: 'Glamour-Rubric-Presentations-CyrilFerlicot.43';
			package: 'Glamour-Tests-Rubric' with: 'Glamour-Tests-Rubric-AndreiChis.14'. ].

]

{ #category : #versions }
ConfigurationOfGlamourCore >> version322: spec [
	<version: '3.2.2' imports: #('3.2-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'remove  hard dependency to theme icons (they will be remove, and also it was bad :) )'.
		spec author: 'EstebanLorenzano'.
		spec timestamp: '10/1/2015 14:23'.
		spec project: 'Rubric' with: '1.18'.
		spec 
			package: 'Glamour-Announcements' with: 'Glamour-Announcements-AndreiChis.8';
			package: 'Glamour-Helpers' with: 'Glamour-Helpers-AndreiChis.39';
			package: 'Glamour-Core' with: 'Glamour-Core-AndreiChis.302';
			package: 'Glamour-Presentations' with: 'Glamour-Presentations-AndreiChis.177';
			package: 'Glamour-Browsers' with: 'Glamour-Browsers-TorstenBergmann.109';
			package: 'Glamour-Examples' with: 'Glamour-Examples-EstebanLorenzano.294';
			package: 'Glamour-Morphic-Brick' with: 'Glamour-Morphic-Brick-AndreiChis.401';
			package: 'Glamour-Morphic-Brick-Tests' with: 'Glamour-Morphic-Brick-Tests-AliakseiSyrel.13';
			package: 'Glamour-Tests-Core' with: 'Glamour-Tests-Core-BernardoContreras.105';
			package: 'Glamour-Tests-Resources' with: 'Glamour-Tests-Resources-AndreiChis.3';
			package: 'Glamour-Morphic-Theme' with: 'Glamour-Morphic-Theme-EstebanLorenzano.217';
			package: 'Glamour-Morphic-Widgets' with: 'Glamour-Morphic-Widgets-AndreiChis.180';
			package: 'Glamour-Morphic-Renderer' with: 'Glamour-Morphic-Renderer-AndreiChis.325';
			package: 'Glamour-Morphic-Pager' with: 'Glamour-Morphic-Pager-AndreiChis.103';
			package: 'Glamour-Tests-Morphic' with: 'Glamour-Tests-Morphic-AndreiChis.124';
			package: 'Glamour-Rubric-Presentations' with: 'Glamour-Rubric-Presentations-CyrilFerlicot.43';
			package: 'Glamour-Tests-Rubric' with: 'Glamour-Tests-Rubric-AndreiChis.14'. ].

]

{ #category : #versions }
ConfigurationOfGlamourCore >> version323: spec [
	<version: '3.2.3' imports: #('3.2-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'merged latest brick changes (fixing a compiler problem)'.
		spec author: 'EstebanLorenzano'.
		spec timestamp: '10/2/2015 12:14'.
		spec project: 'Rubric' with: '1.18'.
		spec 
			package: 'Glamour-Announcements' with: 'Glamour-Announcements-AndreiChis.8';
			package: 'Glamour-Helpers' with: 'Glamour-Helpers-AndreiChis.39';
			package: 'Glamour-Core' with: 'Glamour-Core-AndreiChis.302';
			package: 'Glamour-Presentations' with: 'Glamour-Presentations-AndreiChis.177';
			package: 'Glamour-Browsers' with: 'Glamour-Browsers-TorstenBergmann.109';
			package: 'Glamour-Examples' with: 'Glamour-Examples-EstebanLorenzano.294';
			package: 'Glamour-Morphic-Brick' with: 'Glamour-Morphic-Brick-EstebanLorenzano.406';
			package: 'Glamour-Morphic-Brick-Tests' with: 'Glamour-Morphic-Brick-Tests-AliakseiSyrel.13';
			package: 'Glamour-Tests-Core' with: 'Glamour-Tests-Core-BernardoContreras.105';
			package: 'Glamour-Tests-Resources' with: 'Glamour-Tests-Resources-AndreiChis.3';
			package: 'Glamour-Morphic-Theme' with: 'Glamour-Morphic-Theme-EstebanLorenzano.218';
			package: 'Glamour-Morphic-Widgets' with: 'Glamour-Morphic-Widgets-AndreiChis.180';
			package: 'Glamour-Morphic-Renderer' with: 'Glamour-Morphic-Renderer-AndreiChis.325';
			package: 'Glamour-Morphic-Pager' with: 'Glamour-Morphic-Pager-AndreiChis.103';
			package: 'Glamour-Tests-Morphic' with: 'Glamour-Tests-Morphic-AndreiChis.124';
			package: 'Glamour-Rubric-Presentations' with: 'Glamour-Rubric-Presentations-CyrilFerlicot.43';
			package: 'Glamour-Tests-Rubric' with: 'Glamour-Tests-Rubric-AndreiChis.14'. ].

]

{ #category : #versions }
ConfigurationOfGlamourCore >> version324: spec [
	<version: '3.2.4' imports: #('3.2-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'bugfixes'.
		spec author: 'AndreiChis'.
		spec timestamp: '10/8/2015 21:24'.
		spec project: 'Rubric' with: '1.18'.
		spec 
			package: 'Glamour-Announcements' with: 'Glamour-Announcements-AndreiChis.8';
			package: 'Glamour-Helpers' with: 'Glamour-Helpers-AndreiChis.39';
			package: 'Glamour-Core' with: 'Glamour-Core-SeanDeNigris.303';
			package: 'Glamour-Presentations' with: 'Glamour-Presentations-AndreiChis.178';
			package: 'Glamour-Browsers' with: 'Glamour-Browsers-TorstenBergmann.109';
			package: 'Glamour-Examples' with: 'Glamour-Examples-EstebanLorenzano.294';
			package: 'Glamour-Morphic-Brick' with: 'Glamour-Morphic-Brick-EstebanLorenzano.406';
			package: 'Glamour-Morphic-Brick-Tests' with: 'Glamour-Morphic-Brick-Tests-AliakseiSyrel.13';
			package: 'Glamour-Tests-Core' with: 'Glamour-Tests-Core-BernardoContreras.106';
			package: 'Glamour-Tests-Resources' with: 'Glamour-Tests-Resources-AndreiChis.3';
			package: 'Glamour-Morphic-Theme' with: 'Glamour-Morphic-Theme-EstebanLorenzano.218';
			package: 'Glamour-Morphic-Widgets' with: 'Glamour-Morphic-Widgets-AndreiChis.180';
			package: 'Glamour-Morphic-Renderer' with: 'Glamour-Morphic-Renderer-MarcusDenker.326';
			package: 'Glamour-Morphic-Pager' with: 'Glamour-Morphic-Pager-CyrilFerlicot.104';
			package: 'Glamour-Tests-Morphic' with: 'Glamour-Tests-Morphic-AndreiChis.124';
			package: 'Glamour-Rubric-Presentations' with: 'Glamour-Rubric-Presentations-CyrilFerlicot.43';
			package: 'Glamour-Tests-Rubric' with: 'Glamour-Tests-Rubric-AndreiChis.14'. ].

]

{ #category : #versions }
ConfigurationOfGlamourCore >> version325: spec [
	<version: '3.2.5' imports: #('3.2-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'bugfixes'.
		spec author: 'AndreiChis'.
		spec timestamp: '10/15/2015 16:18'.
		spec project: 'Rubric' with: '2.1'.
		spec 
			package: 'Glamour-Announcements' with: 'Glamour-Announcements-AndreiChis.8';
			package: 'Glamour-Helpers' with: 'Glamour-Helpers-AndreiChis.39';
			package: 'Glamour-Core' with: 'Glamour-Core-SeanDeNigris.303';
			package: 'Glamour-Presentations' with: 'Glamour-Presentations-AndreiChis.178';
			package: 'Glamour-Browsers' with: 'Glamour-Browsers-TorstenBergmann.109';
			package: 'Glamour-Examples' with: 'Glamour-Examples-AndreiChis.296';
			package: 'Glamour-Morphic-Brick' with: 'Glamour-Morphic-Brick-EstebanLorenzano.406';
			package: 'Glamour-Morphic-Brick-Tests' with: 'Glamour-Morphic-Brick-Tests-AliakseiSyrel.13';
			package: 'Glamour-Tests-Core' with: 'Glamour-Tests-Core-BernardoContreras.106';
			package: 'Glamour-Tests-Resources' with: 'Glamour-Tests-Resources-AndreiChis.3';
			package: 'Glamour-Morphic-Theme' with: 'Glamour-Morphic-Theme-AndreiChis.221';
			package: 'Glamour-Morphic-Widgets' with: 'Glamour-Morphic-Widgets-AndreiChis.180';
			package: 'Glamour-Morphic-Renderer' with: 'Glamour-Morphic-Renderer-AndreiChis.327';
			package: 'Glamour-Morphic-Pager' with: 'Glamour-Morphic-Pager-CyrilFerlicot.104';
			package: 'Glamour-Tests-Morphic' with: 'Glamour-Tests-Morphic-AndreiChis.124';
			package: 'Glamour-Rubric-Presentations' with: 'Glamour-Rubric-Presentations-AndreiChis.44';
			package: 'Glamour-Tests-Rubric' with: 'Glamour-Tests-Rubric-AndreiChis.14'. ].

]

{ #category : #versions }
ConfigurationOfGlamourCore >> version33: spec [
	<version: '3.3' imports: #('3.2-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'Updated GTools: 
  - bug fixes
  - deprecated PluggableTextMorph
  - improved event recorder'.
		spec author: 'AndreiChis'.
		spec timestamp: '11/9/2015 14:32'.
		spec project: 'Rubric' with: '2.2'.
		spec 
			package: 'Glamour-Announcements' with: 'Glamour-Announcements-AndreiChis.8';
			package: 'Glamour-Helpers' with: 'Glamour-Helpers-AndreiChis.39';
			package: 'Glamour-Core' with: 'Glamour-Core-AndreiChis.306';
			package: 'Glamour-Presentations' with: 'Glamour-Presentations-AndreiChis.179';
			package: 'Glamour-Browsers' with: 'Glamour-Browsers-TorstenBergmann.109';
			package: 'Glamour-Examples' with: 'Glamour-Examples-AndreiChis.301';
			package: 'Glamour-Morphic-Brick' with: 'Glamour-Morphic-Brick-AndreiChis.407';
			package: 'Glamour-Morphic-Brick-Tests' with: 'Glamour-Morphic-Brick-Tests-AliakseiSyrel.13';
			package: 'Glamour-Tests-Core' with: 'Glamour-Tests-Core-AndreiChis.109';
			package: 'Glamour-Tests-Resources' with: 'Glamour-Tests-Resources-AndreiChis.5';
			package: 'Glamour-Morphic-Theme' with: 'Glamour-Morphic-Theme-AndreiChis.221';
			package: 'Glamour-Morphic-Widgets' with: 'Glamour-Morphic-Widgets-AliakseiSyrel.184';
			package: 'Glamour-Morphic-Renderer' with: 'Glamour-Morphic-Renderer-AliakseiSyrel.329';
			package: 'Glamour-Morphic-Pager' with: 'Glamour-Morphic-Pager-CyrilFerlicot.104';
			package: 'Glamour-Tests-Morphic' with: 'Glamour-Tests-Morphic-AndreiChis.129';
			package: 'Glamour-Rubric-Presentations' with: 'Glamour-Rubric-Presentations-AndreiChis.47';
			package: 'Glamour-Tests-Rubric' with: 'Glamour-Tests-Rubric-AndreiChis.16'. ].

]

{ #category : #versions }
ConfigurationOfGlamourCore >> version341: spec [
	<version: '3.4.1' imports: #('3.2-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'Changes in the use of #garbageCollect'.
		spec author: 'AndreiChis'.
		spec timestamp: '11/25/2015 18:00'.
		spec project: 'Rubric' with: '2.4'.
		spec 
			package: 'Glamour-Announcements' with: 'Glamour-Announcements-AndreiChis.8';
			package: 'Glamour-Helpers' with: 'Glamour-Helpers-AndreiChis.39';
			package: 'Glamour-Core' with: 'Glamour-Core-AndreiChis.306';
			package: 'Glamour-Presentations' with: 'Glamour-Presentations-AndreiChis.179';
			package: 'Glamour-Browsers' with: 'Glamour-Browsers-TorstenBergmann.109';
			package: 'Glamour-Examples' with: 'Glamour-Examples-AndreiChis.301';
			package: 'Glamour-Morphic-Brick' with: 'Glamour-Morphic-Brick-AndreiChis.408';
			package: 'Glamour-Morphic-Brick-Tests' with: 'Glamour-Morphic-Brick-Tests-AliakseiSyrel.13';
			package: 'Glamour-Tests-Core' with: 'Glamour-Tests-Core-AndreiChis.109';
			package: 'Glamour-Tests-Resources' with: 'Glamour-Tests-Resources-AndreiChis.5';
			package: 'Glamour-Morphic-Theme' with: 'Glamour-Morphic-Theme-AndreiChis.221';
			package: 'Glamour-Morphic-Widgets' with: 'Glamour-Morphic-Widgets-AliakseiSyrel.184';
			package: 'Glamour-Morphic-Renderer' with: 'Glamour-Morphic-Renderer-AliakseiSyrel.329';
			package: 'Glamour-Morphic-Pager' with: 'Glamour-Morphic-Pager-CyrilFerlicot.104';
			package: 'Glamour-Tests-Morphic' with: 'Glamour-Tests-Morphic-AndreiChis.129';
			package: 'Glamour-Rubric-Presentations' with: 'Glamour-Rubric-Presentations-AndreiChis.47';
			package: 'Glamour-Tests-Rubric' with: 'Glamour-Tests-Rubric-AndreiChis.16'. ].

]

{ #category : #versions }
ConfigurationOfGlamourCore >> version342: spec [
	<version: '3.4.2' imports: #('3.2-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'Update GTools: small fixes and improvements (issue 17184)'.
		spec author: 'AndreiChis'.
		spec timestamp: '12/4/2015 11:12'.
		spec project: 'Rubric' with: '2.4.1'.
		spec 
			package: 'Glamour-Announcements' with: 'Glamour-Announcements-AndreiChis.8';
			package: 'Glamour-Helpers' with: 'Glamour-Helpers-AndreiChis.39';
			package: 'Glamour-Core' with: 'Glamour-Core-AndreiChis.306';
			package: 'Glamour-Presentations' with: 'Glamour-Presentations-AndreiChis.179';
			package: 'Glamour-Browsers' with: 'Glamour-Browsers-TorstenBergmann.109';
			package: 'Glamour-Examples' with: 'Glamour-Examples-AndreiChis.301';
			package: 'Glamour-Morphic-Brick' with: 'Glamour-Morphic-Brick-AndreiChis.409';
			package: 'Glamour-Morphic-Brick-Tests' with: 'Glamour-Morphic-Brick-Tests-TheIntegrator.14';
			package: 'Glamour-Tests-Core' with: 'Glamour-Tests-Core-AndreiChis.109';
			package: 'Glamour-Tests-Resources' with: 'Glamour-Tests-Resources-AndreiChis.5';
			package: 'Glamour-Morphic-Theme' with: 'Glamour-Morphic-Theme-AndreiChis.221';
			package: 'Glamour-Morphic-Widgets' with: 'Glamour-Morphic-Widgets-AliakseiSyrel.184';
			package: 'Glamour-Morphic-Renderer' with: 'Glamour-Morphic-Renderer-AliakseiSyrel.329';
			package: 'Glamour-Morphic-Pager' with: 'Glamour-Morphic-Pager-CyrilFerlicot.104';
			package: 'Glamour-Tests-Morphic' with: 'Glamour-Tests-Morphic-AndreiChis.129';
			package: 'Glamour-Rubric-Presentations' with: 'Glamour-Rubric-Presentations-AndreiChis.47';
			package: 'Glamour-Tests-Rubric' with: 'Glamour-Tests-Rubric-AndreiChis.16'. ].

]

{ #category : #versions }
ConfigurationOfGlamourCore >> version34: spec [
	<version: '3.4' imports: #('3.2-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'Update GTools. 
 - bug fixes
 - improvements in the event recorder'.
		spec author: 'AndreiChis'.
		spec timestamp: '11/19/2015 20:57'.
		spec project: 'Rubric' with: '2.3'.
		spec 
			package: 'Glamour-Announcements' with: 'Glamour-Announcements-AndreiChis.8';
			package: 'Glamour-Helpers' with: 'Glamour-Helpers-AndreiChis.39';
			package: 'Glamour-Core' with: 'Glamour-Core-AndreiChis.306';
			package: 'Glamour-Presentations' with: 'Glamour-Presentations-AndreiChis.179';
			package: 'Glamour-Browsers' with: 'Glamour-Browsers-TorstenBergmann.109';
			package: 'Glamour-Examples' with: 'Glamour-Examples-AndreiChis.301';
			package: 'Glamour-Morphic-Brick' with: 'Glamour-Morphic-Brick-AndreiChis.407';
			package: 'Glamour-Morphic-Brick-Tests' with: 'Glamour-Morphic-Brick-Tests-AliakseiSyrel.13';
			package: 'Glamour-Tests-Core' with: 'Glamour-Tests-Core-AndreiChis.109';
			package: 'Glamour-Tests-Resources' with: 'Glamour-Tests-Resources-AndreiChis.5';
			package: 'Glamour-Morphic-Theme' with: 'Glamour-Morphic-Theme-AndreiChis.221';
			package: 'Glamour-Morphic-Widgets' with: 'Glamour-Morphic-Widgets-AliakseiSyrel.184';
			package: 'Glamour-Morphic-Renderer' with: 'Glamour-Morphic-Renderer-AliakseiSyrel.329';
			package: 'Glamour-Morphic-Pager' with: 'Glamour-Morphic-Pager-CyrilFerlicot.104';
			package: 'Glamour-Tests-Morphic' with: 'Glamour-Tests-Morphic-AndreiChis.129';
			package: 'Glamour-Rubric-Presentations' with: 'Glamour-Rubric-Presentations-AndreiChis.47';
			package: 'Glamour-Tests-Rubric' with: 'Glamour-Tests-Rubric-AndreiChis.16'. ].

]

{ #category : #versions }
ConfigurationOfGlamourCore >> version35: spec [
	<version: '3.5' imports: #('3.2-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'Load GTDebugger together with the extensions for SUnit and Bytecode.
Bugfixes (17190, 17206, 17336, 17337, 17225)'.
		spec author: 'AndreiChis'.
		spec timestamp: '1/7/2016 10:41'.
		spec project: 'Rubric' with: '2.4.2'.
		spec 
			package: 'Glamour-Announcements' with: 'Glamour-Announcements-AndreiChis.8';
			package: 'Glamour-Helpers' with: 'Glamour-Helpers-TudorGirba.40';
			package: 'Glamour-Core' with: 'Glamour-Core-TudorGirba.307';
			package: 'Glamour-Presentations' with: 'Glamour-Presentations-AndreiChis.179';
			package: 'Glamour-Browsers' with: 'Glamour-Browsers-AndreiChis.111';
			package: 'Glamour-Examples' with: 'Glamour-Examples-CyrilFerlicot.302';
			package: 'Glamour-Morphic-Brick' with: 'Glamour-Morphic-Brick-AndreiChis.409';
			package: 'Glamour-Morphic-Brick-Tests' with: 'Glamour-Morphic-Brick-Tests-TheIntegrator.14';
			package: 'Glamour-Tests-Core' with: 'Glamour-Tests-Core-CyrilFerlicot.110';
			package: 'Glamour-Tests-Resources' with: 'Glamour-Tests-Resources-AndreiChis.5';
			package: 'Glamour-Morphic-Theme' with: 'Glamour-Morphic-Theme-AndreiChis.221';
			package: 'Glamour-Morphic-Widgets' with: 'Glamour-Morphic-Widgets-AliakseiSyrel.184';
			package: 'Glamour-Morphic-Renderer' with: 'Glamour-Morphic-Renderer-AndreiChis.331';
			package: 'Glamour-Morphic-Pager' with: 'Glamour-Morphic-Pager-CyrilFerlicot.104';
			package: 'Glamour-Tests-Morphic' with: 'Glamour-Tests-Morphic-SkipLentz.133';
			package: 'Glamour-Rubric-Presentations' with: 'Glamour-Rubric-Presentations-AndreiChis.47';
			package: 'Glamour-Tests-Rubric' with: 'Glamour-Tests-Rubric-AndreiChis.16'. ].

]

{ #category : #versions }
ConfigurationOfGlamourCore >> version36: spec [
	<version: '3.6' imports: #('3.2-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'This version fixes problems in GTDebugger and updates  Rubric (issues: 17155, 17279, 17152)'.
		spec author: 'AndreiChis'.
		spec timestamp: '1/8/2016 19:27'.
		spec project: 'Rubric' with: '2.5'.
		spec 
			package: 'Glamour-Announcements' with: 'Glamour-Announcements-AndreiChis.8';
			package: 'Glamour-Helpers' with: 'Glamour-Helpers-TudorGirba.40';
			package: 'Glamour-Core' with: 'Glamour-Core-TudorGirba.307';
			package: 'Glamour-Presentations' with: 'Glamour-Presentations-AndreiChis.179';
			package: 'Glamour-Browsers' with: 'Glamour-Browsers-AndreiChis.111';
			package: 'Glamour-Examples' with: 'Glamour-Examples-CyrilFerlicot.302';
			package: 'Glamour-Morphic-Brick' with: 'Glamour-Morphic-Brick-AndreiChis.409';
			package: 'Glamour-Morphic-Brick-Tests' with: 'Glamour-Morphic-Brick-Tests-TheIntegrator.14';
			package: 'Glamour-Tests-Core' with: 'Glamour-Tests-Core-CyrilFerlicot.110';
			package: 'Glamour-Tests-Resources' with: 'Glamour-Tests-Resources-AndreiChis.5';
			package: 'Glamour-Morphic-Theme' with: 'Glamour-Morphic-Theme-AndreiChis.221';
			package: 'Glamour-Morphic-Widgets' with: 'Glamour-Morphic-Widgets-AndreiChis.185';
			package: 'Glamour-Morphic-Renderer' with: 'Glamour-Morphic-Renderer-AndreiChis.333';
			package: 'Glamour-Morphic-Pager' with: 'Glamour-Morphic-Pager-CyrilFerlicot.104';
			package: 'Glamour-Tests-Morphic' with: 'Glamour-Tests-Morphic-SkipLentz.133';
			package: 'Glamour-Rubric-Presentations' with: 'Glamour-Rubric-Presentations-AndreiChis.47';
			package: 'Glamour-Tests-Rubric' with: 'Glamour-Tests-Rubric-AndreiChis.16'. ].

]

{ #category : #versions }
ConfigurationOfGlamourCore >> version37: spec [
	<version: '3.7' imports: #('3.3-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'Fixes in the debugger, inspector and spotter.'.
		spec author: 'AndreiChis'.
		spec timestamp: '1/10/2016 23:53'.
		spec 
			project: 'Rubric' with: '2.5';
			project: 'FastTable' with: '0.8.1'.
		spec 
			package: 'Glamour-Announcements' with: 'Glamour-Announcements-AndreiChis.8';
			package: 'Glamour-Helpers' with: 'Glamour-Helpers-TudorGirba.40';
			package: 'Glamour-FastTable' with: 'Glamour-FastTable-AndreiChis.50';
			package: 'Glamour-Core' with: 'Glamour-Core-AndreiChis.309';
			package: 'Glamour-Presentations' with: 'Glamour-Presentations-AndreiChis.181';
			package: 'Glamour-Browsers' with: 'Glamour-Browsers-AndreiChis.111';
			package: 'Glamour-Examples' with: 'Glamour-Examples-TudorGirba.303';
			package: 'Glamour-Morphic-Brick' with: 'Glamour-Morphic-Brick-AndreiChis.409';
			package: 'Glamour-Morphic-Brick-Tests' with: 'Glamour-Morphic-Brick-Tests-TheIntegrator.14';
			package: 'Glamour-Tests-Core' with: 'Glamour-Tests-Core-CyrilFerlicot.110';
			package: 'Glamour-Tests-Resources' with: 'Glamour-Tests-Resources-AndreiChis.5';
			package: 'Glamour-Morphic-Theme' with: 'Glamour-Morphic-Theme-AndreiChis.221';
			package: 'Glamour-Morphic-Widgets' with: 'Glamour-Morphic-Widgets-AndreiChis.187';
			package: 'Glamour-Morphic-Renderer' with: 'Glamour-Morphic-Renderer-AndreiChis.338';
			package: 'Glamour-Morphic-Pager' with: 'Glamour-Morphic-Pager-AndreiChis.105';
			package: 'Glamour-Tests-Morphic' with: 'Glamour-Tests-Morphic-SkipLentz.133';
			package: 'Glamour-Rubric-Presentations' with: 'Glamour-Rubric-Presentations-AndreiChis.47';
			package: 'Glamour-Tests-Rubric' with: 'Glamour-Tests-Rubric-AndreiChis.16'. ].

]

{ #category : #versions }
ConfigurationOfGlamourCore >> version38: spec [
	<version: '3.8' imports: #('3.3-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'Bugfixes in Spotter and Glamour'.
		spec author: 'AndreiChis'.
		spec timestamp: '1/15/2016 16:23'.
		spec 
			project: 'Rubric' with: '2.5';
			project: 'FastTable' with: '0.8.3'.
		spec 
			package: 'Glamour-Announcements' with: 'Glamour-Announcements-AndreiChis.8';
			package: 'Glamour-Helpers' with: 'Glamour-Helpers-TudorGirba.40';
			package: 'Glamour-FastTable' with: 'Glamour-FastTable-AndreiChis.50';
			package: 'Glamour-Core' with: 'Glamour-Core-AndreiChis.309';
			package: 'Glamour-Presentations' with: 'Glamour-Presentations-AndreiChis.181';
			package: 'Glamour-Browsers' with: 'Glamour-Browsers-AndreiChis.111';
			package: 'Glamour-Examples' with: 'Glamour-Examples-TudorGirba.303';
			package: 'Glamour-Morphic-Brick' with: 'Glamour-Morphic-Brick-AndreiChis.409';
			package: 'Glamour-Morphic-Brick-Tests' with: 'Glamour-Morphic-Brick-Tests-TheIntegrator.14';
			package: 'Glamour-Tests-Core' with: 'Glamour-Tests-Core-CyrilFerlicot.110';
			package: 'Glamour-Tests-Resources' with: 'Glamour-Tests-Resources-AndreiChis.5';
			package: 'Glamour-Morphic-Theme' with: 'Glamour-Morphic-Theme-AndreiChis.221';
			package: 'Glamour-Morphic-Widgets' with: 'Glamour-Morphic-Widgets-AndreiChis.188';
			package: 'Glamour-Morphic-Renderer' with: 'Glamour-Morphic-Renderer-AndreiChis.338';
			package: 'Glamour-Morphic-Pager' with: 'Glamour-Morphic-Pager-AndreiChis.105';
			package: 'Glamour-Tests-Morphic' with: 'Glamour-Tests-Morphic-SkipLentz.133';
			package: 'Glamour-Rubric-Presentations' with: 'Glamour-Rubric-Presentations-AndreiChis.48';
			package: 'Glamour-Tests-Rubric' with: 'Glamour-Tests-Rubric-AndreiChis.16'. ].

]

{ #category : #versions }
ConfigurationOfGlamourCore >> version39: spec [
	<version: '3.9' imports: #('3.3-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'Bugfixes in inspector and debugger'.
		spec author: 'AndreiChis'.
		spec timestamp: '1/15/2016 18:14'.
		spec 
			project: 'Rubric' with: '2.5';
			project: 'FastTable' with: '0.8.3'.
		spec 
			package: 'Glamour-Announcements' with: 'Glamour-Announcements-AndreiChis.8';
			package: 'Glamour-Helpers' with: 'Glamour-Helpers-TudorGirba.40';
			package: 'Glamour-FastTable' with: 'Glamour-FastTable-AndreiChis.50';
			package: 'Glamour-Core' with: 'Glamour-Core-AndreiChis.309';
			package: 'Glamour-Presentations' with: 'Glamour-Presentations-AndreiChis.181';
			package: 'Glamour-Browsers' with: 'Glamour-Browsers-AndreiChis.111';
			package: 'Glamour-Examples' with: 'Glamour-Examples-TudorGirba.303';
			package: 'Glamour-Morphic-Brick' with: 'Glamour-Morphic-Brick-AndreiChis.409';
			package: 'Glamour-Morphic-Brick-Tests' with: 'Glamour-Morphic-Brick-Tests-TheIntegrator.14';
			package: 'Glamour-Tests-Core' with: 'Glamour-Tests-Core-CyrilFerlicot.110';
			package: 'Glamour-Tests-Resources' with: 'Glamour-Tests-Resources-AndreiChis.5';
			package: 'Glamour-Morphic-Theme' with: 'Glamour-Morphic-Theme-AndreiChis.221';
			package: 'Glamour-Morphic-Widgets' with: 'Glamour-Morphic-Widgets-AndreiChis.188';
			package: 'Glamour-Morphic-Renderer' with: 'Glamour-Morphic-Renderer-AndreiChis.338';
			package: 'Glamour-Morphic-Pager' with: 'Glamour-Morphic-Pager-AndreiChis.105';
			package: 'Glamour-Tests-Morphic' with: 'Glamour-Tests-Morphic-SkipLentz.133';
			package: 'Glamour-Rubric-Presentations' with: 'Glamour-Rubric-Presentations-AndreiChis.48';
			package: 'Glamour-Tests-Rubric' with: 'Glamour-Tests-Rubric-AndreiChis.16'. ].

]
