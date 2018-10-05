Class {
	#name : #BaselineOfGlamour,
	#superclass : #BaselineOf,
	#category : #BaselineOfGlamour
}

{ #category : #baselines }
BaselineOfGlamour >> baseline: spec [ 
	<baseline>
	spec for: #common do: [
		spec
			baseline: 'GlamourCore' with: [ 
				spec repository: 'github://moosetechnology/Glamour:pharo6/src' ].
		spec 
			package: 'Glamour-Tools' with: [
				spec requires: #('GlamourCore')];
			package: 'Glamour-Examples-Extras' with: [
				spec requires: #('Glamour-Tools') ] ]
]
