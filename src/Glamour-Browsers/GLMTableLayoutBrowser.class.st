Class {
	#name : #GLMTableLayoutBrowser,
	#superclass : #Object,
	#category : #'Glamour-Browsers'
}

{ #category : #'as yet unclassified' }
GLMTableLayoutBrowser class >> new [
	self deprecated: 'Please use GLMTabulator instead'.
	^ GLMTabulator new
]
