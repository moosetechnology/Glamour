"
I am the representation of a Dashbord for Glamour.

Description 
--------------------

I am use to create a browser with some GLMPanes inside.
I am able to position my subpanes but you can also give some layouts yourself.

Public API and Key Messages
--------------------

- #addPaneNamed: aSymbole 		Allow to create a pane in this dashboard.
- #addPaneNamed: aSymbole layout: aLayoutFrame 		Allow to create a pane with  a certain layout.

Example
-------------------
	""See more in GLMExampleBrowser""
	
	| tmpBrowser |
	tmpBrowser := GLMDashboard new.
	tmpBrowser addPaneNamed: #first layout: (0 @ 0 corner: 0.33 @ 0.5).
	tmpBrowser addPaneNamed: #second layout: (0.33 @ 0 corner: 0.66 @ 0.5).
	tmpBrowser addPaneNamed: #third layout: (0 @ 0.5 corner: 0.33 @ 1).
	tmpBrowser addPaneNamed: #fourth layout: (0.33 @ 0.5 corner: 0.66 @ 1).
	tmpBrowser addPaneNamed: #fifth layout: (0.66 @ 0 corner: 1 @ 1).
	tmpBrowser transmit
		to: #first;
		andShow: [ :a | 
					a list
						display: [ :i | #(#a #b #c #d #e) ];
						yourself ].
	tmpBrowser transmit
		to: #second;
		andShow: [ :a | a list display: [ :i | #(#a #b #c #d #e) ] ].
	tmpBrowser transmit
		to: #third;
		andShow: [ :a | a list display: [ :i | #(#a #b #c #d #e) ] ].
	tmpBrowser transmit
		to: #fourth;
		andShow: [ :a | a list display: [ :i | #(#a #b #c #d #e) ] ].
	tmpBrowser transmit
		to: #fifth;
		andShow: [ :a | a list display: [ :i | #(#a #b #c #d #e) ] ].
	^ tmpBrowser
 
Internal Representation and Key Implementation Points.
-------------------

    Instance Variables
	panesLayouts:		<aDictionary> that associate a symbole with the layout of his pane.

"
Class {
	#name : #GLMDashboard,
	#superclass : #GLMExplicitBrowser,
	#instVars : [
		'panesLayouts'
	],
	#category : #'Glamour-Browsers-Dashboard'
}

{ #category : #adding }
GLMDashboard >> addPaneNamed: aString [
	self addNewPaneNamed: aString
]

{ #category : #adding }
GLMDashboard >> addPaneNamed: aSymbol layout: aLayout [
	self addPaneNamed: aSymbol.
	self panesLayouts at: aSymbol put: aLayout
]

{ #category : #scripting }
GLMDashboard >> initializeScriptingDefaults [
	super initializeScriptingDefaults.
	self transmissions
		detect: [ :each | each originatesAt: (self pane port: #entity) ]
		ifNone: [ 
			self
				transmit to: (self panes first port: #entity);
				from: #outer port: #entity;
				andShow: [:a |  a custom: GLMFlexiblePresentation new ] ]
]

{ #category : #accessing }
GLMDashboard >> layoutOfPaneNamed: aSymbol [
	^ self panesLayouts
		at: aSymbol
		ifAbsent:
			[ | index pas yTop yBot |
			"I think this can be clean a little but I don't have the time right now."
			index := (self panes collect: [ :e | e name ]) indexOf: aSymbol.
			pas := 1 / ((self panes size / 2) floor + 1).
			yTop := ((index / 2) rounded - 1) * pas.
			yBot := (index / 2) rounded * pas.
			(index = self panes size and: [ index odd ])
				ifTrue: [ ^ (0 @ yTop corner: 1 @ yBot) asLayoutFrame ].
			index odd
				ifTrue: [ (0 @ yTop corner: 0.5 @ yBot) asLayoutFrame ]
				ifFalse: [ (0.5 @ yTop corner: 1 @ yBot) asLayoutFrame ] ]
]

{ #category : #accessing }
GLMDashboard >> panesLayouts [
	^ panesLayouts ifNil: [ panesLayouts := Dictionary new ]
]

{ #category : #rendering }
GLMDashboard >> renderGlamorouslyOn: aRenderer [ 
	 
	^aRenderer renderDashboard: self
]
