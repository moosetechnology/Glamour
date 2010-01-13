"
Browsers are one of the core components in Glamour.

They contain panes and transmission between them, which can either be explicitely defined by the user (such as in the TableLayoutBrowser) or implicitely defined (such as in the Finder).

Browsers serve as composition managers. They determine when and under which conditions transmissions should be triggered and how they connect the ports of panes. In return, panes inform the browsers when event occur on their ports so that the browser can make an informed decission on what to do.

A Browser is a Presentation which means that it can be nested into other browsers.
"
Class {
	#name : #GLMBrowser,
	#superclass : #GLMPresentation,
	#traits : 'GLMTPresentationBuilder',
	#classTraits : 'GLMTPresentationBuilder classTrait',
	#category : #'Glamour-Core'
}

{ #category : #accessing }
GLMBrowser >> panes [ 
	"Return an (ordered) collection of the panes used by this browser." 
	 
	self subclassResponsibility
]
