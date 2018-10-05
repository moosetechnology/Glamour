Class {
	#name : #SGLFinderPresenter,
	#superclass : #SGLBrowserPresenter,
	#category : #'Glamour-Seaside-Rendering'
}

{ #category : #rendering }
SGLFinderPresenter >> actOnPaneAdded: anAnnouncement [
	self addPane: anAnnouncement pane
]

{ #category : #rendering }
SGLFinderPresenter >> actOnPaneRemoved: anAnnouncement [
	self removeLastPane
]

{ #category : #rendering }
SGLFinderPresenter >> actOnPaneReplaced: anAnnouncement [
	self replaceLastPaneWith: anAnnouncement newPane 
]

{ #category : #callbacks }
SGLFinderPresenter >> addPane: aPane [
	self renderer 
		scriptFor: self browser 
		add: ((self renderer html jQuery id: (self renderer uuidFor: self browser))
			glamourFinder addPane: [ :aRenderer | self renderPane: aPane on: aRenderer ]).
]

{ #category : #initialization }
SGLFinderPresenter >> initializeFor: aBrowser [
	super initializeFor: aBrowser.
	self registerAnnouncers
]

{ #category : #initialization }
SGLFinderPresenter >> registerAnnouncers [
	self browser when: GLMPaneAdded send: #actOnPaneAdded: to: self.
	self browser when: GLMPaneRemoved send: #actOnPaneRemoved: to: self.
	self browser when: GLMPaneReplaced send: #actOnPaneReplaced: to: self.
]

{ #category : #callbacks }
SGLFinderPresenter >> removeLastPane [
	self renderer 
		scriptFor: self browser 
		add: ((self renderer html jQuery id: (self renderer uuidFor: self browser))
			glamourFinder removeLastPane)
]

{ #category : #rendering }
SGLFinderPresenter >> renderContentOn: html [
	html div		
		id: (self renderer uuidFor: self browser); 		
		script: (html jQuery new glamourFinder);
		with: [
			self browser panes 
				do: [ :each | self renderPane: each on: html ] ] .
]

{ #category : #rendering }
SGLFinderPresenter >> renderPane: aPane on: html [
	html div		
		id: (self renderer uuidFor: aPane);
		with: [ self renderer render: aPane ]
]

{ #category : #callbacks }
SGLFinderPresenter >> replaceLastPaneWith: newPane [
	self renderer 
		scriptFor: self browser 
		add: ((self renderer html jQuery id: (self renderer uuidFor: self browser))
			glamourFinder replaceLastPane: [ :aRenderer | self renderPane: newPane on: aRenderer ])
]
