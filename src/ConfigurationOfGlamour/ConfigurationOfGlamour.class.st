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
ConfigurationOfGlamour >> baseline23: spec [ 
	<version: '2.3-baseline'>
	
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
			package: 'Glamour-Morphic-Widgets';
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
ConfigurationOfGlamour >> baseline24: spec [ 
	<version: '2.4-baseline'>
	
	spec for: #common do: [
		spec blessing: #baseline.
		spec description: 'Loading moose packages from SmalltalkHub for Pharo1.4'.
		spec repository: 'http://smalltalkhub.com/mc/Moose/Glamour/main'.
		spec 
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
			package: 'Glamour-Tools';
			package: 'Glamour-Roassal-Presentations' with: [spec requires: 'Roassal for Glamour'];
			package: 'Glamour-Mondrian-Presentations' with: [spec requires: 'Mondrian for Glamour'];
			package: 'Glamour-Magritte-Presentations' with: [spec requires: #('Magritte3')];
			package: 'Glamour-EyeSee-Presentations' with: [spec requires: 'EyeSee for Glamour'];
			package: 'Glamour-Tests-Mondrian' with: [spec requires: #('Glamour-Tests-Morphic' 'Glamour-Mondrian-Presentations')];
			package: 'Glamour-Tests-Roassal' with: [spec requires: #('Glamour-Tests-Morphic' 'Glamour-Roassal-Presentations')];
			package: 'Glamour-Tests-EyeSee' with: [spec requires: #('Glamour-Tests-Morphic' 'Glamour-EyeSee-Presentations')];
			package: 'Glamour-Tests-Resources'.
	spec for: #squeakCommon do: [
			spec package: 'CollectionExtensions' with: [
				spec repository: 'http://smalltalkhub.com/mc/Moose/CollectionExtensions/main'].
			spec
				package: 'Glamour-Tools' with: [spec requires: 'CollectionExtensions'].
		].

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
						'Glamour-EyeSee-Presentations'
						'Glamour-Roassal-Presentations').
		spec group: 'Core Tests' with: #(
						'Glamour-Tests-Core'
						'Glamour-Examples'
						'Glamour-Tests-Resources'
						'Glamour-Tests-Morphic'). 
		spec group: 'Tests' with: #(
						'Glamour-Tests-Core'
						'Glamour-Examples'
						'Glamour-Tests-Morphic'
						'Glamour-Tests-Mondrian'
						'Glamour-Tests-EyeSee'
						'Glamour-Tests-Roassal'
						'Glamour-Tests-Resources'). 
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
					repository: 'http://smalltalkhub.com/mc/Moose/Mondrian/main' ].
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
					repository: 'http://smalltalkhub.com/mc/Moose/EyeSee/main' ].
		spec project: 'Magritte3' with: [
			spec
					className: 'ConfigurationOfMagritte3';
					file: 'ConfigurationOfMagritte3';
					version: #stable;
					repository: 'http://source.lukas-renggli.ch/magritte3';
					loads: #('Magritte-Model' 'Magritte-Tests-Model' 'Magritte-Morph') ] ]
]

