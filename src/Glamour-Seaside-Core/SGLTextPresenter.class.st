"
SGLTextPresenter has not been documented yet. The class comment should describe the purpose of the class, its collaborations and its variables.

Instance Variables:
	renderer	<SGLRenderer>
	model	<SGLTextModel>
	htmlId	<ProtoObject | PseudoContext>
	isSelectionNil	<Boolean>
		Indicates if the selection should be set to nil.
"
Class {
	#name : #SGLTextPresenter,
	#superclass : #SGLPresenter,
	#instVars : [
		'model',
		'htmlId'
	],
	#category : #'Glamour-Seaside-Rendering'
}

{ #category : #accessing }
SGLTextPresenter >> htmlId [
	^ htmlId
]

{ #category : #accessing }
SGLTextPresenter >> htmlId: anObject [
	htmlId := anObject
]

{ #category : #'jQuery-scripts' }
SGLTextPresenter >> initializationScriptWith: html [
	^ html jQuery this glamourText 
			onSelect: ( self onSelectActionWith: html );
			onChange: ( self onChangeActionWith: html )
]

{ #category : #initialization }
SGLTextPresenter >> initializeFor: aPresentation [
	model := SGLTextModel for: aPresentation.
	
	"When the glamour model changes, we want to update the presenter"
	aPresentation when: GLMContextChanged do: [ :ann | 
		( #(#text #selectionInterval #selectedText) includes:  ann property) 
			ifTrue: [
				model announcer suspendAllWhile: [
					self perform: ( ('update', ann property asString capitalized) , ':' ) asSymbol with: ann value ] ] ].
	aPresentation when: GLMPresentationUpdated do: [:ann | ].
	
]

{ #category : #accessing }
SGLTextPresenter >> model [
	^ model
]

{ #category : #'jQuery-scripts' }
SGLTextPresenter >> onChangeActionWith: html [
	^ html jQuery ajax
		sglCallbackText:  [ :event :script |
			self model text: (event at: 'text').
			self updateSelectionScript.
			self renderer updateScript: script  ]
]

{ #category : #'jQuery-scripts' }
SGLTextPresenter >> onSelectActionWith: html [
	^ html jQuery ajax 
		sglCallbackText: [ :event :script |
			((event at: 'port') = 'selection')
				ifTrue: [  | interval |
					interval := Interval from: (event at: 'start') to: (event at: 'end').
					self model 
						selectionInterval: interval 
						withSelectedText: (self model selectionForInterval: interval)	].
			((event at: 'port') = 'selectedText')
				ifTrue: [
					self model 
						selectionInterval:  (self model intervalForSelection: (event at: 'selection') ) ].
			((event at: 'port') = 'selectionInterval')
				ifTrue: [
					self model 
						selectedText: (self model selectionForInterval: (Interval from: (event at: 'start') to: (event at: 'end') ) ) ].
			self renderer updateScript: script ]
]

{ #category : #rendering }
SGLTextPresenter >> renderContentOn: html [
	"We populate the text port"
	self model text: model glamourPresentation formatedDisplayValue.
	html div
		class: 'ui-widget ui-widget-content ui-corner-all';
		class: 'presentation-container glm-text-presentation';
		with: [ self renderTextAreaOn: html ]
]

{ #category : #rendering }
SGLTextPresenter >> renderTextAreaOn: html [
	html textArea
		id: self htmlId;
		value: self model glamourPresentation formatedDisplayValue;
		script: (self initializationScriptWith: html)
			
]

{ #category : #callbacks }
SGLTextPresenter >> updateSelectedText: aSelection [
	self model selectedText: aSelection.
	self updateSelectedTextScriptWith: aSelection
]

{ #category : #private }
SGLTextPresenter >> updateSelectedTextScriptWith: aSelection [
	self renderer
		scriptFor: self model glamourPresentation 
		add: ( ( (self renderer html jQuery id: (
			self renderer uuidFor: self model glamourPresentation) )  glamourText ) selectText: (aSelection ifNil: ['']) )
]

{ #category : #callbacks }
SGLTextPresenter >> updateSelectionInterval: anInterval [
	self model selectionInterval: anInterval.
	self updateSelectionIntervalScriptWith: anInterval
]

{ #category : #private }
SGLTextPresenter >> updateSelectionIntervalScriptWith: anInterval [
	self renderer
		scriptFor: self model glamourPresentation 
		add: ( ( (self renderer html jQuery id: (
			self renderer uuidFor: self model glamourPresentation) )  glamourText ) 
				selectFrom: (anInterval ifNil: [0] ifNotNil: [anInterval first ])
				to: (anInterval ifNil: [0] ifNotNil: [anInterval last]) )
]

{ #category : #private }
SGLTextPresenter >> updateSelectionScript [
	self model selectionInterval 
		ifNil: [
			self model selectedText  ifNotNil: [
				self updateSelectedTextScriptWith: self model selectedText ] ] 
		ifNotNil:  [
			self updateSelectionIntervalScriptWith: self model selectionInterval ]
	
		
]

{ #category : #callbacks }
SGLTextPresenter >> updateText: aText [
	self model text: aText.
	self updateSelectionScript.
	self updateTextScriptWith: aText
]

{ #category : #callbacks }
SGLTextPresenter >> updateTextScriptWith: aText [
	self renderer 
		scriptFor: self model glamourPresentation 
		add: ( ( (self renderer html jQuery id: (
			self renderer uuidFor: self model glamourPresentation) )  glamourText ) changeText: (aText ifNil: ['']) )
]
