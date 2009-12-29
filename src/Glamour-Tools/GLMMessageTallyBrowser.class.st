"
self openOn: [10000 timesRepeat: [1.23 printString]]
"
Class {
	#name : #GLMMessageTallyBrowser,
	#superclass : #GLMBrowserTemplate,
	#category : #'Glamour-Tools'
}

{ #category : #building }
GLMMessageTallyBrowser >> buildBrowser [
	browser := GLMTabulator new.
	browser title: 'Message Tally'.
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

{ #category : #building }
GLMMessageTallyBrowser >> openOn: aBlock [
	^ super openOn: (MessageTally new spyEvery: 1 on: aBlock; yourself)
]
