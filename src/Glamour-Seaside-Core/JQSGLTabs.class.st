Class {
	#name : #JQSGLTabs,
	#superclass : #JQTabs,
	#category : #'Glamour-Seaside-Core'
}

{ #category : #actions }
JQSGLTabs >> add: aUrl label: aRenderable actions: htmlContent [	
	self action: 'add' arguments: (Array with: aUrl with: (self render: aRenderable)).
	self optionAt: 'actionsContent' put: htmlContent
	
]

{ #category : #'options-generated' }
JQSGLTabs >> closable: aBoolean [
	"Whether or not to append a close button to the tabs"
	
	self optionAt: 'closable' put: aBoolean
]

{ #category : #'options-generated' }
JQSGLTabs >> hasActions: aBoolean [
	"Wether or not tabs have actions associated with them."

	self optionAt: 'hasActions' put: aBoolean
]

{ #category : #'options-generated' }
JQSGLTabs >> ifEmptyDo: aString [
	"An action to be executed when the last tab is removed.
	 	'remove': removes the DOM element containing the  tabs
	 	'replace': replaces the DOM element containing the tabs
		'nothing': default option " 
	
	self optionAt: 'ifEmptyDo' put: aString
]

{ #category : #accessing }
JQSGLTabs >> method [
	^ 'glamourTabs'
]

{ #category : #'events-generated' }
JQSGLTabs >> onRemove: anObject [
	"Bind this event with the 'delete' action as 'remove' does not properly work in JQueru-UI 1.8.2 "

	self optionAt: 'glmDelete' put: anObject asFunction
]
