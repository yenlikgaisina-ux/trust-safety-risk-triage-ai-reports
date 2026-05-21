# Data Dictionary

**Project:** Trust & Safety Operations — AI User Report Triage
**Version:** 1.0
**Last Updated:** 2026-05-21
**Owner:** Trust & Safety Operations / Data Engineering

---

## Overview

This document provides field-level definitions for all datasets used in the Trust & Safety AI Triage project. It covers the primary case management dataset, the reporter and reported-user profile datasets, the QA review log, and the model inference log. These definitions govern data collection, storage, analysis, and reporting across the pipeline.

Field definitions are aligned with the risk taxonomy, escalation decision tree, and QA checklist to ensure consistent interpretation across operational, analytical, and governance use cases.

---

## Dataset 1: Case Management — `ts_cases`

The primary operational dataset. Each row represents one user-submitted report that has entered the triage pipeline.

| Field Name | Data Type | Nullable | Description | Example Values |
|---|---|---|---|---|
| `case_id` | VARCHAR(20) | No | Unique identifier for the case. Format: CASE-YYYYMMDD-NNNNNN | CASE-20260521-000142 |
| `parent_case_id` | VARCHAR(20) | Yes | If this case was escalated from a lower tier, the original case ID. Null for original cases. | CASE-20260521-000141 |
| `report_submitted_at` | TIMESTAMP (UTC) | No | Timestamp when the user submitted the report to the platform | 2026-05-21 14:32:11 UTC |
| `case_created_at` | TIMESTAMP (UTC) | No | Timestamp when the case was created in the case management system (may differ from submission due to queue ingestion lag) | 2026-05-21 14:32:45 UTC |
| `case_closed_at` | TIMESTAMP (UTC) | Yes | Timestamp when the case was closed. Null if case is still open. | 2026-05-21 16:14:03 UTC |
| `sla_deadline_at` | TIMESTAMP (UTC) | No | Calculated SLA deadline based on severity tier and case_created_at | 2026-05-21 18:32:45 UTC |
| `sla_breached` | BOOLEAN | No | TRUE if case was closed after sla_deadline_at or remains open past the deadline | FALSE |
| `reporter_user_id` | VARCHAR(36) | No | Anonymized identifier of the user who submitted the report | usr_a1b2c3d4 |
| `reported_user_id` | VARCHAR(36) | No | Anonymized identifier of the user being reported | usr_e5f6g7h8 |
| `reported_content_ref` | VARCHAR(100) | No | Reference identifier for the reported content (post ID, message ID, etc.) | post_99887766 |
| `report_category_submitted` | VARCHAR(50) | No | Risk category selected by the reporter at submission time (free-form; not normalized) | Harassment |
| `ai_risk_category` | VARCHAR(50) | No | Primary risk category assigned by the AI classifier. Values align with risk_taxonomy.md | Harassment & Abuse |
| `ai_risk_subcategory` | VARCHAR(100) | No | Sub-category assigned by the AI classifier. Values align with risk_taxonomy.md | Targeted Harassment |
| `ai_severity_tier` | SMALLINT | No | Severity tier (1–4) assigned by the AI classifier | 2 |
| `ai_confidence_score` | DECIMAL(5,4) | No | Calibrated probability score (0.0000–1.0000) for the top predicted category | 0.8712 |
| `ai_alt_category_1` | VARCHAR(50) | Yes | Second most probable risk category from AI classifier | Platform Integrity |
| `ai_alt_score_1` | DECIMAL(5,4) | Yes | Confidence score for ai_alt_category_1 | 0.0931 |
| `ai_alt_category_2` | VARCHAR(50) | Yes | Third most probable risk category from AI classifier | Misinformation & Manipulation |
| `ai_alt_score_2` | DECIMAL(5,4) | Yes | Confidence score for ai_alt_category_2 | 0.0214 |
| `routing_reason_code` | VARCHAR(50) | No | Code describing why the case was routed to its assigned queue. See Appendix A for controlled vocabulary | LOW_CONFIDENCE_OVERRIDE |
| `assigned_queue` | VARCHAR(50) | No | Name of the queue to which the case was assigned | Standard Review Queue |
| `analyst_user_id` | VARCHAR(36) | Yes | Anonymized identifier of the analyst who reviewed the case. Null for auto-disposed cases. | analyst_x1y2z3 |
| `analyst_risk_category` | VARCHAR(50) | Yes | Risk category as determined by the reviewing analyst. Null if analyst accepted AI classification. | Harassment & Abuse |
| `analyst_severity_tier` | SMALLINT | Yes | Severity tier as determined by the reviewing analyst. Null if analyst accepted AI tier. | 3 |
| `analyst_override` | BOOLEAN | No | TRUE if the analyst changed the AI-assigned risk category or severity tier | TRUE |
| `analyst_override_direction` | VARCHAR(10) | Yes | Direction of the override: UPGRADE or DOWNGRADE. Null if analyst_override = FALSE | UPGRADE |
| `analyst_override_justification` | TEXT | Yes | Free-text justification provided by the analyst for the override. Required when analyst_override = TRUE | Threat contains specific target address and named weapon |
| `outcome_code` | VARCHAR(50) | No | Enforcement action applied. See Appendix B for controlled vocabulary | CONTENT_REMOVED |
| `enforcement_applied_at` | TIMESTAMP (UTC) | Yes | Timestamp when enforcement action was executed in the platform tooling | 2026-05-21 16:10:22 UTC |
| `legal_flag` | BOOLEAN | No | TRUE if the case involves potential legal or regulatory exposure requiring Legal team notification | FALSE |
| `sensitive_case` | BOOLEAN | No | TRUE if the case involves a vulnerable user (minor, self-harm indicators, domestic violence signals) | FALSE |
| `watch_list_set` | BOOLEAN | No | TRUE if the reported user was added to enhanced monitoring watch list as a result of this case | FALSE |
| `csam_flag` | BOOLEAN | No | TRUE if a CSAM/CSEM indicator was detected at any point in this case's lifecycle | FALSE |
| `repeat_offender_flag` | BOOLEAN | No | TRUE if the reported user had 3 or more prior enforcements within the preceding 90 days at time of case creation | FALSE |
| `trusted_reporter_flag` | BOOLEAN | No | TRUE if the reporter holds trusted reporter or verified organization status | FALSE |
| `model_version` | VARCHAR(20) | No | Version identifier of the AI classifier model that produced the ai_* fields for this case | v2.4.1 |
| `pipeline_version` | VARCHAR(20) | No | Version identifier of the triage pipeline that processed this case | v1.9.0 |

