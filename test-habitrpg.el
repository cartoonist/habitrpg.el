;;; test-habitrpg.el --- Tests for habitrpg.el  -*- lexical-binding: t; -*-

;; Copyright (C) 2026
;; Author: Ali Ghaffaari <ali.ghaffaari at gmail.com>

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; How to run this test ?
;; $ Emacs -batch -L . -l test-habitrpg.el -f ert-run-tests-batch-and-exit

;;; Code:

(require 'ert)
(require 'habitrpg)

(ert-deftest test-habitrpg-headers-default ()
  "Test that `habitrpg-headers' returns the correct structure by default."
  (let ((habitrpg-api-user "test-user-id")
        (habitrpg-api-token "test-token")
        (habitrpg-api-client "habitrpg"))
    (let ((headers (habitrpg-headers)))
      (should (equal (assoc-default "X-API-User" headers) "test-user-id"))
      (should (equal (assoc-default "X-API-Key" headers) "test-token"))
      (should (equal (assoc-default "X-Client" headers) "test-user-id-habitrpg")))))

(ert-deftest test-habitrpg-headers-extra ()
  "Test that extra headers are correctly prepended."
  (let ((habitrpg-api-user "test-user-id")
        (habitrpg-api-token "test-token")
        (habitrpg-api-client "habitrpg"))
    (let ((headers (habitrpg-headers '(("Accept" . "application/json")))))
      (should (equal (assoc-default "Accept" headers) "application/json"))
      (should (equal (assoc-default "X-API-User" headers) "test-user-id"))
      (should (equal (assoc-default "X-API-Key" headers) "test-token"))
      (should (equal (assoc-default "X-Client" headers) "test-user-id-habitrpg")))))

(provide 'test-habitrpg)
;;; test-habitrpg.el ends here
