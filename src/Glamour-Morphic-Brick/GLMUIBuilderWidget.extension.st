Extension { #name : #GLMUIBuilderWidget }

{ #category : #'*Glamour-Morphic-Brick' }
GLMUIBuilderWidget >> asBrick [

	^ GLMUIBuilderTreeWidgetBrick new
		vShrinkWrap;
		widgetModel: self
]