---

## Dataset 2: Reporter Profiles — `ts_reporter_profiles`

Aggregated metadata about users who submit reports. One row per reporter user ID.

| Field Name | Data Type | Nullable | Description | Example Values |
|---|---|---|---|---|
| `reporter_user_id` | VARCHAR(36) | No | Anonymized user identifier — primary key | usr_a1b2c3d4 |
| `account_created_at` | DATE | No | Date the reporter's account was created | 2024-03-15 |
| `trusted_reporter` | BOOLEAN | No | TRUE if the reporter has been granted trusted reporter status | FALSE |
| `verified_organization` | BOOLEAN | No | TRUE if the reporter is associated with a verified organization (NGO, law enforcement partner, etc.) | FALSE |
| `total_reports_submitted` | INTEGER | No | Total number of reports submitted by this user (all time) | 47 |
| `reports_last_90_days` | INTEGER | No | Number of reports submitted in the preceding 90 days | 12 |
| `report_action_rate` | DECIMAL(5,4) | Yes | Proportion of this reporter's reports that resulted in an enforcement action (rolling 90-day) | 0.7500 |
| `report_dismiss_rate` | DECIMAL(5,4) | Yes | Proportion of this reporter's reports that were dismissed as no-violation (rolling 90-day) | 0.2500 |
| `account_region` | VARCHAR(5) | Yes | ISO 3166-1 alpha-2 country code of the reporter's registered region (may differ from content origin) | US |

---

## Dataset 3: Reported User Profiles — `ts_reported_user_profiles`

Aggregated enforcement history for users who have been the subject of reports. One row per reported user ID.

