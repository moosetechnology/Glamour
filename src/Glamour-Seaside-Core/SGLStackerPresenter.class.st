Class {
	#name : #SGLStackerPresenter,
	#superclass : #SGLBrowserPresenter,
	#category : #'Glamour-Seaside-Rendering'
}

{ #category : #rendering }
SGLStackerPresenter >> renderContentOn: html [
	self flag: 'to implement'.
	self renderEmptyPresentationOn: html
]
