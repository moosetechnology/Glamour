"
Browsers are one of the core components in Glamour.

They contain panes and transmission between them, which can either be explicitely defined by the user (such as in the TableLayoutBrowser) or implicitely defined (such as in the Finder).

Browsers serve as composition managers. They determine when and under which conditions transmissions should be triggered and how they connect the ports of panes. In return, panes inform the browsers when event occur on their ports so that the browser can make an informed decission on what to do.
"
Class {
	#name : #GLBrowser,
	#superclass : #GLPresentation,
	#category : #'Glamour-Core'
}

{ #category : #scripting }
GLBrowser >> custom: aPresentation [
	
	self subclassResponsibility
]

{ #category : #scripting }
GLBrowser >> defaultRenderer [
	
	^GLRenderer subclasses any new
]

{ #category : #'scripting-private' }
GLBrowser >> initializeScriptingDefaults [
	"Initialize some default behavior if the user did not explcitely script it.

	Subclasses can use this to create a default startup transmission or show
	a default pane or something like that."
	
	^self
]

{ #category : #scripting }
GLBrowser >> list [
	
	^self custom: GLListPresentation new
]

{ #category : #scripting }
GLBrowser >> mondrian [
	
	^self custom: GLMondrianPresentation new
]

{ #category : #scripting }
GLBrowser >> open [
	
	^self openWith: self defaultRenderer
]

{ #category : #scripting }
GLBrowser >> openOn: anObject [
	
	^self
		openOn: anObject
		with: self defaultRenderer
]

{ #category : #scripting }
GLBrowser >> openOn: anObject with: aRenderer [
	
	self startOn: anObject.
	^aRenderer open: self
]

{ #category : #scripting }
GLBrowser >> openWith: aRenderer [
	
	^self openOn: nil with: aRenderer
]

{ #category : #accessing }
GLBrowser >> panes [
	"Return an (ordered) collection of the panes used by this browser."
	
	self subclassResponsibility
]

{ #category : #scripting }
GLBrowser >> startOn: anObject [
	
	self initializeScriptingDefaults.
	self entity: anObject
]

{ #category : #scripting }
GLBrowser >> text [
	
	^self custom: GLTextPresentation new
]

{ #category : #scripting }
GLBrowser >> tree [
	
	^self custom: GLTreePresentation new
]
