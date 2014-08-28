Extension { #name : #GLMBasicExamples }

{ #category : #'*glamour-roassal-presentations' }
GLMBasicExamples >> roassalWithCustomHighlight [
	<glmBrowser: 'Roassal with custom highlight' input: '1 to: 42'>
	"self new roassalWithCustomHighlight openOn: (1 to: 42)"

	| browser |
	browser := GLMTabulator new .
	browser
		with: [:tabulator | 
			tabulator column: #index; column: #visualization.
			tabulator transmit to: #index; andShow: [:a | a list ].
			tabulator transmit to: #visualization; andShowIfNone:[ :a | 
				a roassal 
					painting: [:view :collection :roassal | 
						view shape label.
						view interaction on: ROMouseLeftClick do: [:ann | (roassal pane port: #selection) value: ann element model ].
						view nodes: collection.
						view gridLayout.
						roassal on: GLMContextChanged do: [:ann |
							ann property = #selection ifTrue: [
								ann oldValue ifNotNil: [
							ROBlink unhighlight: (ann presentation view raw elementFromModel: ann oldValue).
							ROBlink highlight: (ann presentation view raw elementFromModel: ann value) 
						]]]]].
			tabulator transmit from: #index; to: #visualization port: #selection.
			tabulator transmit from: #visualization port: #selection; to: #index port: #selection.
	].
	^ browser
]

{ #category : #'*glamour-roassal-presentations' }
GLMBasicExamples >> roassalWithMenu [
	<glmBrowser: 'Roassal with menu' input: '42'>
	"self new roassalWithMenu openOn: 42"

	| browser |
	browser := GLMTabulator withStatusbar.
	browser column: #one.
	browser transmit to: #one; andShow: [ :a |
		a roassal 
			title: 'Numbers in Roassal';
			painting: [:view :number | 
				view shape label.
				view interaction 
					on: ROMouseClick do:  [ :event |  
						ROFocusView new on: event element view: view raw ].
				view nodes: (1 to: number).
				view edgesFrom: [:each | each // 5 ].
				view treeLayout.
				view addMenu: 'Zoom in' callBack: [ :stack | ROZoomInMove new on: stack firstView ].
				view addMenu: 'Zoom out' callBack: [ :stack | ROZoomOutMove new on: stack firstView ].
				  ]].
	^ browser
]
