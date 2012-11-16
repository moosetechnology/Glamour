Class {
	#name : #SGLSimpleFinderComponentTest,
	#superclass : #SGLBrowserComponentTest,
	#category : #'Glamour-Seaside-Tests'
}

{ #category : #accessing }
SGLSimpleFinderComponentTest >> componentClass [
	^ SGLSimpleFinderTestComponent
]

{ #category : #'private selectors' }
SGLSimpleFinderComponentTest >> finderAbsolutePaneSelector [
	^ '/html/body/', self finderPaneSelector
]

{ #category : #'private selectors' }
SGLSimpleFinderComponentTest >> finderAbsoluteSelector [
	^ '/html/body/', self finderSelector
]

{ #category : #'testing pane flow' }
SGLSimpleFinderComponentTest >> testAddMultiplePanes [
	
	self clickAndPauseNodeWithIndex: 20 forTreeIn: self finderAbsolutePaneSelector, '[1]/'.
	self clickAndPauseNodeWithIndex: 10 forTreeIn: self finderAbsolutePaneSelector, '[2]/'.
	self clickAndPauseNodeWithIndex: 5 forTreeIn: self finderAbsolutePaneSelector, '[3]/'.
	
	self shouldElementWithXPathBePresent: self finderAbsolutePaneSelector, '[4]'.
	self shouldntElementWithXPathBePresent: self finderAbsolutePaneSelector, '[5]'.
	
]

{ #category : #'testing pane flow' }
SGLSimpleFinderComponentTest >> testAddOnePane [

	self clickAndPauseNodeWithIndex: 20 forTreeIn: self finderAbsolutePaneSelector, '[1]/'.
	
	self shouldElementWithXPathBePresent: self finderAbsolutePaneSelector, '[2]' .
	self shouldntElementWithXPathBePresent: self finderAbsolutePaneSelector, '[3]'.
	
]

{ #category : #'testing pane flow' }
SGLSimpleFinderComponentTest >> testContentAfterAddingOnePane [
	| paneSelector |
	
	self clickAndPauseNodeWithIndex: 20 forTreeIn: self finderAbsolutePaneSelector.
	
	paneSelector := self finderAbsolutePaneSelector, '[2]/'.
	self shouldElementWithXPathBePresent: paneSelector, self treePresentationSelector.  
	self assert: (driver findElementsByXPath: paneSelector, self treeAllRootNodesSelector ) size = 20.
	self shouldntElementWithXPathBePresent: paneSelector, (self treeRootNodeSelectorWithIndex: 21)
	
]

{ #category : #'testing initialization' }
SGLSimpleFinderComponentTest >> testFinderIsPresent [
	
	self shouldElementWithXPathBePresent: self finderAbsoluteSelector,'[1]'.
	self shouldntElementWithXPathBePresent: self finderAbsoluteSelector,'[2]'.
	
]

{ #category : #'testing initialization' }
SGLSimpleFinderComponentTest >> testOneFinderPanePresent [
	
	self shouldElementWithXPathBePresent: self finderAbsolutePaneSelector, '[1]'.
	self shouldntElementWithXPathBePresent: self finderAbsolutePaneSelector, '[2]'.
]

{ #category : #'testing initialization' }
SGLSimpleFinderComponentTest >> testPaneContentIsPresent [
	
	self shouldElementWithXPathBePresent: self finderAbsolutePaneSelector, '/', self treePresentationSelector.
	self assert: (driver findElementsByXPath: self finderAbsolutePaneSelector, '/', self treeAllRootNodesSelector) size = 100.

]

{ #category : #'testing pane flow' }
SGLSimpleFinderComponentTest >> testReplaceAndRemovePanes [
	| listElement |
	
	self clickAndPauseNodeWithIndex: 50 forTreeIn: self finderAbsolutePaneSelector, '[1]/'.
	self clickAndPauseNodeWithIndex: 10 forTreeIn: self finderAbsolutePaneSelector, '[2]/'.
	self clickAndPauseNodeWithIndex: 10 forTreeIn: self finderAbsolutePaneSelector, '[3]/'.
	self clickAndPauseNodeWithIndex: 1 forTreeIn: self finderAbsolutePaneSelector, '[4]/'.
	self clickAndPauseNodeWithIndex: 30 forTreeIn: self finderAbsolutePaneSelector, '[2]/'.
	
	self shouldElementWithXPathBePresent: self finderAbsolutePaneSelector, '[3]'.
	self shouldntElementWithXPathBePresent: self finderAbsolutePaneSelector, '[4]'.
	self assert: (driver findElementsByXPath: self finderAbsolutePaneSelector, '[3]/', self treeAllRootNodesSelector) size = 30.
]

{ #category : #'testing pane flow' }
SGLSimpleFinderComponentTest >> testReplacePane [
	| listElement |
	
	self clickAndPauseNodeWithIndex: 10 forTreeIn: self finderAbsolutePaneSelector, '[1]'.
	self clickAndPauseNodeWithIndex: 30 forTreeIn: self finderAbsolutePaneSelector, '[1]'.
	
	self shouldElementWithXPathBePresent: self finderAbsolutePaneSelector, '[2]'.
	self assert: (driver findElementsByXPath: self finderAbsolutePaneSelector, '[2]/', self treeAllRootNodesSelector) size = 30.
	
	self shouldntElementWithXPathBePresent: self finderAbsolutePaneSelector, '[3]'.
]
