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

{ #category : #accessing }
SGLDropDownListModel >> list [
	
	^list ifNil: [ list:= (self glamourPresentation displayValue 
									collect:[ :each| (self glamourPresentation formatedDisplayValueOf: each) ])]
]

{ #category : #accessing }
SGLDropDownListModel >> selectedItem [
	"Answer the currently selected item or nil if none."

	^self selectionIndex = 0
		ifTrue: [nil]
		ifFalse: [self glamourPresentation displayValue at: self selectionIndex]
]

{ #category : #accessing }
SGLDropDownListModel >> selectionIndex [

	^ selectionIndex ifNil:[ selectionIndex:= self glamourPresentation selectedIndex ]
]

{ #category : #callbacks }
SGLDropDownListModel >> selectionIndex: anObject [
	selectionIndex := anObject.
	self announcer announce: (
			GLMDropDownListMorphSelectionChanged new 
				selectionValue: self selectedItem
				yourself)
]

{ #category : #callbacks }
SGLDropDownListModel >> updateSelectionIndex [

	self selectionIndex: self selectionIndex
]
