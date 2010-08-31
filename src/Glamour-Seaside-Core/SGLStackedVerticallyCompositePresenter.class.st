Class {
	#name : #SGLStackedVerticallyCompositePresenter,
	#superclass : #SGLCompositePresenter,
	#category : #'Glamour-Seaside-Rendering'
}

{ #category : #rendering }
SGLStackedVerticallyCompositePresenter >> renderContentOn: html [
	| presentations|
	presentations := self presentation matchingPresentations.
	presentations isEmpty ifTrue: [ ^ self renderEmptyPresentationOn: html ].	
	presentations size = 1 ifTrue: [^ self renderWithTitleOrNil: presentations first on: html ].
	
	html div 
		class: 'ui-widget ui-widget-content ui-corner-all';
		class: 'stacked-arrangement';
		with: [
			presentations do: [ :each | 
				self renderWithTitle: each andAddCloseButton: true on: html ] ]
]
