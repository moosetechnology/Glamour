Class {
	#name : #SGLExpanderPresenter,
	#superclass : #SGLBrowserPresenter,
	#category : #'Glamour-Seaside-Rendering'
}

{ #category : #rendering }
SGLExpanderPresenter >> actOnPaneAdded: anAnnouncement [
	self addPane: anAnnouncement pane
]

{ #category : #callbacks }
SGLExpanderPresenter >> addPane: aPane [
	self renderer 
		scriptFor: self browser 
		add: ((self renderer html jQuery id: (self renderer uuidFor: self browser))
			glamourExpander addPane: [ :aRenderer | self renderPaneHeaderFor: aPane on: aRenderer ] )
	
]

{ #category : #initialization }
SGLExpanderPresenter >> initializeFor: aBrowser [
	super initializeFor: aBrowser.
	self browser on: GLMPaneAdded send: #actOnPaneAdded: to: self.
]

{ #category : #'jQuery-scripts' }
SGLExpanderPresenter >> loadContentScriptFor: aPane with: html [
	^ html jQuery ajax
		html: [ :aRenderer | 				
			self renderPaneContentFor: aPane on: aRenderer];
		fullUrl
]

{ #category : #rendering }
SGLExpanderPresenter >> renderContentOn: html [
	|panes|
	
	panes := self browser panes.
	panes isEmpty ifTrue: [ ^ self renderEmptyPresentationOn: html ].
	html div
		id: (self renderer uuidFor: self browser);		
		script: ( html jQuery new glamourExpander );
		with: [			
			panes do: [ :each |
				self renderPaneHeaderFor: each on: html ] ]
]

{ #category : #rendering }
SGLExpanderPresenter >> renderPaneAnchorFor: aPane on: html [
	html anchor
		url: (self loadContentScriptFor: aPane with: html);
		with: [ self renderTitleOrIconOf: aPane presentations on: html ]
]

{ #category : #rendering }
SGLExpanderPresenter >> renderPaneContentFor: aPane on: html [
	self render: aPane presentations on: html
]

{ #category : #rendering }
SGLExpanderPresenter >> renderPaneHeaderFor: aPane on: html [
	html heading 
		level: 3;
		with: [
			self renderPaneAnchorFor: aPane on: html.
			self renderActionsFrom: aPane presentations on: html  ]
]
