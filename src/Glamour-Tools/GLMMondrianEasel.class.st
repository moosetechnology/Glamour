"
This browser offers a Glamour-based MondrianEasel.

Example:
self openOn: {#variable->'value'}

This will open the editor with a variable named #variable whose value will be 'value'.
"
Class {
	#name : #GLMMondrianEasel,
	#superclass : #GLMScriptingEditorTemplate,
	#category : #'Glamour-Tools'
}

{ #category : #building }
GLMMondrianEasel >> defaultScriptBindings [
	^ {#view -> MOViewRenderer new}
]

{ #category : #building }
GLMMondrianEasel >> defaultScriptDisplayIn: aPresentation [
	^ aPresentation display: 'view'
]

{ #category : #building }
GLMMondrianEasel >> defaultTitle [
	^ 'Mondrian Easel'
]

{ #category : #private }
GLMMondrianEasel >> evaluate: script in: context for: view [
	| message |
	^ [ Compiler new evaluate: script in: context to: context ]
		on: Error
		do: [ :e | 
			message := e class name , ': ' , e errorMessage.
			self inform: message.
			view shape label fontColor: Color red; withText .
			view node: message ]
]

{ #category : #building }
GLMMondrianEasel >> resultIn: a [
	^ a mondrian
		title: 'Painting';
		painting: [ :view :bindings :script | 
			| context |
			context := GLMDoItContext with: #view -> view withAll: bindings.
			self evaluate: script in: context for: view ];
		act: [ :m | m canvas exportAsPNG ] entitled: 'Export as PNG';
		act: [ :m | m canvas exportAsJPEG ] entitled: 'Export as JPEG';
		act: [ :m | m canvas exportAsSVG ] entitled: 'Export as SVG';
		act: [ :m | m canvas exportAsTikz ] entitled: 'Export as Tikz';
		act: [ :m | m canvas exportAsXML ] entitled: 'Export as XML';
		act: [ :m | 
					m canvas root decreaseZoom.
					m canvas changed ]
			icon: MondrianIcons mondrianZoomOut
			on: $-
			entitled: 'Zoom out';
		act: [ :m | 
					m canvas root increaseZoom.
					m canvas changed ]
			icon: MondrianIcons mondrianZoomIn
			on: $+
			entitled: 'Zoom in'
]
