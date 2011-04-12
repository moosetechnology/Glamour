Class {
	#name : #GLMMorphicFinderRenderer,
	#superclass : #GLMMorphicBrowserRenderer,
	#instVars : [
		'container'
	],
	#category : #'Glamour-Morphic-Renderer'
}

{ #category : #rendering }
GLMMorphicFinderRenderer >> actOnPaneAdded: ann [
	self subclassResponsibility
]

{ #category : #rendering }
GLMMorphicFinderRenderer >> actOnPaneRemoved: ann [
	self subclassResponsibility
]

{ #category : #rendering }
GLMMorphicFinderRenderer >> actOnPaneReplaced: ann [
	self subclassResponsibility
]

{ #category : #rendering }
GLMMorphicFinderRenderer >> registerAnnouncementsFor: aBrowser [
	aBrowser 
		on: GLMPaneRemoved send: #actOnPaneRemoved: to: self.
	aBrowser 
		on: GLMPaneAdded send: #actOnPaneAdded: to: self.
	aBrowser 
		on: GLMPaneReplaced send: #actOnPaneReplaced: to: self.
	aBrowser 
		on: GLMBrowserClosed send: #actOnBrowserClosed: to: self.
]

{ #category : #rendering }
GLMMorphicFinderRenderer >> render: aBrowser [
	^ self subclassResponsibility
]
