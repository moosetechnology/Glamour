Class {
	#name : #GLMExplicitBrowserCopyTest,
	#superclass : #TestCase,
	#instVars : [
		'browser',
		'copiedBrowser'
	],
	#category : #'Glamour-Tests'
}

{ #category : #tests }
GLMExplicitBrowserCopyTest >> setUp [
	| pane1 pane2 transmission1 transmission2 | 
	browser := GLMExplicitBrowser new. 
	
	pane1 := browser addNewPane name: 'pane1'. 
	pane2 := browser addNewPane name: 'pane2'. 
	transmission1 := GLMSimpleTransmission new
		origin: (pane2 port: #selection); 
		destination: (browser pane port: #selection); 
		yourself.  
	browser addTransmission: transmission1. 
	transmission2 := GLMBundleTransmission new
		addActiveOrigin: (pane1 port: #selection); 
		destination: (pane2 port: #entity); 
		addPresentation: (GLMPresentation new title: 'presentation1');
		yourself.  
	browser addTransmission: transmission2. 
	copiedBrowser := browser copy
]

{ #category : #tests }
GLMExplicitBrowserCopyTest >> testEquality [
	self assert: copiedBrowser = browser
]

{ #category : #tests }
GLMExplicitBrowserCopyTest >> testPanes [
	self assert: copiedBrowser panes size = 2.
	self assert: copiedBrowser panes first ~~ browser panes first.
	self assert: copiedBrowser panes last ~~ browser panes last.

	self assert: copiedBrowser panes first browser == copiedBrowser.
	self assert: copiedBrowser panes last browser == copiedBrowser.

	self assert: copiedBrowser panes first ports size = 1.
	self assert: copiedBrowser panes first ports first name = #selection.
	self assert: copiedBrowser panes first ports first pane == copiedBrowser panes first.

	self assert: copiedBrowser panes last ports size = 2.
	self assert: copiedBrowser panes last ports first name = #selection.
	self assert: copiedBrowser panes last ports last name = #entity.
]

{ #category : #tests }
GLMExplicitBrowserCopyTest >> testTrasmissions [
	self assert: copiedBrowser transmissions size = 2.
	self assert: copiedBrowser transmissions first ~~ browser transmissions first.
	self assert: copiedBrowser transmissions last ~~ browser transmissions last.

	self assert: (copiedBrowser transmissions first destination pane browser isKindOf: GLMNoBrowser).
	self assert: copiedBrowser transmissions last destination pane browser == copiedBrowser.
	
	self assert: (copiedBrowser transmissions first origin pane browser == copiedBrowser).
	self assert: copiedBrowser transmissions last origins first pane browser == copiedBrowser
]
