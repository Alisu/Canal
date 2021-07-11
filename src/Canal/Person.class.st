Class {
	#name : #Person,
	#superclass : #Object,
	#instVars : [
		'name',
		'job',
		'friend'
	],
	#category : #Canal
}

{ #category : #accessing }
Person >> name: aString [ 
	name := aString
]
