"
self browseExamples
"
Class {
	#name : #GLMSmalltalkExamples,
	#superclass : #GLMExamples,
	#category : #'Glamour-Examples'
}

{ #category : #'as yet unclassified' }
GLMSmalltalkExamples >> diffBrowser [
	"self new diffBrowser openOn: (Collection withAllSubclasses asOrderedCollection sortBy: [:a :b | a name < b name])"
	| browser |
	browser := GLMTableLayoutBrowser new.
	browser title: 'Glamorous Diff Browser'.
	browser
		row: [:r | r column: #left; column: #right ];
		row: #diff.
	browser showOn: #left; using: [browser custom: self threePaneNavigator ].
	browser showOn: #right; using: [browser custom: self threePaneNavigator ].
	browser showOn: #diff; 
		from: #left->#selectedClass; from: #left->#selectedMethod;
		from: #right->#selectedClass; from: #right->#selectedMethod;
		using: [
		browser diff
			display: [:leftClass :leftMethod :rightClass :rightMethod | 
				Array with: (leftClass sourceCodeAt: leftMethod) with: (rightClass sourceCodeAt: rightMethod)
			]
		].
	^ browser
]

{ #category : #code }
GLMSmalltalkExamples >> implementorsChasingBrowser [
	"self new implementorsChasingBrowser openOn: #implementorsChasingBrowser"
	| finder browser |
	finder := GLMFinder new.
	finder tree
		display: [ :each | self systemNavigation allImplementorsOf:	each ];
		format: [:each | 
			(each isKindOf: MethodReference) ifTrue: [each classSymbol, '>>', each selector ] ifFalse: [ each ]];
		children: [ :each | 
			(each isKindOf: MethodReference) ifTrue: [each compiledMethod messages] ifFalse: [OrderedCollection new]];
		whenKindOf: String.
	browser := GLMTableLayoutBrowser new.
	browser title: [:each | 'Implementors of ', each].
	browser row: #finder; row: #details.
	browser showOn: #finder; using: [browser custom: finder].
	browser showOn: #details; from: #finder; using: [
		browser text
			forSmalltalk: [:reference | reference actualClass ];
			display: [:reference | reference sourceCode ];
			whenKindOf: MethodReference ].
	^ browser
]

{ #category : #objects }
GLMSmalltalkExamples >> messageTallyFinder [
	"self new messageTallyFinder openOn: (
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

{ #category : #objects }
GLMSmalltalkExamples >> messageTallyTree [
	<glmBrowser: 'Message Tally Tree' input: 'MessageTally new spyEvery: 1 on: [10000 timesRepeat: [1.23 printString]]; yourself'>
	"self new messageTallyTree openOn: (MessageTally new spyEvery: 1 on: [10000 timesRepeat: [1.23 printString]]; yourself)"

	| browser |
	browser := GLMTableLayoutBrowser new.
	browser column: #messages; column: #details.
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
	"self new metacelloBrowser openOn: ((Object subclasses select: [:each | each isMetacelloConfig ]) sort: [:a :b | a name < b name])"
	| browser all |

browser := GLMTableLayoutBrowser new.
browser column: #configs; column: #versions; column: #packages.
browser showOn: #versions; from: #configs; using: [
	browser list
		display: [:config | config project versions ]].
browser showOn: #packages; from: #versions; using: [
	browser list
		title: 'Items';
		display: [:version | version spec packages packageSpecsInLoadOrder];
		format: #name;
		act: [:list  | list selection inspect] entitled: 'Inspect'.
	browser mondrian
		title: 'Dependencies';
		painting: [:view :version | 
			all := Dictionary new.
version packages do: [:each | all at: each name put: each].
version projects do: [:each | all at: each name put: each].
view nodes: all values.
view edges: version packages from: [:eachPackage | all at: eachPackage name] toAll: [:eachPackage |
	eachPackage requires collect: [:each | all at: each ]].
view treeLayout.].
 ].
	^ browser 
]

{ #category : #objects }
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

{ #category : #objects }
GLMSmalltalkExamples >> objectFinderTabbed [
	<glmBrowser: 'Object Finder' input: 'Smalltalk'>
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
		format: [ :assoc | assoc key asString , ' : ' , (assoc value printString copyFrom: 1 to: ((50 min: assoc value printString size) max: 0)) ];
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

{ #category : #code }
GLMSmalltalkExamples >> stClassicBrowser [
	<glmBrowser: 'Classic Code Browser' input: 'Smalltalk organization categories'>
	"self new stClassicBrowser openOn: Smalltalk organization categories."
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
				forSmalltalk: [ :class | class ].
			browser text
				forSmalltalk;
				useExplicitNotNil;
				title: 'Class definition';
				display: [ :class | class definition ];
				when: [:class | class notNil].
			browser text
				title: 'Class comment';
				display: [ :class | class comment ];
				useExplicitNotNil;
				when: [:class | class notNil]
		].
	^ browser
]

{ #category : #code }
GLMSmalltalkExamples >> stClassicNavigator [
	"self new stClassicNavigator openOn: Smalltalk organization categories."
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
			[ browser list ].
	browser
		showOn: #classes;
		from: #classCats;
		using: [
			browser tree
				display: [ :classCat | 
					(Smalltalk organization listAtCategoryNamed: classCat) collect: [ :className | Smalltalk classNamed: className ] ];
				children: [ :each | each traitComposition traits ];
				title: 'Class list'.
			browser mondrian 
				painting: [ :view :package |
					view nodes: ((Smalltalk organization listAtCategoryNamed: package) collect: [:name | Smalltalk classNamed: name]).
					view edgesFrom: #superclass.
					view treeLayout.];
				title: 'Hierarchy'.
 ].
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
					(class organization listAtCategoryNamed: category) asSortedCollection].
			browser list
				useExplicitNotNil;
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

{ #category : #code }
GLMSmalltalkExamples >> stMultiPanedBrowser [
	<glmBrowser: 'Multi-paned Code Browser' input: 'GLMSTClassCategory all'>
	"self new stMultiPanedBrowser openOn: GLMSTClassCategory all"
	| browser |
	browser := GLMTableLayoutBrowser new.
	browser title: 'Glamorous Smallalk Browser'.
	browser
		column: #navigation;
		column: #sourceCode.
	browser
		showOn: #navigation;
		using: [ browser custom: self stMutiPanedNavigator ].
	browser
		showOn: #sourceCode;
		from: #navigation -> #selectedClass;
		from: #navigation -> #selectedMethod;
		from: #navigation -> #selectedClassCategory;
		using: 
			[ browser text
				title: [:class :method | method glmBehavior isMetaSide ifTrue: ['Meta-side method'] ifFalse: ['Instance-side method']];
				display: [ :class :method | method sourceCode ];
				when: [ :class :method | method notNil and: [ method isMethod ] ];
				forSmalltalk: [ :class | class stBehavior ].
			browser text
				forSmalltalk;
				title: 'Class definition';
				display: [ :class | class definition ];
				useExplicitNotNil;
				when: [ :class | class notNil ] ].
	^ browser
]

{ #category : #code }
GLMSmalltalkExamples >> stMutiPanedNavigator [
	"
		self new stMutiPanedNavigator openOn: GLMSTClassCategory all
	"
	| browser |
	browser := GLMTableLayoutBrowser new.
	browser
		column: #classCats;
		column: 
			[ :c | 
			c
				row: #classes
					span: 2;
				row: #classComment ];
		column: 
			[ :c | 
			c
				row: #instanceMethods
					span: 2;
				row: #metaMethods ].
	browser
		showOn: #classCats;
		using: 
			[ browser list
				display: [ :categories | categories sort: [ :a :b | a name < b name ] ];
				filterOn: [ :text :list | list select: [ :each | text match: each name ] ] ].
	browser
		showOn: #classes;
		from: #classCats;
		using: 
			[ browser tree
				display: [ :classCat | classCat classes ];
				children: [ :each | each traits ];
				icon: 
					[ :each | 
					each stBehavior theNonMetaClass browserIcon isNil 
						ifFalse: 
							[ OBMorphicIcons iconNamed: each stBehavior theNonMetaClass browserIcon ]
						ifTrue: [ nil ] ] ].
	browser
		showOn: #classComment;
		from: #classes;
		using: [ browser text display: [ :class | class comment ] ].
	browser
		showOn: #instanceMethods;
		from: #classes;
		using: 
			[ browser tree
				display: [ :class | class protocols ];
				children: 
					[ :catOrMethod | 
					catOrMethod isCategory 
						ifTrue: [ catOrMethod methods ]
						ifFalse: [ OrderedCollection new ] ];
				send: 
					[ :catOrMethod | 
					(catOrMethod notNil and: [ catOrMethod isCategory ]) 
						ifTrue: [ nil ]
						ifFalse: [ catOrMethod ] ] ].
	browser
		showOn: #metaMethods;
		from: #classes;
		using: 
			[ browser tree
				display: [ :class | class metaSide protocols ];
				children: 
					[ :catOrMethod | 
					catOrMethod isCategory 
						ifTrue: [ catOrMethod methods ]
						ifFalse: [ OrderedCollection new ] ];
				send: 
					[ :catOrMethod | 
					(catOrMethod notNil and: [ catOrMethod isCategory ]) 
						ifTrue: [ nil ]
						ifFalse: [ catOrMethod ] ] ].
	browser 
		sendToOutside: #selectedClassCategory
		from: #classCats.
	browser 
		sendToOutside: #selectedClass
		from: #classes.
	browser 
		sendToOutside: #selectedMethod
		from: #instanceMethods.
	browser 
		sendToOutside: #selectedMethod
		from: #metaMethods.
	^ browser
]

{ #category : #'as yet unclassified' }
GLMSmalltalkExamples >> threePaneNavigator [	
	| classBrowser |
	classBrowser := GLMTableLayoutBrowser new.
	classBrowser column: #classes; column: #methods.
	classBrowser showOn: #classes; using: [classBrowser list].
	classBrowser showOn: #methods; from: #classes; using: [
		classBrowser list
			display: [:cls | cls selectors asOrderedCollection sortBy: [:a :b | a < b]]].
	classBrowser sendToOutside: #selectedClass from: #classes.
	classBrowser sendToOutside: #selectedMethod from: #methods.
	^ classBrowser
]

{ #category : #code }
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
