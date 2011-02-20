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
	| previousDeprecationWarning |
	previousDeprecationWarning := Deprecation raiseWarning.
	Deprecation raiseWarning: false.
	(self project version: 'default') load.
	Deprecation raiseWarning: previousDeprecationWarning
]

{ #category : #accessing }
ConfigurationOfGlamourSeaside class >> project [

	^self new project
]

{ #category : #baselines }
ConfigurationOfGlamourSeaside >> baseline01: spec [ 
	<version: '0.1-baseline'>

	spec for: #common do: [
		spec blessing: #baseline.
		spec repository: 'http://www.squeaksource.com/Glamour'.
		spec package: 'Glamour-Seaside' with: [
			spec requires: #('Seaside' 'Glamour' 'SeasideTesting') ]..
		spec package: 'JQWidgetBox-Core' with: [
			spec requires: #('Seaside').
			spec repository: 'http://www.squeaksource.com/JQueryWidgetBox'].
		spec package: 'JQWidgetBox-MbMenu-Core' with: [
			spec repository: 'http://www.squeaksource.com/JQueryWidgetBox'.
			spec requires: #('Seaside') ].
		spec package: 'JQWidgetBox-HoverIntent-Core' with: [
			spec requires: #('Seaside').
			spec repository: 'http://www.squeaksource.com/JQueryWidgetBox'].
		spec package: 'JQuery-UI' with: [
			spec requires: #('Seaside').
			spec repository: 'http://www.squeaksource.com/Seaside30'].
		spec package: 'Seaside-Core' with: [
			spec requires: #('Seaside').
			spec repository: 'http://www.squeaksource.com/Seaside30'].
		spec group: 'Core' with: #(
						'Seaside'
						'Glamour-Seaside'
						'JQWidgetBox-Core'
						'JQWidgetBox-MbMenu-Core'
						'JQWidgetBox-HoverIntent-Core'
						'JQuery-UI'
						'Seaside-Core').
		spec group: 'Tests' with: #(
						'SeasideTesting'
						'Glamour-Seaside'). 
		spec
			project: 'Glamour' with: [
				spec
					className: 'ConfigurationOfGlamour';
					file: 'ConfigurationOfGlamour';
					version: '2.0-beta.8';
					repository: 'http://www.squeaksource.com/Glamour' ].
		spec
			project: 'Seaside' with: [
				spec
					className: 'ConfigurationOfSeaside30';
					file: 'ConfigurationOfSeaside30';
					version: '3.0.0-rc.2';
					repository: 'http://www.squeaksource.com/MetacelloRepository' ].
		spec
			project: 'SeasideTesting' with: [
				spec
					className: 'ConfigurationOfSeasideTesting';
					file: 'ConfigurationOfSeasideTesting';
					version: '0.4';
					repository: 'http://www.squeaksource.com/SeasideTesting' ].
		spec ]
]

{ #category : #baselines }
ConfigurationOfGlamourSeaside >> baseline02: spec [ 
	<version: '0.2-baseline'>

	spec for: #common do: [
		spec blessing: #baseline.
		spec repository: 'http://www.squeaksource.com/Glamour'.
		spec package: 'Glamour-Seaside' with: [
			spec requires: #('Seaside' 'Glamour' 'SeasideTesting') ].
		spec package: 'JQWidgetBox-Core' with: [
			spec requires: #('Seaside').
			spec repository: 'http://www.squeaksource.com/JQueryWidgetBox'].
		spec package: 'JQWidgetBox-MbMenu-Core' with: [
			spec repository: 'http://www.squeaksource.com/JQueryWidgetBox'.
			spec requires: #('Seaside') ].
		spec package: 'JQWidgetBox-HoverIntent-Core' with: [
			spec requires: #('Seaside').
			spec repository: 'http://www.squeaksource.com/JQueryWidgetBox'].
		spec package: 'Glamour-Morphic-Theme' with: [
			spec requires: #('Glamour').
			spec repository: 'http://www.squeaksource.com/Glamour'].
		spec group: 'Core' with: #(
						'Seaside'
						'Glamour-Seaside'
						'JQWidgetBox-Core'
						'JQWidgetBox-MbMenu-Core'
						'JQWidgetBox-HoverIntent-Core'
						'Glamour-Morphic-Theme').
		spec group: 'Tests' with: #(						
						'SeasideTesting'
						'Glamour-Seaside'
						'JQWidgetBox-Core'
						'JQWidgetBox-MbMenu-Core'
						'JQWidgetBox-HoverIntent-Core'
						'Glamour-Morphic-Theme'). 
		spec
			project: 'Glamour' with: [
				spec
					className: 'ConfigurationOfGlamour';
					file: 'ConfigurationOfGlamour';
					version: '2.0-beta.8';
					repository: 'http://www.squeaksource.com/Glamour' ].
		spec
			project: 'Seaside' with: [
				spec
					className: 'ConfigurationOfSeaside30';
					file: 'ConfigurationOfSeaside30';
					version: '3.0.0-rc.2';
					repository: 'http://www.squeaksource.com/MetacelloRepository' ].
		spec
			project: 'SeasideTesting' with: [
				spec
					className: 'ConfigurationOfSeasideTesting';
					file: 'ConfigurationOfSeasideTesting';
					version: '0.6';
					repository: 'http://www.squeaksource.com/SeasideTesting' ].
		spec ]
]

{ #category : #baselines }
ConfigurationOfGlamourSeaside >> baseline03: spec [ 
	<version: '0.3-baseline'>
	
	spec for: #common do: [
		spec blessing: #baseline.
		spec repository: 'http://www.squeaksource.com/Glamour'.
		spec package: 'Glamour-Seaside-Core' with: [
			spec requires: #('Seaside' 'Glamour' 'JQWidgetBox-Core' 'JQWidgetBox-MbMenu-Core' 'JQWidgetBox-HoverIntent-Core' 'Glamour-Morphic-Theme') ].
		spec package: 'Glamour-Seaside-Rendering' with: [
			spec requires: #('Glamour-Seaside-Core') ].
		spec package: 'Glamour-Seaside-Examples' with: [
			spec requires: #('Seaside' 'Glamour-Seaside-Rendering') ].
		spec package: 'Glamour-Seaside-Tests' with: [
			spec requires: #('Glamour-Seaside-Rendering' 'SeasideTesting') ].
		spec package: 'JQWidgetBox-Core' with: [
			spec requires: #('Seaside').
			spec repository: 'http://www.squeaksource.com/JQueryWidgetBox'].
		spec package: 'JQWidgetBox-MbMenu-Core' with: [
			spec repository: 'http://www.squeaksource.com/JQueryWidgetBox'.
			spec requires: #('Seaside') ].
		spec package: 'JQWidgetBox-HoverIntent-Core' with: [
			spec requires: #('Seaside').
			spec repository: 'http://www.squeaksource.com/JQueryWidgetBox'].
		spec package: 'Glamour-Morphic-Theme'.
		spec group: 'Core' with: #(						
						'Glamour-Seaside-Core'
						'Glamour-Seaside-Rendering').
		spec group: 'Examples' with: #(						
						'Glamour-Seaside-Examples').
		spec group: 'Tests' with: #(						
						'Glamour-Seaside-Tests'). 
		spec
			project: 'Glamour' with: [
				spec
					className: 'ConfigurationOfGlamour';
					file: 'ConfigurationOfGlamour';
					version: '2.0-beta.8';
					repository: 'http://www.squeaksource.com/Glamour' ].
		spec
			project: 'Seaside' with: [
				spec
					className: 'ConfigurationOfSeaside30';
					file: 'ConfigurationOfSeaside30';
					version: '3.0.3';
					repository: 'http://www.squeaksource.com/MetacelloRepository' ].
		spec
			project: 'SeasideTesting' with: [
				spec
					className: 'ConfigurationOfSeasideTesting';
					file: 'ConfigurationOfSeasideTesting';
					version: '0.6';
					repository: 'http://www.squeaksource.com/SeasideTesting' ].
		spec ]
]

{ #category : #baselines }
ConfigurationOfGlamourSeaside >> default: spec [ 
	<version: 'default'>

	spec for: #common do: [
		spec blessing: #baseline.
		spec repository: 'http://www.squeaksource.com/Glamour'.
		spec package: 'Glamour-Seaside-Core' with: [
			spec requires: #('Seaside' 'Glamour' 'JQWidgetBox-Core' 'JQWidgetBox-MbMenu-Core' 'JQWidgetBox-HoverIntent-Core' 'Glamour-Morphic-Theme') ].
		spec package: 'Glamour-Seaside-Rendering' with: [
			spec requires: #('Glamour-Seaside-Core') ].
		spec package: 'Glamour-Seaside-Examples' with: [
			spec requires: #('Seaside' 'Glamour-Seaside-Rendering') ].
		spec package: 'Glamour-Seaside-Tests' with: [
			spec requires: #('Glamour-Seaside-Rendering' 'SeasideTesting') ].
		spec package: 'JQWidgetBox-Core' with: [
			spec requires: #('Seaside').
			spec repository: 'http://www.squeaksource.com/JQueryWidgetBox'].
		spec package: 'JQWidgetBox-MbMenu-Core' with: [
			spec repository: 'http://www.squeaksource.com/JQueryWidgetBox'.
			spec requires: #('Seaside') ].
		spec package: 'JQWidgetBox-HoverIntent-Core' with: [
			spec requires: #('Seaside').
			spec repository: 'http://www.squeaksource.com/JQueryWidgetBox'].
		spec package: 'Glamour-Morphic-Theme'.
		spec group: 'Core' with: #(
						'Glamour-Seaside-Core'
						'Glamour-Seaside-Rendering').
		spec group: 'Examples' with: #(						
						'Glamour-Seaside-Examples').
		spec group: 'Tests' with: #(						
						'Glamour-Seaside-Tests'). 
		spec
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
					version: '3.0.3';
					repository: 'http://www.squeaksource.com/MetacelloRepository' ].
		spec
			project: 'SeasideTesting' with: [
				spec
					className: 'ConfigurationOfSeasideTesting';
					file: 'ConfigurationOfSeasideTesting';
					version: '1.0.3-baseline';
					loads: #('SimulatedBrowserTesting');
					repository: 'http://www.squeaksource.com/SeasideTesting' ].
		spec ]
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

{ #category : #versions }
ConfigurationOfGlamourSeaside >> version01: spec [ 
	<version: '0.1' imports: #('0.1-baseline') >
	
	spec for: #common do: [
		spec blessing: #release.
		spec 
			package: 'Glamour-Seaside' with: 'Glamour-Seaside-AndreiChis.98';
			package: 'JQWidgetBox-Core' with: 'JQWidgetBox-Core-tbn.2';
			package: 'JQWidgetBox-MbMenu-Core' with: 'JQWidgetBox-MbMenu-Core-AndreiChis.18';
			package: 'JQWidgetBox-HoverIntent-Core' with: 'JQWidgetBox-HoverIntent-Core-JohanBrichau.2';
			package: 'JQuery-UI' with: 'JQuery-UI-lr.62';
			package: 'Seaside-Core' with: 'Seaside-Core-pmm.659']. 
]

{ #category : #versions }
ConfigurationOfGlamourSeaside >> version02: spec [ 
	<version: '0.2' imports: #('0.2-baseline') >
	
	spec for: #common do: [
		spec blessing: #development.
		spec 
			package: 'Glamour-Seaside' with: 'Glamour-Seaside-AndreiChis.111';
			package: 'JQWidgetBox-Core' with: 'JQWidgetBox-Core-tbn.2';
			package: 'JQWidgetBox-MbMenu-Core' with: 'JQWidgetBox-MbMenu-Core-AndreiChis.18';
			package: 'JQWidgetBox-HoverIntent-Core' with: 'JQWidgetBox-HoverIntent-Core-JohanBrichau.2';
			package: 'Glamour-Morphic-Theme' with: 'Glamour-Morphic-Theme-FernandoOlivero.23']. 
]
