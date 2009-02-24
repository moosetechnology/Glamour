Class {
	#name : #GLTutorialExamples,
	#superclass : #Object,
	#instVars : [
		'model'
	],
	#category : #'Glamour-Examples'
}

{ #category : #examples }
GLTutorialExamples >> example1 [
	"
		self new example1
	"
	
	| browser |
	browser := GLTableLayoutBrowser new.
	browser openOn: self model allPundles
]

{ #category : #examples }
GLTutorialExamples >> example2 [
	"
		self new example2
	"
	
	| browser |
	browser := GLTableLayoutBrowser new.
	browser
		column: #pundles;
		column: #classes.
	browser
		showOn: #classes;
		from: #pundles;
		using:
				[(browser list)
						display: [:pundle | pundle containedClasses];
						when: [:pundle | pundle isPackage]].
	browser openOn: self model allPundles
]

{ #category : #examples }
GLTutorialExamples >> example3 [
	"
		self new example3
	"
	
	| browser |
	browser := GLTableLayoutBrowser new.
	browser
		column: #pundles;
		column: #classes.
	browser
		showOn: #pundles;
		using: [browser tree children: #childPundles].
	browser
		showOn: #classes;
		from: #pundles;
		using:
				[(browser list)
						display: [:pundle | pundle containedClasses];
						when: [:pundle | pundle isPackage]].
	browser openOn: self model pundleRoot
]

{ #category : #examples }
GLTutorialExamples >> example4 [
	"
		self new example4
	"
	
	| browser |
	browser := GLTableLayoutBrowser new.
	browser
		column: #pundles;
		column: #classes;
		column: #categories.
	browser
		showOn: #pundles;
		using: [browser tree children: #childPundles].
	browser
		showOn: #classes;
		from: #pundles;
		using:
				[(browser list)
						display: [:pundle | pundle containedClasses];
						when: [:pundle | pundle isPackage]].
	browser
		showOn: #categories;
		from: #classes;
		using: [browser list display: [:class | class categoryNames]].
	browser openOn: self model pundleRoot
]

{ #category : #examples }
GLTutorialExamples >> example5 [
	"
		self new example5
	"
	
	| browser |
	browser := GLTableLayoutBrowser new.
	browser
		column: #pundles;
		column: #classes;
		column: #categories;
		column: #methods.
	browser
		showOn: #pundles;
		using: [browser tree children: #childPundles].
	browser
		showOn: #classes;
		from: #pundles;
		using:
				[(browser list)
						display: [:pundle | pundle containedClasses];
						when: [:pundle | pundle isPackage]].
	browser
		showOn: #categories;
		from: #classes;
		using: [browser list display: [:class | class categoryNames]].
	browser
		showOn: #methods;
		from: #classes;
		from: #categories;
		using:
				[browser list display: [:class :category | class methodNamesIn: category].
					(browser list)
						display: [:class | class allMethodNames];
						when: [:class :category | category isNil]].
	browser openOn: self model pundleRoot
]

{ #category : #accessing }
GLTutorialExamples >> model [
	
	^model ifNil: [model := GLTutorialModel new]
]
