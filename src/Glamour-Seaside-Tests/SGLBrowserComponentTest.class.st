Class {
	#name : #SGLBrowserComponentTest,
	#superclass : #BPWebDriverTestCase,
	#instVars : [
		'componentUnderTest'
	],
	#category : #'Glamour-Seaside-Tests'
}

{ #category : #selector }
SGLBrowserComponentTest >> bodySelector [
	^ '/html/body'
]

{ #category : #actions }
SGLBrowserComponentTest >> clickAndPause: anElement [
	anElement click.
	self pause.
	
]

{ #category : #'actions tree' }
SGLBrowserComponentTest >> clickAndPauseNodeWithIndex: anInteger forTreeIn: treePresentationContainerSelector [
	| listElement |
	
	"  '/*[1]' is used in order to select the content of the node that can be clicked "
	listElement := driver findElementByXPath: treePresentationContainerSelector, '/', (self treeRootNodeSelectorWithIndex: anInteger ), '/*[1]'.
	self clickAndPause: listElement.
]

{ #category : #setup }
SGLBrowserComponentTest >> configureTestApp: testApp [
	SGLComponent applyPreferencesOn: testApp.
]

{ #category : #'actions tabulator' }
SGLBrowserComponentTest >> dragAndDropVerticallyBy: aPoint [
	|tabulator|

	tabulator := driver findElementByXPath: self tabulatorAbsoluteSelector.
	(tabulator findElementByXPath: self horizontalResizingBarSelector) dragAndDropBy: aPoint.
	
	self pause.
]

{ #category : #selector }
SGLBrowserComponentTest >> emptyPresentationSelector [
	^ 'div[contains(@class, "glm-empty-presentation")]'
]

{ #category : #'selectors finder' }
SGLBrowserComponentTest >> finderPaneSelector [
	^ self finderSelector , '/', 'div[contains(@class, "sgl-finder-pane")]'
]

{ #category : #'selectors finder' }
SGLBrowserComponentTest >> finderSelector [
	^ 'div[contains(@class, "sgl-finder")]'
]

{ #category : #selector }
SGLBrowserComponentTest >> horizontalResizingBarSelector [
	^ 'div[contains(@class, "hsplitbar")]'
]

{ #category : #accessing }
SGLBrowserComponentTest >> outlineSpanForElement: anElement [
	"|totalOutline|
	
	totalOutline := (anElement getAttribute: 'margin-top') asInteger.
	totalOutline := (anElement getAttribute: 'margin-bottom') asInteger + totalOutline.
	totalOutline := (anElement getAttribute: 'padding-top') asInteger + totalOutline.
	totalOutline := (anElement getAttribute: 'padding-bottom') asInteger + totalOutline.
	totalOutline := (anElement getAttribute: 'border-top-width') asInteger + totalOutline.
	totalOutline := (anElement getAttribute: 'border-bottom-width') asInteger + totalOutline.
	
	^ totalOutline"
	
	^2@2
	
]

{ #category : #actions }
SGLBrowserComponentTest >> pause [
	self pause: 1
]

{ #category : #actions }
SGLBrowserComponentTest >> pause: waitTimeInSeconds [
	(Delay forSeconds: waitTimeInSeconds) wait.
]

{ #category : #accessing }
SGLBrowserComponentTest >> resizingBarSizeInPixels [
	^ 5
]

{ #category : #setup }
SGLBrowserComponentTest >> setUp [
	super setUp. 
	
	self pause.
]

{ #category : #asserting }
SGLBrowserComponentTest >> shouldElementWithXPathBePresent: aXpath [
	self shouldnt: [ driver findElementByXPath: aXpath ] raise: BPNoSuchElementException.
]

{ #category : #asserting }
SGLBrowserComponentTest >> shouldXPathBePresent: aXpath inElement: anElement [
	self shouldnt: [ anElement findElementByXPath: aXpath ] raise: BPNoSuchElementException.
]

{ #category : #asserting }
SGLBrowserComponentTest >> shouldntElementWithXPathBePresent: aXpath [
	self should: [ driver findElementByXPath: aXpath ] raise: BPNoSuchElementException.
]

{ #category : #asserting }
SGLBrowserComponentTest >> shouldntXPathBePresent: aXpath inElement: anElement [
	self should: [ anElement findElementByXPath: aXpath ] raise: BPNoSuchElementException.
]

{ #category : #'selectors tabulator' }
SGLBrowserComponentTest >> tabulatorAbsoluteFirstPaneSelector [
	^ self bodySelector, '/', self tabulatorFirstPaneSelector 
]

{ #category : #'selectors tabulator' }
SGLBrowserComponentTest >> tabulatorAbsoluteSecondPaneSelector [
	^ self bodySelector, '/', self tabulatorSecondPaneSelector 
]

{ #category : #'selectors tabulator' }
SGLBrowserComponentTest >> tabulatorAbsoluteSelector [
	^ '/html/body/', self tabulatorSelector 
]

{ #category : #'selectors tabulator' }
SGLBrowserComponentTest >> tabulatorFirstPaneSelector [
	^ self tabulatorSelector,'/', self tabulatorStandaloneFirstPaneSelector
]

{ #category : #'selectors tabulator' }
SGLBrowserComponentTest >> tabulatorSecondPaneSelector [
	^ self tabulatorSelector,'/', self tabulatorStandaloneSecondPaneSelector
]

{ #category : #'selectors tabulator' }
SGLBrowserComponentTest >> tabulatorSelector [
	^ 'div[contains(@class, "sgl-table")]'
]

{ #category : #'selectors tabulator' }
SGLBrowserComponentTest >> tabulatorStandaloneFirstPaneSelector [
	^ 'div[contains(@class, "sgl-table-paneA")]'
]

{ #category : #'selectors tabulator' }
SGLBrowserComponentTest >> tabulatorStandaloneSecondPaneSelector [
	^ 'div[contains(@class, "sgl-table-paneB")]'
]

{ #category : #'selectors tree' }
SGLBrowserComponentTest >> treeAllRootNodesSelector [
	^ self treePresentationSelector, '/ul[contains(@class, "sgl-tree-root")]/li'.
]

{ #category : #'selectors tree' }
SGLBrowserComponentTest >> treePresentationSelector [
	^ 'div[contains(@class, "sgl-tree-presentation")]'.
]

{ #category : #'selectors tree' }
SGLBrowserComponentTest >> treeRootNodeSelector [
	^ self treePresentationSelector, '/ul[contains(@class, "sgl-tree-root")]'.
]

{ #category : #'selectors tree' }
SGLBrowserComponentTest >> treeRootNodeSelectorWithIndex: anInteger [
	^ self treeAllRootNodesSelector, '[', anInteger asString , ']'
]
