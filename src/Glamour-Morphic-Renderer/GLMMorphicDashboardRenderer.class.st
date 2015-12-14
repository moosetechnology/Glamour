"
I am a renderer for a GLMDashboard. 

Description 
-------------------

In the MCV I am the View. 

I will iterate on all the panes of the dashboard to create them in the browser.
You can see some examples in GLMExampleBrowser.
"
Class {
	#name : #GLMMorphicDashboardRenderer,
	#superclass : #GLMMorphicBrowserRenderer,
	#category : #'Glamour-Morphic-Renderer'
}

{ #category : #private }
GLMMorphicDashboardRenderer >> render: aBrowser [
	| container |
	container := PanelMorph new.
	container
		fillStyle: Color transparent;
		changeProportionalLayout;
		hResizing: #spaceFill;
		vResizing: #spaceFill.
	aBrowser panes reverseDo: [ :aGLMPane | self renderPane: aGLMPane inUI: container from: aBrowser ].
	aBrowser when: GLMBrowserClosed send: #actOnBrowserClosed: to: self.
	^ container
]

{ #category : #private }
GLMMorphicDashboardRenderer >> renderPane: aPane inUI: aMorph from: aDashboard [
	aMorph addMorph: (self renderObject: aPane) fullFrame: (aDashboard layoutOfPaneNamed: aPane name)
]
