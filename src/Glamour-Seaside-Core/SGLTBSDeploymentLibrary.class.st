Class {
	#name : #SGLTBSDeploymentLibrary,
	#superclass : #TBSDeploymentLibrary,
	#category : #'Glamour-Seaside-Core'
}

{ #category : #accessing }
SGLTBSDeploymentLibrary >> selectorsToInclude [
	^ #(cssbootstrapminCss cssbootstrapthememinCss)
]
