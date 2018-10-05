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

	browser transmit to: #classes; andShow: [ :composite |
		composite tree
			title: 'Tree';
			children: [ :class | class subclasses ].
		composite mondrian
			title: 'Mondrian';
			painting: [ :view :class |
				view nodeShape size: 10. 
				view nodes: class withAllSubclasses.
				view edgesFrom: #superclass. 
				view treeLayout ] ].
	browser transmit to: #selectors; from: #classes; andShow: [ :composite |
		composite list 
			display: [ :class | class selectors asSortedCollection ] ].

	browser transmit to: #source; from: #classes; from: #selectors; andShow: [ :composite |
		composite text
			title: 'Source';
			when: [ :class :selector | class notNil and: [ selector notNil ] ];
			display: [ :class :selector | class sourceCodeAt: selector ].
		composite text
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

	browser transmit to: #folders; andShow: [ :composite |
		composite tree 
			title: 'Folders'; 
			children: [ :directory | 
				directory directoryNames
					collect: [ :each | directory directoryNamed: each ] ];
			format: [ :directory | directory localName ] ].

	browser transmit to: #files; from: #folders; andShow: [ :composite |
		composite list
			display: [ :directory | 
				directory fileNames
					collect: [ :each | directory directoryNamed: each ] ];
			format: [ :directory | directory localName ] ].

	browser transmit to: #summary; from: #files; andShow: [ :composite |
		composite text 
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
	browser transmit to: #navigation; andShow: [ :composite |
		composite tree
			children: [ :page | page enumerator contents ];
			format: [ :page | page title ] ].
	browser transmit to: #map; andShow: [ :composite |
		composite mondrian
			painting: [ :view :page |
				view nodeShape: (MORectangleShape new height: [ :each | each document text size // 50 + 20 ]; width: [ :each | each document text size // 50 + 20 ]).
				view nodes: page root enumerator all.
				view edgesFrom: #parent.
				view treeLayout ]
	].
	browser transmit to: #editor; from: #navigation; andShow: [ :composite |
		composite magritte ].
	browser transmit to: #editor; from: #map; andShow: [ :composite |
		composite magritte ].
	^ browser 
]

{ #category : #others }
SGLOtherExamples >> stBrowserExamples [
	"
		self new stBrowserExamples openOn:  (RBBrowserEnvironment new forPackageNames: (Array with: 'Glamour'))
	"
	<glmBrowser: 'STBrowser' input: '(RBBrowserEnvironment new forPackageNames: #(''Glamour''))'>
	^ GLMSTBrowserExample new browser
]

{ #category : #accessing }
SGLOtherExamples >> title [
	^ 'Other Examples'
]
