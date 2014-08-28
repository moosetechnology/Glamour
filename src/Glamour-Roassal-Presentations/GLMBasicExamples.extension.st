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

{ #category : #'*glamour-roassal-presentations' }
GLMBasicExamples >> updateableIndividualPresentations [
	<glmBrowser: 'Updateable individual presentations' input: '|collection|
	collection := GLMAnnouncingCollection new.
	collection add: 1; add: 2; add: 3.
	collection'>
	"
	|collection|
	collection := GLMAnnouncingCollection new.
	collection add: 1; add: 2; add: 3.
	self new updateableIndividualPresentations openOn: collection."
	
	| browser |
	browser := GLMTabulator new.
	browser column: #automatic; column: #menu.
	browser 
		act: [:b | b entity add: (b entity size + 1) ] 	
		icon: GLMUIThemeExtraIcons glamorousAdd
		entitled: 'Add an item in the collection'.
	browser 
		act: [:b | b entity removeLast ] 
		icon: GLMUIThemeExtraIcons glamorousRemove
		entitled: 'Remove last item from the collection'.
	browser 
		act: [:b | b update ] 
		icon: GLMUIThemeExtraIcons glamorousRefresh
		entitled: 'Update complete browser'.
	browser transmit to: #automatic; andShow: [ :a :x |
		a title: 'Updated automatically'.
		a stackedArrangement.
		a list title: [ 'List: ', x size printString ];
			shouldValidate: true;
			updateOn: GLMItemAdded from: #yourself;
			updateOn: GLMItemRemoved from: #yourself.
		a text title: 'Text';
			updateOn: GLMItemAdded from: #yourself;
			updateOn: GLMItemRemoved from: #yourself .
		a roassal title: 'Roassal';
			updateOn: GLMItemAdded from: #yourself;
			updateOn: GLMItemRemoved from: #yourself;
			painting: [:view | 
				view shape label.
				view nodes: x ] ].
	browser transmit to: #menu; andShow: [ :a :x |
		a title: 'Updated via menu'.
		a stackedArrangement.
		a list title: 'List';
			shouldValidate: true;
			act: [:p | p update] 
				icon: GLMUIThemeExtraIcons glamorousRefresh
				entitled: 'Update'.
		a text title: 'Text';
			act: [:p | p update] 
				icon: GLMUIThemeExtraIcons glamorousRefresh
				entitled: 'Update'.
		a roassal title: 'Roassal';
			act: [:p | p update]
				icon: GLMUIThemeExtraIcons glamorousRefresh
				entitled: 'Update';
			painting: [:view | 
				view shape label.
				view nodes: x ] ].
	^ browser
]
