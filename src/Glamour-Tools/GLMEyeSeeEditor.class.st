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
		morphicAct: [:text | GLMEyeSeeExamplesBrowser open ] 
			icon: GLMUIThemeExtraIcons glamorousExample 
			entitled: 'Browse basic examples'
]

{ #category : #building }
GLMEyeSeeEditor >> defaultTitle [
	^ 'EyeSee Editor'
]

{ #category : #building }
GLMEyeSeeEditor >> getDiagramRenderer: renderer bindings: bindings scripts: script [
	| context diagramRenderer |
	context := GLMDoItContext with: #chart -> renderer withAll: bindings.
	^ [ 
	diagramRenderer := (Smalltalk compiler requestor: self) evaluate: script in: context to: context.
	diagramRenderer diagram ifNil: [ Error signal: 'The Diagram was not initialized' ] ]
		on: Error
		do: [ :e | 
			self inform: e class name , ': ' , e messageText.
			renderer pieDiagram
				radius: 100;
				models: #('Error');
				pieValue: [ :x | 100 ];
				displayLegend: true;
				defaultColor: Color red ]
]

{ #category : #building }
GLMEyeSeeEditor >> resultIn: a [
	^ a eyesee
		title: 'Chart';
		diagram: [ :renderer :bindings :script | self getDiagramRenderer: renderer bindings: bindings scripts: script ];
		defaultActions
]
