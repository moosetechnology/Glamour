Class {
	#name : #GLMFinderTest,
	#superclass : #TestCase,
	#category : #'Glamour-Tests-Core'
}

{ #category : #tests }
GLMFinderTest >> testEmptyPanes [
	| browser | 
	browser := GLMFinder new. 
	self assert: browser panes isEmpty. 
	self assert: browser transmissions isEmpty.
]

{ #category : #tests }
GLMFinderTest >> testPaneCreation [ 
	| browser | 
	browser := GLMFinder new. 
	browser addPresentation: (GLMPresentation new title: 'presentation1'). 
	self assert: browser panes isEmpty.	"Outer entity changed." 
	(browser pane port: #entity) value: #value1. 
	self assert: browser panes size = 1. 
	self assert: browser panes first browser == browser. 
	self assert: (browser panes first port: #entity) value = #value1. 
	self assert: browser panes first presentations size = 1. 
	self assert: browser panes first presentations first title = 'presentation1'. 
	self assert: browser panes first presentations first ~~ browser presentations first.	"First pane selection changed." 
	(browser panes first port: #selection) value: #value2. 
	self assert: browser panes size = 2. 
	self assert: browser panes last browser == browser. 
	self assert: (browser panes last port: #entity) value = #value2. 
	self assert: browser panes last presentations first title = 'presentation1'. 
	self assert: browser panes last presentations first ~~ browser presentations first. 
	self assert: 
			browser panes last presentations first 
				~~ browser panes first presentations first.	"Second pane selection changed." 
	(browser panes last port: #selection) value: #value3. 
	self assert: browser panes size = 3. 
	self assert: browser panes last browser == browser. 
	self assert: (browser panes last port: #entity) value = #value3.	"First pane selection changed again." 
	(browser panes first port: #selection) value: #value4. 
	self assert: browser panes size = 2. 
	self assert: browser panes last browser == browser. 
	self assert: (browser panes last port: #entity) value = #value4.	"Outer entity changed again." 
	(browser pane port: #entity) value: #value5. 
	self assert: browser panes size = 1. 
	self assert: browser panes last browser == browser. 
	self assert: (browser panes last port: #entity) value = #value5
]

{ #category : #tests }
GLMFinderTest >> testPortPublishing [ 
	 
	| browser | 
	browser := GLMFinder new. 
	(browser pane port: #entity) value: #value1. 
	self assert: browser panes size = 1. 
	self assert: browser pane ports size = 1. 
	self assert: (browser pane port: #entity) value = #value1. 
	(browser panes first port: #selection) value: #value2. 
	self assert: browser panes size = 2. 
	self assert: browser pane ports size = 2. 
	self assert: (browser pane port: #entity) value = #value1. 
	self assert: (browser pane port: #selection) value = #value2. 
	(browser panes last port: #selection) value: #value3. 
	self assert: browser panes size = 3. 
	self assert: browser pane ports size = 2. 
	self assert: (browser pane port: #entity) value = #value1. 
	self assert: (browser pane port: #selection) value = #value3. 
	(browser panes first port: #hover) value: #value4. 
	self assert: browser panes size = 3. 
	self assert: browser pane ports size = 3. 
	self assert: (browser pane port: #entity) value = #value1. 
	self assert: (browser pane port: #selection) value = #value3. 
	self assert: (browser pane port: #hover) value = #value4
]

{ #category : #tests }
GLMFinderTest >> testUnregisterAnnouncementsWhenRemovingPane [
	| announcer browser presentation |
	announcer := Announcer new.
	browser := GLMFinder new.
	presentation := GLMPresentation new.
	presentation title: [:entity | entity].
	browser addPresentation: presentation.
	presentation updateOn: TestAnnouncement from: [ announcer ].
	browser entity: #value1.
	browser panes first presentations first registerAnnouncements.
	self assert: ((announcer instVarNamed: 'subscriptions') at: TestAnnouncement) size = 1.
	self assert: ((announcer instVarNamed: 'subscriptions') at: TestAnnouncement) first receiver presentation = browser panes first presentations first.
	self assert: ((announcer instVarNamed: 'subscriptions') at: TestAnnouncement) first receiver presentation == browser panes first presentations first.
	(browser panes first port: #selection) value: #value2.
	browser panes last presentations first registerAnnouncements.
	self assert: ((announcer instVarNamed: 'subscriptions') at: TestAnnouncement) size = 2.
	self assert: ((announcer instVarNamed: 'subscriptions') at: TestAnnouncement) last receiver presentation = browser panes last presentations first.
	self assert: ((announcer instVarNamed: 'subscriptions') at: TestAnnouncement) last receiver presentation == browser panes last presentations first.
	(browser panes first port: #selection) value: #value3.
	self assert: ((announcer instVarNamed: 'subscriptions') at: TestAnnouncement) size = 1.
]
