Class {
	#name : #JQSGLDashboardCell,
	#superclass : #JQWidget,
	#category : #'Glamour-Seaside-Core'
}

{ #category : #accessing }
JQSGLDashboardCell >> cellHeight: anInteger [

	self optionAt: 'cellHeight' put: anInteger 
]

{ #category : #accessing }
JQSGLDashboardCell >> method [ 
	^ 'sglDashboardCell'
]
