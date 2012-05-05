"
ConfigurationOfGlamour loadDevelopment
"
Class {
	#name : #ConfigurationOfGlamour,
	#superclass : #Object,
	#instVars : [
		'project'
	],
	#category : #ConfigurationOfGlamour
}

{ #category : #private }
ConfigurationOfGlamour class >> ensureMetacello [
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
ConfigurationOfGlamour class >> isMetacelloConfig [
	"Answer true and the Metacello tools will operate on you"
	
	^true
]

{ #category : #loading }
ConfigurationOfGlamour class >> loadDefault [
	"this will be deprecated soon"
	self loadDevelopment
]

{ #category : #loading }
ConfigurationOfGlamour class >> loadDevelopment [
	(self project version: #development) load
]

{ #category : #accessing }
ConfigurationOfGlamour class >> project [

	^self new project
]

{ #category : #baselines }
ConfigurationOfGlamour >> baseline20beta1: spec [ 
	<version: '2.0-beta.1-baseline'>
	
	spec for: #common do: [
		spec blessing: #baseline.
		spec repository: 'http://www.squeaksource.com/Glamour'.
		spec 
			package: 'Morphic-MorphTreeWidget' with: [
				spec file: 'Morphic-MorphTreeWidget-AlainPlantec.17'.
				spec repository: 'http://www.squeaksource.com/Momo' ];
			package: 'Glamour-Helpers' ;
			package: 'Glamour-Squeak' ;
			package: 'Glamour-Core' ;
			package: 'Glamour-Presentations' ;
			package: 'Glamour-Browsers' ;
			package: 'Glamour-Scripting' ;
			package: 'Glamour-Tests' ;
			package: 'Glamour-Morphic' with: [spec requires: #('Morphic-MorphTreeWidget')];
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

{ #category : #baselines }
ConfigurationOfGlamour >> baseline20beta2: spec [ 
	<version: '2.0-beta.2-baseline'>
	
	spec for: #common do: [
		spec blessing: #baseline.
		spec repository: 'http://www.squeaksource.com/Glamour'.
		spec 
			package: 'Morphic-MorphTreeWidget' with: [
				spec repository: 'http://www.squeaksource.com/Momo' ];
			package: 'Glamour-Helpers' ;
			package: 'Glamour-Squeak' ;
			package: 'Glamour-Core' ;
			package: 'Glamour-Presentations' ;
			package: 'Glamour-Browsers' ;
			package: 'Glamour-Scripting' ;
			package: 'Glamour-Tests' ;
			package: 'Glamour-Morphic' with: [spec requires: #('Morphic-MorphTreeWidget')];
			package: 'Glamour-Test-Morphic' with: [spec requires: #('Glamour-Morphic')];
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

{ #category : #baselines }
ConfigurationOfGlamour >> baseline20beta3: spec [ 
	<version: '2.0-beta.3-baseline'>
	
	spec for: #common do: [
		spec blessing: #baseline.
		spec repository: 'http://www.squeaksource.com/Glamour'.
		spec 
			package: 'Morphic-MorphTreeWidget' with: [
				spec repository: 'http://www.squeaksource.com/Momo10' ];
			package: 'Glamour-Helpers' ;
			package: 'Glamour-Squeak' ;
			package: 'Glamour-Core' ;
			package: 'Glamour-Presentations' ;
			package: 'Glamour-Browsers' ;
			package: 'Glamour-Scripting' ;
			package: 'Glamour-Tests' ;
			package: 'Glamour-Morphic' with: [spec requires: #('Morphic-MorphTreeWidget')];
			package: 'Glamour-Test-Morphic' with: [spec requires: #('Glamour-Morphic')];
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

{ #category : #baselines }
ConfigurationOfGlamour >> baseline20beta4: spec [ 
	<version: '2.0-beta.4-baseline'>
	
	spec for: #common do: [
		spec blessing: #baseline.
		spec repository: 'http://www.squeaksource.com/Glamour'.
		spec 
			package: 'Morphic-MorphTreeWidget' with: [
				spec repository: 'http://www.squeaksource.com/Momo10' ];
			package: 'Glamour-Announcements' ;
			package: 'Glamour-Helpers' ;
			package: 'Glamour-Core' ;
			package: 'Glamour-Presentations' ;
			package: 'Glamour-Browsers' ;
			package: 'Glamour-Scripting' ;
			package: 'Glamour-Tests' ;
			package: 'Glamour-Morphic' with: [spec requires: #('Morphic-MorphTreeWidget')];
			package: 'Glamour-Test-Morphic' with: [spec requires: #('Glamour-Morphic')];
			package: 'Glamour-Examples' ;
			package: 'Glamour-Tools' .
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

{ #category : #baselines }
ConfigurationOfGlamour >> baseline20beta5: spec [ 
	<version: '2.0-beta.5-baseline'>
	
	spec for: #common do: [
		spec blessing: #baseline.
		spec repository: 'http://www.squeaksource.com/Glamour'.
		spec 
			package: 'Glamour-Announcements' ;
			package: 'Glamour-Helpers' ;
			package: 'Glamour-Core' with: [spec requires: #('Glamour-Helpers' 'Glamour-Announcements')];
			package: 'Glamour-Presentations'  with: [spec requires: #('Glamour-Core')];
			package: 'Glamour-Browsers'  with: [spec requires: #('Glamour-Core')];
			package: 'Glamour-Scripting' with: [spec requires: #('Glamour-Presentations' 'Glamour-Browsers' 'Glamour-Core')];
			package: 'Glamour-Tests-Core' ;
			package: 'Glamour-Morphic-Renderer' with: [spec requires: #('Magritte-Morph' 'Mondrian for Glamour')];
			package: 'Glamour-Morphic-Theme';
			package: 'Glamour-Tests-Morphic' with: [spec requires: #('Glamour-Morphic-Renderer')];
			package: 'Glamour-Examples' ;
			package: 'Glamour-Tools';
			package: 'Magritte-Model' with: [
				spec repository: 'http://source.lukas-renggli.ch/magritte2'.
				spec requires: 'Grease'];
			package: 'Magritte-Tests-Model' with: [
				spec repository: 'http://source.lukas-renggli.ch/magritte2'.
				spec requires: 'Magritte-Model'];
			package: 'Magritte-Morph' with: [
				spec repository: 'http://source.lukas-renggli.ch/magritte2'.
				spec requires: #('Magritte-Model')];
			package: 'Magritte-Pharo-Model' with: [
				spec repository: 'http://source.lukas-renggli.ch/magritte2'.
				spec requires: 'Magritte-Model' ].
		spec group: 'Core' with: #(
						'Glamour-Announcements'
						'Glamour-Helpers'
						'Glamour-Core'
						'Glamour-Presentations'
						'Glamour-Browsers'
						'Glamour-Scripting'
						'Glamour-Examples'
						'Glamour-Tools').
		spec group: 'Extras' with: #(
						'Glamour-Morphic-Renderer'
						'Glamour-Morphic-Theme'
						'Mondrian for Glamour').
		spec group: 'Tests' with: #(
						'Glamour-Tests-Core'
						'Glamour-Examples'
						'Glamour-Tests-Morphic'). 
		spec
			project: 'Mondrian for Glamour' with: [
				spec
					className: 'ConfigurationOfMondrian';
					file: 'ConfigurationOfMondrian';
					version: 'default';
					repository: 'http://www.squeaksource.com/Mondrian' ].
		spec
			project: 'Grease' with: [
				spec
					className: 'ConfigurationOfGrease';
					file: 'ConfigurationOfGrease';
					version: '1.0-alpha9.1';
					repository: 'http://www.squeaksource.com/MetacelloRepository' ].

	]
]

{ #category : #baselines }
ConfigurationOfGlamour >> baseline20beta6: spec [ 
	<version: '2.0-beta.6-baseline'>
	
	spec for: #common do: [
		spec blessing: #baseline.
		spec description: 'Work on Pharo 1.1.1'.
		spec author: 'Alexandre Bergel'.
		spec repository: 'http://www.squeaksource.com/Glamour'.
		spec 
			package: 'Glamour-Announcements' ;
			package: 'Glamour-Helpers' ;
			package: 'Glamour-Core' with: [spec requires: #('Glamour-Helpers' 'Glamour-Announcements')];
			package: 'Glamour-Presentations'  with: [spec requires: #('Glamour-Core')];
			package: 'Glamour-Browsers'  with: [spec requires: #('Glamour-Core')];
			package: 'Glamour-Scripting' with: [spec requires: #('Glamour-Presentations' 'Glamour-Browsers' 'Glamour-Core' 'Mondrian for Glamour')];
			package: 'Glamour-Tests-Core' ;
			package: 'Glamour-Morphic-Renderer' with: [spec requires: #('Shout')];
			package: 'Glamour-Morphic-Theme';
			package: 'Glamour-Tests-Morphic' with: [spec requires: #('Glamour-Morphic-Renderer')];
			package: 'Glamour-Examples' ;
			package: 'Glamour-Tools';
			package: 'Magritte-Model' with: [
				spec repository: 'http://source.lukas-renggli.ch/magritte2'.
				spec requires: 'Grease'];
			package: 'Magritte-Tests-Model' with: [
				spec repository: 'http://source.lukas-renggli.ch/magritte2'.
				spec requires: 'Magritte-Model'];
			package: 'Magritte-Morph' with: [
				spec repository: 'http://source.lukas-renggli.ch/magritte2'.
				spec requires: #('Magritte-Model')];
			package: 'Magritte-Pharo-Model' with: [
				spec repository: 'http://source.lukas-renggli.ch/magritte2'.
				spec requires: 'Magritte-Model' ];
			package: 'Glamour-Mondrian-Presentations' with: [spec requires: 'Mondrian for Glamour'];
			package: 'Glamour-Magritte-Presentations' with: [spec requires: #('Magritte-Morph' 'Magritte-Pharo-Model')];
			package: 'Glamour-Tests-Mondrian' with: [spec requires: #('Glamour-Tests-Morphic' 'Glamour-Mondrian-Presentations')].

		spec group: 'Core' with: #(
						'Glamour-Announcements'
						'Glamour-Helpers'
						'Glamour-Core'
						'Glamour-Presentations'
						'Glamour-Browsers'
						'Glamour-Scripting'
						'Glamour-Examples'
						'Glamour-Tools').
		spec group: 'Morphic' with: #(
						'Glamour-Morphic-Renderer'
						'Glamour-Morphic-Theme').
		spec group: 'Extras' with: #(
						'Glamour-Mondrian-Presentations'
						'Glamour-Magritte-Presentations').
		spec group: 'Tests' with: #(
						'Glamour-Tests-Core'
						'Glamour-Examples'
						'Glamour-Tests-Morphic'
						'Glamour-Tests-Mondrian'). 
		spec
			project: 'Shout' with: [
				spec
					className: 'ConfigurationOfShout';
					file: 'ConfigurationOfShout';
					version: '1.1';
					repository: 'http://www.squeaksource.com/MetacelloRepository' ].					
		spec
			project: 'Mondrian for Glamour' with: [
				spec
					className: 'ConfigurationOfMondrian';
					file: 'ConfigurationOfMondrian';
					version: '2.1.2';
					repository: 'http://www.squeaksource.com/Mondrian' ].
		spec
			project: 'Grease' with: [
				spec
					className: 'ConfigurationOfGrease';
					file: 'ConfigurationOfGrease';
					version: '1.0-alpha9.1';
					repository: 'http://www.squeaksource.com/MetacelloRepository' ].
	]
]

{ #category : #baselines }
ConfigurationOfGlamour >> baseline21: spec [ 
	<version: '2.1-baseline'>
	
	spec for: #common do: [
		spec blessing: #baseline.
		spec repository: 'http://www.squeaksource.com/Glamour'.
		spec 
			package: 'Glamour-Announcements' ;
			package: 'Glamour-Helpers' ;
			package: 'Glamour-Core' with: [spec requires: #('Glamour-Helpers' 'Glamour-Announcements')];
			package: 'Glamour-Presentations'  with: [spec requires: #('Glamour-Core')];
			package: 'Glamour-Browsers'  with: [spec requires: #('Glamour-Core')];
			package: 'Glamour-Tests-Core' ;
			package: 'Glamour-Morphic-Renderer' with: [spec requires: #('Shout')];
			package: 'Glamour-Morphic-Theme';
			package: 'Glamour-Tests-Morphic' with: [spec requires: #('Glamour-Morphic-Renderer')];
			package: 'Glamour-Examples' ;
			package: 'Glamour-Tools';
			package: 'Magritte-Model' with: [
				spec repository: 'http://source.lukas-renggli.ch/magritte2'.
				spec requires: 'Grease'];
			package: 'Magritte-Tests-Model' with: [
				spec repository: 'http://source.lukas-renggli.ch/magritte2'.
				spec requires: 'Magritte-Model'];
			package: 'Magritte-Morph' with: [
				spec repository: 'http://source.lukas-renggli.ch/magritte2'.
				spec requires: #('Magritte-Model')];
			package: 'Magritte-Pharo-Model' with: [
				spec repository: 'http://source.lukas-renggli.ch/magritte2'.
				spec requires: 'Magritte-Model' ];
			package: 'Glamour-Mondrian-Presentations' with: [spec requires: 'Mondrian for Glamour'];
			package: 'Glamour-Magritte-Presentations' with: [spec requires: #('Magritte-Morph' 'Magritte-Pharo-Model')];
			package: 'Glamour-Tests-Mondrian' with: [spec requires: #('Glamour-Tests-Morphic' 'Glamour-Mondrian-Presentations')].

		spec group: 'Core' with: #(
						'Glamour-Announcements'
						'Glamour-Helpers'
						'Glamour-Core'
						'Glamour-Presentations'
						'Glamour-Browsers'
						'Glamour-Examples'
						'Glamour-Tools').
		spec group: 'Morphic' with: #(
						'Glamour-Morphic-Renderer'
						'Glamour-Morphic-Theme').
		spec group: 'Extras' with: #(
						'Glamour-Mondrian-Presentations'
						'Glamour-Magritte-Presentations').
		spec group: 'Tests' with: #(
						'Glamour-Tests-Core'
						'Glamour-Examples'
						'Glamour-Tests-Morphic'). 
		spec group: 'ExtrasTests' with: #(
						'Glamour-Tests-Mondrian').	
		spec
			project: 'Shout' with: [
				spec
					className: 'ConfigurationOfShout';
					file: 'ConfigurationOfShout';
					version: '1.2.2';
					repository: 'http://www.squeaksource.com/MetacelloRepository' ].					
		spec
			project: 'Mondrian for Glamour' with: [
				spec
					className: 'ConfigurationOfMondrian';
					file: 'ConfigurationOfMondrian';
					version: 'default';
					repository: 'http://www.squeaksource.com/Mondrian' ].
		spec
			project: 'Grease' with: [
				spec
					className: 'ConfigurationOfGrease';
					file: 'ConfigurationOfGrease';
					version: '1.0.3';
					repository: 'http://www.squeaksource.com/MetacelloRepository' ].
	]
]

{ #category : #baselines }
ConfigurationOfGlamour >> baseline22: spec [ 
	<version: '2.2-baseline'>
	
	spec for: #common do: [
		spec blessing: #baseline.
		spec repository: 'http://www.squeaksource.com/Glamour'.
		spec 
			package: 'CollectionExtensions' with: [spec repository: 'http://www.squeaksource.com/CollectionExtensions'];
			package: 'Glamour-Announcements' ;
			package: 'Glamour-Helpers' ;
			package: 'Glamour-Core' with: [spec requires: #('Glamour-Helpers' 'Glamour-Announcements')];
			package: 'Glamour-Presentations'  with: [spec requires: #('Glamour-Core')];
			package: 'Glamour-Browsers'  with: [spec requires: #('Glamour-Core')];
			package: 'Glamour-Tests-Core' ;
			package: 'Glamour-Morphic-Widgets' with: [spec requires: #('Shout')];
			package: 'Glamour-Morphic-Renderer' with: [spec requires: #('Glamour-Morphic-Widgets' 'Glamour-Core')];
			package: 'Glamour-Morphic-Theme';
			package: 'Glamour-Tests-Morphic' with: [spec requires: #('Glamour-Morphic-Renderer')];
			package: 'Glamour-Examples' ;
			package: 'Glamour-Tools' with: [spec requires: 'CollectionExtensions'];
			package: 'Magritte-Model' with: [
				spec repository: 'http://source.lukas-renggli.ch/magritte2'.
				spec requires: 'Grease'];
			package: 'Magritte-Tests-Model' with: [
				spec repository: 'http://source.lukas-renggli.ch/magritte2'.
				spec requires: 'Magritte-Model'];
			package: 'Magritte-Morph' with: [
				spec repository: 'http://source.lukas-renggli.ch/magritte2'.
				spec requires: #('Magritte-Model')];
			package: 'Magritte-Pharo-Model' with: [
				spec repository: 'http://source.lukas-renggli.ch/magritte2'.
				spec requires: 'Magritte-Model' ];
			package: 'Glamour-Mondrian-Presentations' with: [spec requires: 'Mondrian for Glamour'];
			package: 'Glamour-Magritte-Presentations' with: [spec requires: #('Magritte-Morph' 'Magritte-Pharo-Model')];
			package: 'Glamour-EyeSee-Presentations' with: [spec requires: 'EyeSee for Glamour'];
			package: 'Glamour-Tests-Mondrian' with: [spec requires: #('Glamour-Tests-Morphic' 'Glamour-Mondrian-Presentations')];
			package: 'Glamour-Tests-EyeSee' with: [spec requires: #('Glamour-Tests-Morphic' 'Glamour-EyeSee-Presentations')].

		spec group: 'Core' with: #(
						'Glamour-Announcements'
						'Glamour-Helpers'
						'Glamour-Core'
						'Glamour-Presentations'
						'Glamour-Browsers'
						'Glamour-Examples'
						'Glamour-Tools').
		spec group: 'Morphic' with: #(
						'Glamour-Morphic-Renderer'
						'Glamour-Morphic-Theme').
		spec group: 'Extras' with: #(
						'Glamour-Mondrian-Presentations'
						'Glamour-Magritte-Presentations'
						'Glamour-EyeSee-Presentations').
		spec group: 'Core Tests' with: #(
						'Glamour-Tests-Core'
						'Glamour-Examples'
						'Glamour-Tests-Morphic'). 
		spec group: 'Tests' with: #(
						'Glamour-Tests-Core'
						'Glamour-Examples'
						'Glamour-Tests-Morphic'
						'Glamour-Tests-Mondrian'
						'Glamour-Tests-EyeSee'). 
		spec
			project: 'Shout' with: [
				spec
					className: 'ConfigurationOfShout';
					file: 'ConfigurationOfShout';
					version: '1.3';
					repository: 'http://www.squeaksource.com/MetacelloRepository' ].					
		spec
			project: 'Mondrian for Glamour' with: [
				spec
					className: 'ConfigurationOfMondrian';
					file: 'ConfigurationOfMondrian';
					version: 'default';
					repository: 'http://www.squeaksource.com/Mondrian' ].
		spec
			project: 'EyeSee for Glamour' with: [
				spec
					className: 'ConfigurationOfEyeSee';
					file: 'ConfigurationOfEyeSee';
					version: 'default';
					repository: 'http://www.squeaksource.com/EyeSee' ].
		spec
			project: 'Grease' with: [
				spec
					className: 'ConfigurationOfGrease';
					file: 'ConfigurationOfGrease';
					version: #stable;
					repository: 'http://www.squeaksource.com/MetacelloRepository' ].
	]
]

{ #category : #baselines }
ConfigurationOfGlamour >> default: spec [ 
	<version: 'default'>
	
	spec for: #common do: [
		spec blessing: #baseline.
		spec repository: 'http://www.squeaksource.com/Glamour'.
		spec 
			package: 'CollectionExtensions' with: [spec repository: 'http://www.squeaksource.com/CollectionExtensions'];
			package: 'Glamour-Announcements' ;
			package: 'Glamour-Helpers' ;
			package: 'Glamour-Core' with: [spec requires: #('Glamour-Helpers' 'Glamour-Announcements')];
			package: 'Glamour-Presentations'  with: [spec requires: #('Glamour-Core')];
			package: 'Glamour-Browsers'  with: [spec requires: #('Glamour-Core')];
			package: 'Glamour-Tests-Core' ;
			package: 'Glamour-Morphic-Widgets' with: [spec requires: #('Shout' 'NEC')];
			package: 'Glamour-Morphic-Renderer' with: [spec requires: #('Glamour-Morphic-Widgets' 'Glamour-Core')];
			package: 'Glamour-Morphic-Theme';
			package: 'Glamour-Tests-Morphic' with: [spec requires: #('Glamour-Morphic-Renderer' 'BDDExtensions')];
			package: 'Glamour-Examples' ;
			package: 'Glamour-Tools' with: [spec requires: 'CollectionExtensions'];
			package: 'Glamour-Roassal-Presentations' with: [spec requires: 'Roassal for Glamour'];
			package: 'Glamour-Mondrian-Presentations' with: [spec requires: 'Mondrian for Glamour'];
			package: 'Glamour-Magritte-Presentations' with: [spec requires: #('Magritte3')];
			package: 'Glamour-EyeSee-Presentations' with: [spec requires: 'EyeSee for Glamour'];
			package: 'Glamour-Tests-Mondrian' with: [spec requires: #('Glamour-Tests-Morphic' 'Glamour-Mondrian-Presentations')];
			package: 'Glamour-Tests-Roassal' with: [spec requires: #('Glamour-Tests-Morphic' 'Glamour-Roassal-Presentations')];
			package: 'Glamour-Tests-EyeSee' with: [spec requires: #('Glamour-Tests-Morphic' 'Glamour-EyeSee-Presentations')].

		spec group: 'Core' with: #(
						'Glamour-Announcements'
						'Glamour-Helpers'
						'Glamour-Core'
						'Glamour-Presentations'
						'Glamour-Browsers'
						'Glamour-Examples'
						'Glamour-Tools').
		spec group: 'Morphic' with: #(
						'Glamour-Morphic-Renderer'
						'Glamour-Morphic-Theme').
		spec group: 'Extras' with: #(
						'Glamour-Mondrian-Presentations'
						'Glamour-Magritte-Presentations'
						'Glamour-EyeSee-Presentations').
		spec group: 'Core Tests' with: #(
						'Glamour-Tests-Core'
						'Glamour-Examples'
						'Glamour-Tests-Morphic'). 
		spec group: 'Tests' with: #(
						'Glamour-Tests-Core'
						'Glamour-Examples'
						'Glamour-Tests-Morphic'
						'Glamour-Tests-Mondrian'
						'Glamour-Tests-EyeSee'). 
		spec
			project: 'Shout' with: [
				spec
					className: 'ConfigurationOfShout';
					file: 'ConfigurationOfShout';
					version: '1.3';
					repository: 'http://www.squeaksource.com/MetacelloRepository' ].
		spec
			project: 'NEC' with: [
				spec
					className: 'ConfigurationOfNewECompletion';
					file: 'ConfigurationOfNewECompletion';
					version: #stable;
					repository: 'http://ss3.gemstone.com/ss/NEC' ].
		spec
			project: 'BDDExtensions' with: [
				spec
					className: 'ConfigurationOfBDDExtensions';
					file: 'ConfigurationOfBDDExtensions';
					version: '1.0-baseline';
					repository: 'http://www.squeaksource.com/BDDExtensions' ].
		spec
			project: 'Mondrian for Glamour' with: [
				spec
					className: 'ConfigurationOfMondrian';
					file: 'ConfigurationOfMondrian';
					version: 'default';
					repository: 'http://www.squeaksource.com/Mondrian' ].
		spec
			project: 'Roassal for Glamour' with: [
				spec
					className: 'ConfigurationOfRoassal';
					file: 'ConfigurationOfRoassal';
					version: #development;
					repository: 'http://www.squeaksource.com/Roassal' ].
		spec
			project: 'EyeSee for Glamour' with: [
				spec
					className: 'ConfigurationOfEyeSee';
					file: 'ConfigurationOfEyeSee';
					version: 'default';
					repository: 'http://www.squeaksource.com/EyeSee' ].
		spec project: 'Magritte3' with: [
			spec
					className: 'ConfigurationOfMagritte3';
					file: 'ConfigurationOfMagritte3';
					version: #stable;
					repository: 'http://source.lukas-renggli.ch/magritte3';
					loads: #('Magritte-Model' 'Magritte-Tests-Model' 'Magritte-Morph' 'Magritte-Pharo-Model') ].
	]
]

{ #category : #'symbolic versions' }
ConfigurationOfGlamour >> development: spec [
	<symbolicVersion: #'development'>

	spec for: #'common' version: 'default'.

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

{ #category : #'symbolic versions' }
ConfigurationOfGlamour >> stable: spec [
	<symbolicVersion: #'stable'>

	spec for: #'common' version: '2.1'.
	spec for: #'pharo1.3.x' version: '2.2'.
	spec for: #'pharo1.4.x' version: '2.3'.
]

{ #category : #versions }
ConfigurationOfGlamour >> version206: spec [
	<version: '2.0.6' imports: #('2.0-beta.4-baseline')>

	spec for: #common do: [
		spec author: 'simondenier'.
		spec timestamp: '4/6/2010 19:51'.
		spec blessing: #development.
		spec project: 'Mondrian for Glamour' with: '2.0.7'.
		spec 
			package: 'Morphic-MorphTreeWidget' with: 'Morphic-MorphTreeWidget-AlainPlantec.88';
			package: 'Glamour-Announcements' with: 'Glamour-Announcements-tg.4';
			package: 'Glamour-Helpers' with: 'Glamour-Helpers-tg.17';
			package: 'Glamour-Core' with: 'Glamour-Core-tg.121';
			package: 'Glamour-Presentations' with: 'Glamour-Presentations-tg.71';
			package: 'Glamour-Browsers' with: 'Glamour-Browsers-tg.38';
			package: 'Glamour-Scripting' with: 'Glamour-Scripting-tg.83';
			package: 'Glamour-Tests' with: 'Glamour-Tests-tg.137';
			package: 'Glamour-Morphic' with: 'Glamour-Morphic-tg.271';
			package: 'Glamour-Test-Morphic' with: 'Glamour-Test-Morphic-tg.65';
			package: 'Glamour-Examples' with: 'Glamour-Examples-tg.137';
			package: 'Glamour-Tools' with: 'Glamour-Tools-tg.22'.].
]

{ #category : #versions }
ConfigurationOfGlamour >> version20beta1: spec [
	<version: '2.0-beta.1' imports: #('2.0-beta.1-baseline')>

	spec for: #common do: [
		spec blessing: #stable.
		spec author: 'tg'.
		spec timestamp: '11/21/2009 23:06'.
		spec project: 'Mondrian for Glamour' with: '2.0-beta.1'.
		spec 
			package: 'Morphic-MorphTreeWidget' with: 'Morphic-MorphTreeWidget-AlainPlantec.17';
			package: 'Glamour-Helpers' with: 'Glamour-Helpers-tg.11';
			package: 'Glamour-Squeak' with: 'Glamour-Squeak-tg.7';
			package: 'Glamour-Core' with: 'Glamour-Core-tg.51';
			package: 'Glamour-Presentations' with: 'Glamour-Presentations-VeronicaUquillas.51';
			package: 'Glamour-Browsers' with: 'Glamour-Browsers-tg.14';
			package: 'Glamour-Scripting' with: 'Glamour-Scripting-tg.44';
			package: 'Glamour-Tests' with: 'Glamour-Tests-tg.53';
			package: 'Glamour-Morphic' with: 'Glamour-Morphic-VeronicaUquillas.194';
			package: 'Glamour-Test-Morphic' with: 'Glamour-Test-Morphic-tg.11';
			package: 'Glamour-Examples' with: 'Glamour-Examples-simondenier.89'.].
]

{ #category : #versions }
ConfigurationOfGlamour >> version20beta2: spec [
	<version: '2.0-beta.2' imports: #('2.0-beta.2-baseline')>

	spec for: #common do: [
		spec blessing: #stable.
		spec author: 'tg'.
		spec timestamp: '12/18/2009 19:13'.
		spec project: 'Mondrian for Glamour' with: '2.0-beta.1'.
		spec 
			package: 'Morphic-MorphTreeWidget' with: 'Morphic-MorphTreeWidget-AlainPlantec.39';
			package: 'Glamour-Helpers' with: 'Glamour-Helpers-tg.11';
			package: 'Glamour-Squeak' with: 'Glamour-Squeak-tg.7';
			package: 'Glamour-Core' with: 'Glamour-Core-tg.55';
			package: 'Glamour-Presentations' with: 'Glamour-Presentations-tg.52';
			package: 'Glamour-Browsers' with: 'Glamour-Browsers-tg.15';
			package: 'Glamour-Scripting' with: 'Glamour-Scripting-tg.46';
			package: 'Glamour-Tests' with: 'Glamour-Tests-tg.59';
			package: 'Glamour-Morphic' with: 'Glamour-Morphic-tg.203';
			package: 'Glamour-Test-Morphic' with: 'Glamour-Test-Morphic-tg.18';
			package: 'Glamour-Examples' with: 'Glamour-Examples-tg.95'.].
]

{ #category : #versions }
ConfigurationOfGlamour >> version20beta3: spec [
	<version: '2.0-beta.3' imports: #('2.0-beta.3-baseline')>

	spec for: #common do: [
		spec blessing: #stable.
		spec author: 'tg'.
		spec timestamp: '12/28/2009 21:29'.
		spec project: 'Mondrian for Glamour' with: '2.0-beta.3'.
		spec 
			package: 'Morphic-MorphTreeWidget' with: 'Morphic-MorphTreeWidget-AlainPlantec.46';
			package: 'Glamour-Helpers' with: 'Glamour-Helpers-tg.11';
			package: 'Glamour-Squeak' with: 'Glamour-Squeak-tg.7';
			package: 'Glamour-Core' with: 'Glamour-Core-tg.59';
			package: 'Glamour-Presentations' with: 'Glamour-Presentations-tg.53';
			package: 'Glamour-Browsers' with: 'Glamour-Browsers-tg.15';
			package: 'Glamour-Scripting' with: 'Glamour-Scripting-tg.47';
			package: 'Glamour-Tests' with: 'Glamour-Tests-tg.61';
			package: 'Glamour-Morphic' with: 'Glamour-Morphic-tg.204';
			package: 'Glamour-Test-Morphic' with: 'Glamour-Test-Morphic-tg.18';
			package: 'Glamour-Examples' with: 'Glamour-Examples-tg.97'.].
]

{ #category : #versions }
ConfigurationOfGlamour >> version20beta4: spec [
	<version: '2.0-beta.4' imports: #('2.0-beta.4-baseline')>

	spec for: #common do: [
		spec blessing: #beta.
		spec author: 'tg'.
		spec timestamp: '2/16/2010 12:58'.
		spec project: 'Mondrian for Glamour' with: '2.0-beta.5'.
		spec 
			package: 'Morphic-MorphTreeWidget' with: 'Morphic-MorphTreeWidget-AlainPlantec.88';
			package: 'Glamour-Announcements' with: 'Glamour-Announcements-tg.3';
			package: 'Glamour-Helpers' with: 'Glamour-Helpers-tg.15';
			package: 'Glamour-Core' with: 'Glamour-Core-tg.113';
			package: 'Glamour-Presentations' with: 'Glamour-Presentations-tg.63';
			package: 'Glamour-Browsers' with: 'Glamour-Browsers-tg.37';
			package: 'Glamour-Scripting' with: 'Glamour-Scripting-tg.74';
			package: 'Glamour-Tests' with: 'Glamour-Tests-tg.124';
			package: 'Glamour-Morphic' with: 'Glamour-Morphic-tg.259';
			package: 'Glamour-Test-Morphic' with: 'Glamour-Test-Morphic-tg.57';
			package: 'Glamour-Examples' with: 'Glamour-Examples-tg.125';
			package: 'Glamour-Tools' with: 'Glamour-Tools-tg.21'.].
]

{ #category : #versions }
ConfigurationOfGlamour >> version20beta5: spec [
	<version: '2.0-beta.5' imports: #('2.0-beta.4-baseline')>

	spec for: #common do: [
		spec author: 'simon.denier'.
		spec timestamp: '3/31/2010 16:13'.
		spec blessing: #development.
		spec project: 'Mondrian for Glamour' with: '2.0-beta.6'.
		spec 
			package: 'Morphic-MorphTreeWidget' with: 'Morphic-MorphTreeWidget-AlainPlantec.88';
			package: 'Glamour-Announcements' with: 'Glamour-Announcements-tg.3';
			package: 'Glamour-Helpers' with: 'Glamour-Helpers-tg.15';
			package: 'Glamour-Core' with: 'Glamour-Core-tg.113';
			package: 'Glamour-Presentations' with: 'Glamour-Presentations-tg.63';
			package: 'Glamour-Browsers' with: 'Glamour-Browsers-tg.37';
			package: 'Glamour-Scripting' with: 'Glamour-Scripting-tg.74';
			package: 'Glamour-Tests' with: 'Glamour-Tests-tg.124';
			package: 'Glamour-Morphic' with: 'Glamour-Morphic-tg.259';
			package: 'Glamour-Test-Morphic' with: 'Glamour-Test-Morphic-tg.57';
			package: 'Glamour-Examples' with: 'Glamour-Examples-tg.125';
			package: 'Glamour-Tools' with: 'Glamour-Tools-tg.21'.].
]

{ #category : #versions }
ConfigurationOfGlamour >> version20beta6: spec [
	<version: '2.0-beta.6' imports: #('2.0-beta.4-baseline')>

	spec for: #common do: [
		spec author: 'jannik.laval'.
		spec timestamp: '6/1/2010 22:59'.
		spec blessing: #development.
		spec project: 'Mondrian for Glamour' with: '2.0-beta.7'.
		spec 
			package: 'Morphic-MorphTreeWidget' with: 'Morphic-MorphTreeWidget-AlainPlantec.88';
			package: 'Glamour-Announcements' with: 'Glamour-Announcements-tg.4';
			package: 'Glamour-Helpers' with: 'Glamour-Helpers-FabrizioPerin.19';
			package: 'Glamour-Core' with: 'Glamour-Core-tg.131';
			package: 'Glamour-Presentations' with: 'Glamour-Presentations-VeronicaUquillas.79';
			package: 'Glamour-Browsers' with: 'Glamour-Browsers-Alexandre_Bergel.40';
			package: 'Glamour-Scripting' with: 'Glamour-Scripting-VeronicaUquillas.89';
			package: 'Glamour-Tests' with: 'Glamour-Tests-tg.143';
			package: 'Glamour-Morphic' with: 'Glamour-Morphic-VeronicaUquillas.282';
			package: 'Glamour-Test-Morphic' with: 'Glamour-Test-Morphic-tg.72';
			package: 'Glamour-Examples' with: 'Glamour-Examples-VeronicaUquillas.142';
			package: 'Glamour-Tools' with: 'Glamour-Tools-tg.22'.].
]

{ #category : #versions }
ConfigurationOfGlamour >> version20beta7: spec [
	<version: '2.0-beta.7' imports: #('2.0-beta.5-baseline')>

	spec for: #common do: [
		spec author: 'jl'.
		spec timestamp: '09/13/2010 22:00'.
		spec blessing: #development.
		spec project: 'Mondrian for Glamour' with: '2.0-beta.8'.
		spec 
			package: 'Glamour-Announcements' with:  'Glamour-Announcements-tg.5';
			package: 'Glamour-Helpers' with:  'Glamour-Helpers-tg.20';
			package: 'Glamour-Core' with:  'Glamour-Core-tg.142';
			package: 'Glamour-Presentations'  with: 'Glamour-Presentations-tg.83';
			package: 'Glamour-Browsers'  with: 'Glamour-Browsers-tg.45';
			package: 'Glamour-Scripting' with: 'Glamour-Scripting-tg.91';
			package: 'Glamour-Tests-Core' with:  'Glamour-Tests-Core-tg.1';
			package: 'Glamour-Morphic-Renderer' with:  'Glamour-Morphic-Renderer-tg.5';
			package: 'Glamour-Morphic-Theme' with:  'Glamour-Morphic-Theme-tg.21';
			package: 'Glamour-Tests-Morphic' with:  'Glamour-Tests-Morphic-tg.3';
			package: 'Glamour-Examples' with:  'Glamour-Examples-tg.148';
			package: 'Glamour-Tools' with:  'Glamour-Tools-tg.22';
			package: 'Magritte-Model' with:  'Magritte-Model-lr.397';
			package: 'Magritte-Tests-Model' with:  'Magritte-Tests-Model-lr.13';
			package: 'Magritte-Morph' with:  'Magritte-Morph-lr.52';
			package: 'Magritte-Pharo-Model' with:  'Magritte-Pharo-Model-lr.22'.].
]

{ #category : #versions }
ConfigurationOfGlamour >> version20beta8: spec [
	<version: '2.0-beta.8' imports: #('2.0-beta.6-baseline')>

	spec for: #common do: [
		spec author: 'Alexandre Bergel'.
		spec timestamp: '12/2/2010 09:36'.
		spec description: 'Compatible with Pharo 1.1.1'.
		spec blessing: #development.
		spec project: 'Mondrian for Glamour' with: '2.1.2'.
		spec 
			package: 'Glamour-Announcements' with:  'Glamour-Announcements-tg.5';
			package: 'Glamour-Helpers' with:  'Glamour-Helpers-tg.23';
			package: 'Glamour-Core' with:  'Glamour-Core-tg.146';
			package: 'Glamour-Presentations'  with: 'Glamour-Presentations-tg.88';
			package: 'Glamour-Browsers'  with: 'Glamour-Browsers-tg.46';
			package: 'Glamour-Scripting' with: 'Glamour-Scripting-TudorGirba.100';
			package: 'Glamour-Tests-Core' with:  'Glamour-Tests-Core-TudorGirba.9';
			package: 'Glamour-Morphic-Renderer' with:  'Glamour-Morphic-Renderer-TudorGirba.21';
			package: 'Glamour-Morphic-Theme' with:  'Glamour-Morphic-Theme-tg.21';
			package: 'Glamour-Tests-Morphic' with:  'Glamour-Tests-Morphic-tg.4';
			package: 'Glamour-Examples' with:  'Glamour-Examples-TudorGirba.156';
			package: 'Glamour-Tools' with:  'Glamour-Tools-tg.23';
			package: 'Magritte-Model' with:  'Magritte-Model-lr.397';
			package: 'Magritte-Tests-Model' with:  'Magritte-Tests-Model-lr.13';
			package: 'Magritte-Morph' with:  'Magritte-Morph-lr.52';
			package: 'Magritte-Pharo-Model' with:  'Magritte-Pharo-Model-lr.22'.].
]

{ #category : #versions }
ConfigurationOfGlamour >> version21: spec [
	<version: '2.1' imports: #('2.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'release'.
		spec description: 'New version'.
		spec author: 'AlexandreBergel'.
		spec timestamp: '2/17/2011 10:45'.
		spec 
			project: 'Shout' with: '1.2.2';
			project: 'Mondrian for Glamour' with: '2.49';
			project: 'Grease' with: '1.0.3.1'.
		spec 
			package: 'Glamour-Announcements' with: 'Glamour-Announcements-tg.5';
			package: 'Glamour-Helpers' with: 'Glamour-Helpers-TudorGirba.25';
			package: 'Glamour-Core' with: 'Glamour-Core-TudorGirba.159';
			package: 'Glamour-Presentations' with: 'Glamour-Presentations-TudorGirba.90';
			package: 'Glamour-Browsers' with: 'Glamour-Browsers-TudorGirba.55';
			package: 'Glamour-Scripting' with: 'Glamour-Scripting-TudorGirba.112';
			package: 'Glamour-Tests-Core' with: 'Glamour-Tests-Core-TudorGirba.23';
			package: 'Glamour-Morphic-Renderer' with: 'Glamour-Morphic-Renderer-TudorGirba.70';
			package: 'Glamour-Morphic-Theme' with: 'Glamour-Morphic-Theme-TudorGirba.38';
			package: 'Glamour-Tests-Morphic' with: 'Glamour-Tests-Morphic-TudorGirba.27';
			package: 'Glamour-Examples' with: 'Glamour-Examples-TudorGirba.162';
			package: 'Glamour-Tools' with: 'Glamour-Tools-tg.23';
			package: 'Magritte-Model' with: 'Magritte-Model-lr.404';
			package: 'Magritte-Tests-Model' with: 'Magritte-Tests-Model-lr.16';
			package: 'Magritte-Morph' with: 'Magritte-Morph-lr.53';
			package: 'Magritte-Pharo-Model' with: 'Magritte-Pharo-Model-lr.22';
			package: 'Glamour-Mondrian-Presentations' with: 'Glamour-Mondrian-Presentations-TudorGirba.2';
			package: 'Glamour-Magritte-Presentations' with: 'Glamour-Magritte-Presentations-tg.1';
			package: 'Glamour-Tests-Mondrian' with: 'Glamour-Tests-Mondrian-TudorGirba.4'. ].

]

{ #category : #versions }
ConfigurationOfGlamour >> version22: spec [
	<version: '2.2' imports: #('2.2-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'release'.
		spec description: 'release for pharo 1.3'.
		spec author: 'GuillermoPolito'.
		spec timestamp: '9/26/2011 21:07'.
		spec 
			package: 'CollectionExtensions' with: 'CollectionExtensions-TudorGirba.29'.
		spec 
			package: 'Glamour-Announcements' with: 'Glamour-Announcements-TudorGirba.6';
			package: 'Glamour-Helpers' with: 'Glamour-Helpers-TudorGirba.32';
			package: 'Glamour-Core' with: 'Glamour-Core-TudorGirba.221';
			package: 'Glamour-Presentations'  with: 'Glamour-Presentations-TudorGirba.109';
			package: 'Glamour-Browsers'  with: 'Glamour-Browsers-TudorGirba.90';
			package: 'Glamour-Tests-Core' with: 'Glamour-Tests-Core-TudorGirba.66';
			package: 'Glamour-Morphic-Widgets' with: 'Glamour-Morphic-Widgets-TudorGirba.31';
			package: 'Glamour-Morphic-Renderer' with: 'Glamour-Morphic-Renderer-TudorGirba.139';
			package: 'Glamour-Morphic-Theme' with: 'Glamour-Morphic-Theme-TudorGirba.55';
			package: 'Glamour-Tests-Morphic' with: 'Glamour-Tests-Morphic-TudorGirba.83';
			package: 'Glamour-Examples' with: 'Glamour-Examples-TudorGirba.219';
			package: 'Glamour-Tools' with: 'Glamour-Tools-TudorGirba.50';
			
			package: 'Magritte-Model' with: 'Magritte-Model-NickAger.407';
			package: 'Magritte-Tests-Model' with: 'Magritte-Tests-Model-lr.16';
			package: 'Magritte-Morph' with: 'Magritte-Morph-EstebanLorenzano.57';
			package: 'Magritte-Pharo-Model' with:  'Magritte-Pharo-Model-lr.22';
			
			package: 'Glamour-Mondrian-Presentations' with: 'Glamour-Mondrian-Presentations-TudorGirba.4';
			package: 'Glamour-Magritte-Presentations' with: 'Glamour-Magritte-Presentations-TudorGirba.2';
			package: 'Glamour-EyeSee-Presentations' with: 'Glamour-EyeSee-Presentations-AndreHora.2';
			package: 'Glamour-Tests-Mondrian' with: 'Glamour-Tests-Mondrian-TudorGirba.5';
			package: 'Glamour-Tests-EyeSee' with: 'Glamour-Tests-EyeSee-AndreHora.6'.

		]
]

{ #category : #versions }
ConfigurationOfGlamour >> version23: spec [
	<version: '2.3' imports: #('2.2-baseline')>

	spec for: #'common' do: [
		spec blessing: #'release'.
		spec description: 'release for pharo 1.4'.
		spec author: 'GuillermoPolito'.
		spec timestamp: '2012-04-26T19:38:58.264+02:00'.

		spec 
			package: 'CollectionExtensions' with: 'CollectionExtensions-TudorGirba.29'.
		spec 
			package: 'Glamour-Announcements' with: 'Glamour-Announcements-TudorGirba.7';
			package: 'Glamour-Helpers' with: 'Glamour-Helpers-TudorGirba.32';
			package: 'Glamour-Core' with: 'Glamour-Core-TudorGirba.225';
			package: 'Glamour-Presentations'  with: 'Glamour-Presentations-EstebanLorenzano.111';
			package: 'Glamour-Browsers'  with: 'Glamour-Browsers-TudorGirba.90';
			package: 'Glamour-Tests-Core' with: 'Glamour-Tests-Core-TudorGirba.69';
			package: 'Glamour-Morphic-Widgets' with: 'Glamour-Morphic-Widgets-EstebanLorenzano.38';
			package: 'Glamour-Morphic-Renderer' with: 'Glamour-Morphic-Renderer-EstebanLorenzano.145';
			package: 'Glamour-Morphic-Theme' with: 'Glamour-Morphic-Theme-TudorGirba.56';
			package: 'Glamour-Tests-Morphic' with: 'Glamour-Tests-Morphic-TudorGirba.87';
			package: 'Glamour-Examples' with: 'Glamour-Examples-TudorGirba.235';
			package: 'Glamour-Tools' with: 'Glamour-Tools-TudorGirba.51';
			
			package: 'Magritte-Model' with: 'Magritte-Model-NickAger.407';
			package: 'Magritte-Tests-Model' with: 'Magritte-Tests-Model-lr.16';
			package: 'Magritte-Morph' with: 'Magritte-Morph-EstebanLorenzano.57';
			package: 'Magritte-Pharo-Model' with:  'Magritte-Pharo-Model-lr.22';
			
			package: 'Glamour-Mondrian-Presentations' with: 'Glamour-Mondrian-Presentations-TudorGirba.4';
			package: 'Glamour-Magritte-Presentations' with: 'Glamour-Magritte-Presentations-BenComan.3';
			package: 'Glamour-EyeSee-Presentations' with: 'Glamour-EyeSee-Presentations-AndreHora.2';
			package: 'Glamour-Tests-Mondrian' with: 'Glamour-Tests-Mondrian-TudorGirba.5';
			package: 'Glamour-Tests-EyeSee' with: 'Glamour-Tests-EyeSee-AndreHora.6'.


	]
]
