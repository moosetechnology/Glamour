"
This browser offers a Glamour-based MondrianEasel.

Example:
self openOn: {#variable->'value'}
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

{ #category : #building }
GLMMondrianEasel >> resultIn: a [
	^ a mondrian
		title: 'Painting';
		painting: [ :view :bindings :script | 
			| context |
			context := GLMContext with: #view -> view withAll: bindings.
			Compiler new evaluate: script in: context to: context ];
		act: [ :m | m canvas exportAsPNG ] entitled: 'Export as PNG';
		act: [ :m | m canvas exportAsJPEG ] entitled: 'Export as JPEG';
		act: [ :m | m canvas exportAsSVG ] entitled: 'Export as SVG';
		act: [ :m | m canvas exportAsTikz ] entitled: 'Export as Tikz';
		act: [ :m | m canvas exportAsXML ] entitled: 'Export as XML';
		act: [ :m | 
					m canvas root decreaseZoom.
					m canvas changed ]
			icon: MondrianIcons mondrianZoomOut
			entitled: 'Zoom out';
		act: [ :m | 
					m canvas root increaseZoom.
					m canvas changed ]
			icon: MondrianIcons mondrianZoomIn
			entitled: 'Zoom in'
]
