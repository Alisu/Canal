Class {
	#name : #WrapperOwnedObject,
	#superclass : #Object,
	#instVars : [
		'object',
		'owner'
	],
	#category : #Canal
}

{ #category : #accessing }
WrapperOwnedObject >> object [
	^ object
]

{ #category : #accessing }
WrapperOwnedObject >> object: anObject [
	object := anObject
]

{ #category : #accessing }
WrapperOwnedObject >> owner [
	^ owner
]

{ #category : #accessing }
WrapperOwnedObject >> owner: anObject [
	owner := anObject
]
