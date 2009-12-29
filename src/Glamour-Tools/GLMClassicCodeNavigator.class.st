"
self openOn: Smalltalk organization categories.
"
Class {
	#name : #GLMClassicCodeNavigator,
	#superclass : #GLMBrowserTemplate,
	#category : #'Glamour-Tools'
}

{ #category : #'as yet unclassified' }
GLMClassicCodeNavigator >> buildBrowser [
	browser := GLMTabulator new.
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
	"for updating selection from lintBrowser"
	"browser 
		sendTo: #methods -> #selection
		fromOutside: #faultyMethod."
	^ browser
]
