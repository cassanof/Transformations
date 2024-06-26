#lang racket

;; The distance of a pair of integers a and b is defined as the absolute difference between a and b.
;; Given an integer list nums and an integer k, return the kth smallest distance among all the pairs nums[i] and nums[j] where 0 <= i < j < nums.length.
;; The distance of a pair of integers a and b is defined as the absolute difference between a and b.
;; Given an integer list nums and an integer k, return the kth smallest distance among all the pairs nums[i] and nums[j] where 0 <= i < j < nums.length.
;; Example 1:
;; Input: nums = [1,3,1], k = 1
;; Output: 0
;; Explanation: Here are all the pairs:
;; (1,3) -> 2
;; (1,1) -> 0
;; (3,1) -> 2
;; Then the 1st smallest distance pair is (1,1), and its distance is 0.
;; Example 2:
;; Input: nums = [1,1,1], k = 2
;; Output: 0
;; Example 3:
;; Input: nums = [1,6,1], k = 3
;; Output: 5
;; Constraints:
;; n == nums.length
;; 2 <= n <= 104
;; 0 <= nums[i] <= 106
;; 1 <= k <= n * (n - 1) / 2
(define (smallestDistancePair nums k)
  ;; Sort the list of numbers to make distance calculation easier
  (define sorted-nums (sort nums <))
  ;; Initialize the search boundaries for the binary search
  (define low 0)
  (define high (- (last sorted-nums) (first sorted-nums)))
  
  ;; Define a helper function to count how many pairs have distance less than or equal to mid
  (define (count-pairs-with-distance<= mid)
    (let loop ([left 0] [right 0] [count 0])
      (if (= right (length sorted-nums))
          count
          (if (> (- (list-ref sorted-nums right) (list-ref sorted-nums left)) mid)
              (loop (+ left 1) right count)
              (loop left (+ right 1) (+ count (- right left)))))))
  
  ;; Perform the binary search
  (let loop ([low low] [high high])
    (if (= low high)
        low
        (let ([mid (quotient (+ low high) 2)])
          (if (< (count-pairs-with-distance<= mid) k)
              (loop (+ mid 1) high)
              (loop low mid)))))
  )

;; Example tests
(smallestDistancePair '(1 3 1) 1) ;; => 0
(smallestDistancePair '(1 1 1) 2) ;; => 0
(smallestDistancePair '(1 6 1) 3) ;; => 5
(require rackunit)

(define (test-humaneval) 

  (let (( candidate smallestDistancePair))
    (check-within (candidate (list 3 1 3 4) 1) 0 0.001)
    (check-within (candidate (list 1 2 3 4 5 6 7) 5) 1 0.001)
    (check-within (candidate (list 1 3 1) 1) 0 0.001)
    (check-within (candidate (list 1 2 3 4 5) 4) 1 0.001)
    (check-within (candidate (list 1 2 3 4 5 6 7) 4) 1 0.001)
    (check-within (candidate (list 2 1 1) 1) 0 0.001)
    (check-within (candidate (list 1 1 1 2 2 2) 3) 0 0.001)
    (check-within (candidate (list 1) 1) 0 0.001)
    (check-within (candidate (list 1 1 1 1 2) 4) 0 0.001)
    (check-within (candidate (list 1 2 3 4 5) 6) 2 0.001)
    (check-within (candidate (list 1 100000) 1) 99999 0.001)
    (check-within (candidate (list 1 2) 1) 1 0.001)
    (check-within (candidate (list 1 2 3 4 5 6) 5) 1 0.001)
    (check-within (candidate (list 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22) 10) 1 0.001)
    (check-within (candidate (list 100 200 300 400 500 600) 15) 500 0.001)
    (check-within (candidate (list 1 2 3) 2) 1 0.001)
    (check-within (candidate (list 2 2 2 2 2) 5) 0 0.001)
    (check-within (candidate (list 1 2 3) 1) 1 0.001)
    (check-within (candidate (list 1000 1000 3 2) 1) 0 0.001)
    (check-within (candidate (list 1 1 1) 2) 0 0.001)
    (check-within (candidate (list 1 2 3 4 5) 7) 2 0.001)
    (check-within (candidate (list 1 2 3 4 5 6 7) 3) 1 0.001)
    (check-within (candidate (list 2 2 2 2 2) 10) 0 0.001)
    (check-within (candidate (list 1 2 3 4) 1) 1 0.001)
    (check-within (candidate (list 1 2 3 4 5 6 7) 6) 1 0.001)
    (check-within (candidate (list 1 2 3 4 5) 1) 1 0.001)
    (check-within (candidate (list 1 10 20 30 40 50) 1) 9 0.001)
    (check-within (candidate (list 6 3 7 4 1 2) 4) 1 0.001)
    (check-within (candidate (list 2 2 2 3 3 3 5 5) 12) 1 0.001)
    (check-within (candidate (list 1 6 1) 3) 5 0.001)
    (check-within (candidate (list 1 2 3 4 5) 2) 1 0.001)
    (check-within (candidate (list 1 2 3 4 5) 3) 1 0.001)
    (check-within (candidate (list 1 2 3 4 5) 5) 2 0.001)
    (check-within (candidate (list 100 200 300 400 500 600) 1) 100 0.001)
    (check-within (candidate (list 1 2 3 4 5 6 7 8 9 10) 1) 1 0.001)
))

(test-humaneval)