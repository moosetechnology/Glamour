Class {
	#name : #GLMCodeBrowser,
	#superclass : #Object,
	#instVars : [
		'browser'
	],
	#category : #'Glamour-Examples'
}

{ #category : #accessing }
GLMCodeBrowser class >> defaultEnvironment [
	^ GLMSTModel defaultEnvironment
]

{ #category : #opening }
GLMCodeBrowser class >> open [
	^ self new
		open
]

{ #category : #accessing }
GLMCodeBrowser >> browser [
	^ browser ifNil: [self buildBrowser. browser]
]

{ #category : #building }
GLMCodeBrowser >> buildBrowser [
	browser := GLMTableLayoutBrowser new.
	self buildLayout.
	self buildPackages.
	self buildClasses.
	self buildMethods.
]

{ #category : #building }
GLMCodeBrowser >> buildClasses [
	browser
		showOn: #classes; from: #packages;
		using: [browser list
					when: [:package | package isCollection not];
					display: [:package | package classes];
					format: [:class | class name]]
]

{ #category : #building }
GLMCodeBrowser >> buildLayout [
	browser
		column: #packages;
		column: #classes;
		column: #methods
]

{ #category : #building }
GLMCodeBrowser >> buildMethods [
	browser
		showOn: #methods;
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
					(catOrMethod isNil or: [catOrMethod isCategory]) 
						ifTrue: [ nil ]
						ifFalse: [ catOrMethod ] ] ]
]

{ #category : #building }
GLMCodeBrowser >> buildPackages [
	browser
		showOn: #packages;
		using: 
			[ browser tree
				children: [ :package | package subPackages ];
				format: [ :package | package name ] ]
]

{ #category : #opening }
GLMCodeBrowser >> open [
	^ self browser openOn: (GLMSTPackage rootPackagesOn: self class defaultEnvironment)
]
