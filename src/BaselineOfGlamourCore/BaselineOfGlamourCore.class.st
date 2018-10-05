Class {
	#name : #BaselineOfGlamourCore,
	#superclass : #BaselineOf,
	#category : #BaselineOfGlamourCore
}

{ #category : #baselines }
BaselineOfGlamourCore >> baseline: spec [ 
	<baseline>
	
	spec for: #'common' do: [
		spec 
			package: 'Glamour-Announcements';
			package: 'Glamour-Helpers';
			package: 'Glamour-Core' with: [
				spec requires: #('Glamour-Helpers' 'Glamour-Announcements' ). ];
			package: 'Glamour-Presentations' with: [
				spec requires: #('Glamour-Core' ). ];
			package: 'Glamour-Browsers' with: [
				spec requires: #('Glamour-Core' ). ];
			package: 'Glamour-Examples' with: [
				spec requires: #('Glamour-Core' ). ];
			package: 'Glamour-FastTable' with: [
				spec requires: #('Glamour-Examples' 'Glamour-Core' 'Glamour-Presentations' 'Glamour-Morphic-Renderer' 'Glamour-Tests-Morphic'). ];
			package: 'Glamour-Morphic-Brick' with: [
				spec requires: #('Glamour-Core' ). ];
			package: 'Glamour-Morphic-Brick-Tests' with: [
				spec requires: #('Glamour-Morphic-Brick' ). ];
			package: 'Glamour-Tests-Core';
			package: 'Glamour-Tests-Resources';
			package: 'Glamour-Morphic-Theme';
			package: 'Glamour-Morphic-Widgets' with: [
				spec requires: #('Glamour-Morphic-Brick' ). ];
			package: 'Glamour-Morphic-Renderer' with: [
				spec requires: #('Glamour-Morphic-Widgets' 'Glamour-Core' ). ];
			package: 'Glamour-Morphic-Pager' with: [
				spec requires: #('Glamour-Morphic-Renderer' 'Glamour-Morphic-Brick' ). ];
			package: 'Glamour-Tests-Morphic' with: [
				spec requires: #('Glamour-Morphic-Renderer' 'Glamour-Morphic-Brick' 'Glamour-Morphic-Pager' ). ];
			package: 'Glamour-Rubric-Presentations' with: [
				spec requires: #('Glamour-Presentations' ). ];
			package: 'Glamour-Tests-Rubric' with: [
				spec requires: #('Glamour-Tests-Morphic' 'Glamour-Rubric-Presentations' ). ];
			package: 'Glamour-SpecIntegration' with: [
				spec requires: #('Glamour-Core' 'Glamour-Examples' 'Glamour-Morphic-Renderer' 'Glamour-Rubric-Presentations'). ] ].
]
