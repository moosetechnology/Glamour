Class {
	#name : #GLMTraitsBrowser,
	#superclass : #Object,
	#category : #'Glamour-Examples'
}

{ #category : #'as yet unclassified' }
GLMTraitsBrowser class >> open [
	self new browser openOn: Smalltalk organization categories
]

{ #category : #'as yet unclassified' }
GLMTraitsBrowser >> browser [
	| browser |
	browser := GLMTableLayoutBrowser new.
	browser
		row: 
			[ :r | 
			r
				column: #categories;
				column: #classes;
				column: #internals ];
		row: #details.
	browser
		showOn: #categories;
		using: 
			[ browser list filterOn: [ :text :list | list select: [ :each | text match: each ] ] ].
	browser
		showOn: #classes;
		from: #categories;
		using: 
			[ browser list display: 
				[ :classCat | 
				(Smalltalk organization listAtCategoryNamed: classCat) collect: [ :className | Smalltalk classNamed: className ] ] ].
	browser
		showOn: #internals;
		from: #classes;
		using: [ browser custom: self traits ].
	browser
		showOn: #details;
		from: #internals;
		using: 
			[ browser text
				when: [ :trait | trait isKindOf: Trait ];
				display: [ :trait | trait comment ].
			browser text
				forSmalltalk;
				when: [ :trait | trait isKindOf: Trait ];
				display: [ :trait | trait definition ].
			browser text
				forSmalltalk: [ :assoc | assoc key ];
				when: [ :assoc | assoc isKindOf: Association ];
				display: [ :assoc | assoc key sourceCodeAt: assoc value ] ].
	^ browser
]

{ #category : #'as yet unclassified' }
GLMTraitsBrowser >> internals [
	| browser |
	browser := GLMFinder new.
	browser list
		title: 'Methods';
		display: [ :anObject | anObject selectors collect: [ :each | anObject -> each ] ];
		format: [ :each | each value ];
		when: [ :anObject | (anObject isKindOf: Class) or: [ anObject isKindOf: Trait ] ].
	browser list
		title: 'Traits';
		when: [ :anObject | (anObject isKindOf: Class) or: [ anObject isKindOf: Trait ] ];
		display: [ :anObject | anObject traitComposition traits ].
	^ browser
]

{ #category : #'as yet unclassified' }
GLMTraitsBrowser >> traits [
	| browser |
	browser := GLMTableLayoutBrowser new.
	browser column: #traits; column: #protocols; column: #methods.
	browser showOn: #traits; using: [
		browser tree children: [ :aBehavior | aBehavior traitComposition traits ] ].
	browser showOn: #methods; from: #traits; using: [
		browser list display: [ :aBehavior | aBehavior selectors ] ].
	^ browser
]
