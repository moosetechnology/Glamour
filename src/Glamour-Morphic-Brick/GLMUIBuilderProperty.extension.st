Extension { #name : #GLMUIBuilderProperty }

{ #category : #'*Glamour-Morphic-Brick' }
GLMUIBuilderProperty >> asBrick [

	^ GLMUIBuilderPropertyBrick new
		vShrinkWrap;
		padding: #(1 0);
		propertyModel: self
	
]
