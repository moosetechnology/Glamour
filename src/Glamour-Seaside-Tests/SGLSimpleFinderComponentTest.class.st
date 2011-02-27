Class {
	#name : #SGLSimpleFinderComponentTest,
	#superclass : #SGLComponentTest,
	#instVars : [
		'finderSelector',
		'paneSelector'
	],
	#category : #'Glamour-Seaside-Tests'
}

{ #category : #accessing }
SGLSimpleFinderComponentTest class >> component [ 
	^ SGLSimpleFinderTestComponent new.
]

{ #category : #accessing }
SGLSimpleFinderComponentTest >> fullFinderSelector [
	^ '//', finderSelector
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
]

{ #category : #testing }
SGLSimpleFinderComponentTest >> testAddMultiplePanes [
	| newPane |
	
	self clickAndPauseNodeWithIndex: 20 fromTree: self fullPaneSelector, '/', self treePresentationSelector.
	self clickAndPauseNodeWithIndex: 10 fromTree: self fullPaneSelector, '[2]/', self treePresentationSelector.
	self clickAndPauseNodeWithIndex: 5 fromTree: self fullPaneSelector, '[3]/', self treePresentationSelector.
	
	newPane := self elementByXPath: self fullPaneSelector, '[4]'.  
	self should: newPane isPresent.
	
]

{ #category : #testing }
SGLSimpleFinderComponentTest >> testAddOnePane [
	| newPane |

	self clickAndPauseNodeWithIndex: 20 fromTree: self fullPaneSelector, '/', self treePresentationSelector.
	
	newPane := self elementByXPath: self fullPaneSelector, '[2]'.  
	self should: newPane isPresent.
	
]

{ #category : #testing }
SGLSimpleFinderComponentTest >> testContentAfterAddingOnePane [
	| treePresentation lastTreeElement notPresentTreeElement |
	
	self clickAndPauseNodeWithIndex: 20 fromTree: self fullPaneSelector, '/', self treePresentationSelector.
	
	"The new pane should contain a tree presentation"
	treePresentation := self elementByXPath: self fullPaneSelector, '[2]', '/', self treePresentationSelector.  
	self should: treePresentation isPresent.
	
	"The text presentation should contain 20 elements"
	lastTreeElement := self elementByXPath: self fullPaneSelector, '[2]', '/', (self treeRootNodeSelectorWithIndex: 20).
	self should: lastTreeElement isPresent.
	
	notPresentTreeElement := self elementByXPath: self fullPaneSelector, '[2]', '/', (self treeRootNodeSelectorWithIndex: 21).
	self shouldnt: notPresentTreeElement isPresent 
]

{ #category : #testing }
SGLSimpleFinderComponentTest >> testFinderIsPresent [
	| finder |
	
	finder := self divByXPath: self fullFinderSelector.
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
	
	paneContent := self divByXPath: self fullPaneSelector, '/', self treePresentationSelector.
	self should: paneContent isPresent.

]

{ #category : #testing }
SGLSimpleFinderComponentTest >> testReplaceAndRemovePanes [
	| listElement |
	
	self clickAndPauseNodeWithIndex: 50 fromTree: self fullPaneSelector, '/', self treePresentationSelector.
	self clickAndPauseNodeWithIndex: 10 fromTree: self fullPaneSelector, '[2]/', self treePresentationSelector.
	self clickAndPauseNodeWithIndex: 10 fromTree: self fullPaneSelector, '[3]/', self treePresentationSelector.
	self clickAndPauseNodeWithIndex: 1 fromTree: self fullPaneSelector, '[4]/', self treePresentationSelector.
	self clickAndPauseNodeWithIndex: 30 fromTree: self fullPaneSelector, '[2]/', self treePresentationSelector.
	
	listElement := self elementByXPath: self fullPaneSelector, '[3]', '/', (self treeRootNodeSelectorWithIndex: 30).  
	self should: listElement isPresent.
	
]

{ #category : #testing }
SGLSimpleFinderComponentTest >> testReplacePane [
	| listElement |
	
	self clickAndPauseNodeWithIndex: 10 fromTree: self fullPaneSelector, '/', self treePresentationSelector.
	self clickAndPauseNodeWithIndex: 30 fromTree: self fullPaneSelector, '/', self treePresentationSelector.
	
	listElement := self elementByXPath: self fullPaneSelector, '[2]', '/', (self treeRootNodeSelectorWithIndex: 20).  
	self should: listElement isPresent.
	
]
