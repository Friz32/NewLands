class_name QCTimeSpan
extends RefCounted

var ticks := 0
var nanoseconds := 0
var microseconds := 0
var milliseconds := 0
var seconds := 0
var minutes := 0
var hours := 0
var days := 0

func _init(arr := []):
	
	if arr.size() == 1:
		ticks = arr[0]
	elif arr.size() == 3:
		hours = arr[0]
		minutes = arr[1]
		seconds = arr[2]
	elif arr.size() == 4:
		days = arr[0]
		hours = arr[1]
		minutes = arr[2]
		seconds = arr[3]
		
		if arr.size() == 5:
			milliseconds = arr[4]
		
		if arr.size() == 6:
			microseconds = arr[5]


