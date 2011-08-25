"
This browser offers a Glamour-based MondrianEasel.

Example:
self openOn: {#aClass -> Object}
"
Class {
	#name : #GLMMondrianEasel,
	#superclass : #GLMBrowserTemplate,
	#category : #'Glamour-Tools'
}

{ #category : #building }
GLMMondrianEasel >> buildBrowser [
	browser := GLMTabulator new.
	browser title: 'Mondrian Easel'.
	browser
		row: #painting span: 2;
		row: [ :r | 
					r
						column: #script span: 3;
						column: #variables span: 2 ].
	browser transmit
		to: #script;
		andShow: [ :a | self scriptIn: a ].
	browser transmit
		to: #variables;
		andShow: [ :a | self variablesIn: a ].
	browser transmit
		to: #painting;
		fromOutsidePort: #entity;
		from: #script;
		andShow: [ :a | self mondrianIn: a ].
	^ browser
]

{ #category : #building }
GLMMondrianEasel >> mondrianIn: a [
	^ a mondrian
		title: 'Mondrian painting';
		painting: [ :view :bindings :script | 
			| context |
			context := GLMContext with: #view -> view withAll: bindings.
			Compiler new evaluate: script in: context to: context ];
		act: [ :m | m canvas exportAsPNG ] entitled: 'Export as PNG';
		act: [ :m | 
					m canvas root decreaseZoom.
					m canvas changed ]
			icon: MondrianIcons mondrianZoomOut
			entitled: 'Zoom out';
		act: [ :m | 
					m canvas root increaseZoom.
					m canvas root updateWindow ]
			icon: MondrianIcons mondrianZoomIn
			entitled: 'Zoom in'
]

{ #category : #building }
GLMMondrianEasel >> scriptIn: a [
	^ a text
		forSmalltalk;
		variableBindings: [ :bindings | 
					| col |
					col := OrderedCollection withAll: bindings.
					col add: #view -> MOViewRenderer new.
					col ];
		title: 'Mondrian script';
		display: 'view';
		populate: #selection
			icon: GLMUIThemeExtraIcons glamorousAccept
			on: $s
			entitled: 'Generate View'
			with: [ :text | text text ]
]

{ #category : #building }
GLMMondrianEasel >> variablesIn: a [
	^ a table
		column: 'Variable' evaluated: [ :each | each key asString ];
		column: 'Value' evaluated: [ :each | each value asString contractTo: 20 ]
]
