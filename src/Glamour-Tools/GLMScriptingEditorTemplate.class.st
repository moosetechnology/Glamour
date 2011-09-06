Class {
	#name : #GLMScriptingEditorTemplate,
	#superclass : #GLMBrowserTemplate,
	#category : #'Glamour-Tools'
}

{ #category : #building }
GLMScriptingEditorTemplate >> buildBrowser [
	browser := GLMTabulator new.
	self setTitleOf: browser.
	browser
		row: #result span: 2;
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
		to: #result;
		fromOutsidePort: #entity;
		from: #script;
		andShow: [ :a | self resultIn: a ].
	^ browser
]

{ #category : #building }
GLMScriptingEditorTemplate >> defaultBindings [
	"Override this method if you want to provide more bindings for your editor.
	Typically these bindings are related to the Facade that offers the entry point to the scripting API"
	^ {}
]

{ #category : #building }
GLMScriptingEditorTemplate >> defaultDisplayIn: aPresentation [
	^ ''
]

{ #category : #building }
GLMScriptingEditorTemplate >> defaultTitle [
	^ 'Editor'
]

{ #category : #building }
GLMScriptingEditorTemplate >> resultIn: a [
	"Override this method to describe the presentation that should show the result
	of evaluating the script"
	self subclassResponsibility 
]

{ #category : #building }
GLMScriptingEditorTemplate >> scriptIn: a [
	^ a text
		title: 'Script';
		forSmalltalk;
		variableBindings: [ :bindings | 
					| col |
					col := OrderedCollection withAll: bindings.
					col addAll: self defaultBindings.
					col ];
		with: [:p | self defaultDisplayIn: p ];
		populate: #selection
			icon: GLMUIThemeExtraIcons glamorousAccept
			on: $s
			entitled: 'Generate'
			with: [ :text | text text ]
]

{ #category : #building }
GLMScriptingEditorTemplate >> setTitleOf:  b [
	b title: self defaultTitle
]

{ #category : #building }
GLMScriptingEditorTemplate >> variablesIn: a [
	^ a table
		column: 'Variable' evaluated: [ :each | each key asString ];
		column: 'Value' evaluated: [ :each | each value asString contractTo: 20 ]
]