| Field Name | Data Type | Nullable | Description | Example Values |
|---|---|---|---|---|
| `reported_user_id` | VARCHAR(36) | No | Anonymized user identifier — primary key | usr_e5f6g7h8 |
| `account_created_at` | DATE | No | Date the reported user's account was created | 2023-11-02 |
| `total_reports_received` | INTEGER | No | Total number of reports received against this user (all time) | 8 |
| `total_enforcements` | INTEGER | No | Total number of enforcement actions applied to this user (all time) | 3 |
| `enforcements_last_90_days` | INTEGER | No | Number of enforcement actions applied in the preceding 90 days | 2 |
| `current_account_status` | VARCHAR(20) | No | Current account status: ACTIVE, SUSPENDED_TEMP, SUSPENDED_PERM, TERMINATED, UNDER_REVIEW | ACTIVE |
| `watch_list` | BOOLEAN | No | TRUE if user is currently on the enhanced monitoring watch list | FALSE |
| `watch_list_added_at` | TIMESTAMP (UTC) | Yes | Timestamp when user was most recently added to the watch list. Null if watch_list = FALSE | NULL |
| `highest_tier_actioned` | SMALLINT | Yes | Highest severity tier (1–4) at which an enforcement action has been applied to this user | 2 |
| `account_region` | VARCHAR(5) | Yes | ISO 3166-1 alpha-2 country code of the reported user's registered region | GB |

---

## Dataset 4: QA Review Log — `ts_qa_reviews`

Records of QA audit activities. Each row represents one QA review applied to one case.

| Field Name | Data Type | Nullable | Description | Example Values |
|---|---|---|---|---|
| `qa_review_id` | VARCHAR(20) | No | Unique identifier for the QA review | QA-20260521-000088 |
| `case_id` | VARCHAR(20) | No | Foreign key to ts_cases.case_id | CASE-20260521-000142 |
| `qa_reviewer_id` | VARCHAR(36) | No | Anonymized identifier of the QA reviewer | qa_rev_r9s8t7 |
| `review_type` | VARCHAR(30) | No | Type of QA review: RANDOM_SAMPLE, TARGETED_AUDIT, CALIBRATION, POST_INCIDENT | RANDOM_SAMPLE |
| `review_completed_at` | TIMESTAMP (UTC) | No | Timestamp when the QA review was completed | 2026-05-22 09:14:55 UTC |
| `section_1_pass` | BOOLEAN | No | Whether the case passed all Section 1 (Intake & Classification) checks | TRUE |
| `section_2_pass` | BOOLEAN | No | Whether the case passed all Section 2 (Content Review) checks | TRUE |
| `section_3_pass` | BOOLEAN | No | Whether the case passed all Section 3 (Decision & Enforcement) checks | FALSE |
| `section_4_pass` | BOOLEAN | No | Whether the case passed all Section 4 (Documentation) checks | TRUE |
| `overall_result` | VARCHAR(20) | No | Overall QA result: PASS, MINOR_DEFECT, MAJOR_DEFECT, CRITICAL_DEFECT | MINOR_DEFECT |
| `defect_codes` | ARRAY[VARCHAR(15)] | Yes | List of defect codes identified during review. Null if overall_result = PASS | {QA-DEC-002} |
| `qa_notes` | TEXT | Yes | Free-text notes from the QA reviewer | Enforcement action was proportionate but first-offense warning was not documented as considered |
| `analyst_notified` | BOOLEAN | No | TRUE if the analyst was notified of QA findings | TRUE |

---

## Dataset 5: Model Inference Log — `ts_model_inference_log`

Immutable record of all AI model predictions. Each row represents one model inference call.

