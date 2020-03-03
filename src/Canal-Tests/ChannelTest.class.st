Class {
	#name : #ChannelTest,
	#superclass : #TestCase,
	#category : #'Canal-Tests'
}

{ #category : #tests }
ChannelTest >> testChannelCanIterateOnQueue [

	| aChannel anObject |
	self flag: #badTest.
	
	aChannel := Channel new.
	anObject := Object new.
	aChannel send: anObject.
	
	"isNotEmpty not understood"
	self assert: (aChannel do: [ :e | e isKindOf: Object ])
]

{ #category : #tests }
ChannelTest >> testChannelCanSendObject [
	
	| aChannel anObject |
	aChannel := Channel new.
	anObject := Object new.
	aChannel send: anObject.
	
	"isNotEmpty not understood"
	self assert: aChannel queue isEmpty not.
	self assert: aChannel queue next equals: anObject
]

{ #category : #tests }
ChannelTest >> testClosingChannelShouldSignalAllSemaphores [
	
	| aChannel anObject |
	aChannel := Channel new.
	anObject := Object new.
	aChannel send: anObject.
	
	aChannel close.
	
	self assert: aChannel queue availSema size = 0
	
]
