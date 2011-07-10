Extension { #name : #GLMBrowser }

{ #category : #'*glamour-tools' }
GLMBrowser >> viewAnnouncements [

	| view |
	
	view := MOViewRenderer new.
	self viewAnnouncementsOn: view.
	view open
]

{ #category : #'*glamour-tools' }
GLMBrowser >> viewAnnouncementsOn: view [
	view shape rectangle withoutBorder.
	view node: 'Glamour' forIt: [
		self viewTreeOn: view ].
	view shape rectangle withoutBorder.
	view node: 'Announced objects' forIt: [
		view shape label text: [:p | (p class name removePrefix: 'GLM') removeSuffix: 'Renderer' ].
		view nodes: 
			(self pane withAllPanes flatCollect: [:each | 
			(each instVarNamed: 'registry') glmSubscriptions collect: [:eachSub | eachSub subscriber]]) asSet.
		view shape label text: [:p | (p class name removePrefix: 'GLM') removeSuffix: 'Renderer' ].
		view nodes: 
			(self pane withAllPresentations flatCollect: [:each | 
			(each instVarNamed: 'registry') glmSubscriptions collect: [:eachSub | eachSub subscriber]]) asIdentitySet.
		view verticalLineLayout ].
	
	view shape line color: Color red.
	view edges: self pane withAllPanes from: #yourself toAll: [:each | 
			(each instVarNamed: 'registry') glmSubscriptions collect: [:eachSub | eachSub subscriber]].
	view shape line color: Color red.
	view edges: self pane withAllPresentations from: #yourself toAll: [:each | 
			(each instVarNamed: 'registry') glmSubscriptions collect: [:eachSub | eachSub subscriber]]
]

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
	| edges1 edges2 |
	
	view shape umlClassWithTitle: #name.
	view nodes: self pane withAllPanes forEach: [ :each |
		view shape label text: #name.
		view nodes: each ports.
		view verticalLineLayout gapSize: 2 ].
	
	view shape label text: [:p | (p class name removePrefix: 'GLM') removeSuffix: 'Presentation' ].
	view nodes: (self withAllPresentations reject: [:each | each isKindOf: GLMCompositePresentation]).

	view shape verticalOrthogonalLine color: Color lightGray. 	
	edges1 := view edges: self pane withAllPanes from: #yourself toAll: [:each | each presentations presentations ].

	view shape verticalOrthogonalLine color: Color lightGray. 
	edges2 := view edges: self pane withAllPanes from: #browser to: #yourself.

	view treeLayout layered userDefinedEdges: (edges1, edges2).

	view shape line color: Color blue. 
	view 
		edges: ((self withAllPresentations select: [:each | each isKindOf: GLMBrowser]) flatCollect: [:each | each transmissions])
		fromAll: #origins
		to: #destination.
		view shape line color: Color blue

]
