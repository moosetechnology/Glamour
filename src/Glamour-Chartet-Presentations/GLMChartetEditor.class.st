"
This browser offers a Glamour-based editor for Chartet charts.

Example:
self openOn: {#variable->'value'}

This will open the editor with a variable named #variable whose value will be 'value'.
"
Class {
	#name : #GLMChartetEditor,
	#superclass : #GLMScriptingEditorTemplate,
	#category : #'Glamour-Chartet-Presentations'
}

{ #category : #building }
GLMChartetEditor >> defaultScriptBindings [
	^ {#chart -> GETDiagramBuilder new}
]

{ #category : #building }
GLMChartetEditor >> defaultScriptDisplayIn: aPresentation [
	^ aPresentation 
		display: 'chart'
		"morphicAct: [:text | GLMEyeSeeExamplesBrowser open ] 
			icon: GLMUIThemeExtraIcons glamorousExample 
			entitled: 'Browse basic examples'"
]

{ #category : #building }
GLMChartetEditor >> defaultTitle [
	^ 'Chartet Editor'
]

{ #category : #private }
GLMChartetEditor >> evaluate: script in: context for: view [
	| message |
	^ [ Compiler new evaluate: script in: context to: context ]
		on: Error
		do: [ :e | 
			message := e class name , ': ' , e messageText.
			self inform: message.
			view shape label color: Color red lighter; withText .
			view node: message ]
]

{ #category : #building }
GLMChartetEditor >> resultIn: a [
	^ a chartet
		title: 'View';
		chart: [ :chart :bindings :script | 
					| context |
					context := GLMDoItContext with: #chart -> chart withAll: bindings.
					self evaluate: script in: context for: chart ]
]
