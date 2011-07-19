Class {
	#name : #SGLDashboardPresenter,
	#superclass : #SGLBrowserPresenter,
	#category : #'Glamour-Seaside-Rendering'
}

{ #category : #private }
SGLDashboardPresenter >> firstColumnPanesFrom: aGLMDashboard [

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
SGLDashboardPresenter >> renderColumnPane: aPane on: html [

	| tag |
	tag := html div.
	tag 
		script: html jQuery new glamourDashboard;
		with: [ self render: aPane on: html].
]

{ #category : #rendering }
SGLDashboardPresenter >> renderColumnWith: aCollectionOfPanes on: html [
	
	aCollectionOfPanes do: [:currentPane |
		self renderColumnPane:  currentPane on: html.
		]
	
]

{ #category : #rendering }
SGLDashboardPresenter >> renderContentOn: html [
	
	 self renderMainDivOn: html
	
]

{ #category : #rendering }
SGLDashboardPresenter >> renderMainDivOn: html [

	html div 
		script: (self resizeAndSplitVerticalyScriptOn: html);
		with: [
			html div
				script: html jQuery new glamourDashboard;
				with: [self renderColumnWith: (self firstColumnPanesFrom: self browser) on: html.
			].
				
			html div 
				script: html jQuery new glamourDashboard;
				with: [self renderColumnWith: (self secondColumnPanesFrom: self browser) on: html.]  
			]
	


	"example to see how to display a tabulator"	
			
			"html div 
			script: html jQuery new glamourDashboard;				
			with:[
							
					html div
						script: html jQuery new glamourDashboard;
						with: [
							self render: ((self firstColumnPanesFrom: self browser) at: 4) on: html
							].
					html div
						script: html jQuery new glamourDashboard;
						with: [
							self render: ((self firstColumnPanesFrom: self browser) at: 2) on: html
							].
					html div	
						script: html jQuery new glamourDashboard;
						with: [
							self render: ((self firstColumnPanesFrom: self browser) at: 1) on: html
							].

						]"
			

]

{ #category : #'jQuery-scripts' }
SGLDashboardPresenter >> resizeAndSplitHorizontalyScriptOn: html [
	^ html jQuery new glamourResize
		"paneASpan: 1 ;
		remainingSpan: 1;"
	 	splitHorizontal.
]

{ #category : #'jQuery-scripts' }
SGLDashboardPresenter >> resizeAndSplitVerticalyScriptOn: html [
	^ html jQuery new glamourResize 
			splitVertical.
]

{ #category : #'jQuery-scripts' }
SGLDashboardPresenter >> resizeHorizontalyScriptOn: html [
	^ html jQuery new glamourResizeHorizontaly
		"paneASpan: 1 ;
		remainingSpan: 1;"
	 	"splitHorizontal."
]

{ #category : #'jQuery-scripts' }
SGLDashboardPresenter >> resizeScriptOn: html [
	^ html jQuery new glamourResize
		"paneASpan: 1 ;
		remainingSpan: 1;"
	 	"splitHorizontal."
]

{ #category : #private }
SGLDashboardPresenter >> secondColumnPanesFrom: aGLMDashboard [

	|tmpHalfSizePanes tmpResult|
	aGLMDashboard panes isEmpty ifTrue: [^#()].
	tmpResult := OrderedCollection new.
	tmpHalfSizePanes := (aGLMDashboard panes size / 2) asFloat rounded.
	(tmpHalfSizePanes + 1) to: aGLMDashboard panes size do: [:anIndex |
		tmpResult add: (aGLMDashboard panes at: anIndex)
		].
	^ tmpResult
]
