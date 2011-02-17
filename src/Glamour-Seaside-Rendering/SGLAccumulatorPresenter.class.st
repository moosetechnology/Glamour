Class {
	#name : #SGLAccumulatorPresenter,
	#superclass : #SGLBrowserPresenter,
	#category : #'Glamour-Seaside-Rendering'
}

{ #category : #rendering }
SGLAccumulatorPresenter >> actOnPaneAdded: anAnnouncement [
	self addPane: anAnnouncement pane
]

{ #category : #rendering }
SGLAccumulatorPresenter >> actOnPaneSelected: anAnnouncement [
	self selectPaneAt: anAnnouncement position
]

{ #category : #callbacks }
SGLAccumulatorPresenter >> addPane: aPane [
	|tabs|
	self flag: 'Check if the way to give the html to add:label:action: bellow is correct'.
	tabs := (self renderer html jQuery id: (self renderer uuidFor: self browser)).
	self renderer scriptFor: self browser add: ( 
		tabs glamourTabs 
			add: (self renderer html jQuery ajax
						html: [ :aRenderer |
							self renderPaneWithoutTitle: aPane on: aRenderer ];
						fullUrl) 			 
			label: [ :aRenderer | self renderTitleOrIconOf: aPane presentations on: aRenderer ]
			actions: [:aRenderer| self renderActionFromPane: aPane on: aRenderer ])
]

{ #category : #'jQuery-scripts' }
SGLAccumulatorPresenter >> initializationScriptWith: html [
	 ^ html jQuery this glamourTabs  
		cache: true; 
		hasActions: true;
		closable: true;
		onRemove: (self onRemoveActionWith: html);
		onSelect: (self onSelectScriptWith: html)
]

{ #category : #initialization }
SGLAccumulatorPresenter >> initializeFor: aBrowser [
	super initializeFor: aBrowser.
	self registerAnnouncers
]

{ #category : #'jQuery-scripts' }
SGLAccumulatorPresenter >> onRemoveActionWith: html [
	^ html jQuery ajax
			callbackTabs: [:event|
				self browser removePaneIndex: (event at: #index) + 1];
			script: [: script | self renderer updateScript: script ]
]

{ #category : #'jQuery-scripts' }
SGLAccumulatorPresenter >> onSelectScriptWith: html [
	^ html jQuery ajax 
			callbackTabs: [ :event | 
   	  	     		self browser activeEntity: ((self browser panes at: (event at: #index) + 1) port: #entity) value ];
			script: [: script | self renderer updateScript: script ]
]

{ #category : #initialization }
SGLAccumulatorPresenter >> registerAnnouncers [
	self browser on: GLMPaneAdded send: #actOnPaneAdded: to: self.
	self browser on: GLMPaneSelected send: #actOnPaneSelected: to: self.
]

{ #category : #rendering }
SGLAccumulatorPresenter >> renderActionFromPane: aPane on: html [
	html listItem
		class: 'glm-actions';
		style: 'display: none;';
		with: [ self renderActionsFrom: aPane presentations on: html ]
]

{ #category : #rendering }
SGLAccumulatorPresenter >> renderContentOn: html [
	|panes|
	panes := self browser panes.
	panes isEmpty ifTrue: [ ^ self renderEmptyPresentationOn: html ].
	html div
		id: (self renderer uuidFor: self browser);
		class: 'glm-accumulator';
		script: ( self initializationScriptWith: html );
		with: [
			html unorderedList: [
				self browser panes withIndexDo: [ :each :i |
					self renderPane: each at: i on: html ] ] ]
]

{ #category : #rendering }
SGLAccumulatorPresenter >> renderPane: aPane at: index on: html [
	html listItem
		class: 'ui-tabs-selected' if: self browser panes size = index;  
		with: [
			html anchor
				url: (html jQuery ajax
					html: [ :aRenderer | 								
						self renderPaneWithoutTitle: aPane on: aRenderer ];
					fullUrl);
				with: [ self renderTitleOrIconOf: aPane presentations on: html ] ].
	self renderActionFromPane: aPane on: html
	
]

{ #category : #callbacks }
SGLAccumulatorPresenter >> selectPaneAt: index [
	self renderer scriptFor: self browser add:  (
		 (self renderer html jQuery id: (self renderer uuidFor: self browser)) glamourTabs select: index-1 ).
]
