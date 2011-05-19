Class {
	#name : #GLMDashboard,
	#superclass : #GLMExplicitBrowser,
	#instVars : [
		'panesExtents'
	],
	#category : #'Glamour-Browsers'
}

{ #category : #scripting }
GLMDashboard >> addPaneNamed: aString [

	self addNewPaneNamed: aString
]

{ #category : #scripting }
GLMDashboard >> addPaneNamed: aSymbol extent: aPoint [

	self addPaneNamed: aSymbol.
	self panesExtents at: aSymbol put: aPoint
]

{ #category : #accessing }
GLMDashboard >> defaultPaneExtent [

	^ 300@150
]

{ #category : #accessing }
GLMDashboard >> extentOfPaneNamed: aSymbol [

	^ self panesExtents at: aSymbol ifAbsent: [
		"default extent for a pane"
		self defaultPaneExtent 		
		]
]

{ #category : #scripting }
GLMDashboard >> initializeScriptingDefaults [ 
	 
	super initializeScriptingDefaults. 
	self transmissions 
		detect: [ :each | each originatesAt: (self pane port: #entity) ]
		ifNone: [
			self 
				showOn: (self panes first port: #entity);
				from: #outer->#entity;
				using: [ self custom: GLMFlexiblePresentation new ] ]
]

{ #category : #accessing }
GLMDashboard >> panesExtents [

	^ panesExtents ifNil: [panesExtents := Dictionary new]
]

{ #category : #rendering }
GLMDashboard >> renderGlamorouslyOn: aRenderer [ 
	 
	^aRenderer renderDashbord: self
]
