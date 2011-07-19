"
self openOn: 
'| browser |
browser := GLMTabulator new.
browser startOn: 42'.
"
Class {
	#name : #GLMEditor,
	#superclass : #GLMBrowserTemplate,
	#category : #'Glamour-Tools'
}

{ #category : #building }
GLMEditor >> buildBrowser [
	browser := GLMTabulator new.
	browser row: #browser; row: #source.
	browser title: 'Glamour Browser Editor'.
	browser transmit to: #source; andShow: [ :a |
		a text
			title: 'Editor';
			forSmalltalk;
			populate: #selection icon: GLMUIThemeExtraIcons glamorousAccept on: $s entitled: 'Open (s)' with: [:text | text text]].
	browser transmit to: #browser; from: #source; transformed: [:source | (Compiler evaluate: source logged: false)]; andShow: [ :a |
		a dynamic
			title: 'Preview';
			act: [:dynamic | dynamic cachedPresentation presentations first viewTree ] entitled: 'View browser tree' ].
	^ browser
]