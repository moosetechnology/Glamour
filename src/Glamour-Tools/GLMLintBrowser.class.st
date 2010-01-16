"
self openOn: GLMPresentation withAllSubclasses asOrderedCollection
"
Class {
	#name : #GLMLintBrowser,
	#superclass : #GLMBrowserTemplate,
	#category : #'Glamour-Tools'
}

{ #category : #building }
GLMLintBrowser >> buildBrowser [
	browser := GLMTabulator new.
	browser title: 'Lint Browser'.
	browser column: #groups; column: #rules; column: #results.
	browser transmit from: #outer->#entity transformed: [:classOrCollection | classOrCollection isCollection ifFalse: [{ classOrCollection }] ifTrue: [ classOrCollection ]]; to: #groups; andShow: [ :a |
 		a list
			display: [:dic | RBCompositeLintRule lintChecks rules];
			allowNil;
			format: #name ].
	browser showOn: #rules; from: #groups; using: [
		browser list
			display: [:group | group rules];
			format: #name ].
	browser transmit to: #results; from: #rules; from: #outer->#entity transformed: [:classOrCollection | classOrCollection isCollection ifFalse: [{ classOrCollection }] ifTrue: [ classOrCollection ]]; andShow: [ :a |
		a list
			display: [:rule :tuple | self getLintResult:
					(self runRule: rule forClasses: tuple) result] ].
			"tuple = {class. selector} from the browser. We select the class"
	browser sendToOutside: #faultyMethod from: #results->#selection.
	^ browser
]

{ #category : #private }
GLMLintBrowser >> getLintResult: anEnvironment [

	| results stream |
	results := OrderedCollection new.
	anEnvironment classesAndSelectorsDo: [:class :sel | results add: sel].
	^ results
]

{ #category : #private }
GLMLintBrowser >> runRule: aRule forClasses: aClassesCollection [

	| environment |
	environment := BrowserEnvironment new forClasses: aClassesCollection.
	^ SmalllintChecker runRule: aRule onEnvironment: environment
]
