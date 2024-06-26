#lang racket

;; Given two integers n and k, return the kth lexicographically smallest integer in the range [1, n].
;; Example 1:
;; Input: n = 13, k = 2
;; Output: 10
;; Explanation: The lexicographical order is [1, 10, 11, 12, 13, 2, 3, 4, 5, 6, 7, 8, 9], so the second smallest number is 10.
;; Example 2:
;; Input: n = 1, k = 1
;; Output: 1
;; Constraints:
;; 1 <= k <= n <= 109
(define (find_kth_number n k)
  ;; First, create a list of numbers from 1 to n
  (let ([nums (range 1 (add1 n))])
    ;; Next, convert each number to its string representation
    ;; and sort the list lexicographically
    (let ([sorted-nums (sort (map number->string nums) string<?)])
      ;; Finally, retrieve the k-th smallest number by its index
      ;; and convert it back to an integer before returning it
      (string->number (list-ref sorted-nums (sub1 k))))))

;; The function starts by generating a list of numbers from 1 to n.
;; It then maps each number to its string representation to prepare
;; for lexicographic sorting. Using `sort` with `string<?` sorts the numbers
;; as if they were strings, which achieves the lexicographic ordering required.
;; Finally, it finds the k-th element in this sorted list (accounting for 0-based indexing),
;; converts this string back to a number, and returns it.
(require rackunit)

(define (test-humaneval) 

  (let (( candidate find_kth_number))
    (check-within (candidate 9999 9999) 9999 0.001)
    (check-within (candidate 2 1) 1 0.001)
    (check-within (candidate 100 10) 17 0.001)
    (check-within (candidate 10000 1) 1 0.001)
    (check-within (candidate 13 1) 1 0.001)
    (check-within (candidate 1 1) 1 0.001)
    (check-within (candidate 2 2) 2 0.001)
    (check-within (candidate 13 2) 10 0.001)
    (check-within (candidate 1000 1) 1 0.001)
    (check-within (candidate 100 2) 10 0.001)
    (check-within (candidate 100 1) 1 0.001)
    (check-within (candidate 15 1) 1 0.001)
    (check-within (candidate 100000 1) 1 0.001)
))

(test-humaneval)