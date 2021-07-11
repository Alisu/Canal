Class {
	#name : #OwnedPerson,
	#superclass : #OwnedObject,
	#instVars : [
		'name',
		'job',
		'friend'
	],
	#category : #Canal
}

{ #category : #accessing }
OwnedPerson >> friend [
	^ friend
]

{ #category : #accessing }
OwnedPerson >> friend: anObject [
	friend := anObject
]

{ #category : #accessing }
OwnedPerson >> job [
	^ job
]

{ #category : #accessing }
OwnedPerson >> job: aJob [
	job := aJob
]

{ #category : #accessing }
OwnedPerson >> name [
	^ name
]

{ #category : #accessing }
OwnedPerson >> name: anObject [
	name := anObject
]
