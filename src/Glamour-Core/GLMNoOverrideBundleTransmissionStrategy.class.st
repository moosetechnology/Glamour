Class {
	#name : #GLMNoOverrideBundleTransmissionStrategy,
	#superclass : #GLMBundleTransmissionStrategy,
	#category : #'Glamour-Core'
}

{ #category : #transmitting }
GLMNoOverrideBundleTransmissionStrategy >> transmitIn: aContext [
	(self transmission destination hasPane and: [
		self transmission destination pane presentations ~= self presentations ]) ifTrue: [
		self transmission destination pane clearIn: aContext.
			self transmission destination pane presentations: self presentations copy ]
]