{ #category : #baselines }
ConfigurationOfGlamour >> baseline25: spec [ 
	<version: '2.5-baseline'>
	
	spec for: #common do: [
		spec blessing: #baseline.
		spec description: 'Loading moose packages from SmalltalkHub for Pharo2.0'.
		spec repository: 'http://www.smalltalkhub.com/mc/Moose/Glamour/main'.
		spec 
			package: 'Glamour-Announcements' ;
			package: 'Glamour-Helpers' ;
			package: 'Glamour-Core' with: [spec requires: #('Glamour-Helpers' 'Glamour-Announcements')];
			package: 'Glamour-Presentations'  with: [spec requires: #('Glamour-Core')];
			package: 'Glamour-Browsers'  with: [spec requires: #('Glamour-Core')];
			package: 'Glamour-Tests-Core' ;
			package: 'Glamour-Morphic-Widgets';
			package: 'Glamour-Morphic-Renderer' with: [spec requires: #('Glamour-Morphic-Widgets' 'Glamour-Core')];
			package: 'Glamour-Morphic-Theme';
			package: 'Glamour-Tests-Morphic' with: [spec requires: #('Glamour-Morphic-Renderer')];
			package: 'Glamour-Examples' with: [spec requires: #('Glamour-Tools')];
			package: 'Glamour-Tools' with: [spec requires: #('Glamour-Core')];
			package: 'Rubric' with: [spec repository: 'http://www.smalltalkhub.com/mc/AlainPlantec/Rubric/main'];
			package: 'Glamour-Rubric-Presentations' with: [spec requires: 'Rubric'];
			package: 'Glamour-Roassal-Presentations' with: [spec requires: 'Roassal for Glamour'];
			package: 'Glamour-Mondrian-Presentations' with: [spec requires: 'Mondrian for Glamour'];
			package: 'Glamour-Magritte-Presentations' with: [spec requires: #('Magritte3')];
			package: 'Glamour-EyeSee-Presentations' with: [spec requires: 'EyeSee for Glamour'];
			package: 'Glamour-GraphET-Presentations' with: [spec requires: 'Graph-ET'];
			package: 'Glamour-Tests-Mondrian' with: [spec requires: #('Glamour-Tests-Morphic' 'Glamour-Mondrian-Presentations')];
			package: 'Glamour-Tests-Rubric' with: [spec requires: #('Glamour-Tests-Morphic' 'Glamour-Rubric-Presentations')];
			package: 'Glamour-Tests-Roassal' with: [spec requires: #('Glamour-Tests-Morphic' 'Glamour-Roassal-Presentations')];
			package: 'Glamour-Tests-EyeSee' with: [spec requires: #('Glamour-Tests-Morphic' 'Glamour-EyeSee-Presentations')];
			package: 'Glamour-Tests-Resources'].

	spec for: #squeakCommon do: [ 
		spec
			package: 'CollectionExtensions' with: [spec repository: 'http://www.smalltalkhub.com/mc/Moose/CollectionExtensions/main'].
		spec
			package: 'Glamour-Tools' with: [spec requires: #('Glamour-Core' 'CollectionExtensions')].
		 ].

	spec for: #common do: [ 
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
		spec group: 'Roassal' with: #(
						'Glamour-Roassal-Presentations').				
		spec group: 'Extras' with: #(
						'Glamour-Mondrian-Presentations'
						'Glamour-Magritte-Presentations'
						'Glamour-EyeSee-Presentations'
						'Glamour-Roassal-Presentations'
						'Glamour-Rubric-Presentations').
		spec group: 'Core Tests' with: #(
						'Glamour-Tests-Core'
						'Glamour-Examples'
						'Glamour-Tests-Resources'
						'Glamour-Tests-Morphic'). 
		spec group: 'Tests' with: #(
						'Glamour-Tests-Core'
						'Glamour-Examples'
						'Glamour-Tests-Morphic'
						'Glamour-Tests-Mondrian'
						'Glamour-Tests-EyeSee'
						'Glamour-Tests-Roassal'
						'Glamour-Tests-Rubric'
						'Glamour-Tests-Resources'). 
		spec
			project: 'Mondrian for Glamour' with: [
				spec
					className: 'ConfigurationOfMondrian';
					file: 'ConfigurationOfMondrian';
					version: #development;
					repository: 'http://www.smalltalkhub.com/mc/Moose/Mondrian/main' ].
		spec
			project: 'Roassal for Glamour' with: [
				spec
					className: 'ConfigurationOfRoassal';
					file: 'ConfigurationOfRoassal';
					version: #development;
					repository: 'http://www.smalltalkhub.com/mc/ObjectProfile/Roassal/main' ].
		spec
			project: 'EyeSee for Glamour' with: [
				spec
					className: 'ConfigurationOfEyeSee';
					file: 'ConfigurationOfEyeSee';
					version: #development;
					repository: 'http://www.smalltalkhub.com/mc/Moose/EyeSee/main' ].
		spec
			project: 'Graph-ET' with: [
				spec
					className: 'ConfigurationOfGraphET';
					file: 'ConfigurationOfGraphET';
					version: #development;
					repository: 'http://www.smalltalkhub.com/mc/ObjectProfile/GraphET/main' ].
		spec project: 'Magritte3' with: [
			spec
					className: 'ConfigurationOfMagritte3';
					file: 'ConfigurationOfMagritte3';
					version: #development;
					repository: 'http://www.smalltalkhub.com/mc/Magritte/Magritte3/main';
					loads: #('Magritte-Model' 'Magritte-Tests-Model' 'Magritte-Morph') ] ]
]

{ #category : #baselines }
ConfigurationOfGlamour >> baseline26: spec [ 
	<version: '2.6-baseline'>
	
	spec for: #common do: [
		spec blessing: #baseline.
		spec description: 'Removed Mondrian'.
		spec repository: 'http://www.smalltalkhub.com/mc/Moose/Glamour/main'.
		spec 
			package: 'Glamour-Announcements' ;
			package: 'Glamour-Helpers' ;
			package: 'Glamour-Core' with: [spec requires: #('Glamour-Helpers' 'Glamour-Announcements')];
			package: 'Glamour-Presentations'  with: [spec requires: #('Glamour-Core')];
			package: 'Glamour-Browsers'  with: [spec requires: #('Glamour-Core')];
			package: 'Glamour-Tests-Core' ;
			package: 'Glamour-Morphic-Widgets';
			package: 'Glamour-Morphic-Renderer' with: [spec requires: #('Glamour-Morphic-Widgets' 'Glamour-Core')];
			package: 'Glamour-Morphic-Theme';
			package: 'Glamour-Tests-Morphic' with: [spec requires: #('Glamour-Morphic-Renderer')];
			package: 'Glamour-Examples' with: [spec requires: #('Glamour-Tools')];
			package: 'Glamour-Tools' with: [spec requires: #('Glamour-Core')];
			package: 'Rubric' with: [spec repository: 'http://www.smalltalkhub.com/mc/AlainPlantec/Rubric/main'];
			package: 'Glamour-Rubric-Presentations' with: [spec requires: 'Rubric'];
			package: 'Glamour-Roassal-Presentations' with: [spec requires: 'Roassal for Glamour'];
			package: 'Glamour-Magritte-Presentations' with: [spec requires: #('Magritte3')];
			package: 'Glamour-EyeSee-Presentations' with: [spec requires: 'EyeSee for Glamour'];
			package: 'Glamour-GraphET-Presentations' with: [spec requires: 'Graph-ET'];
			package: 'Glamour-Tests-Rubric' with: [spec requires: #('Glamour-Tests-Morphic' 'Glamour-Rubric-Presentations')];
			package: 'Glamour-Tests-Roassal' with: [spec requires: #('Glamour-Tests-Morphic' 'Glamour-Roassal-Presentations')];
			package: 'Glamour-Tests-EyeSee' with: [spec requires: #('Glamour-Tests-Morphic' 'Glamour-EyeSee-Presentations')];
			package: 'Glamour-Tests-Resources'].

	spec for: #squeakCommon do: [ 
		spec
			package: 'CollectionExtensions' with: [spec repository: 'http://www.smalltalkhub.com/mc/Moose/CollectionExtensions/main'].
		spec
			package: 'Glamour-Tools' with: [spec requires: #('Glamour-Core' 'CollectionExtensions')].
		 ].

	spec for: #common do: [ 
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
		spec group: 'Roassal' with: #(
						'Glamour-Roassal-Presentations').				
		spec group: 'Extras' with: #(
						'Glamour-Magritte-Presentations'
						'Glamour-EyeSee-Presentations'
						'Glamour-Roassal-Presentations'
						'Glamour-Rubric-Presentations').
		spec group: 'Core Tests' with: #(
						'Glamour-Tests-Core'
						'Glamour-Examples'
						'Glamour-Tests-Resources'
						'Glamour-Tests-Morphic'). 
		spec group: 'Tests' with: #(
						'Glamour-Tests-Core'
						'Glamour-Examples'
						'Glamour-Tests-Morphic'
						'Glamour-Tests-EyeSee'
						'Glamour-Tests-Roassal'
						'Glamour-Tests-Rubric'
						'Glamour-Tests-Resources'). 
		spec
			project: 'Roassal for Glamour' with: [
				spec
					className: 'ConfigurationOfRoassal';
					file: 'ConfigurationOfRoassal';
					version: #development;
					repository: 'http://www.smalltalkhub.com/mc/ObjectProfile/Roassal/main' ].
		spec
			project: 'EyeSee for Glamour' with: [
				spec
					className: 'ConfigurationOfEyeSee';
					file: 'ConfigurationOfEyeSee';
					version: #development;
					repository: 'http://www.smalltalkhub.com/mc/Moose/EyeSee/main' ].
		spec
			project: 'Graph-ET' with: [
				spec
					className: 'ConfigurationOfGraphET';
					file: 'ConfigurationOfGraphET';
					version: #development;
					repository: 'http://www.smalltalkhub.com/mc/ObjectProfile/GraphET/main' ].
		spec project: 'Magritte3' with: [
			spec
					className: 'ConfigurationOfMagritte3';
					file: 'ConfigurationOfMagritte3';
					version: #development;
					repository: 'http://www.smalltalkhub.com/mc/Magritte/Magritte3/main';
					loads: #('Magritte-Model' 'Magritte-Tests-Model' 'Magritte-Morph') ] ]
]

{ #category : #baselines }
ConfigurationOfGlamour >> baseline27: spec [ 
	<version: '2.7-baseline'>
	
	spec for: #common do: [
		spec blessing: #baseline.
		spec description: 'Pharo 3.0'.
		spec repository: 'http://www.smalltalkhub.com/mc/Moose/Glamour/main'.
		spec 
			package: 'Glamour-Announcements' ;
			package: 'Glamour-Helpers' ;
			package: 'Glamour-Core' with: [spec requires: #('Glamour-Helpers' 'Glamour-Announcements')];
			package: 'Glamour-Presentations'  with: [spec requires: #('Glamour-Core')];
			package: 'Glamour-Browsers'  with: [spec requires: #('Glamour-Core')];
			package: 'Glamour-Tests-Core' ;
			package: 'Glamour-Morphic-Widgets' with: [spec requires: 'Spotlight2'];
			package: 'Glamour-Morphic-Renderer' with: [spec requires: #('Glamour-Morphic-Widgets' 'Glamour-Core')];
			package: 'Glamour-Morphic-Theme';
			package: 'Glamour-Tests-Morphic' with: [spec requires: #('Glamour-Morphic-Renderer')];
			package: 'Glamour-Examples' with: [spec requires: #('Glamour-Tools')];
			package: 'Glamour-Tools' with: [spec requires: #('Glamour-Core')];
			package: 'Rubric' with: [spec repository: 'http://www.smalltalkhub.com/mc/AlainPlantec/Rubric/main'];
			package: 'Glamour-Rubric-Presentations' with: [spec requires: 'Rubric'];
			package: 'Glamour-Roassal-Presentations' with: [spec requires: #('Roassal for Glamour' 'Roassal2 for Glamour')];
			package: 'Glamour-Magritte-Presentations' with: [spec requires: #('Magritte3')];
			package: 'Glamour-EyeSee-Presentations' with: [spec requires: 'EyeSee for Glamour'];
			package: 'Glamour-GraphET-Presentations' with: [spec requires: #('Graph-ET' 'Glamour-Tools')];
			package: 'Glamour-Tests-Rubric' with: [spec requires: #('Glamour-Tests-Morphic' 'Glamour-Rubric-Presentations')];
			package: 'Glamour-Tests-Roassal' with: [spec requires: #('Glamour-Tests-Morphic' 'Glamour-Roassal-Presentations')];
			package: 'Glamour-Tests-EyeSee' with: [spec requires: #('Glamour-Tests-Morphic' 'Glamour-EyeSee-Presentations')];
			package: 'Glamour-Tests-Resources'].

	spec for: #squeakCommon do: [ 
		spec
			package: 'CollectionExtensions' with: [spec repository: 'http://www.smalltalkhub.com/mc/Moose/CollectionExtensions/main'].
		spec
			package: 'Glamour-Tools' with: [spec requires: #('Glamour-Core' 'CollectionExtensions')].
		 ].

	spec for: #common do: [ 
		spec group: 'Core' with: #(
						'Glamour-Announcements'
						'Glamour-Helpers'
						'Glamour-Core'
						'Glamour-Presentations'
						'Glamour-Browsers'
						'Glamour-Examples'
						'Glamour-Tools'
						'Glamour-Rubric-Presentations').
		spec group: 'Morphic' with: #(
						'Glamour-Morphic-Renderer'
						'Glamour-Morphic-Theme').
		spec group: 'Roassal' with: #(
						'Glamour-Roassal-Presentations'
						'Glamour-GraphET-Presentations').				
		spec group: 'Extras' with: #(
						'Glamour-Magritte-Presentations'
						'Glamour-EyeSee-Presentations'
						'Glamour-Roassal-Presentations').
		spec group: 'Core Tests' with: #(
						'Glamour-Tests-Core'
						'Glamour-Examples'
						'Glamour-Tests-Resources'
						'Glamour-Tests-Morphic'). 
		spec group: 'Tests' with: #(
						'Glamour-Tests-Core'
						'Glamour-Examples'
						'Glamour-Tests-Morphic'
						'Glamour-Tests-EyeSee'
						'Glamour-Tests-Roassal'
						'Glamour-Tests-Rubric'
						'Glamour-Tests-Resources'). 
		spec
			project: 'Roassal for Glamour' with: [
				spec
					className: 'ConfigurationOfRoassal';
					file: 'ConfigurationOfRoassal';
					version: #development;
					repository: 'http://www.smalltalkhub.com/mc/ObjectProfile/Roassal/main' ].
		spec
			project: 'Roassal2 for Glamour' with: [
				spec
					className: 'ConfigurationOfRoassal2';
					file: 'ConfigurationOfRoassal2';
					version: #development;
					repository: 'http://www.smalltalkhub.com/mc/ObjectProfile/Roassal2/main' ].
		spec
			project: 'EyeSee for Glamour' with: [
				spec
					className: 'ConfigurationOfEyeSee';
					file: 'ConfigurationOfEyeSee';
					version: #development;
					repository: 'http://www.smalltalkhub.com/mc/Moose/EyeSee/main' ].
		spec
			project: 'Graph-ET' with: [
				spec
					className: 'ConfigurationOfGraphET';
					file: 'ConfigurationOfGraphET';
					version: #development;
					repository: 'http://www.smalltalkhub.com/mc/ObjectProfile/GraphET/main' ].
		spec project: 'Magritte3' with: [
			spec
					className: 'ConfigurationOfMagritte3';
					file: 'ConfigurationOfMagritte3';
					version: #development;
					repository: 'http://www.smalltalkhub.com/mc/Magritte/Magritte3/main';
					loads: #('Magritte-Model' 'Magritte-Tests-Model' 'Magritte-Morph') ].
		spec project: 'Spotlight2' with: [ 
			spec className: 'ConfigurationOfSpotlight2';
			file: 'ConfigurationOfSpotlight2';
			version: #development;
			repository: 'http://www.smalltalkhub.com/mc/PharoExtras/Spotlight2/main' ] ]
]

{ #category : #baselines }
ConfigurationOfGlamour >> baseline28: spec [ 
	<version: '2.8-baseline'>
	
	spec for: #common do: [
		spec blessing: #baseline.
		spec description: 'Pharo 3.0'.
		spec repository: 'http://www.smalltalkhub.com/mc/Moose/Glamour/main'.
		spec 
			package: 'Glamour-Announcements' ;
			package: 'Glamour-Helpers' ;
			package: 'Glamour-Core' with: [spec requires: #('Glamour-Helpers' 'Glamour-Announcements')];
			package: 'Glamour-Presentations'  with: [spec requires: #('Glamour-Core')];
			package: 'Glamour-Browsers'  with: [spec requires: #('Glamour-Core')];
			package: 'Glamour-Tests-Core' ;
			package: 'Glamour-Morphic-Widgets' with: [spec requires: 'Spotlight2'];
			package: 'Glamour-Morphic-Renderer' with: [spec requires: #('Glamour-Morphic-Widgets' 'Glamour-Core')];
			package: 'Glamour-Morphic-Theme';
			package: 'Glamour-Tests-Morphic' with: [spec requires: #('Glamour-Morphic-Renderer')];
			package: 'Glamour-Examples' with: [spec requires: #('Glamour-Tools')];
			package: 'Glamour-Tools' with: [spec requires: #('Glamour-Core')];
			package: 'Rubric' with: [spec repository: 'http://www.smalltalkhub.com/mc/AlainPlantec/Rubric/main'];
			package: 'Glamour-Rubric-Presentations' with: [spec requires: 'Rubric'];
			package: 'Glamour-Roassal-Presentations' with: [spec requires: #('Roassal for Glamour' 'Glamour-Morphic-Renderer')];
			package: 'Glamour-Roassal2-Presentations' with: [spec requires: #('Roassal2 for Glamour' 'Glamour-Morphic-Renderer')];
			package: 'Glamour-Magritte-Presentations' with: [spec requires: #('Magritte3')];
			package: 'Glamour-EyeSee-Presentations' with: [spec requires: 'EyeSee for Glamour'];
			package: 'Glamour-GraphET-Presentations' with: [spec requires: #('Graph-ET' 'Glamour-Tools')];
			package: 'Glamour-Tests-Rubric' with: [spec requires: #('Glamour-Tests-Morphic' 'Glamour-Rubric-Presentations')];
			package: 'Glamour-Tests-Roassal' with: [spec requires: #('Glamour-Tests-Morphic' 'Glamour-Roassal-Presentations')];
			package: 'Glamour-Tests-EyeSee' with: [spec requires: #('Glamour-Tests-Morphic' 'Glamour-EyeSee-Presentations')];
			package: 'Glamour-Tests-Resources'].

	spec for: #squeakCommon do: [ 
		spec
			package: 'CollectionExtensions' with: [spec repository: 'http://www.smalltalkhub.com/mc/Moose/CollectionExtensions/main'].
		spec
			package: 'Glamour-Tools' with: [spec requires: #('Glamour-Core' 'CollectionExtensions')].
		 ].

	spec for: #common do: [ 
		spec group: 'Core' with: #(
						'Glamour-Announcements'
						'Glamour-Helpers'
						'Glamour-Core'
						'Glamour-Presentations'
						'Glamour-Browsers'
						'Glamour-Examples'
						'Glamour-Tools'
						'Glamour-Rubric-Presentations').
		spec group: 'Morphic' with: #(
						'Glamour-Morphic-Renderer'
						'Glamour-Morphic-Theme').
		spec group: 'Roassal' with: #(
						'Glamour-Roassal-Presentations'
						'Glamour-GraphET-Presentations').				
		spec group: 'Roassal2' with: #(
						'Glamour-Roassal2-Presentations').
		spec group: 'Extras' with: #(
						'Glamour-Magritte-Presentations'
						'Glamour-EyeSee-Presentations'
						'Glamour-Roassal-Presentations').
		spec group: 'Core Tests' with: #(
						'Glamour-Tests-Core'
						'Glamour-Examples'
						'Glamour-Tests-Resources'
						'Glamour-Tests-Morphic'). 
		spec group: 'Tests' with: #(
						'Glamour-Tests-Core'
						'Glamour-Examples'
						'Glamour-Tests-Morphic'
						'Glamour-Tests-EyeSee'
						'Glamour-Tests-Roassal'
						'Glamour-Tests-Rubric'
						'Glamour-Tests-Resources'). 
		spec
			project: 'Roassal for Glamour' with: [
				spec
					className: 'ConfigurationOfRoassal';
					file: 'ConfigurationOfRoassal';
					version: #development;
					repository: 'http://www.smalltalkhub.com/mc/ObjectProfile/Roassal/main' ].
		spec
			project: 'Roassal2 for Glamour' with: [
				spec
					className: 'ConfigurationOfRoassal2';
					file: 'ConfigurationOfRoassal2';
					version: #development;
					repository: 'http://www.smalltalkhub.com/mc/ObjectProfile/Roassal2/main' ].
		spec
			project: 'EyeSee for Glamour' with: [
				spec
					className: 'ConfigurationOfEyeSee';
					file: 'ConfigurationOfEyeSee';
					version: #development;
					repository: 'http://www.smalltalkhub.com/mc/Moose/EyeSee/main' ].
		spec
			project: 'Graph-ET' with: [
				spec
					className: 'ConfigurationOfGraphET';
					file: 'ConfigurationOfGraphET';
					version: #development;
					repository: 'http://www.smalltalkhub.com/mc/ObjectProfile/GraphET/main' ].
		spec
			project: 'Graph-ET2' with: [
				spec
					className: 'ConfigurationOfGraphET2';
					file: 'ConfigurationOfGraphET2';
					version: #development;
					repository: 'http://www.smalltalkhub.com/mc/ObjectProfile/GraphET2/main' ].
		spec project: 'Magritte3' with: [
			spec
					className: 'ConfigurationOfMagritte3';
					file: 'ConfigurationOfMagritte3';
					version: #development;
					repository: 'http://www.smalltalkhub.com/mc/Magritte/Magritte3/main';
					loads: #('Magritte-Model' 'Magritte-Tests-Model' 'Magritte-Morph' 'Magritte-Pharo-Model') ].
		spec project: 'Spotlight2' with: [ 
			spec 
					className: 'ConfigurationOfSpotlight2';
					file: 'ConfigurationOfSpotlight2';
					version: #development;
					repository: 'http://www.smalltalkhub.com/mc/PharoExtras/Spotlight2/main' ]
	]
]

{ #category : #baselines }
ConfigurationOfGlamour >> baseline291: spec [ 
	<version: '2.91-baseline'>
	
	spec for: #common do: [
		spec blessing: #baseline.
		spec description: 'CoreExtras'.
		spec repository: 'http://www.smalltalkhub.com/mc/Moose/Glamour/main'.
		spec 
			package: 'Glamour-Announcements' ;
			package: 'Glamour-Helpers' ;
			package: 'Glamour-Core' with: [spec requires: #('Glamour-Helpers' 'Glamour-Announcements')];
			package: 'Glamour-Presentations'  with: [spec requires: #('Glamour-Core')];
			package: 'Glamour-Browsers'  with: [spec requires: #('Glamour-Core')];
			package: 'Glamour-Tests-Core' ;
			package: 'Glamour-Morphic-Widgets' with: [spec requires: #('Rubric')];
			package: 'Glamour-Morphic-Renderer' with: [spec requires: #('Glamour-Morphic-Widgets' 'Glamour-Core')];
			package: 'Glamour-Morphic-Pager' with: [spec requires: #('Glamour-Morphic-Renderer')];
			package: 'Glamour-Morphic-Theme' with: [spec requires: 'Rubric'];
			package: 'Glamour-Tests-Morphic' with: [spec requires: #('Glamour-Morphic-Renderer')];
			package: 'Glamour-Examples' with: [spec requires: #('Glamour-Core')];
			package: 'Glamour-Examples-Extras' with: [spec requires: #('Glamour-Examples' 'Glamour-Tools')];
			package: 'Glamour-Tools' with: [spec requires: #('Glamour-Examples')];
			package: 'Glamour-Rubric-Presentations' with: [spec requires: #('Rubric' 'Glamour-Presentations')];
			package: 'Glamour-Roassal-Presentations' with: [spec requires: #('Roassal for Glamour' 'Glamour-Morphic-Renderer' 'Glamour-Tools' 'Glamour-Examples-Extras')];
			package: 'Glamour-Roassal2-Presentations' with: [spec requires: #('Roassal2 for Glamour' 'Glamour-Morphic-Renderer' 'Glamour-Tools')];
			package: 'Glamour-Magritte-Presentations' with: [spec requires: #('Magritte3')];			
			package: 'Glamour-GraphET-Presentations' with: [spec requires: #('Graph-ET' 'Glamour-Tools')];
			package: 'Glamour-Tests-Rubric' with: [spec requires: #('Glamour-Tests-Morphic' 'Glamour-Rubric-Presentations')];
			package: 'Glamour-Tests-Roassal' with: [spec requires: #('Glamour-Tests-Morphic' 'Glamour-Roassal-Presentations')];
			package: 'Glamour-Tests-Resources'].

	spec for: #squeakCommon do: [ 
		spec
			package: 'CollectionExtensions' with: [spec repository: 'http://www.smalltalkhub.com/mc/Moose/CollectionExtensions/main'].
		spec
			package: 'Glamour-Tools' with: [spec requires: #('Glamour-Core' 'CollectionExtensions')].
		 ].

	spec for: #common do: [ 
		spec group: 'Core' with: #(
						'Glamour-Announcements'
						'Glamour-Helpers'
						'Glamour-Core'
						'Glamour-Presentations'
						'Glamour-Browsers'
						'Glamour-Examples'
						'Glamour-Rubric-Presentations').
		spec group: 'CoreExtras' with: #(
						'Glamour-Tools'
						'Glamour-Examples-Extras').
		spec group: 'Morphic' with: #(
						'Glamour-Morphic-Renderer'
						'Glamour-Morphic-Theme'
						'Glamour-Morphic-Pager').
		spec group: 'Roassal' with: #(
						'Glamour-Roassal-Presentations'
						'Glamour-GraphET-Presentations').				
		spec group: 'Roassal2' with: #(
						'Glamour-Roassal2-Presentations').
		spec group: 'Extras' with: #(
						'Glamour-Magritte-Presentations'
						'Glamour-Roassal-Presentations').
		spec group: 'Core Tests' with: #(
						'Glamour-Tests-Core'
						'Glamour-Examples'
						'Glamour-Tests-Resources'
						'Glamour-Tests-Morphic'
						'Glamour-Tests-Rubric'). 
		spec group: 'Tests' with: #(
						'Glamour-Tests-Core'
						'Glamour-Examples'
						'Glamour-Tests-Morphic'
						'Glamour-Tests-Roassal'
						'Glamour-Tests-Rubric'
						'Glamour-Tests-Resources'). 
		spec
			project: 'Roassal for Glamour' with: [
				spec
					className: 'ConfigurationOfRoassal';
					file: 'ConfigurationOfRoassal';
					version: #development;
					repository: 'http://www.smalltalkhub.com/mc/ObjectProfile/Roassal/main' ].
		spec
			project: 'Roassal2 for Glamour' with: [
				spec
					className: 'ConfigurationOfRoassal2';
					file: 'ConfigurationOfRoassal2';
					version: #development;
					repository: 'http://www.smalltalkhub.com/mc/ObjectProfile/Roassal2/main' ].
		spec
			project: 'Graph-ET' with: [
				spec
					className: 'ConfigurationOfGraphET';
					file: 'ConfigurationOfGraphET';
					version: #development;
					repository: 'http://www.smalltalkhub.com/mc/ObjectProfile/GraphET/main' ].
		spec
			project: 'Graph-ET2' with: [
				spec
					className: 'ConfigurationOfGraphET2';
					file: 'ConfigurationOfGraphET2';
					version: #development;
					repository: 'http://www.smalltalkhub.com/mc/ObjectProfile/GraphET2/main' ].
		spec project: 'Magritte3' with: [
			spec
					className: 'ConfigurationOfMagritte3';
					file: 'ConfigurationOfMagritte3';
					version: #development;
					repository: 'http://www.smalltalkhub.com/mc/Magritte/Magritte3/main';
					loads: #('Magritte-Model' 'Magritte-Tests-Model' 'Magritte-Morph' 'Magritte-Pharo-Model') ].
		spec project: 'Rubric' with: [ 
			spec 
					className: 'ConfigurationOfRubric';
					file: 'ConfigurationOfRubric';
					version: '1.1';
					repository: 'http://www.smalltalkhub.com/mc/AlainPlantec/Rubric/main' ]
	]
]

{ #category : #baselines }
ConfigurationOfGlamour >> baseline292: spec [ 
	<version: '2.92-baseline'>
	
	spec for: #common do: [
		spec blessing: #baseline.
		spec description: 'CoreExtras'.
		spec repository: 'http://www.smalltalkhub.com/mc/Moose/Glamour/main'.
		spec 
			package: 'Glamour-Announcements' ;
			package: 'Glamour-Helpers' ;
			package: 'Glamour-Core' with: [spec requires: #('Glamour-Helpers' 'Glamour-Announcements')];
			package: 'Glamour-Presentations'  with: [spec requires: #('Glamour-Core')];
			package: 'Glamour-Browsers'  with: [spec requires: #('Glamour-Core')];
			package: 'Glamour-Tests-Core' ;
			package: 'Glamour-Morphic-Widgets' with: [spec requires: #('Rubric')];
			package: 'Glamour-Morphic-Renderer' with: [spec requires: #('Glamour-Morphic-Widgets' 'Glamour-Core')];
			package: 'Glamour-Morphic-Pager' with: [spec requires: #('Glamour-Morphic-Renderer')];
			package: 'Glamour-Morphic-Theme' with: [spec requires: 'Rubric'];
			package: 'Glamour-Tests-Morphic' with: [spec requires: #('Glamour-Morphic-Renderer')];
			package: 'Glamour-Examples' with: [spec requires: #('Glamour-Core')];
			package: 'Glamour-Examples-Extras' with: [spec requires: #('Glamour-Examples' 'Glamour-Tools')];
			package: 'Glamour-Tools' with: [spec requires: #('Glamour-Examples')];
			package: 'Glamour-Rubric-Presentations' with: [spec requires: #('Rubric' 'Glamour-Presentations')];
			package: 'Glamour-Roassal-Presentations' with: [spec requires: #('Roassal for Glamour' 'Glamour-Morphic-Renderer' 'Glamour-Tools' 'Glamour-Examples-Extras')];
			package: 'Glamour-Roassal2-Presentations' with: [spec requires: #('Roassal2 for Glamour' 'Glamour-Morphic-Renderer' 'Glamour-Tools')];
			package: 'Glamour-Magritte-Presentations' with: [spec requires: #('Magritte3')];			
			package: 'Glamour-Tests-Rubric' with: [spec requires: #('Glamour-Tests-Morphic' 'Glamour-Rubric-Presentations')];
			package: 'Glamour-Tests-Roassal' with: [spec requires: #('Glamour-Tests-Morphic' 'Glamour-Roassal-Presentations')];
			package: 'Glamour-Tests-Resources'].

	spec for: #squeakCommon do: [ 
		spec
			package: 'CollectionExtensions' with: [spec repository: 'http://www.smalltalkhub.com/mc/Moose/CollectionExtensions/main'].
		spec
			package: 'Glamour-Tools' with: [spec requires: #('Glamour-Core' 'CollectionExtensions')].
		 ].

	spec for: #common do: [ 
		spec group: 'Core' with: #(
						'Glamour-Announcements'
						'Glamour-Helpers'
						'Glamour-Core'
						'Glamour-Presentations'
						'Glamour-Browsers'
						'Glamour-Examples'
						'Glamour-Rubric-Presentations').
		spec group: 'CoreExtras' with: #(
						'Glamour-Tools'
						'Glamour-Examples-Extras').
		spec group: 'Morphic' with: #(
						'Glamour-Morphic-Renderer'
						'Glamour-Morphic-Theme'
						'Glamour-Morphic-Pager').
		spec group: 'Roassal' with: #(
						'Glamour-Roassal-Presentations').				
		spec group: 'Roassal2' with: #(
						'Glamour-Roassal2-Presentations').
		spec group: 'Extras' with: #(
						'Glamour-Magritte-Presentations'
						'Glamour-Roassal-Presentations').
		spec group: 'Core Tests' with: #(
						'Glamour-Tests-Core'
						'Glamour-Examples'
						'Glamour-Tests-Resources'
						'Glamour-Tests-Morphic'
						'Glamour-Tests-Rubric'). 
		spec group: 'Tests' with: #(
						'Glamour-Tests-Core'
						'Glamour-Examples'
						'Glamour-Tests-Morphic'
						'Glamour-Tests-Roassal'
						'Glamour-Tests-Rubric'
						'Glamour-Tests-Resources'). 
		spec
			project: 'Roassal for Glamour' with: [
				spec
					className: 'ConfigurationOfRoassal';
					file: 'ConfigurationOfRoassal';
					version: #development;
					repository: 'http://www.smalltalkhub.com/mc/ObjectProfile/Roassal/main' ].
		spec
			project: 'Roassal2 for Glamour' with: [
				spec
					className: 'ConfigurationOfRoassal2';
					file: 'ConfigurationOfRoassal2';
					version: #development;
					repository: 'http://www.smalltalkhub.com/mc/ObjectProfile/Roassal2/main' ].
		spec
			project: 'Graph-ET2' with: [
				spec
					className: 'ConfigurationOfGraphET2';
					file: 'ConfigurationOfGraphET2';
					version: #development;
					repository: 'http://www.smalltalkhub.com/mc/ObjectProfile/GraphET2/main' ].
		spec project: 'Magritte3' with: [
			spec
					className: 'ConfigurationOfMagritte3';
					file: 'ConfigurationOfMagritte3';
					version: #development;
					repository: 'http://www.smalltalkhub.com/mc/Magritte/Magritte3/main';
					loads: #('Magritte-Model' 'Magritte-Tests-Model' 'Magritte-Morph' 'Magritte-Pharo-Model') ].
		spec project: 'Rubric' with: [ 
			spec 
					className: 'ConfigurationOfRubric';
					file: 'ConfigurationOfRubric';
					version: '1.1';
					repository: 'http://www.smalltalkhub.com/mc/AlainPlantec/Rubric/main' ]
	]
]

{ #category : #baselines }
ConfigurationOfGlamour >> baseline29: spec [ 
	<version: '2.9-baseline'>
	
	spec for: #common do: [
		spec blessing: #baseline.
		spec description: 'Pager'.
		spec repository: 'http://www.smalltalkhub.com/mc/Moose/Glamour/main'.
		spec 
			package: 'Glamour-Announcements' ;
			package: 'Glamour-Helpers' ;
			package: 'Glamour-Core' with: [spec requires: #('Glamour-Helpers' 'Glamour-Announcements')];
			package: 'Glamour-Presentations'  with: [spec requires: #('Glamour-Core')];
			package: 'Glamour-Browsers'  with: [spec requires: #('Glamour-Core')];
			package: 'Glamour-Tests-Core' ;
			package: 'Glamour-Morphic-Widgets' with: [spec requires: #('Rubric')];
			package: 'Glamour-Morphic-Renderer' with: [spec requires: #('Glamour-Morphic-Widgets' 'Glamour-Core')];
			package: 'Glamour-Morphic-Pager' with: [spec requires: #('Glamour-Morphic-Renderer')];
			package: 'Glamour-Morphic-Theme' with: [spec requires: 'Rubric'];
			package: 'Glamour-Tests-Morphic' with: [spec requires: #('Glamour-Morphic-Renderer')];
			package: 'Glamour-Examples' with: [spec requires: #('Glamour-Tools')];
			package: 'Glamour-Tools' with: [spec requires: #('Glamour-Core')];
			package: 'Glamour-Rubric-Presentations' with: [spec requires: #('Rubric' 'Glamour-Presentations')];
			package: 'Glamour-Roassal-Presentations' with: [spec requires: #('Roassal for Glamour' 'Glamour-Morphic-Renderer' 'Glamour-Tools')];
			package: 'Glamour-Roassal2-Presentations' with: [spec requires: #('Roassal2 for Glamour' 'Glamour-Morphic-Renderer' 'Glamour-Tools')];
			package: 'Glamour-Magritte-Presentations' with: [spec requires: #('Magritte3')];			
			package: 'Glamour-GraphET-Presentations' with: [spec requires: #('Graph-ET' 'Glamour-Tools')];
			package: 'Glamour-Tests-Rubric' with: [spec requires: #('Glamour-Tests-Morphic' 'Glamour-Rubric-Presentations')];
			package: 'Glamour-Tests-Roassal' with: [spec requires: #('Glamour-Tests-Morphic' 'Glamour-Roassal-Presentations')];
			package: 'Glamour-Tests-Resources'].

	spec for: #squeakCommon do: [ 
		spec
			package: 'CollectionExtensions' with: [spec repository: 'http://www.smalltalkhub.com/mc/Moose/CollectionExtensions/main'].
		spec
			package: 'Glamour-Tools' with: [spec requires: #('Glamour-Core' 'CollectionExtensions')].
		 ].

	spec for: #common do: [ 
		spec group: 'Core' with: #(
						'Glamour-Announcements'
						'Glamour-Helpers'
						'Glamour-Core'
						'Glamour-Presentations'
						'Glamour-Browsers'
						'Glamour-Examples'
						'Glamour-Tools'
						'Glamour-Rubric-Presentations').
		spec group: 'Morphic' with: #(
						'Glamour-Morphic-Renderer'
						'Glamour-Morphic-Theme'
						'Glamour-Morphic-Pager').
		spec group: 'Roassal' with: #(
						'Glamour-Roassal-Presentations'
						'Glamour-GraphET-Presentations').				
		spec group: 'Roassal2' with: #(
						'Glamour-Roassal2-Presentations').
		spec group: 'Extras' with: #(
						'Glamour-Magritte-Presentations'
						'Glamour-Roassal-Presentations').
		spec group: 'Core Tests' with: #(
						'Glamour-Tests-Core'
						'Glamour-Examples'
						'Glamour-Tests-Resources'
						'Glamour-Tests-Morphic'). 
		spec group: 'Tests' with: #(
						'Glamour-Tests-Core'
						'Glamour-Examples'
						'Glamour-Tests-Morphic'
						'Glamour-Tests-Roassal'
						'Glamour-Tests-Rubric'
						'Glamour-Tests-Resources'). 
		spec
			project: 'Roassal for Glamour' with: [
				spec
					className: 'ConfigurationOfRoassal';
					file: 'ConfigurationOfRoassal';
					version: #development;
					repository: 'http://www.smalltalkhub.com/mc/ObjectProfile/Roassal/main' ].
		spec
			project: 'Roassal2 for Glamour' with: [
				spec
					className: 'ConfigurationOfRoassal2';
					file: 'ConfigurationOfRoassal2';
					version: #development;
					repository: 'http://www.smalltalkhub.com/mc/ObjectProfile/Roassal2/main' ].
		spec
			project: 'Graph-ET' with: [
				spec
					className: 'ConfigurationOfGraphET';
					file: 'ConfigurationOfGraphET';
					version: #development;
					repository: 'http://www.smalltalkhub.com/mc/ObjectProfile/GraphET/main' ].
		spec
			project: 'Graph-ET2' with: [
				spec
					className: 'ConfigurationOfGraphET2';
					file: 'ConfigurationOfGraphET2';
					version: #development;
					repository: 'http://www.smalltalkhub.com/mc/ObjectProfile/GraphET2/main' ].
		spec project: 'Magritte3' with: [
			spec
					className: 'ConfigurationOfMagritte3';
					file: 'ConfigurationOfMagritte3';
					version: #development;
					repository: 'http://www.smalltalkhub.com/mc/Magritte/Magritte3/main';
					loads: #('Magritte-Model' 'Magritte-Tests-Model' 'Magritte-Morph' 'Magritte-Pharo-Model') ].
		spec project: 'Rubric' with: [ 
			spec 
					className: 'ConfigurationOfRubric';
					file: 'ConfigurationOfRubric';
					version: #development;
					repository: 'http://www.smalltalkhub.com/mc/AlainPlantec/Rubric/main' ]
	]
]

{ #category : #'symbolic versions' }
ConfigurationOfGlamour >> development: spec [
	<symbolicVersion: #'development'>

	spec for: #'common' version: '2.92-baseline'.
	spec for: #'pharo2.x' version: '2.6-baseline'.

]

{ #category : #snapshots }
ConfigurationOfGlamour >> populateSpec: aSpec with: list [
	"generated by Snapshotcello
	
	creates a spec object for the package and the version stored in the list"
	
	list do: [:each |
		aSpec package: each third with: [
			aSpec file: (each first  copyUpToLast: $. ).
			aSpec repository: each second ] ]
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

{ #category : #snapshots }
ConfigurationOfGlamour >> snapshot1 [
	"generated by Snapshotcello"

	^ #( 
		#('ConfigurationOfGraphET-AlexandreBergel.6.mcz'  'http://www.smalltalkhub.com/mc/ObjectProfile/GraphET/main/'  'ConfigurationOfGraphET' ) 
		#('ConfigurationOfEyeSee-TudorGirba.29.mcz'  'http://www.smalltalkhub.com/mc/Moose/EyeSee/main/'  'ConfigurationOfEyeSee' ) 
		#('ConfigurationOfMondrian-StephaneDucasse.375.mcz'  'http://www.smalltalkhub.com/mc/Moose/Mondrian/main/'  'ConfigurationOfMondrian' ) 
		#('ConfigurationOfMagritte3-TudorGirba.47.mcz'  'http://www.smalltalkhub.com/mc/Magritte/Magritte3/main/'  'ConfigurationOfMagritte3' ) 
		#('ConfigurationOfRoassal-TudorGirba.1186.mcz'  'http://www.smalltalkhub.com/mc/ObjectProfile/Roassal/main/'  'ConfigurationOfRoassal' ) 
		#('Glamour-Announcements-TudorGirba.7.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Announcements' ) 
		#('Glamour-Helpers-TudorGirba.32.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Helpers' ) 
		#('Glamour-Core-AndreiChis.256.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Core' ) 
		#('Glamour-Presentations-AndreiChis.121.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Presentations' ) 
		#('Glamour-Browsers-AndreiChis.101.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Browsers' ) 
		#('Glamour-Tests-Core-AndreiChis.90.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Tests-Core' ) 
		#('Glamour-Morphic-Widgets-TudorGirba.68.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Morphic-Widgets' ) 
		#('Glamour-Morphic-Renderer-AndreiChis.208.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Morphic-Renderer' ) 
		#('Glamour-Morphic-Theme-TudorGirba.78.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Morphic-Theme' ) 
		#('Glamour-Tests-Morphic-TudorGirba.108.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Tests-Morphic' ) 
		#('Glamour-Tools-TudorGirba.66.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Tools' ) 
		#('Glamour-Examples-TudorGirba.262.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Examples' ) 
		#('Rubric-AlainPlantec.82.mcz'  'http://www.smalltalkhub.com/mc/AlainPlantec/Rubric/main/'  'Rubric' ) 
		#('Glamour-Rubric-Presentations-StephanEggermont.7.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Rubric-Presentations' ) 
		#('Glamour-Tests-Rubric-TudorGirba.8.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Tests-Rubric' ) 
		#('Glamour-Tests-Resources-AndreiChis.3.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Tests-Resources' ) 
		#('ConfigurationOfProfStef-ChristopheDemarey.48.mcz'  'http://www.smalltalkhub.com/mc/PharoExtras/ProfStef/main/'  'ConfigurationOfProfStef' ) 
		#('ConfigurationOfHealthReportProducer-TudorGirba.23.mcz'  'http://www.smalltalkhub.com/mc/Moose/HealthReportProducer/main/'  'ConfigurationOfHealthReportProducer' ) 
		#('ConfigurationOfShapeST80-TudorGirba.8.mcz'  'http://www.smalltalkhub.com/mc/Moose/ShapeST80/main/'  'ConfigurationOfShapeST80' ) 
		#('ShapeST80-TudorGirba.2.mcz'  'http://www.smalltalkhub.com/mc/Moose/ShapeST80/main/'  'ShapeST80' ) 
		#('ProfStef-Core-EstebanLorenzano.30.mcz'  'http://smalltalkhub.com/mc/PharoExtras/ProfStef/main/'  'ProfStef-Core' ) 
		#('ProfStef-Tests-LaurentLaffont.16.mcz'  'http://smalltalkhub.com/mc/PharoExtras/ProfStef/main/'  'ProfStef-Tests' ) 
		#('ProfStef-Help-AlainPantec.7.mcz'  'http://smalltalkhub.com/mc/PharoExtras/ProfStef/main/'  'ProfStef-Help' ) 
		#('ConfigurationOfXMLParser-DamienCassou.14.mcz'  'http://www.smalltalkhub.com/mc/PharoExtras/XMLParser/main/'  'ConfigurationOfXMLParser' ) 
		#('ConfigurationOfOrderPreservingDictionary-StephaneDucasse.3.mcz'  'http://smalltalkhub.com/mc/PharoExtras/OrderPreservingDictionary/main/'  'ConfigurationOfOrderPreservingDictionary' ) 
		#('ConfigurationOfBitmapCharacterSet-StephaneDucasse.2.mcz'  'http://www.smalltalkhub.com/mc/PharoExtras/BitmapCharacterSet/main/'  'ConfigurationOfBitmapCharacterSet' ) 
		#('ConfigurationOfXMLWriter-StephaneDucasse.39.mcz'  'http://www.smalltalkhub.com/mc/PharoExtras/XMLWriter/main/'  'ConfigurationOfXMLWriter' ) 
		#('Collections-OrderPreservingDictionary-JAA.7.mcz'  'http://smalltalkhub.com/mc/PharoExtras/OrderPreservingDictionary/main/'  'Collections-OrderPreservingDictionary' ) 
		#('XML-Writer-Core-CamilloBruni.2.mcz'  'http://smalltalkhub.com/mc/Pharo/XMLWriter/main/'  'XML-Writer-Core' ) 
		#('Collections-BitmapCharacterSet-JAA.5.mcz'  'http://smalltalkhub.com/mc/PharoExtras/BitmapCharacterSet/main/'  'Collections-BitmapCharacterSet' ) 
		#('XML-Parser-DamienCassou.143.mcz'  'http://www.smalltalkhub.com/mc/PharoExtras/XMLParser/main/'  'XML-Parser' ) 
		#('XML-Tests-Parser-StephaneDucasse.15.mcz'  'http://www.smalltalkhub.com/mc/PharoExtras/XMLParser/main/'  'XML-Tests-Parser' ) 
		#('HealthReportProducer-Ivan_Rojas.16.mcz'  'http://www.squeaksource.com/HealthReportProducer/'  'HealthReportProducer' ) 
		#('Nile-Base-DamienCassou.81.mcz'  'http://www.squeaksource.com/Nile/'  'Nile-Base' ) 
		#('Mondrian-Core-TudorGirba.86.mcz'  'http://www.smalltalkhub.com/mc/Moose/Mondrian/main/'  'Mondrian-Core' ) 
		#('Mondrian-Layouts-AnneEtien.27.mcz'  'http://www.smalltalkhub.com/mc/Moose/Mondrian/main/'  'Mondrian-Layouts' ) 
		#('Mondrian-Help-TudorGirba.15.mcz'  'http://www.smalltalkhub.com/mc/Moose/Mondrian/main/'  'Mondrian-Help' ) 
		#('Mondrian-Tests-AndreHora.113.mcz'  'http://www.smalltalkhub.com/mc/Moose/Mondrian/main/'  'Mondrian-Tests' ) 
		#('Mondrian-Pharo-Tests-AndreHora.14.mcz'  'http://www.smalltalkhub.com/mc/Moose/Mondrian/main/'  'Mondrian-Pharo-Tests' ) 
		#('Mondrian-Shapes-AlexandreBergel.39.mcz'  'http://www.smalltalkhub.com/mc/Moose/Mondrian/main/'  'Mondrian-Shapes' ) 
		#('Mondrian-ComplexShape-AlexandreBergel.33.mcz'  'http://www.smalltalkhub.com/mc/Moose/Mondrian/main/'  'Mondrian-ComplexShape' ) 
		#('Mondrian-Events-TudorGirba.25.mcz'  'http://www.smalltalkhub.com/mc/Moose/Mondrian/main/'  'Mondrian-Events' ) 
		#('Mondrian-Util-AndreHora.12.mcz'  'http://www.smalltalkhub.com/mc/Moose/Mondrian/main/'  'Mondrian-Util' ) 
		#('Mondrian-Normalizers-TudorGirba.5.mcz'  'http://www.smalltalkhub.com/mc/Moose/Mondrian/main/'  'Mondrian-Normalizers' ) 
		#('Mondrian-Example-JurajKubelka.48.mcz'  'http://www.smalltalkhub.com/mc/Moose/Mondrian/main/'  'Mondrian-Example' ) 
		#('Mondrian-ShapeVisitor-TudorGirba.6.mcz'  'http://www.smalltalkhub.com/mc/Moose/Mondrian/main/'  'Mondrian-ShapeVisitor' ) 
		#('Mondrian-Pharo-Morphic-JurajKubelka.41.mcz'  'http://www.smalltalkhub.com/mc/Moose/Mondrian/main/'  'Mondrian-Pharo-Morphic' ) 
		#('Mondrian-Visitor-AndreHora.33.mcz'  'http://www.smalltalkhub.com/mc/Moose/Mondrian/main/'  'Mondrian-Visitor' ) 
		#('Mondrian-FADELayout-AndreHora.5.mcz'  'http://www.smalltalkhub.com/mc/Moose/Mondrian/main/'  'Mondrian-FADELayout' ) 
		#('Glamour-Mondrian-Presentations-TudorGirba.4.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Mondrian-Presentations' ) 
		#('Glamour-Tests-Mondrian-AndreHora.7.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Tests-Mondrian' ) 
		#('Roassal-AlexandreBergel.668.mcz'  'http://www.smalltalkhub.com/mc/ObjectProfile/Roassal/main/'  'Roassal' ) 
		#('RoassalMorphic-AlexandreBergel.146.mcz'  'http://www.smalltalkhub.com/mc/ObjectProfile/Roassal/main/'  'RoassalMorphic' ) 
		#('Glamour-Roassal-Presentations-TudorGirba.14.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Roassal-Presentations' ) 
		#('Glamour-Tests-Roassal-AndreHora.5.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Tests-Roassal' ) 
		#('ConfigurationOfShapeST80-TudorGirba.8.mcz'  'http://www.smalltalkhub.com/mc/Moose/ShapeST80/main/'  'ConfigurationOfShapeST80' ) 
		#('EyeSee-Events-TudorGirba.11.mcz'  'http://www.smalltalkhub.com/mc/Moose/EyeSee/main/'  'EyeSee-Events' ) 
		#('EyeSee-Axis-AndreHora.16.mcz'  'http://www.smalltalkhub.com/mc/Moose/EyeSee/main/'  'EyeSee-Axis' ) 
		#('EyeSee-Tests-Core-AndreHora.68.mcz'  'http://www.smalltalkhub.com/mc/Moose/EyeSee/main/'  'EyeSee-Tests-Core' ) 
		#('EyeSee-Support-usmanbhatti.9.mcz'  'http://www.smalltalkhub.com/mc/Moose/EyeSee/main/'  'EyeSee-Support' ) 
		#('ShapeST80-TudorGirba.2.mcz'  'http://www.smalltalkhub.com/mc/Moose/ShapeST80/main/'  'ShapeST80' ) 
		#('EyeSee-Core-AnneEtien.106.mcz'  'http://www.smalltalkhub.com/mc/Moose/EyeSee/main/'  'EyeSee-Core' ) 
		#('Glamour-EyeSee-Presentations-TudorGirba.4.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-EyeSee-Presentations' ) 
		#('Glamour-Tests-EyeSee-TudorGirba.8.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Tests-EyeSee' ) 
		#('ConfigurationOfRoassal-TudorGirba.1186.mcz'  'http://www.smalltalkhub.com/mc/ObjectProfile/Roassal/main/'  'ConfigurationOfRoassal' ) 
		#('Graph-ET-TudorGirba.76.mcz'  'http://smalltalkhub.com/mc/ObjectProfile/GraphET/main/'  'Graph-ET' ) 
		#('Roassal-AlexandreBergel.668.mcz'  'http://www.smalltalkhub.com/mc/ObjectProfile/Roassal/main/'  'Roassal' ) 
		#('RoassalMorphic-AlexandreBergel.146.mcz'  'http://www.smalltalkhub.com/mc/ObjectProfile/Roassal/main/'  'RoassalMorphic' ) 
		#('Glamour-GraphET-Presentations-TudorGirba.3.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-GraphET-Presentations' ) 
		#('ConfigurationOfGrease-MattSpr.207.mcz'  'http://smalltalkhub.com/mc/Seaside/MetacelloConfigurations/main/'  'ConfigurationOfGrease' ) 
		#('Grease-Core-MattSpr.77.mcz'  'http://www.smalltalkhub.com/mc/Seaside/Seaside31/main/'  'Grease-Core' ) 
		#('Grease-Pharo20-Core-pmm.10.mcz'  'http://www.smalltalkhub.com/mc/Seaside/Seaside31/main/'  'Grease-Pharo20-Core' ) 
		#('Magritte-Model-SeanDeNigris.433.mcz'  'http://www.smalltalkhub.com/mc/Magritte/Magritte3/main/'  'Magritte-Model' ) 
		#('Magritte-Pharo-Model-DiegoLont.27.mcz'  'http://www.smalltalkhub.com/mc/Magritte/Magritte3/main/'  'Magritte-Pharo-Model' ) 
		#('Magritte-Tests-Model-DamienCassou.33.mcz'  'http://www.smalltalkhub.com/mc/Magritte/Magritte3/main/'  'Magritte-Tests-Model' ) 
		#('Magritte-Tests-Pharo-Model-lr.4.mcz'  'http://www.smalltalkhub.com/mc/Magritte/Magritte3/main/'  'Magritte-Tests-Pharo-Model' ) 
		#('Magritte-Morph-TudorGirba.70.mcz'  'http://www.smalltalkhub.com/mc/Magritte/Magritte3/main/'  'Magritte-Morph' ) 
		#('Glamour-Magritte-Presentations-TudorGirba.4.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Magritte-Presentations' ) 
	)
]

{ #category : #snapshots }
ConfigurationOfGlamour >> snapshot2 [
	"generated by Snapshotcello"

	^ #( 
		#('ConfigurationOfGraphET-TudorGirba.8.mcz'  'http://www.smalltalkhub.com/mc/ObjectProfile/GraphET/main/'  'ConfigurationOfGraphET' ) 
		#('ConfigurationOfEyeSee-TudorGirba.31.mcz'  'http://www.smalltalkhub.com/mc/Moose/EyeSee/main/'  'ConfigurationOfEyeSee' ) 
		#('ConfigurationOfMagritte3-DamienCassou.55.mcz'  'http://www.smalltalkhub.com/mc/Magritte/Magritte3/main/'  'ConfigurationOfMagritte3' ) 
		#('ConfigurationOfRoassal-TudorGirba.1191.mcz'  'http://www.smalltalkhub.com/mc/ObjectProfile/Roassal/main/'  'ConfigurationOfRoassal' ) 
		#('Glamour-Announcements-TudorGirba.7.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Announcements' ) 
		#('Glamour-Helpers-TudorGirba.34.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Helpers' ) 
		#('Glamour-Core-TudorGirba.258.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Core' ) 
		#('Glamour-Presentations-AndreiChis.121.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Presentations' ) 
		#('Glamour-Browsers-DiegoLont.103.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Browsers' ) 
		#('Glamour-Tests-Core-AndreiChis.90.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Tests-Core' ) 
		#('Glamour-Morphic-Widgets-TudorGirba.69.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Morphic-Widgets' ) 
		#('Glamour-Morphic-Renderer-TudorGirba.211.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Morphic-Renderer' ) 
		#('Glamour-Morphic-Theme-TudorGirba.79.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Morphic-Theme' ) 
		#('Glamour-Tests-Morphic-TudorGirba.108.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Tests-Morphic' ) 
		#('Rubric-Alainplantec.84.mcz'  'http://www.smalltalkhub.com/mc/AlainPlantec/Rubric/main/'  'Rubric' ) 
		#('Glamour-Rubric-Presentations-TudorGirba.8.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Rubric-Presentations' ) 
		#('Glamour-Tests-Rubric-TudorGirba.8.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Tests-Rubric' ) 
		#('Glamour-Tests-Resources-AndreiChis.3.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Tests-Resources' ) 
		#('Roassal-AlexandreBergel.702.mcz'  'http://www.smalltalkhub.com/mc/ObjectProfile/Roassal/main/'  'Roassal' ) 
		#('RoassalMorphic-AlexandreBergel.165.mcz'  'http://www.smalltalkhub.com/mc/ObjectProfile/Roassal/main/'  'RoassalMorphic' ) 
		#('RoassalExtras-RobertoMinelli.26.mcz'  'http://www.smalltalkhub.com/mc/ObjectProfile/Roassal/main/'  'RoassalExtras' ) 
		#('Glamour-Roassal-Presentations-TudorGirba.15.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Roassal-Presentations' ) 
		#('Glamour-Tests-Roassal-AndreHora.5.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Tests-Roassal' ) 
		#('ConfigurationOfShapeST80-TudorGirba.8.mcz'  'http://www.smalltalkhub.com/mc/Moose/ShapeST80/main/'  'ConfigurationOfShapeST80' ) 
		#('EyeSee-Events-TudorGirba.11.mcz'  'http://www.smalltalkhub.com/mc/Moose/EyeSee/main/'  'EyeSee-Events' ) 
		#('EyeSee-Axis-AndreHora.16.mcz'  'http://www.smalltalkhub.com/mc/Moose/EyeSee/main/'  'EyeSee-Axis' ) 
		#('EyeSee-Tests-Core-AndreHora.68.mcz'  'http://www.smalltalkhub.com/mc/Moose/EyeSee/main/'  'EyeSee-Tests-Core' ) 
		#('EyeSee-Support-usmanbhatti.9.mcz'  'http://www.smalltalkhub.com/mc/Moose/EyeSee/main/'  'EyeSee-Support' ) 
		#('ShapeST80-TudorGirba.2.mcz'  'http://www.smalltalkhub.com/mc/Moose/ShapeST80/main/'  'ShapeST80' ) 
		#('EyeSee-Core-AnneEtien.106.mcz'  'http://www.smalltalkhub.com/mc/Moose/EyeSee/main/'  'EyeSee-Core' ) 
		#('Glamour-EyeSee-Presentations-TudorGirba.5.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-EyeSee-Presentations' ) 
		#('Glamour-Tests-EyeSee-TudorGirba.8.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Tests-EyeSee' ) 
		#('ConfigurationOfRoassal-TudorGirba.1191.mcz'  'http://www.smalltalkhub.com/mc/ObjectProfile/Roassal/main/'  'ConfigurationOfRoassal' ) 
		#('Graph-ET-DanielAviv.84.mcz'  'http://smalltalkhub.com/mc/ObjectProfile/GraphET/main/'  'Graph-ET' ) 
		#('Roassal-AlexandreBergel.702.mcz'  'http://www.smalltalkhub.com/mc/ObjectProfile/Roassal/main/'  'Roassal' ) 
		#('RoassalMorphic-AlexandreBergel.165.mcz'  'http://www.smalltalkhub.com/mc/ObjectProfile/Roassal/main/'  'RoassalMorphic' ) 
		#('RoassalExtras-RobertoMinelli.26.mcz'  'http://www.smalltalkhub.com/mc/ObjectProfile/Roassal/main/'  'RoassalExtras' ) 
		#('Glamour-GraphET-Presentations-TudorGirba.3.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-GraphET-Presentations' ) 
		#('ConfigurationOfGrease-DamienCassou.234.mcz'  'http://smalltalkhub.com/mc/Seaside/MetacelloConfigurations/main/'  'ConfigurationOfGrease' ) 
		#('Grease-Core-pmm.82.mcz'  'http://www.smalltalkhub.com/mc/Seaside/Grease11/main/'  'Grease-Core' ) 
		#('Grease-Pharo20-Core-pmm.17.mcz'  'http://www.smalltalkhub.com/mc/Seaside/Grease11/main/'  'Grease-Pharo20-Core' ) 
		#('Magritte-Model-SeanDeNigris.433.mcz'  'http://www.smalltalkhub.com/mc/Magritte/Magritte3/main/'  'Magritte-Model' ) 
		#('Magritte-Pharo-Model-DiegoLont.27.mcz'  'http://www.smalltalkhub.com/mc/Magritte/Magritte3/main/'  'Magritte-Pharo-Model' ) 
		#('Magritte-Tests-Model-DamienCassou.33.mcz'  'http://www.smalltalkhub.com/mc/Magritte/Magritte3/main/'  'Magritte-Tests-Model' ) 
		#('Magritte-Tests-Pharo-Model-lr.4.mcz'  'http://www.smalltalkhub.com/mc/Magritte/Magritte3/main/'  'Magritte-Tests-Pharo-Model' ) 
		#('Magritte-Morph-TudorGirba.70.mcz'  'http://www.smalltalkhub.com/mc/Magritte/Magritte3/main/'  'Magritte-Morph' ) 
		#('Glamour-Magritte-Presentations-TudorGirba.4.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Magritte-Presentations' ) 
		#('CollectionExtensions-TudorGirba.34.mcz'  'http://www.smalltalkhub.com/mc/Moose/CollectionExtensions/main/'  'CollectionExtensions' ) 
		#('Glamour-Tools-TudorGirba.66.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Tools' ) 
		#('Glamour-Examples-TudorGirba.267.mcz'  'http://www.smalltalkhub.com/mc/Moose/Glamour/main/'  'Glamour-Examples' ) 
	)
]

{ #category : #'symbolic versions' }
ConfigurationOfGlamour >> stable: spec [
	<symbolicVersion: #'stable'>

	spec for: #'common' version: '2.1'.

	spec for: #'pharo1.3.x' version: '2.2'.

	spec for: #'pharo1.4.x' version: '2.4'.

	spec for: #'pharo2.x' version: '2.6-snapshot'.

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

{ #category : #versions }
ConfigurationOfGlamour >> version24: spec [
	<version: '2.4' imports: #('2.3-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'release'.
		spec description: '-updated to Pharo 1.4 
-using latest versions'.
		spec author: 'EstebanLorenzano'.
		spec timestamp: '6/3/2012 13:40'.
		spec 
			project: 'Mondrian for Glamour' with: '2.157';
			project: 'EyeSee for Glamour' with: '0.9.8';
			project: 'Grease' with: #'stable'.
		spec 
			package: 'Glamour-Announcements' with: 'Glamour-Announcements-TudorGirba.7';
			package: 'Glamour-Helpers' with: 'Glamour-Helpers-TudorGirba.32';
			package: 'Glamour-Core' with: 'Glamour-Core-TudorGirba.230';
			package: 'Glamour-Presentations' with: 'Glamour-Presentations-EstebanLorenzano.111';
			package: 'Glamour-Browsers' with: 'Glamour-Browsers-TudorGirba.93';
			package: 'Glamour-Tests-Core' with: 'Glamour-Tests-Core-TudorGirba.73';
			package: 'Glamour-Morphic-Widgets' with: 'Glamour-Morphic-Widgets-TudorGirba.52';
			package: 'Glamour-Morphic-Renderer' with: 'Glamour-Morphic-Renderer-TudorGirba.159';
			package: 'Glamour-Morphic-Theme' with: 'Glamour-Morphic-Theme-TudorGirba.60';
			package: 'Glamour-Tests-Morphic' with: 'Glamour-Tests-Morphic-TudorGirba.92';
			package: 'Glamour-Examples' with: 'Glamour-Examples-TudorGirba.239';
			package: 'Glamour-Tools' with: 'Glamour-Tools-TudorGirba.55';
			package: 'Magritte-Model' with: 'Magritte-Model-AvO.408';
			package: 'Magritte-Tests-Model' with: 'Magritte-Tests-Model-AvO.17';
			package: 'Magritte-Morph' with: 'Magritte-Morph-EstebanLorenzano.57';
			package: 'Magritte-Pharo-Model' with: 'Magritte-Pharo-Model-lr.22';
			package: 'Glamour-Mondrian-Presentations' with: 'Glamour-Mondrian-Presentations-TudorGirba.4';
			package: 'Glamour-Magritte-Presentations' with: 'Glamour-Magritte-Presentations-BenComan.3';
			package: 'Glamour-EyeSee-Presentations' with: 'Glamour-EyeSee-Presentations-AndreHora.2';
			package: 'Glamour-Tests-Mondrian' with: 'Glamour-Tests-Mondrian-TudorGirba.5';
			package: 'Glamour-Tests-EyeSee' with: 'Glamour-Tests-EyeSee-AndreHora.6' ].
	spec for: #squeakCommon do: [ 
		spec 
			package: 'CollectionExtensions' with: 'CollectionExtensions-TudorGirba.32' ].

]

{ #category : #'snapshot versions' }
ConfigurationOfGlamour >> version25snapshot: spec [
	"generated by Snapshotcello"
	<version: '2.5-snapshot'>

	spec for: #common do: [
		self populateSpec: spec with: self snapshot1 ].
	spec for: #squeakCommon do: [ 
		spec
			package: 'CollectionExtensions' with: 'CollectionExtensions-TudorGirba.34.mcz' ]
]

{ #category : #'snapshot versions' }
ConfigurationOfGlamour >> version26snapshot: spec [
	"generated by Snapshotcello"
	<version: '2.6-snapshot'>

	spec for: #common do: [
		self populateSpec: spec with: self snapshot2 ]
]

{ #category : #versions }
ConfigurationOfGlamour >> version271: spec [
	<version: '2.71' imports: #('2.91-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 2.71'.
		spec author: 'AndreiChis'.
		spec timestamp: '9/30/2014 17:11'.
		spec 
			package: 'Glamour-Announcements' with: 'Glamour-Announcements-TudorGirba.7';
			package: 'Glamour-Helpers' with: 'Glamour-Helpers-AndreiChis.35';
			package: 'Glamour-Core' with: 'Glamour-Core-AndreiChis.277';
			package: 'Glamour-Presentations' with: 'Glamour-Presentations-TudorGirba.157';
			package: 'Glamour-Browsers' with: 'Glamour-Browsers-TudorGirba.104';
			package: 'Glamour-Tests-Core' with: 'Glamour-Tests-Core-AndreiChis.96';
			package: 'Glamour-Morphic-Widgets' with: [ 
				spec file: 'Glamour-Morphic-Widgets-AndreiChis.127'.
				spec repository: 'http://www.smalltalkhub.com/mc/PharoExtras/GTToolsIntegration/main' ];
			package: 'Glamour-Morphic-Renderer' with: [
				spec file: 'Glamour-Morphic-Renderer-AndreiChis.270'.
				spec repository: 'http://www.smalltalkhub.com/mc/PharoExtras/GTToolsIntegration/main' ];
			package: 'Glamour-Morphic-Pager' with: 'Glamour-Morphic-Pager-AliakseiSyrel.67';
			package: 'Glamour-Morphic-Theme' with: 'Glamour-Morphic-Theme-AndreiChis.180';
			package: 'Glamour-Tests-Morphic' with: 'Glamour-Tests-Morphic-AliakseiSyrel.115';
			package: 'Glamour-Examples' with: 'Glamour-Examples-StephanEggermont.284';
			package: 'Glamour-Rubric-Presentations' with: 'Glamour-Rubric-Presentations-AndreiChis.20';
			package: 'Glamour-Tests-Rubric' with: 'Glamour-Tests-Rubric-AndreiChis.13';
			package: 'Glamour-Tests-Resources' with: 'Glamour-Tests-Resources-AndreiChis.3'. ].

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 2.71'.
		spec author: 'AndreiChis'.
		spec timestamp: '9/30/2014 17:11'.
		spec 
			project: 'Rubric' with: '1.2'. ].

]

{ #category : #versions }
ConfigurationOfGlamour >> version272: spec [
	<version: '2.72' imports: #('2.91-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 2.72'.
		spec author: 'AndreiChis'.
		spec timestamp: '10/01/2014 14:31'.
		spec 
			package: 'Glamour-Announcements' with: 'Glamour-Announcements-TudorGirba.7';
			package: 'Glamour-Helpers' with: 'Glamour-Helpers-AndreiChis.35';
			package: 'Glamour-Core' with: 'Glamour-Core-AndreiChis.277';
			package: 'Glamour-Presentations' with: 'Glamour-Presentations-AndreiChis.158';
			package: 'Glamour-Browsers' with: 'Glamour-Browsers-TudorGirba.104';
			package: 'Glamour-Tests-Core' with: 'Glamour-Tests-Core-AndreiChis.96';
			package: 'Glamour-Morphic-Widgets' with: [ 
				spec file: 'Glamour-Morphic-Widgets-AndreiChis.128'.
				spec repository: 'http://www.smalltalkhub.com/mc/PharoExtras/GTToolsIntegration/main' ];
			package: 'Glamour-Morphic-Renderer' with: [
				spec file: 'Glamour-Morphic-Renderer-AndreiChis.272'.
				spec repository: 'http://www.smalltalkhub.com/mc/PharoExtras/GTToolsIntegration/main' ];
			package: 'Glamour-Morphic-Pager' with: 'Glamour-Morphic-Pager-AliakseiSyrel.67';
			package: 'Glamour-Morphic-Theme' with: 'Glamour-Morphic-Theme-AndreiChis.180';
			package: 'Glamour-Tests-Morphic' with: 'Glamour-Tests-Morphic-AliakseiSyrel.115';
			package: 'Glamour-Examples' with: 'Glamour-Examples-StephanEggermont.284';
			package: 'Glamour-Rubric-Presentations' with: 'Glamour-Rubric-Presentations-AndreiChis.23';
			package: 'Glamour-Tests-Rubric' with: 'Glamour-Tests-Rubric-AndreiChis.13';
			package: 'Glamour-Tests-Resources' with: 'Glamour-Tests-Resources-AndreiChis.3'. ].

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 2.72'.
		spec author: 'AndreiChis'.
		spec timestamp: '10/01/2014 14:31'.
		spec 
			project: 'Rubric' with: '1.2.1'. ].

]

{ #category : #versions }
ConfigurationOfGlamour >> version273: spec [
	<version: '2.73' imports: #('2.91-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 2.73'.
		spec author: 'AndreiChis'.
		spec timestamp: '10/02/2014 18:16'.
		spec 
			package: 'Glamour-Announcements' with: 'Glamour-Announcements-TudorGirba.7';
			package: 'Glamour-Helpers' with: 'Glamour-Helpers-AndreiChis.36';
			package: 'Glamour-Core' with: 'Glamour-Core-AndreiChis.277';
			package: 'Glamour-Presentations' with: 'Glamour-Presentations-AndreiChis.158';
			package: 'Glamour-Browsers' with: 'Glamour-Browsers-TudorGirba.104';
			package: 'Glamour-Tests-Core' with: 'Glamour-Tests-Core-AndreiChis.96';
			package: 'Glamour-Morphic-Widgets' with: [ 
				spec file: 'Glamour-Morphic-Widgets-AndreiChis.128'.
				spec repository: 'http://www.smalltalkhub.com/mc/PharoExtras/GTToolsIntegration/main' ];
			package: 'Glamour-Morphic-Renderer' with: [
				spec file: 'Glamour-Morphic-Renderer-AndreiChis.272'.
				spec repository: 'http://www.smalltalkhub.com/mc/PharoExtras/GTToolsIntegration/main' ];
			package: 'Glamour-Morphic-Pager' with: 'Glamour-Morphic-Pager-AliakseiSyrel.67';
			package: 'Glamour-Morphic-Theme' with: 'Glamour-Morphic-Theme-AndreiChis.181';
			package: 'Glamour-Tests-Morphic' with: 'Glamour-Tests-Morphic-AliakseiSyrel.115';
			package: 'Glamour-Examples' with: 'Glamour-Examples-StephanEggermont.284';
			package: 'Glamour-Rubric-Presentations' with: 'Glamour-Rubric-Presentations-AndreiChis.23';
			package: 'Glamour-Tests-Rubric' with: 'Glamour-Tests-Rubric-AndreiChis.14';
			package: 'Glamour-Tests-Resources' with: 'Glamour-Tests-Resources-AndreiChis.3'. ].

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 2.73'.
		spec author: 'AndreiChis'.
		spec timestamp: '10/02/2014 18:16'.
		spec 
			project: 'Rubric' with: '1.2.1'. ].

]

{ #category : #versions }
ConfigurationOfGlamour >> version274: spec [
	<version: '2.74' imports: #('2.91-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 2.74'.
		spec author: 'AndreiChis'.
		spec timestamp: '10/03/2014 17:06'.
		spec 
			package: 'Glamour-Announcements' with: 'Glamour-Announcements-TudorGirba.7';
			package: 'Glamour-Helpers' with: 'Glamour-Helpers-AndreiChis.36';
			package: 'Glamour-Core' with: 'Glamour-Core-AndreiChis.277';
			package: 'Glamour-Presentations' with: 'Glamour-Presentations-AndreiChis.158';
			package: 'Glamour-Browsers' with: 'Glamour-Browsers-TudorGirba.104';
			package: 'Glamour-Tests-Core' with: 'Glamour-Tests-Core-AndreiChis.96';
			package: 'Glamour-Morphic-Widgets' with: [ 
				spec file: 'Glamour-Morphic-Widgets-AndreiChis.128'.
				spec repository: 'http://www.smalltalkhub.com/mc/PharoExtras/GTToolsIntegration/main' ];
			package: 'Glamour-Morphic-Renderer' with: [
				spec file: 'Glamour-Morphic-Renderer-AndreiChis.272'.
				spec repository: 'http://www.smalltalkhub.com/mc/PharoExtras/GTToolsIntegration/main' ];
			package: 'Glamour-Morphic-Pager' with: 'Glamour-Morphic-Pager-AliakseiSyrel.67';
			package: 'Glamour-Morphic-Theme' with: 'Glamour-Morphic-Theme-AndreiChis.181';
			package: 'Glamour-Tests-Morphic' with: 'Glamour-Tests-Morphic-AliakseiSyrel.115';
			package: 'Glamour-Examples' with: 'Glamour-Examples-StephanEggermont.284';
			package: 'Glamour-Rubric-Presentations' with: 'Glamour-Rubric-Presentations-TudorGirba.24';
			package: 'Glamour-Tests-Rubric' with: 'Glamour-Tests-Rubric-AndreiChis.14';
			package: 'Glamour-Tests-Resources' with: 'Glamour-Tests-Resources-AndreiChis.3'. ].

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 2.74'.
		spec author: 'AndreiChis'.
		spec timestamp: '10/03/2014 17:06'.
		spec 
			project: 'Rubric' with: '1.2.2'. ].

]

{ #category : #versions }
ConfigurationOfGlamour >> version27: spec [
	<version: '2.7' imports: #('2.91-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 2.7'.
		spec author: 'AndreiChis'.
		spec timestamp: '9/22/2014 14:24'.
		spec 
			package: 'Glamour-Announcements' with: 'Glamour-Announcements-TudorGirba.7';
			package: 'Glamour-Helpers' with: 'Glamour-Helpers-AndreiChis.35';
			package: 'Glamour-Core' with: 'Glamour-Core-AndreiChis.277';
			package: 'Glamour-Presentations' with: 'Glamour-Presentations-TudorGirba.157';
			package: 'Glamour-Browsers' with: 'Glamour-Browsers-TudorGirba.104';
			package: 'Glamour-Tests-Core' with: 'Glamour-Tests-Core-AndreiChis.96';
			package: 'Glamour-Morphic-Widgets' with: 'Glamour-Morphic-Widgets-AliakseiSyrel.126';
			package: 'Glamour-Morphic-Renderer' with: 'Glamour-Morphic-Renderer-AndreiChis.269';
			package: 'Glamour-Morphic-Pager' with: 'Glamour-Morphic-Pager-AliakseiSyrel.67';
			package: 'Glamour-Morphic-Theme' with: 'Glamour-Morphic-Theme-AndreiChis.180';
			package: 'Glamour-Tests-Morphic' with: 'Glamour-Tests-Morphic-AliakseiSyrel.115';
			package: 'Glamour-Examples' with: 'Glamour-Examples-StephanEggermont.284';
			package: 'Glamour-Rubric-Presentations' with: 'Glamour-Rubric-Presentations-AndreiChis.20';
			package: 'Glamour-Tests-Rubric' with: 'Glamour-Tests-Rubric-AndreiChis.13';
			package: 'Glamour-Tests-Resources' with: 'Glamour-Tests-Resources-AndreiChis.3'. ].

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 2.7'.
		spec author: 'AndreiChis'.
		spec timestamp: '9/22/2014 14:24'.
		spec 
			project: 'Rubric' with: '1.2'. ].

]
