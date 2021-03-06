Class {
	#name : #GLMNestedBrowserTest,
	#superclass : #TestCase,
	#category : #'Glamour-Tests'
}

{ #category : #tests }
GLMNestedBrowserTest >> testChangeInnerSelection [ 
	"Tests setting the selection of an inner pane from the oustide. 
 
	The test sets up a browser with two panes. The first contains a 
	list of numbers, the second a browser which again contains one 
	pane with a list of the same numbers. When the selection in the 
	first pane changes, we want the same number to be selected in 
	the second pane. 
 
	To achieve this, we pull in a port on the second pane and copy 
	it to the inner pane using a simple transmission." 
	 
	| browser1 browser2 list1 list2 | 
	browser1 := GLMExplicitBrowser new. 
	browser2 := GLMExplicitBrowser new. 
	list1 := GLMListPresentation new. 
	list2 := GLMListPresentation new. 
	browser1 addNewPane. 
	browser1 addNewPane. 
	browser2 addNewPane. 
	browser1 panes first addPresentation: list1. 
	browser1 panes last addPresentation: browser2. 
	browser2 panes first addPresentation: list2. 
	browser1 
		addTransmission: 
			((GLMTransmission new) 
				addActiveOrigin: (browser1 panes first port: #selection); 
				destination: (browser1 panes last port: #innerSelection); 
				yourself). 
	browser2 
		addTransmission: 
			((GLMTransmission new) 
				addActiveOrigin: 
						((GLMPresentationBoundPort new) 
								presentation: browser2; 
								name: #innerSelection; 
								yourself); 
				destination: (browser2 panes first port: #selection); 
				yourself). 
	list1 entity: #(1 2 3). 
	list2 entity: #(1 2 3). 
	list1 selection: 1. 
	self assert: list2 selection = 1. 
	list1 selection: 2. 
	self assert: list2 selection = 2
]

{ #category : #tests }
GLMNestedBrowserTest >> testCondition [
	"This tests that the nested browser is controlled by the condition" 
	 
	| browser1 browser2 transmission1 | 
	browser1 := GLMExplicitBrowser new. 
	browser2 := GLMExplicitBrowser new. 
	browser1 title: 'browser1'. 
	browser2 title: 'browser2'. 
	browser2 
				transformation: [:x | x = 42 ifFalse: [self fail. 42 ] ifTrue: [84] ];
				condition: [:x | x = 42].
	browser1 addNewPane name: 'pane1'. 
	transmission1 := GLMTransmission new ensureBundleStrategy.
	transmission1 transmissionStrategy addPresentation: browser2. 
	browser1 addTransmission: (transmission1
				addActiveOrigin: (GLMPresentationBoundPort new 
								presentation: browser1; 
								name: #entity; 
								yourself); 
				destination: (browser1 panes first port: #entity); 
				yourself).
	self assert: (browser1 pane port: #entity) value isNil. 
	self assert: (browser1 panes first port: #entity) value isNil. 
	self assert: browser1 panes first presentations isEmpty. 
	(browser1 pane port: #entity) value: 41. 
	self assert: (browser1 pane port: #entity) value = 41. 
	self assert: (browser1 panes first port: #entity) value = 41.
	self assert: browser1 panes first presentations size = 1.
	self assert: browser1 panes first matchingPresentations size = 0.
	(browser1 pane port: #entity) value: 42. 
	self assert: (browser1 pane port: #entity) value = 42. 
"	self assert: (browser1 panes first port: #entity) presentations value = 84.
"	self assert: browser1 panes first presentations size = 1. 
	self assert: browser1 panes first matchingPresentations size = 1
]

{ #category : #tests }
GLMNestedBrowserTest >> testEntityPropogation [ 
	"This tests that the nested transmissions have the destination correctly set 
	to be in the pane from the outer browser." 
	 
	| browser1 browser2 presentation innerBrowser transmission1 transmission2 | 
	browser1 := GLMExplicitBrowser new. 
	browser2 := GLMExplicitBrowser new. 
	presentation := GLMPresentation new. 
	browser1 title: 'browser1'. 
	browser2 title: 'browser2'. 
	browser1 addNewPane name: 'pane1'. 
	browser2 addNewPane name: 'innerpane 1'.	"Jumpstart presentation for outer browser." 
	transmission1 := GLMTransmission new ensureBundleStrategy.
	transmission1 transmissionStrategy addPresentation: browser2. 
	browser1 addTransmission: (transmission1
				addActiveOrigin: (GLMPresentationBoundPort new 
								presentation: browser1; 
								name: #entity; 
								yourself); 
				destination: (browser1 panes first port: #entity); 
				yourself).	"Jumpstart presentation for inner browser." 
	transmission2 := GLMTransmission new ensureBundleStrategy.
	transmission2 transmissionStrategy addPresentation: presentation. 
	browser2 addTransmission: (transmission2
				addActiveOrigin: (GLMPresentationBoundPort new
								presentation: browser2; 
								name: #entity; 
								yourself); 
				destination: (browser2 panes first port: #entity); 
				yourself). 
	self assert: (browser1 pane port: #entity) value isNil. 
	self assert: browser1 panes size = 1. 
	self assert: (browser1 panes first port: #entity) value isNil. 
	self assert: browser1 panes first presentations isEmpty. 
	self assert: browser2 panes size = 1. 
	self assert: (browser2 panes first port: #entity) value isNil. 
	self assert: browser2 panes first presentations isEmpty. 
	(browser1 pane port: #entity) value: 42. 
	self assert: (browser1 pane port: #entity) value = 42. 
	self assert: browser1 panes size = 1.
	self assert: (browser1 panes first port: #entity) value = 42.
	self assert: browser1 panes first presentations size = 1. 
	innerBrowser := browser1 panes first presentations first.
	self assert: innerBrowser rootPrototype = browser2. 
	self assert: innerBrowser pane == browser1 panes first.
	self assert: innerBrowser panes size = 1.
	self assert: (innerBrowser panes first port: #entity) value = 42.
	self assert: innerBrowser panes first presentations size = 1.
	self assert: innerBrowser panes first presentations first rootPrototype = presentation
]

{ #category : #tests }
GLMNestedBrowserTest >> testInnerTransmissions [
	"This tests that the nested transmissions have the destination correctly set 
	to be in the pane from the outer browser." 
	 
	| browser1 browser2 presentation innerBrowser | 
	browser1 := GLMExplicitBrowser new. 
	browser2 := GLMExplicitBrowser new. 
	presentation := GLMPresentation new. 
	browser1 addNewPane name: 'pane1'. 
	browser2 addNewPane name: 'innerpane 1'.	"Jumpstart presentation for outer browser." 
	browser1 addTransmission: 
			(GLMTransmission new
				ensureBundleStrategy;
				addActiveOrigin: 
						((GLMPresentationBoundPort new) 
								presentation: browser1; 
								name: #entity; 
								yourself); 
				destination: (browser1 panes first port: #entity); 
				addPresentation: browser2; 
				yourself).	"Jumpstart presentation for inner browser." 
	browser2 addTransmission: 
			(GLMTransmission new
				ensureBundleStrategy;
				addActiveOrigin: 
						((GLMPresentationBoundPort new) 
								presentation: browser2; 
								name: #entity; 
								yourself); 
				destination: (browser2 panes first port: #entity); 
				addPresentation: presentation; 
				yourself). 

	(browser1 pane port: #entity) value: 42. 
	innerBrowser := browser1 panes first presentations first.
	self assert: innerBrowser transmissions size = 1.
	self assert: (innerBrowser transmissions first origins first isKindOf: GLMPresentationBoundPort).
	self assert: innerBrowser transmissions first origins first pane == browser1 panes first
]

{ #category : #tests }
GLMNestedBrowserTest >> testNestedBrowsersWithMultipleOrigins [
	| browser innerBrowser transmittedOne transmittedTwo|
	innerBrowser := GLMTabulator new.
	innerBrowser row: #inner.
	innerBrowser transmit to: #inner; andShow: [ :a | a text ].
	
	browser := GLMTabulator new.
	browser column: #one; column: #two; column: #three.
	browser transmit to: #three; from: #one; from: #two; andShow: [ :a | 
		a custom: 
			(innerBrowser
				display: [:one :two | 
					transmittedOne := one. 
					transmittedTwo := two ]) ].
	((browser paneNamed: #one) port: #selection) value: 1.
	((browser paneNamed: #two) port: #selection) value: 2.
	
]
