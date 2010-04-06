Class {
	#name : #GLMBrowserTest,
	#superclass : #TestCase,
	#category : #'Glamour-Tests'
}

{ #category : #'as yet unclassified' }
GLMBrowserTest >> testHasStatusbar [
	| browser |
	browser := GLMBrowser new.
	self deny: browser hasStatusbar.
	browser hasStatusbar: true.
	self assert: browser panes size = 1.
	self assert: browser panes first name = GLMBrowser defaultStatusbarPane.
	self assert: browser statusbarPane == browser panes first
]

{ #category : #'as yet unclassified' }
GLMBrowserTest >> testNoComposite [
	| browser |
	browser := GLMBrowser new.
	self assert: browser pane presentations size = 1.
	self assert: browser pane presentations first = browser.
]

{ #category : #'as yet unclassified' }
GLMBrowserTest >> testSimplePropagation [
	| browser announcements pane |
	browser := GLMBrowser new.
	pane := GLMPane named: 'pane1'.
	browser addPane: pane.
	browser addTransmission: 
			(GLMTransmission new
				ensureBundleStrategy;
				addActiveOrigin: 
						(GLMPresentationBoundPort new
								presentation: browser;
								name: #entity; 
								yourself); 
				destination: (browser panes first port: #entity); 
				addPresentation: GLMPresentation new; 
				yourself).
	announcements := OrderedCollection new. 
	browser whenContextChanged: [:ann | announcements addLast: ann].
	browser pane whenPresentationsChanged: [:ann | announcements addLast: ann].
	browser pane whenMatchingPresentationsChanged: [:ann | announcements addLast: ann].
"	browser panes first whenContextChanged: [:ann | announcements addLast: ann].
"	browser panes first whenPresentationsChanged: [:ann | announcements addLast: ann].
	browser panes first whenMatchingPresentationsChanged: [:ann | announcements addLast: ann].
	browser startOn: 42.
	self assert: announcements size = 5
]

{ #category : #'as yet unclassified' }
GLMBrowserTest >> testStatusbarTransmissions [
	| browser pane |
	browser := GLMBrowser new.
	browser addStatusbar.
	pane := GLMPane new.
	browser addPane: pane.
	self assert: browser transmissions size = 1.
	self assert: browser transmissions first origins size = 1.
	self assert: browser transmissions first origins first = (pane port: #status).
	self assert: browser transmissions first destination = (browser panes first port: #entity).
	self assert: (browser transmissions first presentations first isKindOf: GLMLabelPresentation)
]

{ #category : #'as yet unclassified' }
GLMBrowserTest >> testStatusbarTransmissionsTriggered [
	| browser pane |
	browser := GLMTabulator new.
	browser addStatusbar.
	self assert: browser statusbarPane notNil.
	self assert: browser statusbarPane ~= browser.
	pane := (GLMPane in: browser) name: #one.
	browser addPane: pane.
	self assert: browser transmissions size = 1.
	(pane port: #status) value: #test.
	self assert: browser statusbarPane ~= browser.
	self assert: (browser statusbarPane port: #entity) value = #test.
	self assert: (browser statusbarPane presentations size = 1).
	self assert: (browser statusbarPane presentations first isKindOf: GLMLabelPresentation)
]

{ #category : #'as yet unclassified' }
GLMBrowserTest >> testUnregisterAnnouncements [
	| announcer presentation browser pane |
	announcer := Announcer new.
	browser := GLMBrowser new.
	pane := GLMPane new.
	presentation := GLMPresentation new.
	pane addPresentation: presentation.
	browser addPane: pane.
	presentation updateOn: TestAnnouncement from: [ announcer ].
	presentation registerAnnouncements.
	self assert: (announcer instVarNamed: 'subscriptions') size = 1.
	browser unregisterFromAllAnnouncements.
	self assert: (announcer instVarNamed: 'subscriptions') isEmpty.

]

{ #category : #'as yet unclassified' }
GLMBrowserTest >> testUnregisterAnnouncementsWhenRemovingPane [
	| announcer presentation browser pane |
	announcer := Announcer new.
	browser := GLMBrowser new.
	pane := GLMPane new.
	presentation := GLMPresentation new.
	pane addPresentation: presentation.
	browser addPane: pane.
	presentation updateOn: TestAnnouncement from: [ announcer ].
	presentation registerAnnouncements.
	self assert: (announcer instVarNamed: 'subscriptions') size = 1.
	browser removePane: pane.
	self assert: (announcer instVarNamed: 'subscriptions') isEmpty.

]
