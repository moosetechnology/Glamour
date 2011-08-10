Class {
	#name : #SGLMagrittePresenter,
	#superclass : #SGLPresenter,
	#instVars : [
		'presentation'
	],
	#category : #'Glamour-Seaside-Rendering'
}

{ #category : #'initialize-release' }
SGLMagrittePresenter >> initializeFor: aPresentation [

		self presentation: aPresentation
]

{ #category : #accessing }
SGLMagrittePresenter >> presentation [

	^ presentation
]

{ #category : #accessing }
SGLMagrittePresenter >> presentation: aPresentation [

	presentation := aPresentation
]

{ #category : #rendering }
SGLMagrittePresenter >> renderContentOn: html [

		| toShow description magritteComponent |
		toShow := self presentation displayValue.
		description := (self presentation magritteDescription glamourValue: toShow) copy.
		magritteComponent := (description asComponentOn: toShow)
			addValidatedForm;
			onAnswer: [ :answer | self presentation selection: answer ].
			
		html div
			script: (html jQuery this css: (Dictionary new 
				at: 'overflow' put: 'auto';
				yourself));
			class: 'magritte';
			with: 
				magritteComponent
				
]
