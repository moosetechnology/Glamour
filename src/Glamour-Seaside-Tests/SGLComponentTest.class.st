Class {
	#name : #SGLComponentTest,
	#superclass : #WtSeleniumCase,
	#instVars : [
		'componentUnderTest'
	],
	#category : #'Glamour-Seaside-Tests'
}

{ #category : #accessing }
SGLComponentTest class >> component [
	^ self subclassResponsibility
]

{ #category : #accessing }
SGLComponentTest class >> componentPath [
	^'glamour/componentundertesting/'
]

{ #category : #accessing }
SGLComponentTest class >> defaultAppRoot [
	^GRPlatform current defaultSeasideHostAndPort, '/'
]

{ #category : #accessing }
SGLComponentTest class >> webTesterTestRessourceClass [
	^ WtSeleniumWebTesterTestResource.
]

{ #category : #actions }
SGLComponentTest >> clickAndPause: anElement [
	anElement fireEvent: 'click'.
	self pause.
	
]

{ #category : #actions }
SGLComponentTest >> clickAndPauseNodeWithIndex: anInteger fromTree: anXpath [
	| listElement |
	
	listElement := self elementByXPath: anXpath, '/ul[contains(@class, "sgl-tree-root")]/*[', anInteger asString ,']/*'.
	self clickAndPause: listElement.
]

{ #category : #accessing }
SGLComponentTest >> componentUrl [
	^self class defaultAppRoot , self class componentPath.
]

{ #category : #actions }
SGLComponentTest >> pause [
	self pause: 5000  
]

{ #category : #actions }
SGLComponentTest >> pause: waitTimeInMillis [
	self getEval: 'var date = new Date(); var curDate = null;  while (curDate = new Date() - date < ', waitTimeInMillis asString, '){} '.
]

{ #category : #setup }
SGLComponentTest >> setUp [
	super setUp.	
	componentUnderTest := self class component.
	componentUnderTest  class registerAsApplication: self class componentPath.

	self openUrl: self componentUrl.
	self pause. "Wait for javascript to finish executing"
]

{ #category : #setup }
SGLComponentTest >> tearDown [
	componentUnderTest 
		ifNotNil: [WAAdmin defaultDispatcher unregister: componentUnderTest].
]

{ #category : #accessing }
SGLComponentTest >> timeToWaitInMillis [
	^ 10000
]

{ #category : #selectors }
SGLComponentTest >> treePresentationSelector [
	^ 'div[contains(@class, "sgl-tree-presentation")]'.
]

{ #category : #selectors }
SGLComponentTest >> treeRootNodeSelectorWithIndex: anIndex [
	^ self treeRootSelector, '/*[', anIndex asString , ']'
]

{ #category : #selectors }
SGLComponentTest >> treeRootSelector [
	^ self treePresentationSelector, '/ul[contains(@class, "sgl-tree-root")]'.
]
