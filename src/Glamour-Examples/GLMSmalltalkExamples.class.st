Class {
	#name : #GLMSmalltalkExamples,
	#superclass : #Object,
	#category : #'Glamour-Examples'
}

{ #category : #'st examples' }
GLMSmalltalkExamples >> messageTally [
	"
	self new messageTally openOn: (MessageTally new spyEvery: 1 on: [10000 timesRepeat: [1.23 printString]]; yourself)
	"

	| browser finder |
	finder := GLMFinder new.
	finder list
		title: 'Messages';
		display: [:each | each sonsOver: -1];
		format: [:each | each printString, ' (', each tally printString, ')'].
	browser := GLMTableLayoutBrowser new.
	browser row: #messages; row: #source.
	browser showOn: #messages; using: [browser custom: finder].
	browser showOn: #source; from: #messages; using: [
		browser text
		title: 'Source';
		display: [:each | each method methodClass sourceCodeAt: each method selector ifAbsent: ['unknown']]
	].
	browser 
		act: [:x |
			(StringHolder new contents: (String streamContents: [:s | x entity report: s; close])) openLabel: 'Spy Results' wrap: false.]
		entitled: 'Print report'.	
	^ browser
]

{ #category : #others }
GLMSmalltalkExamples >> metacelloBrowser [
	"
		self new metacelloBrowser openOn: MetacelloMetacelloProject versions
	"
	| browser |

	browser := GLMTableLayoutBrowser new.
	browser title: 'Metacello Browser'.
	browser column: #versions; column: [:c |
		c row: #packages; row: #comment].
	browser showOn: #versions; using: [
		browser list].
	browser showOn: #packages; from: #versions; using: [
		browser list
			title: 'Packages';
			display: [:version | version spec packages packageSpecsInLoadOrder ];
			format: [:package | package name];
			act: [:list | list selection inspect] on: '/' entitled: 'Inspect'.
		browser mondrian
			title: 'Dependencies';
			painting: [:view :version | 
				view nodes: version spec packages map values.
				].
		].
	browser showOn: #comment; from: #versions; using: [
		browser text
			title: 'Comment';
			display: [:version | version description] ].
	^ browser 
]

{ #category : #'st examples' }
GLMSmalltalkExamples >> objectFinder [
	"
		self new objectFinder openOn: #(1 2 3 4)
	"

	| browser insideBrowser |
	insideBrowser := GLMTableLayoutBrowser new.
	browser := GLMFinder new.
	browser custom: insideBrowser.
	insideBrowser row: #object; row: #evaluator.
	insideBrowser showOn: #object; using: [
		insideBrowser list
			title: 'Collection';
			when: [:each | each isCollection].
		insideBrowser list
			title: 'Object';
			display:  [ :anObject | anObject class allInstVarNames collect: [:iv | iv -> (anObject instVarNamed: iv) ] ];
			format: [:assoc | assoc key asString, ' : ', assoc value printString];
			send: #value.
	].
	insideBrowser showOn: #evaluator; using: [
		insideBrowser text
		display: [:entity | 'self' ];
		title: 'Evaluator';
		update: #selection on: $o entitled: 'Open (o)' with: [ :text :entity | Compiler evaluate: text selectedText for: entity logged: false ]
	].
	insideBrowser sendToOutside: #selection from: #object.
	insideBrowser sendToOutside: #selection from: #evaluator.
	^ browser
]

{ #category : #'st examples' }
GLMSmalltalkExamples >> objectFinderPaned [
	"
		self new objectFinderPaned openOn: self new objectFinder
	"

	| browser |
	browser := GLMFinder new.
	browser list
		title: 'Collection';
		when: [:each | each isCollection].
	browser list
			title: 'Object';
			display:  [ :anObject | anObject class allInstVarNames collect: [:iv | iv -> (anObject instVarNamed: iv) ] ];
			format: [:assoc | assoc key asString, ' : ', assoc value printString];
			send: #value.
	browser text
		display: [:entity | 'self' ];
		title: 'Evaluator';
		update: #selection on: $o entitled: 'Open (o)' with: [ :text :entity | Compiler evaluate: text selectedText for: entity logged: false ];
		act: [ :text :entity | (Compiler evaluate: text selectedText for: entity logged: false) inspect ] on: $/ entitled: 'Inspect (/)'.
	
	^ browser
]

{ #category : #'st examples' }
GLMSmalltalkExamples >> stCodeBrowser [	
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
				display: [ :class :method | class sourceCodeAt: method ];
				when: [ :class :method | class notNil & method notNil ];
				forSmalltalk: [:class | class].
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
GLMSmalltalkExamples >> stCodeNavigator [	
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
