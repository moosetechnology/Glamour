Class {
	#name : #GLMMorphicExamples,
	#superclass : #Object,
	#category : #'Glamour-Morphic'
}

{ #category : #examples }
GLMMorphicExamples >> stCodeBrowser [	
	"
		self new stCodeBrowser openOn: (Refactory.Browser.PundleItem item: Store.Registry)
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
		from: #navigation->#selectedPundle;
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
			"browser mondrian
				title: 'Pundle System Complexity';
				painting: [ :view :class :method :pundle | 
					view nodes: pundle item allDefinedClasses.
					view edgesFrom: [:x | x superclass].
					view treeLayout. ];
				when: [:class :method :pundle | (pundle notNil and: [pundle item isPackage]) and: [class isNil]]."
		].

	browser push: #navigation->#selectedClass as: #selectedClass.
	browser push: #navigation->#selectedPundle as: #selectedPundle.

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

	browser sendTo: #outer -> #selectedPundle from: #classCats.
	browser sendTo: #outer -> #selectedClass from: #classes.
	browser sendTo: #outer -> #selectedMethod from: #methods.

	^browser
]
