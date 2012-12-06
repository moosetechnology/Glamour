Class {
	#name : #SGLDropDownListModel,
	#superclass : #SGLWidgetModel,
	#instVars : [
		'selectionIndex',
		'list'
	],
	#category : #'Glamour-Seaside-Rendering'
}

{ #category : #'as yet unclassified' }
SGLDropDownListModel class >> for: aPresentation [
	|model|
	model := self new glamourPresentation: aPresentation.
	
	"When the morph changes, we want to update the glamour model"
	model announcer on: GLMDropDownListMorphSelectionChanged do: [ :ann | 
		"aPresentation announcer suspendAllWhile: ["
			aPresentation selection: ann selectionValue ] .
	
	^model
]

{ #category : #'as yet unclassified' }
SGLDropDownListModel >> list [
	
	^list ifNil: [ list:= (self glamourPresentation displayValue 
									collect:[ :each| (self glamourPresentation formatedDisplayValueOf: each) ])]
]

{ #category : #'as yet unclassified' }
SGLDropDownListModel >> selectedItem [
	"Answer the currently selected item or nil if none."

	^self selectionIndex = 0
		ifTrue: [nil]
		ifFalse: [self glamourPresentation displayValue at: self selectionIndex]
]

{ #category : #'as yet unclassified' }
SGLDropDownListModel >> selectionIndex [

	^ selectionIndex ifNil:[ selectionIndex:= self glamourPresentation selectedIndex ]
]

{ #category : #'as yet unclassified' }
SGLDropDownListModel >> selectionIndex: anObject [
	selectionIndex := anObject.
	self announcer announce: (
			GLMDropDownListMorphSelectionChanged new 
				selectionValue: self selectedItem
				yourself)
]

{ #category : #'as yet unclassified' }
SGLDropDownListModel >> updateSelectionIndex [

	self selectionIndex: self selectionIndex
]
