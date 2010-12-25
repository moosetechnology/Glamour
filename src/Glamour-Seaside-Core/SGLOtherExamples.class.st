Class {
	#name : #SGLOtherExamples,
	#superclass : #SGLExamples,
	#category : #'Glamour-Seaside-Examples'
}

{ #category : #'instance creation' }
SGLOtherExamples class >> initialize [
	self registerAsApplication: 'glamour/otherExamples'
]

{ #category : #others }
SGLOtherExamples >> codeBrowser [
	"
		self new codeBrowser openOn: Collection
	"
	<glmBrowser: 'Code Browser' input: 'Collection'>
	| browser |
	browser := GLMTabulator new.   

	browser row: [ :row | row column: #classes; column: #selectors ].
	browser row: #source.

	browser showOn: #classes; using: [
		browser tree
			title: 'Tree';
			children: [ :class | class subclasses ].
		browser mondrian
			title: 'Mondrian';
			painting: [ :view :class |
				view nodeShape size: 10. 
				view nodes: class withAllSubclasses.
				view edgesFrom: #superclass. 
				view treeLayout ] ].
	browser showOn: #selectors; from: #classes; using: [
		browser list 
			display: [ :class | class selectors asSortedCollection ] ].

	browser showOn: #source; from: #classes; from: #selectors; using: [
		browser text
			title: 'Source';
			when: [ :class :selector | class notNil and: [ selector notNil ] ];
			display: [ :class :selector | class sourceCodeAt: selector ].
		browser text
			title: 'Comment';
			display: [ :class :selector | class comment ] ].
		
	^ browser
]

{ #category : #others }
SGLOtherExamples >> fileBrowser [
	"
		self new fileBrowser openOn: FileDirectory default containingDirectory 
	"
	<glmBrowser: 'File Browser' input: 'FileDirectory default containingDirectory '>
	| browser |
	browser := GLMTabulator new.
	browser 
		column: #folders;
		column: [ :column | column row: #files span: 2; row: #summary ] span: 2.

	browser showOn: #folders; using: [
		browser tree 
			title: 'Folders'; 
			children: [ :directory | 
				directory directoryNames
					collect: [ :each | directory directoryNamed: each ] ];
			format: [ :directory | directory localName ] ].

	browser showOn: #files; from: #folders; using: [
		browser list
			display: [ :directory | 
				directory fileNames
					collect: [ :each | directory directoryNamed: each ] ];
			format: [ :directory | directory localName ] ].

	browser showOn: #summary; from: #files; using: [
		browser text 
			title: 'Summary';
			display: [ :directory |
				| stream |
				stream := FileStream oldFileNamed: directory pathName.
				[ (stream binary; next: 2000) asString ] 
					ensure: [ stream close ] ] ].

	^ browser
]

{ #category : #others }
SGLOtherExamples >> pierBrowser [
	"
		self new pierBrowser openOn: PRKernel instances anyOne root
	"
	<glmBrowser: 'Pier Browser' input: 'PRKernel instances anyOne root'>
	| browser |
	browser := GLMTabulator new.
	browser column: [:c | c row: #navigation; row: #map ];
			column: #editor span: 4.
	browser showOn: #navigation; using: [
		browser tree
			children: [ :page | page enumerator contents ];
			format: [ :page | page title ] ].
	browser showOn: #map; using: [
		browser mondrian
			painting: [ :view :page |
				view nodeShape: (MORectangleShape new height: [ :each | each document text size // 50 + 20 ]; width: [ :each | each document text size // 50 + 20 ]).
				view nodes: page root enumerator all.
				view edgesFrom: #parent.
				view treeLayout ]
	].
	browser showOn: #editor; from: #navigation; using: [
		browser magritte ].
	browser showOn: #editor; from: #map; using: [
		browser magritte ].
	^ browser 
]

{ #category : #others }
SGLOtherExamples >> stBrowserExamples [
	"
		self new stBrowserExamples openOn:  (BrowserEnvironment new forPackageNames: (Array with: 'Glamour'))
	"
	<glmBrowser: 'STBrowser' input: '(BrowserEnvironment new forPackageNames: #(''Glamour''))'>
	^ GLMSTBrowserExample new browser
]

{ #category : #accessing }
SGLOtherExamples >> title [
	^ 'Other Examples'
]
