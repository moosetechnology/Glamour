Class {
	#name : #SGLPaneWithoutTitlePresenter,
	#superclass : #SGLPanePresenter,
	#category : #'Glamour-Seaside-Rendering'
}

{ #category : #rendering }
SGLPaneWithoutTitlePresenter >> renderPaneOn: html [
	self render: pane presentations on: html
]
