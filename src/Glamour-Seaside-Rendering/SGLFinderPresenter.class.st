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
	self removePane: anAnnouncement pane
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
			append: [ :aRenderer | self renderPane: aPane on: aRenderer ]).
	self updateAnimationScriptForPane: aPane
]

{ #category : #initialization }
SGLFinderPresenter >> initializeFor: aBrowser [
	super initializeFor: aBrowser.
	self registerAnnouncers
]

{ #category : #initialization }
SGLFinderPresenter >> registerAnnouncers [
	self browser on: GLMPaneAdded send: #actOnPaneAdded: to: self.
	self browser on: GLMPaneRemoved send: #actOnPaneRemoved: to: self.
	self browser on: GLMPaneReplaced send: #actOnPaneReplaced: to: self.
]

{ #category : #callbacks }
SGLFinderPresenter >> removePane: aPane [
	self renderer 
		scriptFor: self browser 
		add: ((self renderer html jQuery id: (self renderer uuidFor: self browser))
			contents;
			filter: ':last';
			remove)
]

{ #category : #rendering }
SGLFinderPresenter >> renderContentOn: html [
	html div
		id: (self renderer uuidFor: self browser); 
		class: 'ui-widget'; class: 'finder';
		with: [
			self browser panes 
				do: [ :each | self renderPane: each on: html ] ] .
]

{ #category : #rendering }
SGLFinderPresenter >> renderPane: aPane on: html [
	html div
		class: 'finder-pane ui-widget ui-widget-content';
		id: (self renderer uuidFor: aPane);
		with: [ self renderer render: aPane ]
]

{ #category : #callbacks }
SGLFinderPresenter >> replaceLastPaneWith: newPane [
	self renderer scriptFor: self browser 
		add: ((self renderer html jQuery id: (self renderer uuidFor: browser))
			contents;
			filter: ':last';
			replaceWith: [ :aRenderer | self renderPane: newPane on: aRenderer ]).
	self updateAnimationScriptForPane: newPane
]

{ #category : #private }
SGLFinderPresenter >> updateAnimationScriptForPane: aPane [
	self renderer 
		scriptFor: self browser 
		add: ( ( self renderer html jQuery id: (
			self renderer uuidFor: self browser) ) glamourScrollTo target: ( '#', (self renderer uuidFor: aPane) ); duration: 500 ) 
]
