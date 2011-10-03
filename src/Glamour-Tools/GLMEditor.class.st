"
self openOn: {#text->
'| browser |
browser := GLMTabulator new.
browser startOn: 42'}
"
Class {
	#name : #GLMEditor,
	#superclass : #GLMScriptingEditorTemplate,
	#category : #'Glamour-Tools'
}

{ #category : #private }
GLMEditor >> createResultBrowserWithBindings: bindings andScript: script [
	| context resultBrowser scriptedBrowser |
	context := GLMContext withAll: bindings.
	scriptedBrowser  := Compiler new evaluate: script in: context to: context.
	resultBrowser := GLMTabulator new.
	resultBrowser column: #theOuterPane.
	resultBrowser transmit
		fromOutsideEntityPort; 
		to: #theOuterPane;
		andShow: [:a | 
			a custom: scriptedBrowser ].
	"this is a bit of a hack.
	we take the entity as specified in the script by taking it directly
	from the evaluated script browser.
	this is needed because right now the input entity is specified 
	in the same script together with the browser"
	^ resultBrowser startOn: scriptedBrowser entity
]

{ #category : #building }
GLMEditor >> defaultDisplayIn: aPresentation [
	^ aPresentation display: '| browser |
browser := GLMTabulator new.'
]

{ #category : #building }
GLMEditor >> defaultTitle [
	^ 'Glamorous Browser Editor'
]

{ #category : #building }
GLMEditor >> resultIn: composite [
	composite dynamic
		title: 'Preview';
		display: [ :bindings :script | self createResultBrowserWithBindings: bindings andScript: script ];
		act: [ :dynamic | 
			dynamic cachedPresentation presentations first panes first presentations first viewTree ] 
			entitled: 'View browser tree'
]
