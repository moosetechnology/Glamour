"
self openOn: Collection withAllSubclasses
"
Class {
	#name : #GLMSimpleClassesBrowser,
	#superclass : #GLMBrowserTemplate,
	#category : #'Glamour-Tools'
}

{ #category : #'as yet unclassified' }
GLMSimpleClassesBrowser >> buildBrowser [
	browser := GLMTabulator new.
	browser column: #classes; column: #methods.
	browser showOn: #classes; using: [
		browser list
			display: [:classes | classes asOrderedCollection sortBy: [:a :b | a name < b name] ]].
	browser showOn: #methods; from: #classes; using: [
		browser list
			display: [:cls | cls selectors asOrderedCollection sortBy: [:a :b | a < b]]].
	browser sendToOutside: #selectedClass from: #classes.
	browser sendToOutside: #selectedMethod from: #methods.
	^ browser
]
