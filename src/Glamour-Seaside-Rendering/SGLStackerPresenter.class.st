Class {
	#name : #SGLStackerPresenter,
	#superclass : #SGLBrowserPresenter,
	#category : #'Glamour-Seaside-Rendering'
}

{ #category : #'jQuery-scripts' }
SGLStackerPresenter >> loadContentScriptFor: aTab with: html [
	^ html jQuery ajax
		html: [ :aRenderer | self render: aTab on: aRenderer];
		fullUrl
]

{ #category : #accessing }
SGLStackerPresenter >> panes [
	^ self browser panes
]

{ #category : #rendering }
SGLStackerPresenter >> renderContentOn: html [
	html div
		class: 'tabbed-arrangement';
		script: (self tabScriptWith: html);
		with: [self renderTabsHeaderOn: html]
]

{ #category : #rendering }
SGLStackerPresenter >> renderTab: aPane on: html [ 
	html listItem 
		id: html nextId;
		with: [ self renderTabAchorFor: aPane on: html ]
]

{ #category : #rendering }
SGLStackerPresenter >> renderTabAchorFor: aTab on: html [
	html anchor
		url: (self loadContentScriptFor: aTab with: html);
		with: [self renderTitleOrIconOf: aTab presentations on: html]
]

{ #category : #rendering }
SGLStackerPresenter >> renderTabsHeaderOn: html [
	html unorderedList: [self panes do: [ :pane | self renderTab: pane on: html] ]
]

{ #category : #rendering }
SGLStackerPresenter >> tabScriptWith: html [
	^ html jQuery new glamourTabs
		cache: true; 
		hasActions: true;
		closable: true
]
