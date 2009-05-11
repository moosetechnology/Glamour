Class {
	#name : #GLMMorphicExamples,
	#superclass : #Object,
	#category : #'Glamour-Morphic'
}

{ #category : #examples }
GLMMorphicExamples >> mooseFinder [
	"
		self new mooseFinder openOn: MooseModel root
	"


	| browser pragmas |
	browser := GLMFinder new.
	
	browser list
		title: 'Entity';
		display:  [:anObject | 
			pragmas := anObject class withAllSuperclasses flatCollect: [:each |
				Pragma allNamed: #navigation: in: each].
			(pragmas collect: [:each | anObject perform: each selector ])
				select: [ :each | each isCollection  and: [ each isEmpty not ] ].
		]";
		when: [ :each | each isCollection not ]".
	browser list
		display: [:each | each entities];
"		itemAct: [:each | each inspect] entitled: 'Inspect';"
		title: 'Group';
		whenKindOf: MooseGroup.
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
		display: [:entity | '' ];
		title: 'Evaluator';
		update: #selection on: $o with: [ :text :entity | Compiler evaluate: text selectedText for: entity logged: false ];
		update: #selection on: $s with: [ :text :entity | self halt. ].
	
	^ browser
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
GLMMorphicExamples >> stCodeBrowser [	
	"
		self new stCodeBrowser openOn: Smalltalk organization categories
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
				on: $d do: [:pane | Transcript show: 'action d'; cr. ]; 
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

	browser push: #navigation->#selectedClass as: #selectedClass.
	browser push: #navigation->#selectedClassCategory as: #selectedClassCategory.

	^browser
]

{ #category : #examples }
GLMMorphicExamples >> stCodeNavigator [	
	"
		self new stCodeNavigator openOn: Smalltalk organization categories
	"

	| browser |
	browser := GLMTableLayoutBrowser new.
	browser column: #classCats; column:#classes; column:#categories; column: #methods.

	browser showOn: #classCats; using: [
		browser list
	].

	browser showOn: #classes; from: #classCats; using: [
		browser list
			display: [ :classCat |  (Smalltalk organization listAtCategoryNamed: classCat) collect: [:className | Smalltalk classNamed: className] ];
			when: [ :classCat | classCat notNil "and: [pundle item isPackage]"]
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

	browser sendTo: #outer -> #selectedClassCategory from: #classCats.
	browser sendTo: #outer -> #selectedClass from: #classes.
	browser sendTo: #outer -> #selectedMethod from: #methods.

	^browser
]
