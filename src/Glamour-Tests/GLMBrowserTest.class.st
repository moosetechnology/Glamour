Class {
	#name : #GLMBrowserTest,
	#superclass : #TestCase,
	#category : #'Glamour-Tests'
}

{ #category : #'as yet unclassified' }
GLMBrowserTest >> testNoComposite [
	| browser |
	browser := GLMBrowser new.
	self assert: browser pane presentations size = 1.
	self assert: browser pane presentations first = browser.
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
	presentation updateYourselfOn: TestAnnouncement from: [ announcer ].
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
	presentation updateYourselfOn: TestAnnouncement from: [ announcer ].
	presentation registerAnnouncements.
	self assert: (announcer instVarNamed: 'subscriptions') size = 1.
	browser removePane: pane.
	self assert: (announcer instVarNamed: 'subscriptions') isEmpty.

]
