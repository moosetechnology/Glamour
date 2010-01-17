"
self open
"
Class {
	#name : #GLMMetacelloBrowser,
	#superclass : #GLMGlobalBrowserTemplate,
	#category : #'Glamour-Tools'
}

{ #category : #building }
GLMMetacelloBrowser >> buildBrowser [
	browser := GLMTabulator new.
	browser title: 'Metacello Browser'.
	browser column: #configs; column: #versions; column: #packages span: 2.
	self toConfigsAndShow.
	self toVersionsFromConfigsAndShow.
	self toPackagesFromVersionsAndShow.
	^ browser 
]

{ #category : #opening }
GLMMetacelloBrowser >> entity [ 
	^ (Object subclasses select: [:each | (each class canUnderstand: #isMetacelloConfig) and: [each isMetacelloConfig ] ]) sort: [:a :b | a name < b name]
]

{ #category : #private }
GLMMetacelloBrowser >> packageSpecHasNewerVersions: aPackageSpec [
	| copy |
	copy := aPackageSpec workingCopy.
	copy isNil ifTrue: [^ false ].
	^ copy possiblyNewerVersions notEmpty
]

{ #category : #private }
GLMMetacelloBrowser >> packageSpecNeedsSaving: aPackageSpec [
	| copy |
	copy := aPackageSpec workingCopy.
	copy isNil ifTrue: [^ false ].
	^ copy needsSaving
]

{ #category : #private }
GLMMetacelloBrowser >> shortNameOf: config [
	"self new shortNameOf: ConfigurationOfAlien"
	^ (config name beginsWith: 'ConfigurationOf') 
		ifTrue: [config name copyFrom: 'ConfigurationOf' size + 1 to: config name size ] 
		ifFalse: [config name]
]

{ #category : #building }
GLMMetacelloBrowser >> toConfigsAndShow [
	browser transmit to: #configs; andShow: [ :a |
		a title: 'Configurations'.
		a list
			act: [:list  | list selection browse ] entitled: 'Browse implementation';
			act: [:list  | list selection project inspect] entitled: 'Inspect';
			actions: [:list | 
				GLMOBCommandAdaptor new 
					actionsFrom: OBCmdMetacello subclasses 
					on: list selection 
					for: nil ] ]
]

{ #category : #building }
GLMMetacelloBrowser >> toPackagesFromVersionsAndShow [
	browser transmit to: #packages; from: #versions; andShow: [ :a |
		a title: [:version | version name ].
		a list
			title: 'Items';
			display: [:version | version spec packages packageSpecsInLoadOrder];
			format: [:packageSpec | ((packageSpec isKindOf: MetacelloPackageSpec) and: [
					self packageSpecNeedsSaving: packageSpec])
				ifTrue: [Text string: packageSpec name attribute: TextColor blue] ifFalse: [packageSpec name]] ;
			act: [:list  | list selection inspect] entitled: 'Inspect'.
 		a mondrian
			title: 'Dependencies';
			painting: [:view :version | self viewDependenciesOf: version on: view].
		a list
			title: 'Newer in repository?';
			display: [:version | version spec packages packageSpecsInLoadOrder];
			format: [:packageSpec | ((packageSpec isKindOf: MetacelloPackageSpec) and: [
					self packageSpecHasNewerVersions: packageSpec])
				ifTrue: [Text string: packageSpec name attribute: TextColor red] ifFalse: [packageSpec name]];
			act: [:list  | list selection inspect] entitled: 'Inspect'
	]
]

{ #category : #building }
GLMMetacelloBrowser >> toVersionsFromConfigsAndShow. [
	browser transmit to: #versions; from: #configs; andShow: [ :a |
		a title: [:config | self shortNameOf: config ].
		a list
			title: 'Versions';
			display: [:config | config project versions ];
			format: [:each | 
				([each isPossibleBaseline not] on: Error do: [true])
					ifTrue: [Text string: each versionNumber asString attribute: TextColor gray] 
					ifFalse: [each versionNumber asString] ];
			act: [:list  | list selection inspect] entitled: 'Inspect'.
		a mondrian
			title: 'Imports';
			painting: [:view :config | self viewVersionMapOf: config on: view]]
]

{ #category : #private }
GLMMetacelloBrowser >> viewDependenciesOf: version on: view [
	| all | 
	all := Dictionary new.
	version packages do: [:each | all at: each name put: each].
	version projects do: [:each | all at: each name put: each].
	view shape label text: [:each | each name ].
	view nodes: all values.
	view shape curvedLine.
	view edges: version packages from: [:eachPackage | all at: eachPackage name] toAll: [:eachPackage |
		eachPackage requires collect: [:each | all at: each ]].
	view horizontalDominanceTreeLayout
]

{ #category : #private }
GLMMetacelloBrowser >> viewVersionMapOf: configClass on: view [

	| prag1 prag2 nodes edges version imported |
	prag1 := Pragma allNamed: #version:imports: in: configClass.
	prag2 := Pragma allNamed: #version: in: configClass.
	nodes := Dictionary new.
	edges := OrderedCollection new.
	prag2 do: [:prag | 
		nodes at: (prag argumentAt: 1) put: (configClass project version: (prag argumentAt: 1)) ].
	prag1 do: [:prag | 
		version := nodes at: (prag argumentAt: 1) put: (configClass project version: (prag argumentAt: 1)).
		(prag argumentAt: 2) do: [:eachImportPrag |
			imported := nodes at: eachImportPrag ifAbsentPut: [configClass project version: eachImportPrag].
			edges add: version -> imported.
			]
		].
	view shape label text: [:each | each versionNumber printString].
	view nodes: nodes values.
	view edges: edges from: #key to: #value.
	view horizontalDominanceTreeLayout
]
