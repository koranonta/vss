let startAmount = 65000
let installment = 3000
let remain = startAmount
let interest
let pct = 2
let deduction
let index = 0
while (remain > installment) {
   interest = remain * (pct / 100.0)
   deduction = installment + interest
   console.log(++index, remain, installment, interest, deduction)
   remain -= installment

}
interest = remain * (pct / 100.0)
deduction = remain + interest
console.log("--------------------------------------------")
console.log(++index, remain, remain, interest, deduction)


console.log("hello")
