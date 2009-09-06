Class {
	#name : #GLMSmalltalkExamples,
	#superclass : #Object,
	#category : #'Glamour-Examples'
}

{ #category : #'st examples' }
GLMSmalltalkExamples >> messageTally [
	"self new messageTally openOn: (
	MessageTally new spyEvery: 1 on: [10000 timesRepeat: [1.23 printString]]; yourself)"

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

{ #category : #'st examples' }
GLMSmalltalkExamples >> messageTallyTree [
	"
	self new messageTallyTree openOn: (MessageTally new spyEvery: 1 on: [10000 timesRepeat: [1.23 printString]]; yourself)
	"

	| browser |
	browser := GLMTableLayoutBrowser new.
	browser row: #messages; row: #details.
	browser showOn: #messages; using: [
		browser tree
			children: [:each | each sonsOver: -1 ];
			format: [:each | Text fromString: (each printString, ' (', each tally printString, ')')]].
	browser showOn: #details; from: #messages; using: [
		browser text
			forSmalltalk: [:each | each method methodClass];
			display: [:each | each method methodClass sourceCodeAt: each method selector ifAbsent: ['unknown']]].
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
	browser column: #versions; column: [:c | c row: #packages; row: #comment].
	browser showOn: #versions; using: [
		browser list
			act: [:list | list selection inspect] on: '/' entitled: 'Inspect'
	].
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
	insideBrowser
		row: #object;
		row: #evaluator.
	insideBrowser
		showOn: #object;
		using: 
			[ insideBrowser list
				title: 'Collection';
				when: [ :anObject | anObject isCollection ].
			insideBrowser list
				title: [ :anObject | self printObjectAsAnItem: anObject ];
				display: 
					[ :anObject | 
					anObject class allInstVarNames collect: [ :iv | iv -> (anObject instVarNamed: iv) ] ];
				format: [ :assoc | assoc key asString , ' : ' , assoc value printString ];
				send: #value ].
	insideBrowser
		showOn: #evaluator;
		using: 
			[ insideBrowser text
				display: [ :entity | 'self' ];
				title: 'Evaluator';
				update: #selection
					on: $o
					entitled: 'Open (o)'
					with: 
						[ :text :entity | 
						Compiler 
							evaluate: text selectedText
							for: entity
							logged: false ] ].
	insideBrowser 
		sendToOutside: #selection
		from: #object.
	insideBrowser 
		sendToOutside: #selection
		from: #evaluator.
	^ browser
]

