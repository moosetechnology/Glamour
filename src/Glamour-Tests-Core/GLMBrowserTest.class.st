Class {
	#name : #GLMBrowserTest,
	#superclass : #TestCase,
	#category : #'Glamour-Tests-Core'
}

{ #category : #tests }
GLMBrowserTest >> testHasStatusbar [
	| browser |
	browser := GLMBrowser new.
	self deny: browser hasStatusbar.
	browser hasStatusbar: true.
	self assert: browser panes size equals: 1.
	self assert: browser panes first name equals: GLMBrowser defaultStatusbarPane.
	self assert: browser statusbarPane == browser panes first
]

{ #category : #tests }
GLMBrowserTest >> testNoComposite [
	| browser |
	browser := GLMBrowser new.
	self assert: browser pane presentations size equals: 1.
	self assert: browser pane presentations first equals: browser
]

{ #category : #tests }
GLMBrowserTest >> testStatusbarTransmissions [
	| browser pane |
	browser := GLMBrowser new.
	browser addStatusbar.
	pane := GLMPane new.
	browser addPane: pane.
	self assert: browser transmissions size equals: 1.
	self assert: browser transmissions first origins size equals: 1.
	self assert: browser transmissions first origins first equals: (pane port: #status).
	self assert: browser transmissions first destination equals: (browser panes first port: #entity).
	self assert: (browser transmissions first presentations first isKindOf: GLMLabelPresentation)
]

{ #category : #tests }
GLMBrowserTest >> testStatusbarTransmissionsTriggered [
	| browser pane |
	browser := GLMTabulator new.
	browser addStatusbar.
	self assert: browser statusbarPane notNil.
	self assert: browser statusbarPane ~= browser.
	pane := (GLMPane in: browser) name: #one.
	browser addPane: pane.
	self assert: browser transmissions size equals: 1.
	(pane port: #status) value: #test.
	self assert: browser statusbarPane ~= browser.
	self assert: (browser statusbarPane port: #entity) value equals: #test.
	self assert: browser statusbarPane presentations size equals: 1.
	self assert: (browser statusbarPane presentations first isKindOf: GLMLabelPresentation)
]

{ #category : #tests }
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
	self assert: announcer subscriptions numberOfSubscriptions equals: 1.
	browser unregisterFromAllAnnouncements.
	self assert: announcer subscriptions numberOfSubscriptions equals: 0
]

{ #category : #tests }
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
	self assert: announcer subscriptions numberOfSubscriptions equals: 1.
	browser removePane: pane.
	self assert: announcer subscriptions numberOfSubscriptions equals: 0
]

{ #category : #tests }
GLMBrowserTest >> testUnregisterAnnouncementsWhenUpdatingPane [
	| announcer browser |
	announcer := Announcer new.
	browser := GLMTabulator new.
	browser row: #one.
	(browser transmit)
		to: #one;
		andShow: [ :presenter | 
					(presenter list)
						updateOn: TestAnnouncement from: [ announcer ];
						display: [ :start | start to: 10 ] ].
	browser startOn: 1.
	browser panes first presentations first registerAnnouncements.
	browser unregisterFromAllAnnouncements.
	self assert: announcer subscriptions numberOfSubscriptions equals: 0
]

{ #category : #tests }
GLMBrowserTest >> testUnregisterAnnouncementsWhenUpdatingPaneWithTwoAnnouncers [
	| announcer browser announcer2 |
	announcer := Announcer new.
	announcer2 := Announcer new.
	browser := GLMTabulator new.
	browser row: #one.
	(browser transmit)
		to: #one;
		andShow: [ :presenter | 
					(presenter list)
						updateOn: TestAnnouncement
							fromAll: [ 
									{announcer.
									nil.
									announcer2} ];
						display: [ :start | start to: 10 ] ].
	browser startOn: 1.
	browser panes first presentations first registerAnnouncements.
	browser unregisterFromAllAnnouncements.
	self assert: announcer subscriptions numberOfSubscriptions equals: 0.
	self assert: announcer2 subscriptions numberOfSubscriptions equals: 0
]
