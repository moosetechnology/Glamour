"
self openOn: GLMPresentation withAllSubclasses asOrderedCollection
"
Class {
	#name : #GLMLintBrowser,
	#superclass : #GLMBrowserTemplate,
	#category : #'Glamour-Tools'
}

{ #category : #'as yet unclassified' }
GLMLintBrowser >> buildBrowser [
	browser := GLMTabulator new.
	browser title: 'Lint Browser'.
	browser column: #groups; column: #rules; column: #results.
	browser showOn: #groups; using: [
		browser list
			display: [:dic | RBCompositeLintRule lintChecks rules];
			allowNil;
			format: #name ].
	browser showOn: #rules; from: #groups; using: [
		browser list
			display: [:group | group rules];
			format: #name ].
	browser showOn: #results; from: #rules; from: #outer->#entity; using: [
		browser list
			display: [:rule :tuple | self getLintResult:
					(self runRule: rule forClass: tuple) result] ].
			"tuple = {class. selector} from the browser. We select the class"
	browser sendToOutside: #faultyMethod from: #results->#selection.
	^ browser
]

{ #category : #private }
GLMLintBrowser >> getLintResult: anEnvironment [

	| results stream |
	results := OrderedCollection new.
	anEnvironment classesAndSelectorsDo: [:class :sel |
			results add: sel].
	^ results
]

{ #category : #private }
GLMLintBrowser >> runRule: aRule forClass: aClass [

	| environment |
	environment := BrowserEnvironment new
 		forClasses: { aClass }.
	^ SmalllintChecker runRule: aRule onEnvironment: environment
]