{ #category : #'st examples' }
GLMSmalltalkExamples >> objectFinderTabbed [
	"
		self new objectFinderTabbed openOn: Smalltalk
	"
	| browser |
	browser := GLMFinder new.
	browser list
		title: [ :anObject | self printObjectAsAnItem: anObject ];
		display: 
			[ :anObject | 
			anObject class allInstVarNames collect: [ :iv | iv -> (anObject instVarNamed: iv) ] ];
		format: [ :assoc | assoc key asString , ' : ' , (assoc value printString truncate: 50) ];
		send: #value.
	browser list
		title: 'Collection';
		when: [ :each | each isCollection ].
	browser text
		forSmalltalk;
		display: [ :entity | 'self' ];
		title: 'Evaluator';
		update: #selection
			on: $o
			entitled: 'Open (o)'
			with: 
				[ :text :entity | 
				Compiler 
					evaluate: text selectedText
					for: entity
					logged: false ];
		act: 
				[ :text :entity | 
				(Compiler 
					evaluate: text selectedText
					for: entity
					logged: false) inspect ]
			on: $/
			entitled: 'Inspect (/)'.
	^ browser
]

{ #category : #private }
GLMSmalltalkExamples >> printObjectAsAnItem: anObject [ 
	| title stream |
	stream := String new writeStream.
	title := anObject class name.
	stream
		nextPutAll: (title first isVowel 
				ifTrue: [ 'an ' ]
				ifFalse: [ 'a ' ]);
		nextPutAll: title.
	^ stream contents
]

{ #category : #'st examples' }
GLMSmalltalkExamples >> smalldoc [
	"self new smalldoc openOn: Smalltalk organization categories"
	"SGLDefaultComponent register: self new smalldoc on: Smalltalk organization categories"
	|browser classes|
	browser := GLMTableLayoutBrowser new.
	browser column: #classCats; column: #classes; column: #comment.
	browser showOn: #classCats; using: [
		browser list].
	browser showOn: #classes; from: #classCats; using: [
		browser list
			title: 'Classes';
			display: [:classCat | (Smalltalk organization listAtCategoryNamed: classCat) 
				collect: [:className | Smalltalk classNamed: className]];
			act: [:list | list selection inspect] entitled: 'Inspect'.
		"browser mondrian
			title: 'Hierarchies';
			painting: [:view :classCat | 
				classes := (Smalltalk organization listAtCategoryNamed: classCat) 
					collect: [:className | Smalltalk classNamed: className].
				view nodes: classes.
				view edgesFrom: #superclass.
				view treeLayout
			]"].
	browser showOn: #comment; from: #classes; using: [
		browser text
			display: [:class | class comment]].
	^ browser
]

{ #category : #'st examples' }
GLMSmalltalkExamples >> stClassicBrowser [
	"
		self new stBrowser openOn: Smalltalk organization categories.
	"
	| browser |
	browser := GLMTableLayoutBrowser new.
	browser
		row: #navigation;
		row: #sourceCode.
	browser
		showOn: #navigation;
		using: [ browser custom: self stClassicNavigator ].
	browser
		showOn: #sourceCode;
		from: #navigation -> #selectedClass;
		from: #navigation -> #selectedMethod;
		from: #navigation -> #selectedClassCategory;
		using: 
			[ browser text
				title: 'Method source';
				display: [ :class :method | class sourceCodeAt: method ];
				when: [ :class :method | class notNil & method notNil ];
				forSmalltalk: [ :class | class ].
			browser text
				forSmalltalk;
				title: 'Class definition';
				display: [ :class | class definition ];
				when: [ :class | class notNil ].
			browser text
				title: 'Class comment';
				display: [ :class | class comment ];
				when: [ :class | class notNil ] ].
	^ browser
]

{ #category : #'st examples' }
GLMSmalltalkExamples >> stClassicNavigator [
	"
		self new stClassicNavigator openOn: Smalltalk organization categories.
	"
	| browser |
	browser := GLMTableLayoutBrowser new.
	browser
		column: #classCats;
		column: #classes;
		column: #categories;
		column: #methods.
	browser
		showOn: #classCats;
		using: 
			[ browser list filterOn: [ :text :list | list select: [ :each | text match: each ] ] ].
	browser
		showOn: #classes;
		from: #classCats;
		using: 
			[ browser tree
				display: 
					[ :classCat | 
					(Smalltalk organization listAtCategoryNamed: classCat) collect: [ :className | Smalltalk classNamed: className ] ];
				children: [ :each | each traitComposition traits ];
				when: [ :classCat | classCat notNil ] ].
	browser
		showOn: #categories;
		from: #classes;
		using: [ browser list display: [ :class | class organization categories ] ].
	browser
		showOn: #methods;
		from: #classes;
		from: #categories;
		using: 
			[ browser list
				display: 
					[ :class :category | 
					(class organization listAtCategoryNamed: category) asSortedCollection ];
				when: [ :class :category | class notNil and: [ category notNil ] ].
			browser list
				when: [ :class :category | class notNil and: [ category isNil ] ];
				display: [ :class :category | class selectors asSortedCollection ] ].
	browser 
		sendToOutside: #selectedClassCategory
		from: #classCats.
	browser 
		sendToOutside: #selectedClass
		from: #classes.
	browser 
		sendToOutside: #selectedMethod
		from: #methods.
	^ browser
]

{ #category : #'st examples' }
GLMSmalltalkExamples >> stTreeBasedBrowser [
	"
		self new stTreeBasedBrowser openOn: GLMSTClassCategory all
	"
	| browser |
	browser := GLMTableLayoutBrowser new.
	browser
		row: #navigation;
		row: #sourceCode.
	browser
		showOn: #navigation;
		using: [ browser custom: self stTreeBasedNavigator ].
	browser
		showOn: #sourceCode;
		from: #navigation -> #selectedClass;
		from: #navigation -> #selectedMethod;
		from: #navigation -> #selectedClassCategory;
		using: 
			[ browser text
				title: 'Method source';
				display: [ :class :method | method sourceCode ];
				when: [ :class :method | method notNil and: [method isMethod] ];
				forSmalltalk: [ :class | class stBehavior ].
			browser text
				forSmalltalk;
				title: 'Class definition';
				display: [ :class | class definition ];
				when: [ :class | class notNil ].
			browser text
				title: 'Class comment';
				display: [ :class | class comment ];
				when: [ :class | class notNil ].
			].
	^ browser
]

{ #category : #'st examples' }
GLMSmalltalkExamples >> stTreeBasedNavigator [
	"
		self new stTreeBasedNavigator openOn: GLMSTClassCategory all
	"
	| browser |
	browser := GLMTableLayoutBrowser new.
	browser
		column: #classCats;
		column: #classes;
		column: #categorizedMethods.
	browser showOn: #classCats; using: [ 
		browser list
			filterOn: [ :text :list | list select: [ :each | text match: each name ] ] ].
	browser showOn: #classes; from: #classCats; using: [
		browser tree 
			display: [ :classCat | classCat classes];
			children: [ :each | each traits ] ].
	browser showOn: #categorizedMethods; from: #classes; using: [
		browser tree
			display: [ :class | class categories];
			children: [:catOrMethod | 
				catOrMethod isCategory ifTrue: [catOrMethod methods] ifFalse: [OrderedCollection new] ];
			send: [:catOrMethod | catOrMethod isCategory ifTrue: [nil] ifFalse: [catOrMethod] ] ].
	browser 
		sendToOutside: #selectedClassCategory
		from: #classCats.
	browser 
		sendToOutside: #selectedClass
		from: #classes.
	browser 
		sendToOutside: #selectedMethod
		from: #categorizedMethods.
	^ browser
]

{ #category : #'st examples' }
GLMSmalltalkExamples >> traitsBrowser [
	| browser codeBrowser |
	browser := GLMFinder new.
	browser list
		title: 'Classes'; 
		when: [:anObject | anObject isCollection and: [anObject anyOne isKindOf: Class]].
	browser list
		title: 'Methods';
		display: [:anObject | anObject selectors collect: [:each | anObject -> each ]];
		format: [:each | each value];
		when: [:anObject | (anObject isKindOf: Class) or: [anObject isKindOf: Trait]].
	browser list
		title: 'Traits';
		when: [:anObject | (anObject isKindOf: Class) or: [anObject isKindOf: Trait]];
		display: [:anObject | anObject traitComposition traits ].
	codeBrowser := GLMTableLayoutBrowser new.
	codeBrowser row: [:r | r column: #classes; column: #internals]; row: #details.
	codeBrowser showOn: #classes; using: [codeBrowser list].
	codeBrowser showOn: #internals; from: #classes; using: [codeBrowser custom: browser].
	codeBrowser showOn: #details; from: #internals; using: [
		codeBrowser text
			when: [:trait | trait isKindOf: Trait];
			display: [:trait | trait comment].
		codeBrowser text
			forSmalltalk;
			when: [:trait | trait isKindOf: Trait];
			display: [:trait | trait definition].
		codeBrowser text
			forSmalltalk: [:assoc | assoc key];
			when: [:assoc | (assoc isKindOf: Association)];
			display: [:assoc | assoc key sourceCodeAt: assoc value]].
	codeBrowser openOn: NSCollectionStream withAllSubclasses
]
