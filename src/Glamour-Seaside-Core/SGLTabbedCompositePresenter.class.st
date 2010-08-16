Class {
	#name : #SGLTabbedCompositePresenter,
	#superclass : #WAPresenter,
	#instVars : [
		'compositePresentation',
		'renderer'
	],
	#category : #'Glamour-Seaside-Core'
}

{ #category : #'as yet unclassified' }
SGLTabbedCompositePresenter class >> for: aCompositePresentation with: aRenderer [
	^ self basicNew initializeFor: aCompositePresentation with: aRenderer 
]

{ #category : #private }
SGLTabbedCompositePresenter >> indexForSelectedPresentation [
	|index|
	index := 1.
	compositePresentation matchingPresentations withIndexDo: [ :each :i | 
		compositePresentation pane lastActivePresentation notNil and: [ 
			each title = compositePresentation pane lastActivePresentation title ifTrue: [ index := i ] ] ].
	^ index
]

{ #category : #initialization }
SGLTabbedCompositePresenter >> initializeFor: aCompositePresentation with: aRenderer [
	self initialize.
	compositePresentation := aCompositePresentation.
	renderer := aRenderer
]

{ #category : #scripts }
SGLTabbedCompositePresenter >> loadContentScriptFor: aTab with: html [
	^ html jQuery ajax
		html: [ :aRenderer | 				
			renderer render: aTab on: aRenderer];
		fullUrl
]

{ #category : #rendering }
SGLTabbedCompositePresenter >> renderActionsFor: aTab on: html [
	html listItem
		class: 'glm-actions';
		style: 'display: none;';
		with: [ renderer renderActionsFrom: aTab on: html ]
]

{ #category : #rendering }
SGLTabbedCompositePresenter >> renderContentOn: html [
	| presentations|
	presentations := compositePresentation matchingPresentations.
	presentations isEmpty ifTrue: [ ^ renderer renderEmptyPresentation ].
	presentations size = 1 ifTrue: [^ renderer renderWithTitleOrNil: presentations first ].
	html div
		class: 'tabbed-arrangement';
		script: (self tabScriptWith: html);
		with: [ self renderTabsHeaderOn: html ]
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
		with: [renderer renderTitleOrIconOf: aTab on: html]
]

{ #category : #rendering }
SGLTabbedCompositePresenter >> renderTabsHeaderOn: html [
	|index|
	index := self indexForSelectedPresentation.
	html unorderedList: [
		compositePresentation matchingPresentations withIndexDo: [ :each :i|
			self renderTab: each asSelectedIf: i = index on: html.
			self renderActionsFor: each on: html ] ]
]

{ #category : #scripts }
SGLTabbedCompositePresenter >> tabScriptWith: html [
	^ html jQuery new glamourTabs 
		cache: true; 
		hasActions: true;
		closable: true;
		onSelect: (html jQuery ajax callbackTabs: [ :event | 
       		compositePresentation pane lastActivePresentation: (compositePresentation matchingPresentations at: (event at: #index)+1 ) ]) 
]
