Extension { #name : #GLMBrowser }

{ #category : #'*glamour-tools' }
GLMBrowser >> viewNestedOn: view [
	view shape umlClassWithTitle: #name.
	view nodes: self panes forEach: [:each |
		view node: each ports forIt: [
			view shape label text: #name.
			view nodes: each ports.
			view verticalLineLayout gapSize: 2 ].
		view node: each presentations forIt: [
			view shape umlClassWithTitle: [:eachPresentation | eachPresentation class name removePrefix: 'GLM'].
	"		view shape label text: [:p | (p class name removePrefix: 'GLM') removeSuffix: 'Presentation' ]."
			each presentations presentations do: [:eachPresentation | 
				eachPresentation viewNestedOn: view ].
			view verticalLineLayout gapSize: 2 ].
		view verticalLineLayout gapSize: 0; stretch ].
	view 
		edges: self transmissions 
		fromAll: #origins
		to: #destination
]

{ #category : #'*glamour-tools' }
GLMBrowser >> viewTree [

	| view |
	
	view := MOViewRenderer new.
	self viewTreeOn: view.
	view open
]

{ #category : #'*glamour-tools' }
GLMBrowser >> viewTreeOn: view [
	super viewTreeOn: view.
	
	view shape umlClassWithTitle: #name.
	view nodes: self panes forEach: [ :each |
		view shape label text: #name.
		view nodes: each ports.
		view verticalLineLayout gapSize: 2 ].
	
	self panes do: [ :eachPane | 
		eachPane presentations presentations do: [:eachPresentation | 
			eachPresentation viewTreeOn: view ] ].

	view shape verticalOrthogonalLine color: Color lightGray. 	
	view edges: self panes from: #yourself toAll: [:each | each presentations presentations ].

	view shape verticalOrthogonalLine color: Color lightGray. 
	view edges: self panes from: self to: #yourself.

	view treeLayout layered
"	view 
		edges: self transmissions 
		fromAll: #origins
		to: #destination"
]
