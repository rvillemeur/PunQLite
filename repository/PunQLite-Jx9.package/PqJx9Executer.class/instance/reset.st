actions
reset
	| ret |
	ret := self ffi resetExecutionOn: self handle.
	(self isOk: ret) ifFalse: [ ^ false ].
	executed := false.
	^ true