Class {
	#name : #SGLMondrianPresenter,
	#superclass : #SGLPresenter,
	#instVars : [
		'presentation'
	],
	#category : #'Glamour-Seaside-Rendering'
}

{ #category : #initialization }
SGLMondrianPresenter >> initializeFor: aPresentation [
	presentation := aPresentation
]

{ #category : #private }
SGLMondrianPresenter >> mondrianCanvas [
	| view canvas |
	view := MOViewRenderer new.
	self presentation renderOn: view. 
	canvas := MOCanvas new. 
	canvas root: view root.
	canvas selected: (view 
		nodeForDomainValue: self presentation selection 
		ifAbsent: [ nil ]).
	^ canvas
]

{ #category : #accessing }
SGLMondrianPresenter >> presentation [
	^ presentation
]

{ #category : #rendering }
SGLMondrianPresenter >> renderContentOn: html [
	html div
		id: (self renderer uuidFor: self presentation);
		class: 'glm-mondrian-presentation';
		with: [ self renderImageOn: html ]
]

{ #category : #rendering }
SGLMondrianPresenter >> renderImageOn: html [
	| canvas |
	canvas := self mondrianCanvas.
	html image
		form: canvas imageForm;	
		onClick: (html jQuery ajax 
			callback: [ :value |
				| coordinates element |
				coordinates := (value contents findTokens: $,)
					collect: [ :each | each asNumber ].
				element := canvas root elementAt: coordinates first @ coordinates second.
				self presentation selection: (element isNil
					ifFalse: [ element model ]) ]
			value: (JSStream on: 'event.layerX+","+event.layerY');
			script: [ :script |
				self renderer scriptFor: self presentation put: ((html jQuery id: (self renderer uuidFor: self presentation))
					replaceWith: [ :aRenderer | aRenderer render: self ]).
				self renderer updateScript: script ])
]
