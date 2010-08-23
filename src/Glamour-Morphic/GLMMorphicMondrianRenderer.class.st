Class {
	#name : #GLMMorphicMondrianRenderer,
	#superclass : #GLMMorphicWidgetRenderer,
	#category : #'Glamour-Morphic'
}

{ #category : #rendering }
GLMMorphicMondrianRenderer >> render: aPresentation [
	| canvasScrollPane |
	canvasScrollPane := ScrollPane new.
	self mondrianCanvasFor: aPresentation  in: canvasScrollPane.
	canvasScrollPane
		color: Color white;
		vResizing: #spaceFill;
		hResizing: #spaceFill.
	^ canvasScrollPane
]
