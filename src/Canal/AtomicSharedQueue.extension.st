Extension { #name : #AtomicSharedQueue }

{ #category : #'*Canal' }
AtomicSharedQueue >> signalAll [
	"queue is empty, reset sema signals"
	availSema size timesRepeat: [ availSema signal ]
]
