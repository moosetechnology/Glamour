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
	html div
		class: 'ui-widget ui-widget-content ui-corner-all';
		class: 'presentation-container';
		class: 'glm-text-presentation';
		with: [
			self renderTextAreaOn: html]
]

{ #category : #rendering }
SGLTextPresenter >> renderTextAreaOn: html [
	html textArea
		id: self htmlId;
		value: model glamourPresentation formatedDisplayValue;
		script: ( html jQuery this glamourText 
			onChange: (
				html jQuery ajax
					sglCallbackText:  [ :value :script |
						model text: value.
						renderer updateScript: script  ]) )
			
]

{ #category : #updating }
SGLTextPresenter >> updateText [
	renderer 
		scriptFor: self model glamourPresentation 
		add: ( ( (renderer html jQuery id: (
			renderer uuidFor: self model glamourPresentation) )  glamourText ) changeText: self model text )
]
