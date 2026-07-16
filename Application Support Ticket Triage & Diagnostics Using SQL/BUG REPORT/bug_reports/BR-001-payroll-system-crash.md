# BR-001 – Payroll System Crashes During Bulk Salary Processing

## Summary

The Payroll System crashes when processing bulk salary payments, preventing payroll administrators from completing payroll runs.

---

## Environment

- Application: Payroll System
- Module: Salary Processing
- Reported By: Ngozi Adeyemi
- Assigned To: James Okafor

---

## Severity

Critical

## Priority

Critical

---

## Description

When attempting to process payroll for a large batch of employees, the application unexpectedly crashes before completing the operation.

---

## Steps to Reproduce

1. Log in to the Payroll System.
2. Navigate to **Bulk Salary Processing**.
3. Upload a payroll file.
4. Start payroll processing.

---

## Expected Result

Payroll should process successfully and generate employee payslips.

---

## Actual Result

The application crashes during processing and payroll is not completed.

---

## Business Impact

- Payroll processing is interrupted.
- Salary payments may be delayed.
- HR operations cannot complete scheduled payroll.

---

## Recommendation

Escalate to the development team for investigation of the bulk processing module. Review application logs for memory or processing exceptions during payroll execution.
