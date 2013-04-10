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

{ #category : #building }
GLMRoassalEasel >> resultIn: a [
	^ a roassal
		title: 'View';
		painting: [ :view :bindings :script | 
			| context |
			context := GLMDoItContext with: #view -> view withAll: bindings.
			Compiler new evaluate: script in: context to: context ];
		act: [ :roassal | 
			| fName |
			fName := UIManager default request:'Please enter the name' translated initialAnswer: self externalName,'.png'.
			fName isEmptyOrNil ifTrue:[^self].
			PNGReadWriter putForm: roassal bitmap onFileNamed: fName. ] entitled: 'Export as PNG';
		"act: [ :m | m canvas exportAsJPEG ] entitled: 'Export as JPEG';
		act: [ :m | m canvas exportAsSVG ] entitled: 'Export as SVG';"
		act: [ :roassal | ROZoomOutMove new on: roassal view stack firstView ]
			icon: MondrianIcons mondrianZoomOut
			entitled: 'Zoom out';
		act: [ :roassal | ROZoomInMove new on: roassal view stack firstView ]
			icon: MondrianIcons mondrianZoomIn
			entitled: 'Zoom in'
]
