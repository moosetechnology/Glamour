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
	^ [ Compiler new evaluate: script in: context to: context ]
		on: Error
		do: [ :e | 
			message := e class name , ': ' , e errorMessage.
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
					self evaluate: script in: context for: view ];
		act: [ :roassal | ROExportPNGCommand new executeOn: roassal view raw ] entitled: 'Export as PNG';
		act: [ :roassal "act: [ :m | m canvas exportAsJPEG ] entitled: 'Export as JPEG';
		act: [ :m | m canvas exportAsSVG ] entitled: 'Export as SVG';" | ROZoomOutMove new on: roassal view stack firstView ]
			icon: MondrianIcons mondrianZoomOut
			entitled: 'Zoom out';
		act: [ :roassal | ROZoomInMove new on: roassal view stack firstView ]
			icon: MondrianIcons mondrianZoomIn
			entitled: 'Zoom in'
]
