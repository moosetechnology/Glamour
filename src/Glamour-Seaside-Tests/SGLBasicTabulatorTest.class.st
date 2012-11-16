Class {
	#name : #SGLBasicTabulatorTest,
	#superclass : #SGLBrowserComponentTest,
	#category : #'Glamour-Seaside-Tests'
}

{ #category : #asserting }
SGLBasicTabulatorTest >> assertVerticalDragAndDropForTabulator: aTabulator by: heightInPixels [
	| dragPoint firstPaneOldSize firstPaneNewSize secondPaneOldSize secondPaneNewSize |
	
	firstPaneOldSize := (aTabulator findElementByXPath: self tabulatorStandaloneFirstPaneSelector) getSize.
	secondPaneOldSize := (aTabulator findElementByXPath: self tabulatorStandaloneSecondPaneSelector) getSize.
	
	dragPoint := 0@heightInPixels.
	self dragAndDropVerticallyBy: dragPoint.
	
	firstPaneNewSize := (aTabulator findElementByXPath: self tabulatorStandaloneFirstPaneSelector) getSize.
	secondPaneNewSize := (aTabulator findElementByXPath: self tabulatorStandaloneSecondPaneSelector) getSize.
	
	"If the drag is outside the tabulator reset dragPoint to the top/bottom edge of the tabulator"
	((firstPaneOldSize y) + (dragPoint y) < 0) ifTrue: [dragPoint := 0@firstPaneOldSize y negated].
	((secondPaneOldSize y) - (dragPoint y) < 0) ifTrue: [dragPoint := 0@secondPaneOldSize y].
	
	"The dimensions of the panes should change according to the given heightInPixels"
	self assert: (firstPaneOldSize + dragPoint) = firstPaneNewSize.
	self assert: (secondPaneOldSize - dragPoint) = secondPaneNewSize.
	
	"The panes should still fit into the tabulator"
	self assert: firstPaneNewSize x = aTabulator getSize x.
	self assert: secondPaneNewSize x = aTabulator getSize x.
	self assert: firstPaneNewSize y + self resizingBarSizeInPixels + secondPaneNewSize y = aTabulator getSize y.
]

{ #category : #accessing }
SGLBasicTabulatorTest >> componentClass [
	^ SGLTwoRowsTabulatorTestComponent
]

{ #category : #'testing resizing' }
SGLBasicTabulatorTest >> testBottomDragAndDrop [

	self 
		assertVerticalDragAndDropForTabulator: (driver findElementByXPath: self tabulatorAbsoluteSelector) 
		by: 100.
	
]

{ #category : #'testing resizing' }
SGLBasicTabulatorTest >> testBottomDragAndDropByOnePixel [

	self 
		assertVerticalDragAndDropForTabulator: (driver findElementByXPath: self tabulatorAbsoluteSelector) 
		by: 1.
	
]

{ #category : #'testing resizing' }
SGLBasicTabulatorTest >> testBottomDragAndDropBySecondPanelHeight [
	| secondPaneSize |

	secondPaneSize := (driver findElementByXPath: self tabulatorAbsoluteSecondPaneSelector) getSize.
	self 
		assertVerticalDragAndDropForTabulator: (driver findElementByXPath: self tabulatorAbsoluteSelector) 
		by: secondPaneSize y.
	
]

{ #category : #'testing resizing' }
SGLBasicTabulatorTest >> testBottomDragAndDropOutsideTabulator [
	| secondPaneSize |

	secondPaneSize := (driver findElementByXPath: self tabulatorAbsoluteSecondPaneSelector) getSize.
	self 
		assertVerticalDragAndDropForTabulator: (driver findElementByXPath: self tabulatorAbsoluteSelector) 
		by: (secondPaneSize y + 5).
	
]

{ #category : #'testing resizing' }
SGLBasicTabulatorTest >> testBottomDragAndDropOutsideTabulatorByOne [
	| secondPaneSize |

	secondPaneSize := (driver findElementByXPath: self tabulatorAbsoluteSecondPaneSelector) getSize.
	self 
		assertVerticalDragAndDropForTabulator: (driver findElementByXPath: self tabulatorAbsoluteSelector) 
		by: (secondPaneSize y + 1).
	
]

{ #category : #'testing initialization' }
SGLBasicTabulatorTest >> testPanesContentSize [
	|firstPane secondPane emptyPresentation|
	
	
	firstPane := driver findElementByXPath: self tabulatorAbsoluteFirstPaneSelector. 
	secondPane := driver findElementByXPath: self tabulatorAbsoluteSecondPaneSelector. 
	
	emptyPresentation := firstPane findElementByXPath: self emptyPresentationSelector.
	self assert: firstPane getSize = (emptyPresentation getSize).
	
	emptyPresentation := secondPane findElementByXPath: self emptyPresentationSelector.
	self assert: secondPane getSize = (emptyPresentation getSize).
	
	

]

{ #category : #'testing initialization' }
SGLBasicTabulatorTest >> testPanesSize [
	|tabulator tabulatorSize firstPaneSize secondPaneSize offset|
	
	tabulator :=driver findElementByXPath: self tabulatorAbsoluteSelector.
	
	tabulatorSize := tabulator getSize.
	firstPaneSize := (tabulator findElementByXPath: self tabulatorStandaloneFirstPaneSelector) getSize.
	secondPaneSize := (tabulator findElementByXPath: self tabulatorStandaloneSecondPaneSelector) getSize.
	
	"If the available space for the panes is odd the first one should be one pixel bigger"
	offset := (tabulatorSize y -  self resizingBarSizeInPixels) odd ifTrue: [1] ifFalse: [0].
	
	self assert: (tabulatorSize x = firstPaneSize x).
	self assert: (tabulatorSize x = secondPaneSize x).

	self assert: (tabulatorSize y = (firstPaneSize y + self resizingBarSizeInPixels + secondPaneSize y) ).	
	self assert: (firstPaneSize y = (secondPaneSize y + offset)).
	
	

]

{ #category : #'testing initialization' }
SGLBasicTabulatorTest >> testResizeBarIsPresent [
	|tabulator|
	
	tabulator := driver findElementByXPath: self tabulatorAbsoluteSelector.
	
	self shouldXPathBePresent: self horizontalResizingBarSelector inElement: tabulator.
	"The resizing bar should be the second element in a tabulator"
	self shouldXPathBePresent: '*[2]' inElement: tabulator.
	
]

{ #category : #'testing initialization' }
SGLBasicTabulatorTest >> testTabulatorIsPresent [
	
	self shouldElementWithXPathBePresent: self tabulatorAbsoluteSelector,'[1]'.
	self shouldntElementWithXPathBePresent: self tabulatorAbsoluteSelector,'[2]'.
]

{ #category : #'testing initialization' }
SGLBasicTabulatorTest >> testTabulatorPanesArePresent [
	
	self shouldElementWithXPathBePresent: self tabulatorAbsoluteFirstPaneSelector.
	self shouldElementWithXPathBePresent: self tabulatorAbsoluteSecondPaneSelector.
	
	"There should only be one pane of each type"
	self shouldntElementWithXPathBePresent: self tabulatorAbsoluteFirstPaneSelector, '[2]'.
	self shouldntElementWithXPathBePresent: self tabulatorAbsoluteSecondPaneSelector, '[2]'.
]

{ #category : #'testing initialization' }
SGLBasicTabulatorTest >> testTabulatorSize [
	|bodySize tabulatorSize|
	
	bodySize := (driver findElementByXPath: self bodySelector) getSize.
	tabulatorSize := (driver findElementByXPath: self tabulatorAbsoluteSelector) getSize.

	"A tabulator is 20 pixels smallers than the body of the window"
	self assert: (tabulatorSize = ( bodySize - (0@20) ))
]

{ #category : #'testing resizing' }
SGLBasicTabulatorTest >> testTopDragAndDrop [

	self 
		assertVerticalDragAndDropForTabulator: (driver findElementByXPath: self tabulatorAbsoluteSelector) 
		by: 100 negated.
	
]

{ #category : #'testing resizing' }
SGLBasicTabulatorTest >> testTopDragAndDropByFirstPanelHeight [
	| firstPaneSize |

	firstPaneSize := (driver findElementByXPath: self tabulatorAbsoluteFirstPaneSelector) getSize.
	self 
		assertVerticalDragAndDropForTabulator: (driver findElementByXPath: self tabulatorAbsoluteSelector) 
		by: firstPaneSize y negated.
	
]

{ #category : #'testing resizing' }
SGLBasicTabulatorTest >> testTopDragAndDropByOnePixel [

	self 
		assertVerticalDragAndDropForTabulator: (driver findElementByXPath: self tabulatorAbsoluteSelector) 
		by: 1 negated.
	
]

{ #category : #'testing resizing' }
SGLBasicTabulatorTest >> testTopDragAndDropOutsideTabulator [
	| firstPaneSize |

	firstPaneSize := (driver findElementByXPath: self tabulatorAbsoluteFirstPaneSelector) getSize.
	self 
		assertVerticalDragAndDropForTabulator: (driver findElementByXPath: self tabulatorAbsoluteSelector) 
		by: (firstPaneSize y + 5) negated.
	
]

{ #category : #'testing resizing' }
SGLBasicTabulatorTest >> testTopDragAndDropOutsideTabulatorByOne [
	| firstPaneSize |

	firstPaneSize := (driver findElementByXPath: self tabulatorAbsoluteFirstPaneSelector) getSize.
	self 
		assertVerticalDragAndDropForTabulator: (driver findElementByXPath: self tabulatorAbsoluteSelector) 
		by: (firstPaneSize y + 1) negated.
	
]
