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
			display: [:config | config project versions ];
			format: [:each | each versionNumber asString ];
			act: [:list  | list selection inspect] entitled: 'Inspect' ].
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
