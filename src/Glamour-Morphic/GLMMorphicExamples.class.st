Class {
	#name : #GLMMorphicExamples,
	#superclass : #Object,
	#category : #'Glamour-Morphic'
}

{ #category : #private }
GLMMorphicExamples >> actionsFor: aPresentation [ 
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

{ #category : #'moose examples' }
GLMMorphicExamples >> mooseFinder [
	"
		self new mooseFinder openOn: MooseModel root
	"

	| browser pragmas |
	browser := GLMFinder new.
	
	browser list
		display: [:each | each entities];
		title: 'Group';
		whenKindOf: MooseGroup.
	browser list
		title: 'Entity';
		display:  [ :anObject | 
			pragmas := anObject class withAllSuperclasses flatCollect: [:each |
				Pragma allNamed: #navigation: in: each].
			(pragmas collect: [:each | anObject perform: each selector ])
				select: [ :each | each isCollection  and: [ each isEmpty not ] ].
		].
	browser mondrian
		painting: [ :view :each | each viewBlueprintOn: view ];
		title: 'Blueprint';
		whenKindOf: FAMIXClass.
	browser text
		display: #sourceText;
		title: 'Method Source';
		whenKindOf: FAMIXMethod.
	browser text
		display: #sourceText;
		title: 'Class Source';
		whenKindOf: FAMIXClass.
	browser text
		display: [:entity | 'self' ];
		title: 'Evaluator';
		update: #selection on: $o with: [ :text :entity | Compiler evaluate: text selectedText for: entity logged: false ];
		act: [ :text :entity | (Compiler evaluate: text selectedText for: entity logged: false) inspect ] on: $/.
	
	^ browser

]

{ #category : #'moose examples' }
GLMMorphicExamples >> moosePreviewFinder [
	"
		self new moosePreviewFinder openOn: MooseModel root
	"

	| browser |
	browser := GLMTableLayoutBrowser new.
	browser row: #visual; row: #finder; row: #textual.
	browser showOn: #finder; using: [
		browser custom: self mooseFinder.
	].
	browser showOn: #visual; from: #finder; using: [
		browser mondrian
			painting: [ :view :classes | classes viewSystemComplexityOn: view ];
			whenKindOf: FAMIXClassGroup.
	].
	browser showOn: #textual; from: #finder; using: [
		browser text
			display: [:element | element mooseName]
	].

	^ browser
]

{ #category : #'menu examples' }
GLMMorphicExamples >> multipleFinderWithSearch [
	"
		self new finderSearch openOn: ($a to: $z).
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
GLMMorphicExamples >> multipleTabs [
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

{ #category : #'st examples' }
GLMMorphicExamples >> objectFinder [
	"
		self new objectFinder openOn: self new objectFinder
	"

	| browser |
	browser := GLMFinder new.
	browser list
		title: 'Collection';
		when: [:each | each isCollection].
	browser list
		title: 'Object';
		display:  [ :anObject | anObject class allInstVarNames collect: [:iv | (anObject instVarNamed: iv) ] ];
		send: [ :anObject | anObject value ].
	browser text
		display: [:entity | 'self' ];
		title: 'Evaluator';
		update: #selection on: $o entitled: 'Open (o)' with: [ :text :entity | Compiler evaluate: text selectedText for: entity logged: false ];
		act: [ :text :entity | (Compiler evaluate: text selectedText for: entity logged: false) inspect ] on: $/ entitled: 'Inspect (/)'.
	
	^ browser
]

{ #category : #'pier examples' }
GLMMorphicExamples >> pierFinder [
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
GLMMorphicExamples >> pierTreeEditor [

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
GLMMorphicExamples >> simpleFinderWithMenu [
	"
		self new simpleMenu openOn: $z.
	"

	| finder |
	finder := GLMFinder new.
	finder list
			title: 'List';
			display: [:each | $a to: each];
			menu: [:list | self actionsFor: list ].
	^ finder
]

{ #category : #'st examples' }
GLMMorphicExamples >> stCodeBrowser [	
	"
		self new stCodeBrowser openOn: Smalltalk organization categories.
	"
	| browser |
	browser := GLMTableLayoutBrowser new.
	browser row: #navigation; row: #sourceCode.
	browser showOn: #navigation; using: [
		browser custom: self stCodeNavigator ].
	browser
		showOn: #sourceCode;
		from: #navigation->#selectedClass;
		from: #navigation->#selectedMethod;
		from: #navigation->#selectedClassCategory;
		using: [
			browser text
				title: 'Method source';
				act: [:pane | Transcript show: 'action d'; cr. ] on: $d entitled: 'some action'; 
				display: [ :class :method | class sourceCodeAt: method ];
				when: [ :class :method | class notNil & method notNil ].
			browser text
				title: 'Class definition';
				display: [ :class | class definition ];
				when: [:class | class notNil].
			browser text
				title: 'Class comment';
				display: [ :class | class comment];
				when: [:class | class notNil].
			browser mondrian
				title: 'System Complexity';
				painting: [ :view :class :method :cat | 
					view nodes: ((Smalltalk organization listAtCategoryNamed: cat) collect: [:className | Smalltalk classNamed: className]).
					view edgesFrom: [ :x | x superclass ].
					view treeLayout ];
				when: [ :class :method :cat | cat notNil ].
		].
	^ browser
]

{ #category : #'st examples' }
GLMMorphicExamples >> stCodeNavigator [	
	"
		| browser |
		browser := self new stCodeNavigator.
		browser openOn: Smalltalk organization categories.
		((browser paneNamed: #classCats) port: #selection) value: Smalltalk organization categories first
	"

	| browser |
	browser := GLMTableLayoutBrowser new.
	browser column: #classCats; column:#classes; column:#categories; column: #methods.

	browser showOn: #classCats; using: [
		browser list
			beMultiple;
			filterOn: [:text :list | list select: [:each | text match: each ]].
	].

	browser showOn: #classes; from: #classCats; using: [
		browser list
			display: [ :classCat |  (Smalltalk organization listAtCategoryNamed: classCat) collect: [:className | Smalltalk classNamed: className] ];
			when: [ :classCat | classCat notNil ].
	].

	browser showOn: #categories; from: #classes; using: [
		browser list display: [ :class | class organization categories ].
	].

	browser 
		showOn: #methods; from: #classes; from: #categories;
		using: [
			browser list
				display: [  :class :category | (class organization listAtCategoryNamed: category) asSortedCollection ];
				when: [  :class :category | class notNil and: [ category notNil ] ].
			browser list
				when: [ :class :category | class notNil and: [ category isNil ] ];
				display: [ :class :category | class selectors asSortedCollection ].
	].

	browser sendToOutside: #selectedClassCategory from: #classCats.
	browser sendToOutside: #selectedClass from: #classes.
	browser sendToOutside: #selectedMethod from: #methods.

	^browser
]

{ #category : #'menu examples' }
GLMMorphicExamples >> staticAndDynamicMenu [
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
