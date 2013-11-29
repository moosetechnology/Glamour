"
This browser offers a Glamour-based editor for Chartet charts.

Example:
self openOn: {#variable->'value'}

This will open the editor with a variable named #variable whose value will be 'value'.
"
Class {
	#name : #GLMGraphETEditor,
	#superclass : #GLMScriptingEditorTemplate,
	#category : #'Glamour-GraphET-Presentations'
}

{ #category : #building }
GLMGraphETEditor >> defaultScriptBindings [
	^ {#chart -> GETDiagramBuilder new}
]

{ #category : #building }
GLMGraphETEditor >> defaultScriptDisplayIn: aPresentation [
	^ aPresentation 
		display: 'chart'
		"morphicAct: [:text | GLMEyeSeeExamplesBrowser open ] 
			icon: GLMUIThemeExtraIcons glamorousExample 
			entitled: 'Browse basic examples'"
]

{ #category : #building }
GLMGraphETEditor >> defaultTitle [
	^ 'GraphET Editor'
]

{ #category : #private }
GLMGraphETEditor >> evaluate: script in: context for: view [
	| message |
	^ [ Smalltalk compiler evaluate: script in: context to: context ]
		on: Error
		do: [ :e | 
			message := e class name , ': ' , e messageText.
			self inform: message.
			view shape label color: Color red lighter; withText .
			view node: message ]
]

{ #category : #building }
GLMGraphETEditor >> resultIn: a [
	^ a graphET
		title: 'View';
		chart: [ :chart :bindings :script | 
					| context |
					context := GLMDoItContext with: #chart -> chart withAll: bindings.
					self evaluate: script in: context for: chart ]
]
