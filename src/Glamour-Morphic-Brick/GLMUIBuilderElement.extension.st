Extension { #name : #GLMUIBuilderElement }

{ #category : #'*Glamour-Morphic-Brick' }
GLMUIBuilderElement >> asBrick [

	^ GLMUIBuilderTreeElementBrick new
		vShrinkWrap;
		elementModel: self
]
