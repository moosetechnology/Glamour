"
This browser offers a Glamour-based Roassal Easel.

Example:
self openOn: {#variable->'value'}

This will open the editor with a variable named #variable whose value will be 'value'.
"
Class {
	#name : #GLMRoassalEasel,
	#superclass : #GLMScriptingEditorTemplate,
	#category : #'Glamour-Tools'
}

{ #category : #building }
GLMRoassalEasel >> defaultScriptBindings [
	^ {#view -> ROMondrianViewBuilder new}
]

{ #category : #building }
GLMRoassalEasel >> defaultScriptDisplayIn: aPresentation [
	^ aPresentation 
		display: 'view';
		morphicAct: [:text | GLMRoassalExamplesBrowser open ] icon: GLMUIThemeExtraIcons glamorousExample entitled: 'Browse basic examples'
]

{ #category : #building }
GLMRoassalEasel >> defaultTitle [
	^ 'Roassal Easel'
]

{ #category : #private }
GLMRoassalEasel >> evaluate: script in: context for: view [
	| message |
	^ [ (Smalltalk compiler requestor: self) evaluate: script in: context to: context ]
		on: Error
		do: [ :e | 
			message := e class name , ': ' , e messageText.
			self inform: message.
			view shape label color: Color red lighter; withText .
			view node: message ]
]

{ #category : #building }
GLMRoassalEasel >> resultIn: a [
	^ a roassal
		title: 'View';
		painting: [ :view :bindings :script | 
					| context |
					context := GLMDoItContext with: #view -> view withAll: bindings.
					self evaluate: script in: context for: view ]
]
