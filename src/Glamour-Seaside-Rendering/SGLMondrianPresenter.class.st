Class {
	#name : #SGLMondrianPresenter,
	#superclass : #SGLPresenter,
	#instVars : [
		'presentation'
	],
	#category : #'Glamour-Seaside-Rendering'
}

{ #category : #rendering }
SGLMondrianPresenter >> contentInitializationScriptWith: html [
	^ html jQuery new glamourRoassal
		contentURL: (self loadPresentationContentURLWith: html)
]

{ #category : #initialization }
SGLMondrianPresenter >> initializeFor: aPresentation [
	presentation := aPresentation
]

{ #category : #callbacks }
SGLMondrianPresenter >> loadPresentationContentURLWith: html [
	 ^ html jQuery ajax
		sglRoassalCallbackContentURL: [ :anotherHtml :imageExtent | ||
			self renderImageOn: anotherHtml withExtent: imageExtent ]
]

{ #category : #private }
SGLMondrianPresenter >> mondrianCanvas [
		| view  |
	view := self presentation view.
	self presentation renderOn: view. 
	"canvas := view canvas. 
	canvas root: view root.
	canvas selected: (view 
		nodeForDomainValue: self presentation selection 
		ifAbsent: [ nil ])."
	^ view view 
]

{ #category : #accessing }
SGLMondrianPresenter >> presentation [
	^ presentation
]

{ #category : #rendering }
SGLMondrianPresenter >> renderContentOn: html [
	html div
		id: (self renderer uuidFor: self presentation);
		script: (self contentInitializationScriptWith: html);
		class: 'glm-mondrian-presentation'";
		with: [ self renderImageOn: html ]"
]

{ #category : #rendering }
SGLMondrianPresenter >> renderImageOn: html [
	| canvas |
	canvas := self mondrianCanvas setUpCanvas.
	html image
		form: (canvas morphClass new
			canvas: canvas;
			extent: 1000@600)  imageForm ;	
		onClick: (html jQuery ajax 
			callback: [ :value |
				"| coordinates element |
				coordinates := (value contents findTokens: $,)
					collect: [ :each | each asNumber ].
				element := canvas root elementAt: coordinates first @ coordinates second.
				self presentation selection: (element isNil
					ifFalse: [ element model ])" ]
			value: (JSStream on: 'event.layerX+","+event.layerY');
			script: [ :script |
				self renderer scriptFor: self presentation put: ((html jQuery id: (self renderer uuidFor: self presentation))
					replaceWith: [ :aRenderer | aRenderer render: self ]).
				self renderer updateScript: script ])
]

{ #category : #rendering }
SGLMondrianPresenter >> renderImageOn: html withExtent: anExtent [
	| trCanvas |
	trCanvas := self mondrianCanvas setUpCanvas.
	html image
		form: (trCanvas morphClass new
			canvas: trCanvas;
			extent: anExtent) imageForm;	
		onClick: (html jQuery ajax 
			callback: [ :value |
				self presentation selection:  (OFMeta model classes sorted: [:x :y | x fullName < y fullName]) second.
				"| coordinates element |
				coordinates := (value contents findTokens: $,)
					collect: [ :each | each asNumber ].
				element := canvas root elementAt: coordinates first @ coordinates second.
				self presentation selection: (element isNil
					ifFalse: [ element model ])" ]
			value: (JSStream on: 'event.layerX+","+event.layerY');
			script: [ :script |
				self renderer scriptFor: self presentation put: ((html jQuery id: (self renderer uuidFor: self presentation))
					replaceWith: [ :aRenderer | aRenderer render: self ]).
				self renderer updateScript: script ])
]
