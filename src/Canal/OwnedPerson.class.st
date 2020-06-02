Class {
	#name : #OwnedPerson,
	#superclass : #OwnedObject,
	#instVars : [
		'name'
	],
	#category : #Canal
}

{ #category : #accessing }
OwnedPerson >> name [
	^ name
]

{ #category : #accessing }
OwnedPerson >> name: anObject [
	name := anObject
]
