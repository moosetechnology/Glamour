Class {
	#name : #GLMListRenderer,
	#superclass : #GLMRenderer,
	#category : #'Glamour-Core'
}

{ #category : #'as yet unclassified' }
GLMListRenderer >> glamorousValue: aContext [

	^ PluggableListMorph new
		on: aContext
		list: #items
		selected: #selectionIndex
		changeSelected: #selectionIndex:
		menu: nil 
		keystroke: nil;
		yourself.
]
