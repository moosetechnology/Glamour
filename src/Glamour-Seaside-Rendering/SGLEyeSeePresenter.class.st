Class {
	#name : #SGLEyeSeePresenter,
	#superclass : #SGLPresenter,
	#instVars : [
		'presentation'
	],
	#category : #'Glamour-Seaside-Rendering'
}

{ #category : #private }
SGLEyeSeePresenter >> eyeSeeCanvas [

	| diagramRenderer canvas |
	
	diagramRenderer := ESDiagramRenderer new.
	self presentation renderOn: diagramRenderer.
	
	canvas := diagramRenderer canvas.
	canvas selected: self presentation selectedElement.
	
	^ canvas
]

{ #category : #initialization }
SGLEyeSeePresenter >> initializeFor: aPresentation [

	presentation := aPresentation
]

{ #category : #accessing }
SGLEyeSeePresenter >> presentation [

	^ presentation
]

{ #category : #rendering }
SGLEyeSeePresenter >> renderContentOn: html [

	html div
		id: (self renderer uuidFor: self presentation);
		with: [ self renderImageOn: html ]
]

{ #category : #rendering }
SGLEyeSeePresenter >> renderImageOn: html [

	| canvas |
	
	canvas := self eyeSeeCanvas.
	html image
		form: canvas imageForm;
		onClick: (html jQuery ajax 
			callback: [ :value |
				| coordinates element |
				coordinates := (value contents findTokens: $,)
					collect: [ :each | each asNumber ].
				element := canvas diagram atPoint: coordinates first @ coordinates second.
				self presentation selection: (element ifNotNil: [ element model ]).
				self presentation selectedElement: element ]
			value: (JSStream on: 'event.layerX+","+event.layerY');
			script: [ :script |
				self renderer scriptFor: self presentation put: ((html jQuery id: (self renderer uuidFor: self presentation))
					replaceWith: [ :aRenderer | aRenderer render: self ]).
				self renderer updateScript: script ])
]
