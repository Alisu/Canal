Class {
	#name : #OwnedObject,
	#superclass : #Object,
	#instVars : [
		'owner'
	],
	#category : #Canal
}

{ #category : #'write barrier' }
OwnedObject >> attemptToAssign: value withIndex: index [ 

	"Called by the VM when assigning an instance variable of an immutable object.
	Upon return, executing will resume *after* the inst var assignment. If the inst var mutation has to be 
	performed, do it manually here in the call back with instVarAt:put:.
	This method has to return *no* value by jumping to the context's sender"
	owner ~= Processor activeProcess ifTrue:[^super attemptToAssign: value withIndex: index].
	self beWritableObject.
	self instVarAt: index put: value.
	self beReadOnlyObject.

	thisContext sender jump
	"CAN'T REACH"
]

{ #category : #initialization }
OwnedObject >> initialize [
	super initialize.
	owner:= Processor activeProcess.
	self beReadOnlyObject.
]

{ #category : #accessing }
OwnedObject >> owner [
	^ owner
]

{ #category : #accessing }
OwnedObject >> owner: anObject [
	owner := anObject
]
