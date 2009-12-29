"
self openOn: Smalltalk organization categories.
"
Class {
	#name : #GLMClassicCodeBrowser,
	#superclass : #GLMBrowserTemplate,
	#category : #'Glamour-Tools'
}

{ #category : #'as yet unclassified' }
GLMClassicCodeBrowser >> buildBrowser [
	| lintBrowser |
	browser := GLMTabulator new.
	browser
		row: #navigation;
		row: #sourceCode.
	browser
		showOn: #navigation;
		using: [ browser custom: GLMClassicCodeNavigator new browser ].
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
				when: [:class | class notNil].
			lintBrowser := GLMLintBrowser new browser.
			lintBrowser allowNil; when: [:clas :mth | clas notNil ].
			browser custom: lintBrowser
		].
	"for updating selection through lintBrowser"
	"browser sendTo: #navigator->#faultyMethod from: #source->#faultyMethod."
	^ browser
]
