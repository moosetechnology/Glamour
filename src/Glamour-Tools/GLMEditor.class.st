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
			display: [  :bindings :script | 
				| context |
				context := GLMContext withAll: bindings.
				Compiler new evaluate: script in: context to: context ];
			act: [:dynamic | dynamic cachedPresentation presentations first viewTree ] entitled: 'View browser tree' 
]
