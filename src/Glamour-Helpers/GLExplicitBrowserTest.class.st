Class {
	#name : #GLExplicitBrowserTest,
	#superclass : #TestCase,
	#category : #'Glamour-Tests'
}

{ #category : #tests }
GLExplicitBrowserTest >> testJumpstartTransmission [
	
	| browser presentation |
	browser := GLExplicitBrowser new.
	presentation := GLPresentation new.
	browser addPane: GLPane new.
	browser
		addJumpstart:
			((GLBundleTransmission new)
				destination: (browser panes first port: #entity);
				addPresentation: presentation;
				yourself).
	self assert: (browser panes first port: #entity) value isNil.
	self assert: browser panes first presentations isEmpty.
	(browser pane port: #entity) value: #foo.
	self assert: (browser panes first port: #entity) value = #foo.
	self assert: browser panes first presentations size = 1.
	self assert: browser panes first presentations first == presentation
]

{ #category : #tests }
GLExplicitBrowserTest >> testParentPort [
	
	| browser outerPort1 outerPort2 |
	browser := GLExplicitBrowser new.
	browser addPane: GLTestPane new.
	GLTestPane new addPresentation: browser.
	outerPort1 := (GLParentPort new)
		presentation: browser;
		name: #outerPort1;
		yourself.
	outerPort2 := (GLParentPort new)
		presentation: browser;
		name: #outerPort2;
		yourself.	"Capturing"
	browser
		addTransmission:
			((GLSimpleTransmission new)
				origin: outerPort1;
				destination: (browser panes first port: #innerPort1);
				yourself).	"Publishing"
	browser
		addTransmission:
			((GLSimpleTransmission new)
				origin: (browser panes first port: #innerPort2);
				destination: outerPort2;
				yourself).
	(browser pane port: #outerPort1) value: 42.
	self assert: (browser panes first port: #innerPort1) value = 42.
	self assert: (browser pane port: #outerPort1) seenTransmissions size = 1.
	self
		assert:
			((browser pane port: #outerPort1) seenTransmissions first isKindOf:
					GLSimpleTransmission).
	self
		assert:
			((browser pane port: #outerPort1) seenTransmissions first origin isKindOf:
					GLSimplePort).
	self
		assert:
			(browser pane port: #outerPort1) seenTransmissions first destination
				== (browser pane port: #outerPort1).
	self
		assert:
			(browser panes first port: #innerPort1) seenTransmissions size = 1.
	self
		assert:
			(browser panes first port: #innerPort1) seenTransmissions first
				== browser transmissions first.
	(browser panes first port: #innerPort2) value: 43.
	self assert: (browser pane port: #outerPort2) value = 43.
	self
		assert:
			(browser panes first port: #innerPort2) seenTransmissions size = 1.
	self
		assert:
			((browser panes first port: #innerPort2) seenTransmissions first isKindOf:
					GLSimpleTransmission).
	self
		assert:
			((browser panes first port: #innerPort2) seenTransmissions first origin
				isKindOf: GLSimplePort).
	self
		assert:
			(browser panes first port: #innerPort2) seenTransmissions first destination
				== (browser panes first port: #innerPort2).
	self assert: (browser pane port: #outerPort2) seenTransmissions size = 1.
	self
		assert:
			(browser pane port: #outerPort2) seenTransmissions first
				== browser transmissions last
]

{ #category : #tests }
GLExplicitBrowserTest >> testPortLoopPublish [
	
	| browser pane |
	self signalFailure: 'The following test loops indefinetely.'.
	browser := GLExplicitBrowser new.
	pane := GLPane new.
	browser addPane: pane.
	browser
		addPush: (pane port: #port)
		as: #publishedPort.
	browser
		addPull: #publishedPort
		to: (pane port: #port).
	(pane port: #port) value: #foo.
	self assert: browser pane ports size = 1.
	self assert: (browser pane port: #publishedPort) value = #foo.
	self assert: pane ports size = 1.
	self assert: (pane port: #port) value = #foo
]

{ #category : #tests }
GLExplicitBrowserTest >> testPortPulling [
	
	| browser pane |
	browser := GLExplicitBrowser new.
	pane := GLPane new.
	browser addPane: pane.
	browser
		addPull: #port
		to: (pane port: #pulledPort).
	self assert: browser pulledPorts size = 1.
	self
		assert: browser pulledPorts first innerPort = (pane port: #pulledPort).
	self assert: browser pulledPorts first outerPortName = #port.
	self assert: (pane port: #pulledPort) value isNil.
	(browser pane port: #port) value: #foo.
	self assert: pane ports size = 1.
	self assert: (pane port: #pulledPort) value = #foo
]

{ #category : #tests }
GLExplicitBrowserTest >> testPortPushing [
	
	| browser pane |
	browser := GLExplicitBrowser new.
	pane := GLPane new.
	browser addPane: pane.
	browser
		addPush: (pane port: #port)
		as: #pushedPort.
	self assert: browser pushedPorts size = 1.
	self assert: browser pushedPorts first innerPort = (pane port: #port).
	self assert: browser pushedPorts first outerPortName = #pushedPort.
	self assert: (browser pane port: #pushedPort) value isNil.
	(pane port: #port) value: #foo.
	self assert: (browser pane port: #pushedPort) value = #foo
]

{ #category : #tests }
GLExplicitBrowserTest >> testSetup [
	
	| browser pane1 pane2 transmission |
	browser := GLExplicitBrowser new.
	pane1 := GLTestPane new.
	pane2 := GLTestPane new.
	transmission := (GLSimpleTransmission new)
		origin: (pane1 port: #selection);
		destination: (pane2 port: #entity);
		yourself.
	browser addPane: pane1.
	browser addPane: pane2.
	browser addTransmission: transmission.
	self assert: browser panes size = 2.
	self assert: browser transmissions size = 1.
	self assert: browser panes first == pane1.
	self assert: browser panes last == pane2.
	self assert: pane1 browser == browser.
	self assert: pane2 browser == browser.
	self assert: browser transmissions first == transmission
]

{ #category : #tests }
GLExplicitBrowserTest >> testSimpleTransmission [
	
	| browser pane1 pane2 presentation1 presentation2 transmission announcement |
	browser := GLExplicitBrowser new.
	presentation1 := GLPresentation new.
	presentation2 := GLPresentation new.
	pane1 := GLTestPane new.
	pane2 := GLTestPane new.
	pane1 addPresentation: presentation1.
	pane2 addPresentation: presentation2.
	transmission := (GLSimpleTransmission new)
		origin: (pane1 port: #selection);
		destination: (pane2 port: #entity);
		yourself.
	browser addPane: pane1.
	browser addPane: pane2.
	browser addTransmission: transmission.
	announcement := nil.
	presentation2
		on: GLContextChanged
		do: [:ann | announcement := ann].
	presentation1 selection: 'foo'.
	self assert: (pane1 port: #selection) seenTransmissions size = 1.
	self assert: (pane2 port: #entity) seenTransmissions size = 1.
	self
		assert: (pane1 port: #selection) seenTransmissions first ~~ transmission.
	self assert: (pane2 port: #entity) seenTransmissions first == transmission.
	self assert: (pane2 port: #entity) value = 'foo'.
	self assert: announcement notNil
]

{ #category : #tests }
GLExplicitBrowserTest >> testTransmissionBundle [
	
	| browser pane1 pane2 pane3 presentation1 presentation2 transmission |
	browser := GLExplicitBrowser new.
	presentation1 := GLPresentation new.
	presentation2 := GLPresentation new.
	pane1 := GLTestPane new.
	pane2 := GLTestPane new.
	pane3 := GLTestPane new.
	pane1 addPresentation: GLPresentation new.
	pane2 addPresentation: GLPresentation new.
	pane3 addPresentation: presentation1.
	transmission := (GLBundleTransmission new)
		addActiveOrigin: (pane1 port: #selection);
		addPassiveOrigin: (pane2 port: #selection);
		destination: (pane3 port: #entity);
		addPresentation: presentation2;
		yourself.
	browser addPane: pane1.
	browser addPane: pane2.
	browser addPane: pane3.
	browser addTransmission: transmission.
	self assert: pane3 presentations size = 1.
	self assert: pane3 presentations first == presentation1.	"The first should not trigger any transmission (passive)
	but the second should."
	pane2 presentations first selection: #foo.
	pane1 presentations first selection: #bar.
	self assert: (pane1 port: #selection) seenTransmissions size = 1.
	self assert: (pane2 port: #selection) seenTransmissions size = 1.
	self
		assert: (pane1 port: #selection) seenTransmissions first ~~ transmission.
	self
		assert: (pane2 port: #selection) seenTransmissions first ~~ transmission.
	self assert: (pane3 port: #entity) seenTransmissions size = 2.
	self assert: (pane3 port: #entity) seenTransmissions first ~~ transmission.
	self assert: (pane3 port: #entity) seenTransmissions first value = nil.
	self assert: (pane3 port: #entity) seenTransmissions last == transmission.
	self
		assert:
			(pane3 port: #entity) value = (GLMultiValue withAll: #(#bar #foo)).
	self assert: pane3 presentations size = 1.
	self assert: pane3 presentations first == presentation2
]

{ #category : #tests }
GLExplicitBrowserTest >> testTriggeringConditions [
	
	| browser pane1 pane2 transmission |
	browser := GLExplicitBrowser new.
	browser pane: GLTestPane new.
	pane1 := GLTestPane new.
	pane2 := GLTestPane new.
	transmission := (GLSimpleTransmission new)
		origin: (pane1 port: #selection);
		destination: (pane2 port: #entity);
		yourself.
	browser addPane: pane1.
	browser addPane: pane2.
	browser addTransmission: transmission.
	browser
		addPush: (pane1 port: #selection)
		as: #pane1Selection.
	self assert: (pane1 port: #selection) seenTransmissions isEmpty.
	self assert: (pane2 port: #entity) seenTransmissions isEmpty.
	self
		assert: (browser pane port: #pane1Selection) seenTransmissions isEmpty.
	(pane1 port: #selection) value: 12.
	self assert: (pane1 port: #selection) seenTransmissions size = 1.
	self
		assert:
			((pane1 port: #selection) seenTransmissions first isKindOf:
					GLSimpleTransmission).
	self assert: (pane2 port: #entity) seenTransmissions size = 1.
	self assert: (pane2 port: #entity) seenTransmissions first == transmission.
	self
		assert: (browser pane port: #pane1Selection) seenTransmissions size = 1.
	self
		assert:
			((browser pane port: #pane1Selection) seenTransmissions first isKindOf:
					GLSimpleTransmission).	"Setting the same value should re-publish but not trigger inner transmissions."
	(pane1 port: #selection) value: 12.
	self assert: (pane1 port: #selection) seenTransmissions size = 2.
	self
		assert:
			((pane1 port: #selection) seenTransmissions first isKindOf:
					GLSimpleTransmission).
	self
		assert:
			((pane1 port: #selection) seenTransmissions last isKindOf:
					GLSimpleTransmission).
	self assert: (pane2 port: #entity) seenTransmissions size = 1.
	self assert: (pane2 port: #entity) seenTransmissions first == transmission.
	self
		assert: (browser pane port: #pane1Selection) seenTransmissions size = 2.
	self
		assert:
			((browser pane port: #pane1Selection) seenTransmissions first isKindOf:
					GLSimpleTransmission).
	self
		assert:
			((browser pane port: #pane1Selection) seenTransmissions first isKindOf:
					GLSimpleTransmission)
]
