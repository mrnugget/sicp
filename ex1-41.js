function double(f) {
  return function(x) {
    return f(f(x));
  }
}

function inc(x) {
  return x + 1;
}

var result = double(double(double))(inc)(5);
console.log(result);

// double(double(double))(func)(arg)
//
// equals this:
//
// double(double(double(double(arg))));
//
// equals these steps
//
var step1 = double(inc);
console.log(step1(0));
// equals this:
console.log(inc(inc(0)));

var step2 = double(step1);
console.log(step2(0));
// equals this:
console.log(inc(inc(inc(inc(0)))));

var step3 = double(step2);
console.log(step3(0));
// equals this:
console.log(inc(inc(inc(inc(inc(inc(inc(inc(0)))))))));

var step4 = double(step3);
console.log(step4(0));
// equals this:
console.log(inc(inc(inc(inc(inc(inc(inc(inc(inc(inc(inc(inc(inc(inc(inc(inc(0)))))))))))))))));
