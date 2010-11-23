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
	Smalltalk at: #MetacelloProject ifAbsent: [
		Gofer new
				url: 'http://seaside.gemstone.com/ss/metacello';
				package: 'ConfigurationOfMetacello';
				load.
		(Smalltalk at: #ConfigurationOfMetacello) loadLatestVersion ]
]

{ #category : #'metacello tool support' }
ConfigurationOfGlamour class >> isMetacelloConfig [
	"Answer true and the Metacello tools will operate on you"
	
	^true
]

{ #category : #loading }
ConfigurationOfGlamour class >> loadDefault [
	(self project version: 'default') load
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
ConfigurationOfGlamour >> default: spec [ 
	<version: 'default'>
	
	spec for: #common do: [
		spec blessing: #baseline.
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
					version: '1.0-alpha9.1';
					repository: 'http://www.squeaksource.com/MetacelloRepository' ].
	]
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
