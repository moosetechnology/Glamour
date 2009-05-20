Class {
	#name : #GLMExplicitBrowserTest,
	#superclass : #TestCase,
	#category : #'Glamour-Tests'
}

{ #category : #tests }
GLMExplicitBrowserTest >> testJumpstartTransmission [ 
	 
	| browser presentation | 
	browser _ GLMExplicitBrowser new. 
	presentation _ GLMPresentation new. 
	browser addPane: GLMPane new. 
	browser 
		addJumpstart: 
			((GLMBundleTransmission new) 
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
GLMExplicitBrowserTest >> testParentPort [ 
	 
	| browser outerPort1 outerPort2 | 
	browser _ GLMExplicitBrowser new. 
	browser addPane: GLMTestPane new. 
	GLMTestPane new addPresentation: browser. 
	outerPort1 _ (GLMParentPort new) 
		presentation: browser; 
		name: #outerPort1; 
		yourself. 
	outerPort2 _ (GLMParentPort new) 
		presentation: browser; 
		name: #outerPort2; 
		yourself.	"Capturing" 
	browser 
		addTransmission: 
			((GLMSimpleTransmission new) 
				origin: outerPort1; 
				destination: (browser panes first port: #innerPort1); 
				yourself).	"Publishing" 
	browser 
		addTransmission: 
			((GLMSimpleTransmission new) 
				origin: (browser panes first port: #innerPort2); 
				destination: outerPort2; 
				yourself). 
	(browser pane port: #outerPort1) value: 42. 
	self assert: (browser panes first port: #innerPort1) value = 42. 
	self assert: (browser pane port: #outerPort1) seenTransmissions size = 1. 
	self 
		assert: 
			((browser pane port: #outerPort1) seenTransmissions first isKindOf: 
					GLMSimpleTransmission). 
	self 
		assert: 
			((browser pane port: #outerPort1) seenTransmissions first origin isKindOf: 
					GLMSimplePort). 
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
					GLMSimpleTransmission). 
	self 
		assert: 
			((browser panes first port: #innerPort2) seenTransmissions first origin 
				isKindOf: GLMSimplePort). 
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
GLMExplicitBrowserTest >> testSetup [ 
	 
	| browser pane1 pane2 transmission | 
	browser _ GLMExplicitBrowser new. 
	pane1 _ GLMTestPane new. 
	pane2 _ GLMTestPane new. 
	transmission _ (GLMSimpleTransmission new) 
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
GLMExplicitBrowserTest >> testSimpleTransmission [ 
	 
	| browser pane1 pane2 presentation1 presentation2 transmission announcement | 
	browser _ GLMExplicitBrowser new. 
	presentation1 _ GLMPresentation new. 
	presentation2 _ GLMPresentation new. 
	pane1 _ GLMTestPane new. 
	pane2 _ GLMTestPane new. 
	pane1 addPresentation: presentation1. 
	pane2 addPresentation: presentation2. 
	transmission _ (GLMSimpleTransmission new) 
		origin: (pane1 port: #selection); 
		destination: (pane2 port: #entity); 
		yourself. 
	browser addPane: pane1. 
	browser addPane: pane2. 
	browser addTransmission: transmission. 
	announcement _ nil. 
	presentation2 
		when: GLMContextChanged 
		do: [:ann | announcement _ ann]. 
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
GLMExplicitBrowserTest >> testTransmissionBundle [ 
	 
	| browser pane1 pane2 pane3 presentation1 presentation2 transmission | 
	browser _ GLMExplicitBrowser new. 
	presentation1 _ GLMPresentation new. 
	presentation2 _ GLMPresentation new. 
	pane1 _ GLMTestPane new. 
	pane2 _ GLMTestPane new. 
	pane3 _ GLMTestPane new. 
	pane1 addPresentation: GLMPresentation new. 
	pane2 addPresentation: GLMPresentation new. 
	pane3 addPresentation: presentation1. 
	transmission _ (GLMBundleTransmission new) 
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
			(pane3 port: #entity) value = (GLMMultiValue withAll: #(#bar #foo)). 
	self assert: pane3 presentations size = 1. 
	self assert: pane3 presentations first == presentation2
]

{ #category : #tests }
GLMExplicitBrowserTest >> testTriggeringConditions [ 
	 
	| browser pane1 pane2 transmission | 
	browser _ GLMExplicitBrowser new. 
	browser pane: GLMTestPane new. 
	pane1 _ GLMTestPane new. 
	pane2 _ GLMTestPane new. 
	transmission _ (GLMSimpleTransmission new) 
		origin: (pane1 port: #selection); 
		destination: (pane2 port: #entity); 
		yourself. 
	browser addPane: pane1. 
	browser addPane: pane2. 
	browser addTransmission: transmission. 
	self assert: (pane1 port: #selection) seenTransmissions isEmpty. 
	self assert: (pane2 port: #entity) seenTransmissions isEmpty. 
	(pane1 port: #selection) value: 12. 
	self assert: (pane1 port: #selection) seenTransmissions size = 1. 
	self 
		assert: 
			((pane1 port: #selection) seenTransmissions first isKindOf: 
					GLMSimpleTransmission). 
	self assert: (pane2 port: #entity) seenTransmissions size = 1. 
	self assert: (pane2 port: #entity) seenTransmissions first == transmission.	"Setting the same value should re-publish but not trigger inner transmissions." 
	(pane1 port: #selection) value: 12. 
	self assert: (pane1 port: #selection) seenTransmissions size = 2. 
	self 
		assert: 
			((pane1 port: #selection) seenTransmissions first isKindOf: 
					GLMSimpleTransmission). 
	self 
		assert: 
			((pane1 port: #selection) seenTransmissions last isKindOf: 
					GLMSimpleTransmission). 
	self assert: (pane2 port: #entity) seenTransmissions size = 1. 
	self assert: (pane2 port: #entity) seenTransmissions first == transmission
]
