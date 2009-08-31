Class {
	#name : #GLMBasicExamples,
	#superclass : #Object,
	#category : #'Glamour-Examples'
}

{ #category : #private }
GLMBasicExamples >> actionsFor: aPresentation [ 
	|actions|
	aPresentation isMultiple 
							ifTrue: [actions := (aPresentation selection) ifNil: [OrderedCollection new]]
							ifFalse: [actions := OrderedCollection with: aPresentation selection ].
	^ actions collect: [:i |
					(GLMAction new) 
						action: [:each | Transcript show: 'Menu - Item', i printString; cr]; 
						title: 'Menu - Item', i printString; 
						yourself ]
]

{ #category : #others }
GLMBasicExamples >> fileExplorer [
	"
	self new fileExplorer openOn: FileDirectory default
	"

	| browser |
	browser := GLMTableLayoutBrowser new.
	browser 
		column: #folders;
		column: [ :col | col row: #files span: 2; row: #preview ] span: 2. 
	browser showOn: #folders; using: [
		browser tree 
			title: 'Folders'; 
			children: [ :fd | fd directoryNames collect: [ :each | FileDirectory on: fd pathName, fd pathNameDelimiter asString, each ] ]; 
			format: [ :folder | folder localName ] ].
	browser showOn: #files; from: #folders; using: [
		browser list 
			format: [ :fd | fd localName ]; 
			display: [ :fd | fd fileNames collect: [:each | FileDirectory on: fd pathName, fd pathNameDelimiter asString, each ] ] ].
	browser showOn: #preview; from: #files; using: [
		browser text
			display: [ :file | (FileStream readOnlyFileFullyNamed: file fullName) contents ] ].
	^ browser
]

{ #category : #others }
GLMBasicExamples >> fileFinder [
	"self new fileFinder openOn: FileDirectory default"

	| browser |
	browser := GLMFinder new.
	browser list
		display: [ :fd | fd entries collect: [:each | FileDirectory on: fd pathName, fd pathNameDelimiter asString, each name]];
		format: [ :fd | fd localName ];
		when: [ :fd | fd directoryEntry isDirectory ].
	browser text
		display: [ :fd | (FileStream readOnlyFileFullyNamed: fd fullName) contents ];
		when: [ :fd | fd directoryEntry isDirectory not ].
	^ browser
]

{ #category : #'menu examples' }
GLMBasicExamples >> multipleFinderWithSearch [
	"
		self new multipleFinderWithSearch openOn: ($a to: $z).
	"

	| finder |	
	finder := GLMFinder new.
	finder list
			beMultiple;
			actions: [:list | self actionsFor: list];
			searchOn: [:text :list | list select: (Compiler evaluate: '[:each | | entity | ', text, ']')].
	^ finder 
]

{ #category : #'tabs examples' }
GLMBasicExamples >> multipleTabs [
	"self new multipleTabs openOn: 1"
	
	| finder |
	finder := GLMFinder new.
	(1 to: 19) do: [:i | 
		finder text
			title: 'Text ', i printString;
			display: [:x | i printString].
	].
	^ finder
]

{ #category : #'pier examples' }
GLMBasicExamples >> pierFinder [
	"
		self new pierFinder openOn: PRKernel instances anyOne root.
	"
	| browser |
	browser := GLMFinder new.
	browser list
		display: [:each | each enumerator contents];
		format: [:each | each title];
		title: 'Navigation'.
	browser magritte title: 'Editor'.
	browser mondrian
			title: 'Tree';
			painting: [:view :each | 
				view nodeShape: (MORectangleShape withBorder height: [:x | x plainText size // 10]).
				view nodes: each enumerator everything contents.
				view edgesFrom: #parent.
				view treeLayout].
	^ browser
]

{ #category : #'pier examples' }
GLMBasicExamples >> pierTreeEditor [

	"
		self new pierTreeEditor openOn: PRKernel instances anyOne root.
	"

	| browser |
	browser := GLMTableLayoutBrowser new.
	browser column: #navigation; column: #editor span: 4.
	browser showOn: #navigation; using: [
		browser tree
			children: [:each | each enumerator contents];
			format: [:each | each title ];
			title: 'Navigation'.
	].
	browser showOn: #editor; from: #navigation; using: [
		browser magritte
			title: 'Editor'.
	].
	^ browser 
]

{ #category : #'menu examples' }
GLMBasicExamples >> simpleFinderWithMenu [
	"
		self new simpleFinderWithMenu openOn: $z.
	"

	| finder |
	finder := GLMFinder new.
	finder list
			title: 'List';
			display: [:each | $a to: each];
			actions: [:list | self actionsFor: list ].
	^ finder
]

{ #category : #'menu examples' }
GLMBasicExamples >> staticAndDynamicMenu [
	"
		self new staticAndDynamicMenu openOn: $z.
	"

	| finder |
	finder := GLMFinder new.
	finder list
			title: 'List';
			display: [:each | $a to: each];
			actions: [:list | self actionsFor: list ];
			act: [] entitled: 'Static action'.
	finder text
			title: 'Text';
			display: [:each | 'Character ', each asString];
			actions: [:text | OrderedCollection with: (GLMAction new title: 'Print selection'; action: [Transcript show: text selection]; yourself) ];
			act: [Transcript show: 'Text static action'] entitled: 'Static action'.
	^ finder
]
