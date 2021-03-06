Class {
	#name : #SGLTreePresenter,
	#superclass : #SGLPresenter,
	#instVars : [
		'model',
		'htmlId',
		'nodesId',
		'contextMenuId'
	],
	#category : #'Glamour-Seaside-Rendering'
}

{ #category : #rendering }
SGLTreePresenter >> actOnContextChanged: anAnnouncement [
	anAnnouncement property = #selection ifTrue: [ 
		model announcer suspendAllWhile: [
			model explicitSelection: anAnnouncement value.
			self updateSelectedNodes.
			 ] ]
]

{ #category : #rendering }
SGLTreePresenter >> actOnUpdatedPresentation: anAnnouncement [
	model updateRoots
]

{ #category : #accessing }
SGLTreePresenter >> associateNode: aNode withId: anId [
	nodesId at: aNode ifAbsentPut: anId
]

{ #category : #accessing }
SGLTreePresenter >> contextMenuId [

	^ contextMenuId 
]

{ #category : #accessing }
SGLTreePresenter >> contextMenuId: anId [
	contextMenuId := anId
]

{ #category : #selection }
SGLTreePresenter >> explicitSelection: aNodeOrCollection [
	self model glamourPresentation isMultiple 
		ifTrue: [ 
			|nodesPaths|
			nodesPaths := OrderedCollection new.
			aNodeOrCollection isCollection 
				ifTrue: [ aNodeOrCollection do: [:each | nodesPaths add: each path ] ] 
				ifFalse: [nodesPaths add: aNodeOrCollection path]. 
			self model selectAllNodePaths: nodesPaths ]
		ifFalse: [ self model selectNodePath: aNodeOrCollection path]
]

{ #category : #rendering }
SGLTreePresenter >> fullTextCssScriptForNode: aNode With: html [
	^ html jQuery this css: aNode displayText cssDictionaryForFullText
]

{ #category : #accessing }
SGLTreePresenter >> htmlId [
	^ htmlId
]

{ #category : #accessing }
SGLTreePresenter >> htmlId: anObject [
	htmlId := anObject
]

{ #category : #accessing }
SGLTreePresenter >> idOfNode: aNode [
	^ nodesId at: aNode ifAbsent: [nil]
]

{ #category : #initialization }
SGLTreePresenter >> initializeFor: aPresentation [
	model := SGLTreeModel for: aPresentation.
	nodesId := Dictionary new.
	
	"When the glamour model changes, we want to update the morph"
	aPresentation when: GLMContextChanged send: #actOnContextChanged: to: self.
	aPresentation when: GLMPresentationUpdated send: #actOnUpdatedPresentation: to: self.
]

{ #category : #initialization }
SGLTreePresenter >> initializeModelSelection: html [
	self model updateModelSelection.
	self model selection ifNotNil: [ self model selection selectedNodes do: [:each|
			each shouldBeDisplayed ifTrue: [
				"Add an id so selectedIds can compute the selected ids before the tree is rendered."
				self associateNode: each withId: html nextId.
				"Make sure the selected nodes are rendered."
				each expandParentPath ] ] ].
]

{ #category : #'jQuery-scripts' }
SGLTreePresenter >> menuScriptWith: html [
	^ html jQuery new buildContextualMenu 
			menuWidth: 110;
			hasImages: false;
			closeOnMouseOut: true
]

{ #category : #accessing }
SGLTreePresenter >> model [
	^ model
]

{ #category : #accessing }
SGLTreePresenter >> nodeForId: anId [
	|value|
	value := nodesId keyAtValue: anId.
	^ value
]

{ #category : #'jQuery-scripts' }
SGLTreePresenter >> onAppendRootsURLWith: html [
	^ html jQuery ajax 
		sglTreeCallbackAppendRootsURL:  [ :value :script |
			| endIndex stepSize |
			stepSize := ( (value at: 'stepSize') < 0 ifTrue: [0] ifFalse: [value at: 'stepSize'] ).
			endIndex := stepSize isZero ifTrue: [self model allRoots size]  ifFalse:   [ self model amountToFilterBy + stepSize ].
			self renderer scriptFor: self model glamourPresentation add: (
				(self renderer html jQuery expression:  ('#',self htmlId, ' > ul') ) 
					glamourTree appendRoots: [:aRenderer|
						self 
							renderRootNodesFrom: self model amountToFilterBy + 1 
							to:  ( endIndex  min: self model allRoots size  )
							on: aRenderer ] ).	
			stepSize isZero ifFalse: [self model stepSize: stepSize].
			self model amountToFilterBy: (stepSize isZero ifTrue: [0] ifFalse: [endIndex]).
			self model updateModelSelection.
			self updateSelectedNodes.
			self renderer updateScript: script ]
]

{ #category : #'jQuery-scripts' }
SGLTreePresenter >> onAppendURLWith: html [
	^ html jQuery ajax 
		sglTreeCallbackAppendURL:  [ :value :aRenderer |
			|aNode|
			aNode := self nodeForId: (value at: 'id').
			aNode markChildrenAsRendered.
			self renderNodes: aNode contents asListFromLevel: aNode path size on: aRenderer ] 
]

{ #category : #'jQuery-scripts' }
SGLTreePresenter >> onClickActionForTag: aTag of: aNode with: html [
	^ html jQuery ajax script: [:s | 
		aNode containerTree toggleFilteringByTag: aTag.
		s << ( html jQuery id: (self renderer uuidFor: aNode containerTree glamourPresentation ) )
			replaceWith: [ :aRenderer |
				self model markAllNodesAsNotRenderer.
				nodesId := Dictionary new.
				aRenderer render: self ] ] 
]

{ #category : #'jQuery-scripts' }
SGLTreePresenter >> onDoubleClickActionOn: aNode with: html [

	^ html jQuery ajax script: [:s | 
		self model glamourPresentation strongSelection: aNode item.
		self renderer updateScript: s
			] 
]

{ #category : #'jQuery-scripts' }
SGLTreePresenter >> onExpandToggledActionForANodeWith: html [
	^ html jQuery ajax 
		sglTreeCallbackToggleExpand: [ :event :script |
			|aNode|
			aNode := self nodeForId: (event at: 'node').
			aNode toggleExpansion.
			self renderer updateScript: script ]
]

{ #category : #'jQuery-scripts' }
SGLTreePresenter >> onSelectActionURLForANodeWith: html [
	^ html jQuery ajax 
		sglTreeCallbackSelectURL:  [ :value :script |
			|nodes|
			nodes := ( (value at: 'selectedIds') contents findTokens: $, ) collect: [:each | 
				(self nodeForId: each) item].
			(self model glamourPresentation isMultiple not) 
				ifTrue: [self model explicitSelection: (nodes at: 1) ]
				ifFalse:  [self model explicitSelection: nodes].
			"(nodes size == 1) 
				ifTrue: [self explicitSelection: (nodes at: 1) ]
				ifFalse:  [self explicitSelection: nodes]."
			self updateSelectedNodes.
			self renderer updateScript: script ]
]

{ #category : #'jQuery-scripts' }
SGLTreePresenter >> onSelectListItemActionFor: aNode with: html [

	^ html jQuery ajax script: [:s | 
"		self halt."
		(self selectedIds includes: (self idOfNode: aNode)) 
			ifTrue: [
				html jQuery this attributeAt: 'cMenu' put: self contextMenuId
				].
		self renderer updateScript: s
			] 
]

{ #category : #rendering }
SGLTreePresenter >> renderContentOn: html [

	|tmpContextMenuId|

	self contextMenuId:  html nextId.
	self initializeModelSelection: html.
	(self widgetContainerWith: html)
		class: 'sgl-tree-presentation';
		id: self htmlId;
		with: [
			self renderInitialRootNodesOn: html 
			].
	"(SGLSelectionActionPresenter  for: self model glamourPresentation from: self renderer)  menuId: self contextMenuId ; renderContentOn: html."

]

{ #category : #rendering }
SGLTreePresenter >> renderInitialRootNodesOn: html [
	|amountToFilterBy| 
	amountToFilterBy := self model amountToFilterBy.

	html unorderedList  
		id: html nextId;
		script: (self treeInitializationScriptWith: html);
		with: [ self renderRootNodesFrom: 1 to: ( amountToFilterBy isZero ifTrue: [self model roots size] ifFalse: [amountToFilterBy] ) on: html ]
				
]

{ #category : #rendering }
SGLTreePresenter >> renderNode: aNode fromLevel: level  on: html [
	|children|
	self associateNode: aNode withId: html nextId.
	children := aNode contents.
	
			html listItem  
			onDoubleClick: (self onDoubleClickActionOn: aNode with: html);
			id: (self idOfNode: aNode);
			"class: 'sgl-tree-node';"
			"class: 'sgl-tree-node-leaf' if: children size == 0;"
			"class: 'sgl-tree-node-opened' if: (children size > 0 and: [aNode expanded]);"
			class: 'sgl-tree-node-closed' if: (children size > 0 and: [aNode expanded not]);
			with: 
				[
				self renderNodeTitleFor: aNode on: html.
				(children size > 0 and: [ aNode expanded ] ) ifTrue: [ 
					self renderNodes: children asListFromLevel: level+1 on: html.
					aNode markChildrenAsRendered ].
				 ] 
]

{ #category : #rendering }
SGLTreePresenter >> renderNodeTitleFor: aNode on: html [
	|tmpDiv|
	tmpDiv := html div.
	tmpDiv
		script: (self fullTextCssScriptForNode: aNode With: html)";
		script: (self menuScriptWith: html)".
		
	self model glamourPresentation allSelectionActions ifNotEmpty: [
		"tmpDiv contextMenu: self contextMenuId."
		].
	
	tmpDiv	
		with: [ 
			html span
				
				with: [ 
					(html span)
						script: (self textBackgroundColorScriptFor: aNode with: html);
						with: [ 
							1 to: aNode displayText size do: [ :tmpIndex | 
								(html span)
									script: (html jQuery this css: (aNode displayText cssDictionaryAt: tmpIndex));
									with: (aNode displayText at: tmpIndex) asString ] 
								].
					self renderTagsOf: aNode on: html
					] 
				].
			
	(SGLSelectionActionPresenter  for: self model glamourPresentation from: self renderer)  menuId: self contextMenuId ; renderContentOn: html.
]

{ #category : #rendering }
SGLTreePresenter >> renderNodes: nodes asListFromLevel: level on: html [
	html unorderedList 
		id: html nextId;
		with: [ nodes do: [:each | 
			self renderNode: each fromLevel: level on: html ] ]
]

{ #category : #rendering }
SGLTreePresenter >> renderRootNodesFrom: startIndex to: endIndex on: html [
	|nodes|
	nodes := self model allRoots.
	nodes ifEmpty: [ ^ self ].
	(startIndex > 0 and: [endIndex > 0 and: [startIndex <= endIndex] ]) ifTrue: [
		( (startIndex min: self model allRoots size) to: (endIndex min: self model allRoots size) ) do: [ :each |   
			self renderNode: (nodes at: each)  fromLevel: 0 on: html ] ]
]

{ #category : #rendering }
SGLTreePresenter >> renderTag: aTag withFilter: aFilter for: aNode on: html [
	html div
		class: 'glm-tree-tag ui-corner-top ui-corner-bottom';
		class: 'glm-tree-tag-selected' if: ( aNode containerTree tagsToFilterBy includes: aTag );
		onClick: (self onClickActionForTag: aTag of: aNode with: html);
		onClick: JQEvent new stopPropagation, JQEvent new preventDefault;
		with: aTag asString 
]

{ #category : #rendering }
SGLTreePresenter >> renderTagsOf: aNode on: html [
	| tags tagsFilter |
	tags:= aNode containerTree glamourPresentation tagsFor: aNode item to: #show.
	tagsFilter := aNode containerTree glamourPresentation tagsFor: aNode item to: #filter.
	html div
		class: 'glm-tree-tags';
		with: [
			tags withIndexDo:[ :each :index | 
				self renderTag: each withFilter: (tagsFilter at: index ifAbsentPut:[ each ] ) for: aNode on: html ] ]
]

{ #category : #private }
SGLTreePresenter >> selectNodesScript [
	^ (self renderer html jQuery expression:  ('#',self htmlId, ' > ul') ) 
		glamourTree 
			option: 'selectedNodes' put: self selectedIds;
			yourself 

	
]

{ #category : #private }
SGLTreePresenter >> selectedIds [
	|ids|
	ids := OrderedCollection new.
	self model selection ifNotNil: [ self model selection selectedNodes do: [:node |
		(node isNil not and: [node shouldBeDisplayed]) ifTrue: [ 
			(self idOfNode: node)
				ifNil: [
					|path unrenderedNode|
					path := node path.
					unrenderedNode := path detect: [:each| each areChildrenRendered not].
					(path indexOf: unrenderedNode)
						to: path size - 1
						do: [ :i |
							(path at: i)
								expanded: true].
					unrenderedNode expanded: true.
					self updateNodeContentScriptFor: unrenderedNode.
					self toggleNodeClassFor: unrenderedNode.
					unrenderedNode markChildrenAsRendered ].
			ids add: (self idOfNode: node) ] ] ].
	^ ids
]

{ #category : #rendering }
SGLTreePresenter >> textBackgroundColorScriptFor: aNode with: html [
	^ html jQuery this
		css:
			((Dictionary new)
				at: 'background-color' put: (self model glamourPresentation textBackgroundColorFor: aNode item) glmAsHtmlColor;
				yourself)
]

{ #category : #private }
SGLTreePresenter >> toggleNodeClassFor: aNode [
	self renderer scriptFor: self model glamourPresentation add: (
		(self renderer html jQuery expression:  ('#',self htmlId, ' > ul') ) 
			glamourTree  toggleExpand: (self idOfNode: aNode) andTriggerEventIf: false)
]

{ #category : #'jQuery-scripts' }
SGLTreePresenter >> treeInitializationScriptWith: html [
	|tree|
	tree := html jQuery new glamourTree
		isMultiple: self model glamourPresentation isMultiple;
		selectedNodes: self selectedIds; 
		selectURL: (self onSelectActionURLForANodeWith: html);
		appendURL: (self onAppendURLWith: html);		
		onToggleExpand: (self onExpandToggledActionForANodeWith: html).
	tree useAppend
		stepSize:  (self model stepSize);
		maximumSize: self model allRoots size;
		appendRootsURL: (self onAppendRootsURLWith: html).
	^ tree
]

{ #category : #private }
SGLTreePresenter >> updateNodeContentScriptFor: aNode [
	self renderer scriptFor: self model glamourPresentation add: (
		(self renderer html jQuery expression:  ('#',self htmlId, ' > ul') ) 
			glamourTree 
				appendSubtree: [:aRenderer | 
					self renderNodes: aNode contents asListFromLevel: aNode path size on: aRenderer] 
				to: ( (self idOfNode: aNode) ) )
]

{ #category : #callbacks }
SGLTreePresenter >> updateSelectedNodes [
	self renderer 
		scriptFor: self model glamourPresentation 
		add: self selectNodesScript
]

{ #category : #callbacks }
SGLTreePresenter >> updateSelectionWithNode: aNode on: aScript [
	self explicitSelection: aNode.
	self updateSelectedNodes.
	self renderer updateScript: aScript
]
