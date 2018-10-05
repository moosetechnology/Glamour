Class {
	#name : #SGLTabbedCompositePresenter,
	#superclass : #SGLCompositePresenter,
	#instVars : [
		'actionsPresenters'
	],
	#category : #'Glamour-Seaside-Rendering'
}

{ #category : #'jQuery-scripts' }
SGLTabbedCompositePresenter >> loadContentScriptFor: aTab with: html [
	^ html jQuery ajax
		html: [ :aRenderer | 				
			self render: aTab on: aRenderer];
		fullUrl
]

{ #category : #rendering }
SGLTabbedCompositePresenter >> renderActionsFromTab: aTab on: html [
	|actionsPresenter|

	html listItem
		class: 'glm-actions';
		style: 'display: none;';
		with: [ 
			"super renderActionsFrom: aTab on: html "
			actionsPresenter := self renderActionsHeaderFrom: aTab on: html ].
	^ actionsPresenter
]

{ #category : #rendering }
SGLTabbedCompositePresenter >> renderContentOn: html [
	| presentations |
	presentations := self presentation matchingPresentations.
	presentations isEmpty ifTrue: [ ^self renderEmptyPresentationOn: html ].
	presentations size = 1 ifTrue: [^self renderWithTitleOrNil: presentations first on: html ].
	html div
		class: 'tabbed-arrangement';
		script: (self tabScriptWith: html);
		with: [ 
			self renderTabsHeaderOn: html.
			actionsPresenters do: [:each|
				self renderActionsContentFrom: each on: html ] ]
]

{ #category : #rendering }
SGLTabbedCompositePresenter >> renderTab: aTab asSelectedIf: isSelected on: html [
	html listItem 
		class: 'ui-tabs-selected' if: isSelected; 
		id: html nextId;
		with: [ self renderTabAchorFor: aTab on: html ]
]

{ #category : #rendering }
SGLTabbedCompositePresenter >> renderTabAchorFor: aTab on: html [
	html anchor
		url: (self loadContentScriptFor: aTab with: html);
		with: [self renderTitleOrIconOf: aTab on: html]
]

{ #category : #rendering }
SGLTabbedCompositePresenter >> renderTabsHeaderOn: html [
	|index|
	index := self indexForSelectedPresentation.
	actionsPresenters := Array new: self presentation matchingPresentations size.
	html unorderedList: [
		self presentation matchingPresentations withIndexDo: [ :each :i|
			self renderTab: each asSelectedIf: i = index on: html.
			actionsPresenters at: i put: (self renderActionsFromTab: each on: html) ] ]
]

{ #category : #'jQuery-scripts' }
SGLTabbedCompositePresenter >> tabScriptWith: html [
	^ html jQuery new glamourTabs
		cache: true; 
		hasActions: true;
		closable: true;
		onSelect: (html jQuery ajax callbackTabs: [ :event | 
       		self presentation pane lastActivePresentation: ( self presentation matchingPresentations at: (event at: #index)+1 ) ]) 
]
