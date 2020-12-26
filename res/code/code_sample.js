var args = Array.prototype.slice.call(arguments);

// or the es6 way:
var args = Array.from(arguments)

function getGrades() {
	var thisstr = "helloworld";
    var args = Array.prototype.slice.call(arguments, 1, 3);
    return args;
}

// Let's output this!
console.log(getGrades(90, 100, 75, 40, 89, 95));

// OUTPUT SHOULD BE: //
// [100, 75] <- Why? Because it started from index 1 and stopped at index 3
// so, index 3 (40) wasn't taken into consideration.
//
// If we remove the '3' parameter, leaving just (arguments, 1) we'd get
// every argument from index 1: [100, 75, 40, 89, 95].