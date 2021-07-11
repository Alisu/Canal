Class {
	#name : #OwnedObject,
	#superclass : #Object,
	#instVars : [
		'owner'
	],
	#category : #Canal
}

{ #category : #accessing }
OwnedObject >> at: anIndex put: anObject [

	self beWritableObject.
	super at: anIndex put: anObject.
	self beReadOnlyObject.
]

{ #category : #'write barrier' }
OwnedObject >> attemptToAssign: value withIndex: index [ 

	"Called by the VM when assigning an instance variable of an immutable object.
	Upon return, executing will resume *after* the inst var assignment. If the inst var mutation has to be 
	performed, do it manually here in the call back with instVarAt:put:.
	This method has to return *no* value by jumping to the context's sender"
	owner ~= Processor activeProcess ifTrue:[^super attemptToAssign: value withIndex: index].
	self beWritableObject.
	MirrorPrimitives fixedFieldOf: self at: index put: value.
	self beReadOnlyObject.

	thisContext sender jump
	"CAN'T REACH"
]

{ #category : #initialization }
OwnedObject >> initialize [
	super initialize.
	owner:= Processor activeProcess.
	"self beReadOnlyObject."
]

{ #category : #accessing }
OwnedObject >> owner [
	^ owner
]

{ #category : #accessing }
OwnedObject >> owner: anObject [
	"For the debugger and the inspector it is easier to store activeProcess"

	| activeProcess |
	activeProcess := Processor activeProcess.
	self owner = activeProcess
		ifTrue: [ self beWritableObject.
			owner := anObject.
			self beReadOnlyObject ]
		ifFalse: [ owner := anObject ]
]
