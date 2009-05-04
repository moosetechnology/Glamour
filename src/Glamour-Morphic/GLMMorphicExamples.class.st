Class {
	#name : #GLMMorphicExamples,
	#superclass : #Object,
	#category : #'Glamour-Morphic'
}

{ #category : #examples }
GLMMorphicExamples >> asMorphEditor [

	"
		self new asMorphEditor openOn: 'asdasdasd'
	"

	| browser |
	browser := GLMFinder new.
	browser morph.
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
