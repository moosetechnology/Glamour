"
Browsers are one of the core components in Glamour.

They contain panes and transmission between them, which can either be explicitely defined by the user (such as in the TableLayoutBrowser) or implicitely defined (such as in the Finder).

Browsers serve as composition managers. They determine when and under which conditions transmissions should be triggered and how they connect the ports of panes. In return, panes inform the browsers when event occur on their ports so that the browser can make an informed decission on what to do.
"
Class {
	#name : #GLMBrowser,
	#superclass : #GLMPresentation,
	#category : #'Glamour-Core'
}

{ #category : #'scripting-private' }
GLMBrowser >> initializeScriptingDefaults [ 
	"Initialize some default behavior if the user did not explcitly script it. 
 
	Subclasses can use this to create a default startup transmission or show 
	a default pane or something like that." 
	
	^self
]

{ #category : #accessing }
GLMBrowser >> panes [ 
	"Return an (ordered) collection of the panes used by this browser." 
	 
	self subclassResponsibility
]
