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
			((GLMSimpleTransmission new) 
				origin: (browser1 panes first port: #selection); 
				destination: (browser1 panes last port: #innerSelection); 
				yourself). 
	browser2 
		addTransmission: 
			((GLMSimpleTransmission new) 
				origin: 
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
GLMNestedBrowserTest >> testEntityPropogation [ 
	"This tests the order in which presentations and values are updated. 
 
	This is of importance as, in this test, we add a browser to a pane when a 
	certain port of that pane gets updated using a BundleTransmission but this 
	browser has a transmission from its #outer pane that refers to the same 
	port.  In such a case we want the presentation to be set first so that it can 
	be notified when the outer port changes." 
	 
	| browser1 browser2 presentation | 
	browser1 := GLMExplicitBrowser new. 
	browser2 := GLMExplicitBrowser new. 
	presentation := GLMPresentation new. 
	browser1 addNewPane. 
	browser2 addNewPane.	"Jumpstart presentation for outer browser." 
	browser1 addTransmission: 
			((GLMBundleTransmission new) 
				addActiveOrigin: 
						((GLMPresentationBoundPort new) 
								presentation: browser1; 
								name: #entity; 
								yourself); 
				destination: (browser1 panes first port: #entity); 
				addPresentation: browser2; 
				yourself).	"Jumpstart presentation for inner browser." 
	browser2 addTransmission: 
			((GLMBundleTransmission new) 
				addActiveOrigin: 
						((GLMPresentationBoundPort new) 
								presentation: browser2; 
								name: #entity; 
								yourself); 
				destination: (browser2 panes first port: #entity); 
				addPresentation: presentation; 
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
	self assert: browser1 panes first presentations first = browser2. 
	self assert: browser2 panes size = 1. 
	self assert: (browser2 panes first port: #entity) value = 42. 
	self assert: browser2 panes first presentations size = 1. 
	self assert: browser2 panes first presentations first = presentation
]

{ #category : #tests }
GLMNestedBrowserTest >> testEntityPropogationAnnouncements [ 
	"This tests the order in which announcements are raised in nested browsers. 
 
	This is of importance as, in this test, we add a browser to a pane when a 
	certain port of that pane gets updated using a BundleTransmission but this 
	browser has a transmission from its #outer pane that refers to the same 
	port.  In such a case we want the presentation to be set first so that it can 
	be notified when the outer port changes. 
 
	This is a sister test to testEntityPropogation that ensures that the 
	announcements are raised in the right order and not redundantly." 
	 
	| browser1 browser2 presentation announcements | 
	browser1 := GLMExplicitBrowser new title: '1'; yourself. 
	browser2 := GLMExplicitBrowser new title: '2'; yourself. 
	presentation := GLMPresentation new. 
	browser1 pane. 
	browser1 addNewPane. 
	browser2 addNewPane. 
	announcements := OrderedCollection new. 
	self assert: browser1 pane presentations size = 1. 
	self assert: browser1 pane presentations first == browser1. 
	browser1 whenContextChanged: [:ann | announcements addLast: ann]. 
	browser2 whenContextChanged: [:ann | announcements addLast: ann]. 
	presentation whenContextChanged: [:ann | announcements addLast: ann]. 
	browser1 pane whenPresentationsChanged: [:ann | announcements addLast: ann]. 
	browser1 panes first whenPresentationsChanged: [:ann | announcements addLast: ann]. 
	browser2 panes first whenPresentationsChanged: [:ann | announcements addLast: ann]. 
	browser1 pane whenMatchingPresentationsChanged: [:ann | announcements addLast: ann]. 
	browser1 panes first whenMatchingPresentationsChanged: [:ann | announcements addLast: ann]. 
	browser2 panes first whenMatchingPresentationsChanged: [:ann | announcements addLast: ann].	"Jumpstart presentation for outer browser." 
	browser1 
		addTransmission: 
			((GLMBundleTransmission new) 
				addActiveOrigin: 
						((GLMPresentationBoundPort new) 
								presentation: browser1; 
								name: #entity; 
								yourself); 
				destination: (browser1 panes first port: #entity); 
				addPresentation: browser2; 
				yourself).	"Jumpstart presentation for inner browser." 
	browser2 
		addTransmission: 
			((GLMBundleTransmission new) 
				addActiveOrigin: 
						((GLMPresentationBoundPort new) 
								presentation: browser2; 
								name: #entity; 
								yourself); 
				destination: (browser2 panes first port: #entity); 
				addPresentation: presentation; 
				yourself). 
	self assert: announcements isEmpty. 
	(browser1 pane port: #entity) value: 42. 
	self assert: announcements size = 8.	"1. The outer browser's outer pane changes its value." 
	self assert: ((announcements at: 1) isKindOf: GLMContextChanged). 
	self assert: (announcements at: 1) presentation == browser1. 
	self assert: (announcements at: 1) property = #entity. 
	self assert: (announcements at: 1) value = 42.	"2. The jumpstart transmission of the outer browser is triggered, updating the presentations..." 
	self assert: ((announcements at: 2) isKindOf: GLMPresentationsChanged). 
	self assert: (announcements at: 2) pane == browser1 panes first. 
	self assert: (announcements at: 2) oldPresentations isEmpty. 
	self assert: (announcements at: 2) presentations size = 1. 
	self assert: (announcements at: 2) presentations first == browser2.	"3. ...and then the context." 
	self assert: ((announcements at: 3) isKindOf: GLMContextChanged). 
	self assert: (announcements at: 3) presentation == browser2. 
	self assert: (announcements at: 3) property = #entity. 
	self assert: (announcements at: 3) value = 42.	"4. The jumpstart transmission of the inner browser is triggered, updating the presentations..." 
	self assert: ((announcements at: 4) isKindOf: GLMPresentationsChanged). 
	self assert: (announcements at: 4) pane == browser2 panes first. 
	self assert: (announcements at: 4) oldPresentations isEmpty. 
	self assert: (announcements at: 4) presentations size = 1. 
	self assert: (announcements at: 4) presentations first == presentation.	"5. ...and then the context." 
	self assert: ((announcements at: 5) isKindOf: GLMContextChanged). 
	self assert: (announcements at: 5) presentation == presentation. 
	self assert: (announcements at: 5) property = #entity. 
	self assert: (announcements at: 5) value = 42.	"6. Due to the context change of 5, the innermost presentation now matches." 
	self 
		assert: ((announcements at: 6) isKindOf: GLMMatchingPresentationsChanged). 
	self assert: (announcements at: 6) pane == browser2 panes first. 
	self assert: (announcements at: 6) oldMatchingPresentations isEmpty. 
	self assert: (announcements at: 6) matchingPresentations size = 1. 
	self 
		assert: (announcements at: 6) matchingPresentations first == presentation.	"7. Due to the context change of 3, the inner browser now matches." 
	self 
		assert: ((announcements at: 7) isKindOf: GLMMatchingPresentationsChanged). 
	self assert: (announcements at: 7) pane == browser1 panes first. 
	self assert: (announcements at: 7) oldMatchingPresentations isEmpty. 
	self assert: (announcements at: 7) matchingPresentations size = 1. 
	self assert: (announcements at: 7) matchingPresentations first == browser2.	"8. Due to the context change of 1, the outer browser now matches." 
	self 
		assert: ((announcements at: 8) isKindOf: GLMMatchingPresentationsChanged). 
	self assert: (announcements at: 8) pane == browser1 pane. 
	self assert: (announcements at: 8) oldMatchingPresentations isEmpty. 
	self assert: (announcements at: 8) matchingPresentations size = 1. 
	self assert: (announcements at: 8) matchingPresentations first == browser1
]