| Field Name | Data Type | Nullable | Description | Example Values |
|---|---|---|---|---|
| `inference_id` | VARCHAR(36) | No | Unique identifier for the inference call | inf_550e8400-e29b |
| `case_id` | VARCHAR(20) | No | Foreign key to ts_cases.case_id | CASE-20260521-000142 |
| `model_version` | VARCHAR(20) | No | Model version that produced this inference | v2.4.1 |
| `inference_timestamp` | TIMESTAMP (UTC) | No | Timestamp of the inference call | 2026-05-21 14:32:44 UTC |
| `input_content_hash` | VARCHAR(64) | No | SHA-256 hash of the input content used for this inference (for reproducibility; not the raw content) | a3f4b2c1d9e8f7... |
| `predicted_category` | VARCHAR(50) | No | Top predicted risk category | Harassment & Abuse |
| `predicted_subcategory` | VARCHAR(100) | No | Top predicted sub-category | Targeted Harassment |
| `predicted_tier` | SMALLINT | No | Predicted severity tier (1–4) | 2 |
| `confidence_score` | DECIMAL(5,4) | No | Confidence score for predicted_category | 0.8712 |
| `top_signals` | JSON | No | JSON array of top contributing signals in plain-language format | [{"signal": "Repeated contact pattern", "weight": 0.42}, ...] |
| `inference_latency_ms` | INTEGER | No | Time in milliseconds from input receipt to prediction output | 147 |
| `csam_prescreener_flag` | BOOLEAN | No | TRUE if the CSAM/CSEM pre-screener triggered on this input | FALSE |

---

## Appendix A: routing_reason_code Controlled Vocabulary

| Code | Description |
|---|---|
| `AI_T4_CRITICAL` | AI classifier assigned T4 severity — routed to Crisis Response Queue |
| `AI_T3_HIGH` | AI classifier assigned T3 severity with confidence >= 0.85 — routed to Priority Review Queue |
| `AI_T2_STANDARD` | AI classifier assigned T2 severity with confidence >= 0.85 — routed to Standard Review Queue |
| `AI_T1_AUTO` | AI classifier assigned T1 with confidence >= 0.90 — routed to Automated Disposition |
| `LOW_CONFIDENCE_OVERRIDE` | AI confidence < 0.85 (T2/T3) or < 0.90 (T1) — mandatory human review |
| `CSAM_IMMEDIATE` | CSAM/CSEM pre-screener triggered — routed to CSAM Specialist Queue |
| `REPEAT_OFFENDER` | Reported user has 3+ enforcements in 90 days — escalated to T3 |
| `TRUSTED_REPORTER` | Reporter holds trusted reporter or verified organization status — T1 elevated to T2 |
| `ANALYST_ESCALATION` | Human analyst manually escalated from a lower-tier queue |
| `ANALYST_DOWNGRADE` | Human analyst downgraded from a higher-tier queue with Tier Lead approval |
| `QA_SAMPLE` | Case selected for QA random sample review post-closure |
| `T1_CONFIDENCE_INSUFFICIENT` | T1 case with AI confidence < 0.90 — routed to Human Review Queue |
| `INTAKE_INCOMPLETE` | Required intake fields missing — flagged for supervisor resolution |

---

## Appendix B: outcome_code Controlled Vocabulary

| Code | Description |
|---|---|
| `CONTENT_REMOVED` | Reported content was removed from the platform |
| `ACCOUNT_WARNING` | Warning issued to the reported user's account |
| `ACCOUNT_SUSPENDED_TEMP` | Reported user's account temporarily suspended |
| `ACCOUNT_SUSPENDED_PERM` | Reported user's account permanently suspended |
| `ACCOUNT_TERMINATED` | Reported user's account terminated and deleted |
| `REPORT_DISMISSED` | No policy violation found; report dismissed |
| `LAW_ENFORCEMENT_REFERRED` | Case referred to law enforcement; content may or may not have been removed |
| `LEGAL_ESCALATED` | Case escalated to Legal/External Compliance team for action |
| `ENHANCED_MONITORING` | No immediate action; account placed on watch list for enhanced monitoring |
| `AUTO_DISPOSITION_KNOWN_SIGNAL` | T1 case auto-actioned based on prior known-bad signal match |
| `AUTO_DISPOSITION_HIGH_CONFIDENCE` | T1 case auto-closed based on AI confidence >= 0.90 |
| `PENDING_REVIEW` | Case is still open and under active review (not a final outcome) |

---

## Cross-Reference

| Document | Purpose |
|---|---|
| `docs/risk_taxonomy.md` | Defines values for ai_risk_category and ai_risk_subcategory fields |
| `docs/escalation_decision_tree.md` | Defines routing_reason_code logic |
| `docs/qa_checklist.md` | Maps to qa_review_log fields and defect codes |
| `docs/human_in_the_loop_process.md` | Defines analyst responsibilities for case documentation fields |
| `docs/responsible_ai_safeguards.md` | Defines model_version governance and model_inference_log retention |
