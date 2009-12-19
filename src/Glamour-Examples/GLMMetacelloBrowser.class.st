Class {
	#name : #GLMMetacelloBrowser,
	#superclass : #GLMBrowserTemplate,
	#category : #'Glamour-Examples'
}

{ #category : #building }
GLMMetacelloBrowser >> buildBrowser [
	browser := GLMTabulator new.
	browser title: 'Metacello Browser'.
	browser column: #configs; column: #versions; column: #packages span: 2.
	browser showOn: #configs; using: [
		browser list
			act: [:list  | list selection browse ] entitled: 'Browse implementation';
			act: [:list  | list selection project inspect] entitled: 'Inspect' ].
	browser showOn: #versions; from: #configs; using: [
		browser list
			title: 'Versions';
			display: [:config | config project versions ];
			format: [:each | each versionNumber asString ];
			act: [:list  | list selection inspect] entitled: 'Inspect'.
		browser mondrian
			title: 'Depdendencies';
			painting: [:view :config | self viewVersionMapOf: config on: view]].
	browser showOn: #packages; from: #versions; using: [
		browser list
			title: 'Items';
			display: [:version | version spec packages packageSpecsInLoadOrder];
			format: [:packageSpec | ((packageSpec isKindOf: MetacelloPackageSpec) and: [
					self packageSpecNeedsSaving: packageSpec])
				ifTrue: [Text string: packageSpec name attribute: TextColor blue] ifFalse: [packageSpec name]] ;
			act: [:list  | list selection inspect] entitled: 'Inspect'.
 		browser mondrian
			title: 'Dependencies';
			painting: [:view :version | self viewDependenciesOf: version on: view].
		browser list
			title: 'Newer in repository?';
			display: [:version | version spec packages packageSpecsInLoadOrder];
			format: [:packageSpec | ((packageSpec isKindOf: MetacelloPackageSpec) and: [
					self packageSpecHasNewerVersions: packageSpec])
				ifTrue: [Text string: packageSpec name attribute: TextColor red] ifFalse: [packageSpec name]];
			act: [:list  | list selection inspect] entitled: 'Inspect'
	].
	^ browser 
]

{ #category : #opening }
GLMMetacelloBrowser >> defaultEntity [ 
	^ (Object subclasses select: [:each | each isMetacelloConfig ]) sort: [:a :b | a name < b name]
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
