Class {
	#name : #Channel,
	#superclass : #Object,
	#instVars : [
		'queue',
		'closed'
	],
	#category : #Canal
}

{ #category : #closing }
Channel >> close [
	
	closed := true.
	queue signalAll
]

{ #category : #receiving }
Channel >> do: aBlockClosure [ 
	
	[ | received |
		received := self receive.
		self isClosed ifTrue: [ ^ self ].
		aBlockClosure value: received ] repeat
]

{ #category : #initialization }
Channel >> initialize [

	super initialize.
	closed := false.
	queue := AtomicSharedQueue new.

]

{ #category : #testing }
Channel >> isClosed [

	^ closed
]

{ #category : #accessing }
Channel >> queue [
	^ queue
]

{ #category : #accessing }
Channel >> queue: anObject [
	queue := anObject
]

{ #category : #receiving }
Channel >> receive [
	
	| result |
	
	[ | keepWaiting | 
		keepWaiting := false. 
		self isClosed ifTrue: [ ^ nil ].
		result := queue nextIfNone: [ keepWaiting := true ]. 
		keepWaiting ] whileTrue: [ queue waitForNewItems ].

	^ result
]

{ #category : #sending }
Channel >> send: anObject [ 
	
	queue nextPut: anObject
]
