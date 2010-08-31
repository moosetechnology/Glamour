Class {
	#name : #SGLTreePresenter,
	#superclass : #SGLPresenter,
	#instVars : [
		'model',
		'htmlId',
		'nodesId'
	],
	#category : #'Glamour-Seaside-Rendering'
}

{ #category : #accessing }
SGLTreePresenter >> associateNode: aNode withId: anId [
	nodesId at: aNode ifAbsentPut: anId
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
	model := SGLTreeModel new.
	nodesId := Dictionary new.
	model glamourPresentation: aPresentation.
	
	"When the morph changes, we want to update the glamour model"
	model announcer on: GLMTreeMorphSelectionChanged do: [ :ann | 
		aPresentation announcer suspendAllWhile: [
			aPresentation selection: ann selectionValue.
			aPresentation selectionPath: ann selectionPathValue] ].
	"aPresentationModel announcer on: GLMTreeMorphStrongSelectionChanged do: [ :ann | 
		aPresentation strongSelection: ann strongSelectionValue ]."
	
	"When the glamour model changes, we want to update the morph"
	aPresentation when: GLMContextChanged do: [ :ann | 
			ann property = #selection ifTrue: [ 
				model announcer suspendAllWhile: [
					model explicitSelection: ann value.
					self updateSelectedNodes ] ] ].
	aPresentation when: GLMPresentationUpdated do: [ :ann |
		model updateRoots ].
	
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
SGLTreePresenter >> onClickActionForAppendButtonWith: html [
	^ html jQuery ajax
		script: [ :s | 
			(self model roots size > self model amountShown) 
				ifTrue: [ "Load the required elements"
					s << (  (s jQuery id: self htmlId) children: '.glm-tree-root-ct' ) 
						append: [:h |
							self renderRootNodesBeginningWith: self model amountShown+1 on: h ] ] 
				ifFalse: [  "Disable the button for loading content"
					s << ( (s jQuery id: self htmlId) children: '.glm-tree-append-button'  ) attributeAt: 'disabled' put: true ].
			s << ( (html jQuery expression: '#', self htmlId, ' > .glm-tree-root-ct' ) glamourTree update ) ] 
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
SGLTreePresenter >> onExpandToggledActionForANodeWith: html [
	^ html jQuery ajax 
		script: [:s | 
			self renderer updateScript: s ] ;
		callback: [ :nodeId |
			|aNode|
			aNode := self nodeForId: nodeId.
			aNode areChildrenRendered "Render the children and update the model"
				ifTrue: [ aNode toggleExpansion ]
				ifFalse: [
					self updateNodeContentScriptFor: aNode.
					aNode expanded: true.
					aNode markChildrenAsRendered ] ] value:  (JSStream on: '$node.attr("id")')
]

{ #category : #'jQuery-scripts' }
SGLTreePresenter >> onSelectActionForANodeWith: html [
	^ html jQuery ajax 
		script: [:s | 
			self renderer updateScript: s ] ;
		callback: [ :value |
			|nodes|
			nodes := ( value contents findTokens: $, ) collect: [:each | 
				self nodeForId: each ].
			(nodes size == 1) 
				ifTrue: [self explicitSelection: (nodes at: 1) ]
				ifFalse:  [self explicitSelection: nodes].
			self updateSelectedNodes ] value:  (JSStream on: '$anIdOrAList')
]

{ #category : #rendering }
SGLTreePresenter >> renderAppendButtonOn: html [
	html submitButton
		onClick: (self onClickActionForAppendButtonWith: html);
		disabled: false;
		class: 'glm-tree-append-button';
         	with: 'Append'
]

{ #category : #rendering }
SGLTreePresenter >> renderContentOn: html [
	(self widgetContainerWith: html)
		class: 'list-presentation';
		id: self htmlId;
		with: [
			self renderInitialRootNodesOn: html.
			(self model roots size > self model amountShown) ifTrue: [ "Add a button for loading the remaining elements"
				self renderAppendButtonOn: html ] ].
	
]

{ #category : #rendering }
SGLTreePresenter >> renderInitialRootNodesOn: html [
	|listId| 
	listId := html nextId.
	self model selection ifNotNil: [ self model selection selectedNodes do: [:each|
			self associateNode: each withId: html nextId] ].
	html unorderedList   
		class: 'glm-tree-root-ct';
		id: listId;
		script: ( html jQuery new glamourTree init; 
			isMultiple: self model glamourPresentation isMultiple;
			selectedNodes: self selectedIds; 
			onSelect: (self onSelectActionForANodeWith: html);
			onExpandToggled: (self onExpandToggledActionForANodeWith: html) );
		with: [ self renderRootNodesBeginningWith: 1 on: html ]
]

{ #category : #rendering }
SGLTreePresenter >> renderNode: aNode fromLevel: level on: html [
	|children|
	self associateNode: aNode withId: html nextId.
	children := aNode contents.
	html listItem  
		id: (self idOfNode: aNode);  
		class: 'glm-tree-node';
		class: 'glm-tree-leaf' if: children size == 0;
		class: 'glm-tree-open' if: (children size > 0 and: [aNode expanded]);
		class: 'glm-tree-closed' if: (children size > 0 and: [aNode expanded not]);
		with: [
			self renderNodeTitleFor: aNode on: html.
			(children size > 0 and: [ aNode expanded ] ) ifTrue: [ 
				self renderNodes: children asListFromLevel: level+1 on: html.
				aNode markChildrenAsRendered ] ]
]

{ #category : #rendering }
SGLTreePresenter >> renderNodeTitleFor: aNode on: html [
	html div
		class: 'glm-tree-node-el';
		with: [ 
			html span 
				class: 'glm-tree-node-title';
				with: [
					html span: aNode displayText. 
					self renderTagsOf: aNode on: html ] ]
]

{ #category : #rendering }
SGLTreePresenter >> renderNodes: nodes asListFromLevel: level on: html [
	html unorderedList 
		id: html nextId;
		script: ( html jQuery new glamourTree init; level: level );
		class: 'glm-tree-node-ct';
		with: [ nodes do: [:each | 
			self renderNode: each fromLevel: level on: html ] ]
]

{ #category : #rendering }
SGLTreePresenter >> renderRootNodesBeginningWith: startIndex on: html [
	"Render the first 'amountToShow' elements starting from the one with the index 'startIndex'"
	
	|endIndex nodes|
	nodes := self model roots.
	(startIndex == 1 and: [ self model amountShown ~= 0 ] ) 
		ifTrue: [ endIndex  := self model amountShown min: self model roots size ] 
		ifFalse: [ endIndex := startIndex+self model amountToShow-1 ].
	(startIndex to: endIndex) do: [ :each |   
			self renderNode: (nodes at: each)  fromLevel: 0 on: html ].
	(startIndex == 1 and: [self model amountShown ~= 0 ] ) 
		ifTrue: [
			 self model amountShown: (self model amountShown max: endIndex) ]  
		ifFalse: [
			self model amountShown: self model amountToShow + self model amountShown ] 
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
	^ JSStream new 
			nextPutAll:  '$.glamourTree.selectNodes'; 
			arguments: (Array with: self htmlId with: self selectedIds)
]

{ #category : #private }
SGLTreePresenter >> selectedIds [
	|ids|
	ids := OrderedCollection new.
	self model selection ifNotNil: [ self model selection selectedNodes do: [:node |
		node ifNotNil: [ 
			(self idOfNode: node)
				ifNil: [
					|path unrenderedNode|
					Transcript show: 'haba'; cr.
					path := node path.
					unrenderedNode := path detect: [:each| each areChildrenRendered not].
					(path indexOf: unrenderedNode) to: path size - 1do: [:index| (path at: index) expanded: true].
					unrenderedNode expanded: true.
					self updateNodeContentScriptFor: unrenderedNode.
					self toggleNodeClassFor: unrenderedNode.
					unrenderedNode markChildrenAsRendered ].
			ids add: (self idOfNode: node) ] ] ].
	^ ids
]

{ #category : #private }
SGLTreePresenter >> toggleNodeClassFor: aNode [
	self renderer scriptFor: self model glamourPresentation add: (
		JSStream new 
			nextPutAll:  '$.glamourTree.toggleClass'; 
			arguments: (Array with: (self idOfNode: aNode)) )
]

{ #category : #private }
SGLTreePresenter >> updateNodeContentScriptFor: aNode [
	self renderer scriptFor: self model glamourPresentation add: (
		(self renderer html jQuery id: (self idOfNode: aNode) ) append: [:aRenderer | 
			self renderNodes: aNode contents asListFromLevel: aNode path size on: aRenderer ])
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
