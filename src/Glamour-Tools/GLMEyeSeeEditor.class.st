"
This browser offers a Glamour-based editor for EyeSee charts.

Example:
self openOn: {#variable->'value'}

This will open the editor with a variable named #variable whose value will be 'value'.
"
Class {
	#name : #GLMEyeSeeEditor,
	#superclass : #GLMScriptingEditorTemplate,
	#category : #'Glamour-Tools'
}

{ #category : #building }
GLMEyeSeeEditor >> defaultScriptBindings [
	^ {#chart -> ESDiagramRenderer new}
]

{ #category : #building }
GLMEyeSeeEditor >> defaultScriptDisplayIn: aPresentation [
	^ aPresentation 
		display: 'chart';
		morphicAct: [:text | GLMEyeSeeExamplesBrowser open ] icon: GLMUIThemeExtraIcons glamorousExample entitled: 'Browse basic examples'
]

{ #category : #building }
GLMEyeSeeEditor >> defaultTitle [
	^ 'EyeSee Editor'
]

{ #category : #building }
GLMEyeSeeEditor >> resultIn: a [
	^ a eyesee
		title: 'Chart';
		diagram: [ :renderer :bindings :script | 
			| context |
			context := GLMDoItContext with: #chart -> renderer withAll: bindings.
			Compiler new evaluate: script in: context to: context ]
]
