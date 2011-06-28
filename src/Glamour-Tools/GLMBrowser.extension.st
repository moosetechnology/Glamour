Extension { #name : #GLMBrowser }

{ #category : #'*glamour-tools' }
GLMBrowser >> viewOn: view [
	view shape umlClassWithTitle: #name.
	view nodes: self panes forEach: [:each |
	view node: each ports forIt: [
		view shape label text: #name.
		view nodes: each ports ].
	view node: each presentations forIt: [
"		view shape umlClassWithTitle: [:eachPresentation | eachPresentation class name removePrefix: 'GLM']."
		view nodes: each presentations presentations forEach: [:eachPresentation |
			eachPresentation viewOn: view]].
	view verticalLineLayout ].
	view 
		edges: self transmissions 
		fromAll: #origins
		to: #destination
]
