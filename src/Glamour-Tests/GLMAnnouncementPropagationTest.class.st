Class {
	#name : #GLMAnnouncementPropagationTest,
	#superclass : #TestCase,
	#category : #'Glamour-Tests'
}

{ #category : #setup }
GLMAnnouncementPropagationTest >> setUp [
	GLMLogger instance: GLMMemoryLogger new
]

{ #category : #setup }
GLMAnnouncementPropagationTest >> tearDown [
	GLMLogger reset
]

{ #category : #tests }
GLMAnnouncementPropagationTest >> testEntityPropogationAnnouncements [ 
	"This tests the order in which announcements are raised in nested browsers. 
 
	This is of importance as, in this test, we add a browser to a pane when a 
	certain port of that pane gets updated using a BundleTransmission but this 
	browser has a transmission from its #outer pane that refers to the same 
	port.  In such a case we want the presentation to be set first so that it can 
	be notified when the outer port changes. 
 
	This is a sister test to testEntityPropogation that ensures that the 
	announcements are raised in the right order and not redundantly." 
	 
	| browser1 browser2 presentation announcements realBrowser2 realPresentation | 
	browser1 := GLMExplicitBrowser new title: '1'; yourself. 
	browser2 := GLMExplicitBrowser new title: '2'; yourself. 
	presentation := GLMPresentation new. 
	browser1 pane name: 'b1 parent pane'. 
	browser1 addNewPaneNamed: 'b1 pane'. 
	browser2 addNewPaneNamed: 'b2 pane'. 
	announcements := OrderedCollection new. 
	self assert: browser1 pane presentations size = 1. 
	self assert: browser1 pane presentations first == browser1. 
	browser1 whenContextChanged: [:ann | announcements addLast: ann]. 
	browser1 pane whenPresentationsChanged: [:ann | announcements addLast: ann]. 
	browser1 panes first whenPresentationsChanged: [:outerAnn | 
		announcements addLast: outerAnn.
		realBrowser2 := outerAnn pane presentations first.
		realBrowser2 whenContextChanged: [:ann | announcements addLast: ann].
		realBrowser2 panes first whenPresentationsChanged: [:ann | 
			announcements addLast: ann.
			realPresentation := ann pane presentations first.
			realPresentation whenContextChanged: [:ann2 | announcements addLast: ann2]].
		realBrowser2 panes first whenMatchingPresentationsChanged: [:ann | announcements addLast: ann] ]. 
	browser1 pane whenMatchingPresentationsChanged: [:ann | announcements addLast: ann]. 
	browser1 panes first whenMatchingPresentationsChanged: [:ann | announcements addLast: ann]. 
	browser1 addTransmission: 
			(GLMTransmission new
				ensureBundleStrategy;
				addActiveOrigin: 
						(GLMPresentationBoundPort new
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
						(GLMPresentationBoundPort new 
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
	self assert: (announcements at: 2) presentations first = browser2.	"3. ...and then the context." 
	self assert: ((announcements at: 3) isKindOf: GLMContextChanged). 
	self assert: (announcements at: 3) presentation = browser2. 
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
	self assert: ((announcements at: 6) isKindOf: GLMMatchingPresentationsChanged). 
	self assert: (announcements at: 6) pane == browser2 panes first. 
	self assert: (announcements at: 6) oldMatchingPresentations isEmpty. 
	self assert: (announcements at: 6) matchingPresentations size = 1. 
	self assert: (announcements at: 6) matchingPresentations first == presentation.	"7. Due to the context change of 3, the inner browser now matches." 
	self assert: ((announcements at: 7) isKindOf: GLMMatchingPresentationsChanged). 
	self assert: (announcements at: 7) pane == browser1 panes first. 
	self assert: (announcements at: 7) oldMatchingPresentations isEmpty. 
	self assert: (announcements at: 7) matchingPresentations size = 1. 
	self assert: (announcements at: 7) matchingPresentations first == browser2.	"8. Due to the context change of 1, the outer browser now matches." 
	self assert: ((announcements at: 8) isKindOf: GLMMatchingPresentationsChanged). 
	self assert: (announcements at: 8) pane == browser1 pane. 
	self assert: (announcements at: 8) oldMatchingPresentations isEmpty. 
	self assert: (announcements at: 8) matchingPresentations size = 1. 
	self assert: (announcements at: 8) matchingPresentations first == browser1
]

{ #category : #'as yet unclassified' }
GLMAnnouncementPropagationTest >> testSimple [
	GLMPresentation new announce: GLMContextChanged new.
	self assert: GLMLogger instance announcements size = 1
]

{ #category : #'as yet unclassified' }
GLMAnnouncementPropagationTest >> testSimpleCreation [
	| browser announcements pane |
	browser := GLMBrowser new.
	browser startOn: 42.
	self assert: GLMLogger instance announcements copy size = 4.
"	
browser pane.

browser pane presentations pane"
]

{ #category : #'as yet unclassified' }
GLMAnnouncementPropagationTest >> testSimplePropagation [
	| browser announcements pane |
	browser := GLMTabulator new.
	browser column: #pane1.
	browser transmit to: #pane1; andShow: [:a | a text ].
	browser startOn: 42.
	self assert: GLMLogger instance announcements copy size = 8.
"	
browser pane.

browser pane presentations pane"
]
