Class {
	#name : #SGLTextPresenter,
	#superclass : #WAPresenter,
	#instVars : [
		'renderer',
		'model',
		'htmlId'
	],
	#category : #'Glamour-Seaside-Core'
}

{ #category : #'instance creation' }
SGLTextPresenter class >> for: aModel with: aRenderer [
	^ self basicNew initializeFor: aModel with: aRenderer
]

{ #category : #accessing }
SGLTextPresenter >> htmlId [
	^ htmlId
]

{ #category : #accessing }
SGLTextPresenter >> htmlId: anObject [
	htmlId := anObject
]

{ #category : #initialization }
SGLTextPresenter >> initializeFor: aModel with: aRenderer [
	self initialize.
	model := aModel.
	renderer := aRenderer
]

{ #category : #accessing }
SGLTextPresenter >> model [
	^ model
]

{ #category : #rendering }
SGLTextPresenter >> renderContentOn: html [
	Transcript show: 'render text'; cr.
	html div
		class: 'ui-widget ui-widget-content ui-corner-all';
		class: 'presentation-container';
		class: 'glm-text-presentation';
		id: self htmlId;
		with: [
			self renderTextAreaOn: html]
]

{ #category : #rendering }
SGLTextPresenter >> renderTextAreaOn: html [
	html textArea
		value: model glamourPresentation formatedDisplayValue;
		script: ( html jQuery this glamourText 
			onChange: (
				html jQuery ajax
					sglCallbackText:  [ :value :script |
						model text: value.
						renderer updateScript: script  ]) )
			
]
