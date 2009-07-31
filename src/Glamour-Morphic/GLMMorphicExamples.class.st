Class {
	#name : #GLMMorphicExamples,
	#superclass : #Object,
	#category : #'Glamour-Morphic'
}

{ #category : #examples }
GLMMorphicExamples >> demoBrowser [
	"
		self new demoBrowser openOn: Smalltalk organization categories
	"
	| browser |
	browser := GLMTableLayoutBrowser new.
	^ browser 
]

{ #category : #examples }
GLMMorphicExamples >> demoNavigator [
	"
		self new demoNavigator openOn: Smalltalk organization categories
	"
	| browser |
	browser := GLMTableLayoutBrowser new.
	^ browser 
]

{ #category : #examples }
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

{ #category : #examples }
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

{ #category : #examples }
GLMMorphicExamples >> multipleSelectionListWithMenu [

	"
		self new multipleSelectionListWithMenu openOn: #(1 2 3 4 5).
	"

	| finder |
	finder := GLMFinder new.
	finder list
			beMultiple;
			when: [:each | each isCollection];
			menu: [:list | GLMMenu actionsFor: list]..
	
	"finder list
			title: 'List';
			display: [:each | each to: each];
			when: [:each | each isCollection not];
			menu: [:list | GLMMenu actionsFor: list].
	finder list
			title: 'List * 10';
			display: [:each | each to: each*10];
			when: [:each | each isCollection not].
	finder text
			title: 'Text'.	"
	^ finder 
]

{ #category : #examples }
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

{ #category : #examples }
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

{ #category : #examples }
GLMMorphicExamples >> simpleFinder [

	"
		self new simpleFinder openOn: #(1 2 3 4 5).
	"

	| finder |
	finder := GLMFinder new.
	finder list
			when: [:each | each isCollection].
	finder list
			title: 'List';
			display: [:each | each to: each];
			when: [:each | each isCollection not].
	finder list
			title: 'List * 10';
			display: [:each | each to: each*10];
			when: [:each | each isCollection not].
	finder text
			title: 'Text'.	
	^ finder 
]

{ #category : #examples }
GLMMorphicExamples >> simpleFinderWithMenu [

	"
		self new simpleFinderWithMenu openOn: #(1 2 3 4 5).
	"

	| finder |
	finder := GLMFinder new.
	finder list
			when: [:each | each isCollection].
	finder list
			title: 'List';
			display: [:each | each to: each];
			when: [:each | each isCollection not];
			menu: [:list | GLMMenu actionsFor: list].
	finder list
			title: 'List * 10';
			display: [:each | each to: each*10];
			when: [:each | each isCollection not].
	finder text
			title: 'Text'.	
	^ finder 
]

{ #category : #examples }
GLMMorphicExamples >> stCodeBrowser [	
	"
		| browser |
		browser := self new stCodeBrowser.
		browser openOn: Smalltalk organization categories.
	"

	| browser |

	browser := GLMTableLayoutBrowser new.
	browser row: #navigation; row: #sourceCode.

	browser showOn: #navigation; using: [
		browser custom: self stCodeNavigator.
	].

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
					view edgesFrom: [:x | x superclass].
					view treeLayout. ];
				when: [:class :method :cat | cat notNil].
		].

	^browser
]

{ #category : #examples }
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

{ #category : #examples }
GLMMorphicExamples >> toyBrowser [
	"
		self new toyBrowser openOn: Smalltalk
	"

	| browser |
	browser := GLMTableLayoutBrowser new.
	browser column: #categories; column: #classes; column: #methods.
	browser showOn: #categories; using: [
		browser list
			display: [ :environment | environment organization categories ] ].
	browser showOn: #classes; from: #categories; using: [
		browser list
			display: [ :category | 
				(Smalltalk organization listAtCategoryNamed: category) 
					collect: [ :name | Smalltalk classNamed: name ] ] ].
	browser showOn: #methods; from: #classes; using: [
		browser tree
			children: [ :class  | class selectors asSortedCollection ] ].
	^ browser
]

{ #category : #examples }
GLMMorphicExamples >> toyNavigatorBrowser [
	"
		| browser |
		browser := self new toyNavigatorBrowser.
		browser openOn: Smalltalk organization categories.
		((browser paneNamed: #categories) port: #selection) value: Smalltalk organization categories first.
	"

	| browser classes |
	browser := GLMTableLayoutBrowser new.
	browser column: #categories; column: #classes; column: #metCategories; column: #methods.
	browser showOn: #classes->#entity; from: #categories->#selection; using: [
		browser list
			title: 'Classes';
			display: [:category | (Smalltalk organization listAtCategoryNamed: category) collect: [:className | Smalltalk classNamed: className] ].
		browser mondrian
			title: 'System Complexity';
			painting: [:view :category | 
				classes := (Smalltalk organization listAtCategoryNamed: category) collect: [:className | Smalltalk classNamed: className].
				view nodes: classes.
				view edgesFrom: #superclass.
				view treeLayout
			]
	].
	browser showOn: #metCategories; from: #classes; using: [
		browser list
			display: [:class | class organization categories ]
	].
	browser showOn: #methods; from: #classes; from: #metCategories; using: [
		browser list
			display: [  :class :category | (class organization listAtCategoryNamed: category) asSortedCollection ];
			when: [  :class :category | class notNil and: [ category notNil ] ].
		browser list
			display: [ :class :category | class selectors asSortedCollection ];
			when: [ :class :category | class notNil and: [ category isNil ] ].
	].
	^ browser
]
