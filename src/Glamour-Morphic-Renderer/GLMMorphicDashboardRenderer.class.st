Class {
	#name : #GLMMorphicDashboardRenderer,
	#superclass : #GLMMorphicBrowserRenderer,
	#category : #'Glamour-Morphic-Renderer'
}

{ #category : #rendering }
GLMMorphicDashboardRenderer >> firstColumnMaxCellSizeFrom: aGLMDashboard [

	|tmpMaxVerticalSize tmpMaxHorizontalSize|
	tmpMaxHorizontalSize := 0.
	tmpMaxVerticalSize := 0.
	(self firstColumnPanesFrom: aGLMDashboard) do: [:aGLMPane |
		|tmpPaneExtent|
		tmpPaneExtent := aGLMDashboard extentOfPaneNamed: aGLMPane name.  
		tmpPaneExtent x > tmpMaxHorizontalSize ifTrue: [tmpMaxHorizontalSize := tmpPaneExtent x].
		tmpPaneExtent y > tmpMaxVerticalSize ifTrue: [tmpMaxVerticalSize := tmpPaneExtent y].
		].   
	^ tmpMaxHorizontalSize @ tmpMaxVerticalSize 

	
	
]

{ #category : #rendering }
GLMMorphicDashboardRenderer >> firstColumnMinCellSizeFrom: aGLMDashboard [

	|tmpMinVerticalSize tmpMinHorizontalSize|
	tmpMinHorizontalSize := (aGLMDashboard extentOfPaneNamed: (aGLMDashboard panes anyOne name)) x  .
	tmpMinVerticalSize :=  (aGLMDashboard extentOfPaneNamed: (aGLMDashboard panes anyOne name)) y.
	(self firstColumnPanesFrom: aGLMDashboard) do: [:aGLMPane |
		|tmpPaneExtent|
		tmpPaneExtent := aGLMDashboard extentOfPaneNamed: aGLMPane name.  
		tmpPaneExtent x < tmpMinHorizontalSize ifTrue: [tmpMinHorizontalSize := tmpPaneExtent x].
		tmpPaneExtent y < tmpMinVerticalSize ifTrue: [tmpMinVerticalSize := tmpPaneExtent y].
		].   
	^ tmpMinHorizontalSize @ tmpMinVerticalSize 
]

{ #category : #rendering }
GLMMorphicDashboardRenderer >> firstColumnPanesFrom: aGLMDashboard [

	|tmpHalfSizePanes tmpResult|
	aGLMDashboard panes isEmpty ifTrue: [^#()].
	tmpResult := OrderedCollection new.
	tmpHalfSizePanes := (aGLMDashboard panes size / 2) asFloat rounded.
	1 to: tmpHalfSizePanes do: [:anIndex |
		tmpResult add: (aGLMDashboard panes at: anIndex)
		].
	^ tmpResult
]

{ #category : #rendering }
GLMMorphicDashboardRenderer >> render: aBrowser [
	| container firstColumnContainer secondColumnContainer scrollPane panesMidSize|
	firstColumnContainer := PanelMorph new.
	secondColumnContainer := PanelMorph new.
	container := PanelMorph new.
	aBrowser defaultPaneExtent: #glamourOptimalExtent.
	firstColumnContainer  
		fillStyle: Color transparent;
		fillStyle: Color transparent;
		changeTableLayout;
		cellPositioning: #topRight;
		layoutInset: 2;
		"maxCellSize: (self firstColumnMaxCellSizeFrom: aBrowser) ;"
		"minCellSize: 20@20 ;"
		cellInset: 2.
		
	secondColumnContainer   
		fillStyle: Color transparent;
		changeTableLayout;
		cellPositioning: #topLeft; 
		layoutInset: 2;
		"maxCellSize: (self secondColumnMaxCellSizeFrom: aBrowser) ;"
		"minCellSize: (self secondColumnMaxCellSizeFrom: aBrowser);"
		cellInset: 2.
		
	container   
		fillStyle: Color transparent;
		changeTableLayout;
		extent: 200@200;
		layoutInset: 2;
		cellPositioning: #topLeft;
		"maxCellSize: 400@200;
		minCellSize: 400@150;"
		listDirection: #leftToRight;
		cellInset: 2.
	
	aBrowser extentStrategy initializeContainer: container.
	aBrowser extentStrategy initializeFirstColumn: firstColumnContainer.
	aBrowser extentStrategy initializeSecondColumn: secondColumnContainer.
	scrollPane := GeneralScrollPane new.
	scrollPane 
		changeScrollerTableLayout;
		scrollTarget: container.
		
	(self firstColumnPanesFrom: aBrowser) reverseDo: [:aGLMPane |
		self renderPane: aGLMPane inUI: firstColumnContainer  from: aBrowser.
		].  
	(self secondColumnPanesFrom: aBrowser) reverseDo: [:aGLMPane |
		self renderPane: aGLMPane inUI: secondColumnContainer  from: aBrowser
		].
	
	container addMorph: secondColumnContainer.
	container addMorph: firstColumnContainer.
	
	aBrowser on: GLMBrowserClosed send: #actOnBrowserClosed: to: self.
	^ scrollPane
]

{ #category : #private }
GLMMorphicDashboardRenderer >> renderPane: aPane inUI: aMorph from: aGLMDashboard [

	| pane totalSpans currentSpanPosition currentOffset tmpExtent|
	pane := self renderObject: (aPane). 
	"pane
		hResizing: #rigid;
		vResizing: #rigid."
	
	
	"self haltIf: [aPane name = #dashboard]."
	"pane extent: (aGLMDashboard extentOfPaneNamed: aPane name). "
	aGLMDashboard extentStrategy initializePane: pane.
	pane extent: ((aGLMDashboard extentOfPaneNamed: aPane name) glamourValue: pane). 
	"self haltIf: [pane submorphs contains: [:a | a isKindOf: GeneralScrollPane]]."
	aMorph addMorph: pane.

]

{ #category : #rendering }
GLMMorphicDashboardRenderer >> secondColumnMaxCellSizeFrom: aGLMDashboard [

	|tmpMaxVerticalSize tmpMaxHorizontalSize|
	tmpMaxHorizontalSize := 0.
	tmpMaxVerticalSize := 0.
	(self secondColumnPanesFrom: aGLMDashboard) do: [:aGLMPane |
		|tmpPaneExtent|
		tmpPaneExtent := aGLMDashboard extentOfPaneNamed: aGLMPane name.  
		tmpPaneExtent x > tmpMaxHorizontalSize ifTrue: [tmpMaxHorizontalSize := tmpPaneExtent x].
		tmpPaneExtent y > tmpMaxVerticalSize ifTrue: [tmpMaxVerticalSize := tmpPaneExtent y].
		].   
	^ tmpMaxHorizontalSize @ tmpMaxVerticalSize 
]

{ #category : #rendering }
GLMMorphicDashboardRenderer >> secondColumnMinCellSizeFrom: aGLMDashboard [

	|tmpMinVerticalSize tmpMinHorizontalSize|
	tmpMinHorizontalSize := (aGLMDashboard extentOfPaneNamed: (aGLMDashboard panes anyOne name)) x  .
	tmpMinVerticalSize :=  (aGLMDashboard extentOfPaneNamed: (aGLMDashboard panes anyOne name)) y.
	(self secondColumnPanesFrom: aGLMDashboard) do: [:aGLMPane |
		|tmpPaneExtent|
		tmpPaneExtent := aGLMDashboard extentOfPaneNamed: aGLMPane name.  
		tmpPaneExtent x < tmpMinHorizontalSize ifTrue: [tmpMinHorizontalSize := tmpPaneExtent x].
		tmpPaneExtent y < tmpMinVerticalSize ifTrue: [tmpMinVerticalSize := tmpPaneExtent y].
		].   
	^ tmpMinHorizontalSize @ tmpMinVerticalSize 
]

{ #category : #rendering }
GLMMorphicDashboardRenderer >> secondColumnPanesFrom: aGLMDashboard [

	|tmpHalfSizePanes tmpResult|
	aGLMDashboard panes isEmpty ifTrue: [^#()].
	tmpResult := OrderedCollection new.
	tmpHalfSizePanes := (aGLMDashboard panes size / 2) asFloat rounded.
	(tmpHalfSizePanes + 1) to: aGLMDashboard panes size do: [:anIndex |
		tmpResult add: (aGLMDashboard panes at: anIndex)
		].
	^ tmpResult
]
