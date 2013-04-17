"
self loadDevelopment
"
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
        "Bootstrap Gofer (if necessary), load latest mcz file for ConfigurationOfMetacello (using old 
         Gofer API), then load the latest version of Metacello itself."

        Smalltalk at: #MetacelloProject ifAbsent: [ | error |
                "list of repositories to try, in case primary repository is not accessible"
                (Array 
                        with: 'http://www.squeaksource.com/MetacelloRepository' 
                        with: 'http://seaside.gemstone.com/ss/metacello') do: [:repositoryUrl |
                                ([
                                        Smalltalk at: #Gofer ifAbsent: [
                                        "Current version of Gofer from which to bootstrap - as of 1.0-beta.21"
                                                self bootstrapPackage: 'Gofer-Core-lr.115' from: repositoryUrl ].
                                        Smalltalk at: #Gofer ifPresent: [:goferClass | | gofer |
                                                gofer := goferClass new
                                                        url: repositoryUrl;
                                                        yourself.
                                                [ gofer addPackage: 'ConfigurationOfMetacello' ] on: Warning do: [:ex | ex resume ].
                                                gofer load ]]
                                                        on: Error
                                                        do: [ :ex |
                                                                error := ex.
                                                                Transcript 
                                                                        cr; 
                                                                        show: 'failed ensureMetacello: ';
                                                                        show: ex description printString;
                                                                        show: '...retrying'.
                                                                "try again"
                                                                ex return: nil ]) ~~ nil
                                        ifTrue: [
                                                "load 'default' group of Metacello"
                                                (Smalltalk at: #ConfigurationOfMetacello) perform: #load.
                                                ^self ]].
                "shouldn't get here unless the load failed ... throw an error"
                self error: 'retry with alternate repository failed: ', error description printString ]
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

{ #category : #loading }
ConfigurationOfGlamourSeaside class >> loadDevelopment [
	(self project version: #development) load
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
ConfigurationOfGlamourSeaside >> baseline04: spec [ 
	<version: '0.4-baseline'>
	
	spec for: #common do: [
		spec blessing: #baseline.
		spec repository: 'http://www.smalltalkhub.com/mc/Moose/Glamour/main'.

		spec
			project: 'Glamour' with: [
				spec
					className: 'ConfigurationOfGlamour';
					versionString: #'bleedingEdge';
					version: #development;
					repository: 'http://www.smalltalkhub.com/mc/Moose/Glamour/main' ];
			project: 'Seaside' with: [
				spec
					className: 'ConfigurationOfSeaside30';
					versionString: #'stable';
					loads: 'OneClick';
					repository: 'http://www.squeaksource.com/MetacelloRepository' ];
			project: 'SeasideTesting' with: [
				spec
					className: 'ConfigurationOfSeasideTesting';
					version: #'development';
					loads: #('SimulatedBrowserTesting');
					repository: 'http://www.squeaksource.com/SeasideTesting' ];
			project: 'BeachParasol' with: [
				spec
					className: 'ConfigurationOfParasol';
					version: #'development';
					loads: #('dev');
					repository: 'http://ss3.gemstone.com/ss/Parasol' ].
				
		spec
			package: 'Glamour-Seaside-Core' with: [
				spec requires: #('Seaside' 'Glamour' 'JQWidgetBox-Core' 'JQWidgetBox-MbMenu-Core' 'JQWidgetBox-HoverIntent-Core' 'Glamour-Morphic-Theme') ];
			package: 'Glamour-Seaside-Rendering' with: [
				spec requires: #('Glamour-Seaside-Core') ];
			package: 'Glamour-Seaside-Examples' with: [
				spec requires: #('Seaside' 'Glamour-Seaside-Rendering') ];
			package: 'Glamour-Seaside-Tests' with: [
				spec requires: #('Glamour-Seaside-Rendering' 'SeasideTesting' 'BeachParasol') ];
			package: 'JQWidgetBox-Core' with: [
				spec requires: #('Seaside').
				spec repository: 'http://www.squeaksource.com/JQueryWidgetBox'];
			package: 'JQWidgetBox-MbMenu-Core' with: [
				spec repository: 'http://www.squeaksource.com/JQueryWidgetBox'.
				spec requires: #('Seaside') ];
			package: 'JQWidgetBox-HoverIntent-Core' with: [
				spec requires: #('Seaside').
				spec repository: 'http://www.squeaksource.com/JQueryWidgetBox'];
			package: 'Glamour-Morphic-Theme'.

		spec
			group: 'Core' with: #(						
						'Glamour-Seaside-Core'
						'Glamour-Seaside-Rendering');
			group: 'Examples' with: #(						
						'Glamour-Seaside-Examples');
			group: 'Tests' with: #(						
						'Glamour-Seaside-Tests') ]
]

{ #category : #'symbolic versions' }
ConfigurationOfGlamourSeaside >> development: spec [
	<symbolicVersion: #'development'>

	spec for: #'common' version: '0.4-baseline'.

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

{ #category : #versions }
ConfigurationOfGlamourSeaside >> version04: spec [ 
	<version: '0.4' imports: #('0.4-baseline') >
	
	spec for: #common do: [
		spec blessing: #development.
		spec
			project: 'Seaside' with: '3.0.8';
			project: 'SeasideTesting' with: '0.7';
			project: 'BeachParasol' with: '0.9';
			project: 'Glamour' with: #'stable';
			package: 'Glamour-Seaside' with: 'Glamour-Seaside-AndreiChis.111';
			package: 'JQWidgetBox-Core' with: 'JQWidgetBox-Core-tbn.2';
			package: 'JQWidgetBox-MbMenu-Core' with: 'JQWidgetBox-MbMenu-Core-AndreiChis.18';
			package: 'JQWidgetBox-HoverIntent-Core' with: 'JQWidgetBox-HoverIntent-Core-JohanBrichau.2';
			package: 'Glamour-Morphic-Theme' with: 'Glamour-Morphic-Theme-FernandoOlivero.23']. 
]
