Class {
	#name : #SGLAccordionCompositePresenter,
	#superclass : #SGLCompositePresenter,
	#category : #'Glamour-Seaside-Rendering'
}

{ #category : #rendering }
SGLAccordionCompositePresenter >> renderContentOn: html [
	| presentations index |
	presentations := self presentation matchingPresentations.
	presentations isEmpty ifTrue: [ ^ self renderEmptyPresentationOn: html ].
	presentations size = 1 ifTrue: [ ^ self renderWithTitleOrNil: presentations first ].
	
	index := self indexForSelectedPresentation.
	html div
		class: 'accordion-arrangement';
  	      script: (html jQuery new accordion "animated: false; clearStyle: true;" active: index-1);
   	      with: [
         		presentations withIndexDo: [ :each :i | 
				html div: [ 
					html anchor: each titleValue. 
					self renderActionsFrom: each on: html ].
				html div: [ self render: each on: html ] ] ]
]
