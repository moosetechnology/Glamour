Class {
	#name : #GLMPopupAction,
	#superclass : #GLMAction,
	#category : #'Glamour-Core'
}

{ #category : #actions }
GLMPopupAction >> popupActOn: aPresentation from: aButton [

	GLMEmptyPopupBrick new
		with: [ :b | b themer: b themer actionThemer ];
		doNotHideUnhover;
		onCreated: [ :popup |self action glamourValueWithArgs: (Array 
				with: aPresentation 
				withAll: { aPresentation entity . popup }) ];
		openBelowFor: aButton;
		beRightToLeftWithOffset: 0
]

{ #category : #rendering }
GLMPopupAction >> renderGlamorouslyOn: aRenderer [
	^aRenderer renderPopupAction: self
]
