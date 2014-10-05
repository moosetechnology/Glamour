Class {
	#name : #GLMBrowserVisualisationTest,
	#superclass : #TestCase,
	#instVars : [
		'window'
	],
	#category : #'Glamour-Tools-Tests'
}

{ #category : #running }
GLMBrowserVisualisationTest >> tearDown [

	window ifNotNil: [ :w | w delete. window := nil ].
	super tearDown.
]

{ #category : #tests }
GLMBrowserVisualisationTest >> testViewAnnouncements [

	self shouldnt: [ window := GLMBrowser new viewAnnouncements ] raise: Error
]

{ #category : #tests }
GLMBrowserVisualisationTest >> testViewTree [

	self shouldnt: [ window := GLMBrowser new viewTree ] raise: Error
]
