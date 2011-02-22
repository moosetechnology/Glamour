Class {
	#name : #SGLSimpleFinderComponentTest,
	#superclass : #SGLComponentTest,
	#instVars : [
		'finderSelector',
		'paneSelector',
		'treePresentationSelector'
	],
	#category : #'Glamour-Seaside-Tests'
}

{ #category : #accessing }
SGLSimpleFinderComponentTest class >> component [ 
	^ SGLSimpleFinderTestComponent new.
]

{ #category : #accessing }
SGLSimpleFinderComponentTest >> fullPaneSelector [
	^ '//', finderSelector , '/', paneSelector
]

{ #category : #setup }
SGLSimpleFinderComponentTest >> setUp [
	super setUp. 
	
	finderSelector := 'body/div[contains(@class, "sgl-finder")]'.
	paneSelector := 'div[contains(@class, "sgl-finder-pane")]'.
	treePresentationSelector := 'div[contains(@class, "sgl-tree-presentation")]'.
]

{ #category : #testing }
SGLSimpleFinderComponentTest >> testAddOnePane [
	| listElement newPane treePresentation |
	
	listElement := self elementByXPath: '//ul[contains(@class, "sgl-tree-root")]/*[20]/*'.
	listElement fireEvent: 'click'.
	self pause.
	
	"The new pane should be present"
	newPane := self elementByXPath: self fullPaneSelector, '[2]'.  
	self should: newPane isPresent.
	
	"The new pane should contain a tree presentation"
	treePresentation := self elementByXPath: self fullPaneSelector, '[2]', '/', treePresentationSelector.  
	self should: treePresentation isPresent
	
]

{ #category : #testing }
SGLSimpleFinderComponentTest >> testFinderIsPresent [
	| finder |
	
	finder := self divByXPath: '//', finderSelector.	
	self should: finder isPresent
]

{ #category : #testing }
SGLSimpleFinderComponentTest >> testOneFinderPaneIsPresent [
	| firstPane secondPane |
	
	firstPane := self divByXPath: self fullPaneSelector, '[1]'.
	self should: firstPane isPresent.
	
	secondPane := self divByXPath: self fullPaneSelector, '[2]'.	
	self shouldnt: secondPane isPresent.
]

{ #category : #testing }
SGLSimpleFinderComponentTest >> testPaneContentIsPresent [
	| paneContent |
	
	paneContent := self divByXPath: self fullPaneSelector, '/', treePresentationSelector.
	self should: paneContent isPresent.

]
