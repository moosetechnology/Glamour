Class {
	#name : #GLMPresentIfNoneStrategy,
	#superclass : #GLMPresentStrategy,
	#category : #'Glamour-Core'
}

{ #category : #transmitting }
GLMPresentIfNoneStrategy >> transmitIn: aContext [
	(self transmission destination hasPane and: [
		self transmission destination pane presentations ~= self presentations ]) ifTrue: [
		self transmission destination pane clearIn: aContext.
			self transmission destination pane presentations: self presentations copy ]
]
