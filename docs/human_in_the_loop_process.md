# Human-in-the-Loop Process

**Project:** Trust & Safety Operations — AI User Report Triage
**Version:** 1.0
**Last Updated:** 2026-05-21
**Owner:** Trust & Safety Operations

---

## Overview

This document defines the structured process by which human analysts are integrated into the AI-assisted Trust & Safety triage pipeline. It specifies the conditions that trigger human review, the responsibilities of analysts at each stage, the handoff procedures between the AI system and human reviewers, and the governance mechanisms that ensure human oversight remains effective and auditable.

The Human-in-the-Loop (HITL) framework reflects the principle that AI automation augments — but does not replace — human judgment in high-stakes content moderation decisions. Human oversight is mandatory for all cases involving potential serious harm, legal risk, or low model confidence.

---

## 1. Guiding Principles

**Human accountability:** Every enforcement decision that affects a user's account or removes their content must be attributable to an identified human analyst or, for automated dispositions, must meet strict confidence and safety thresholds defined in the escalation decision tree.

**AI as a triage tool:** The AI classifier's role is to pre-screen, prioritize, and surface the most relevant signals to human analysts — not to make final enforcement determinations on cases involving identifiable harm.

**Override authority:** Human analysts retain unconditional authority to override any AI classification or recommendation. All overrides are logged and subject to QA review, but analysts will not be penalized for exercising professional judgment that is well-documented.

**Continuous feedback:** Human decisions flow back into model evaluation pipelines. Analyst overrides, QA audit findings, and calibration outcomes are used to assess model performance and identify retraining needs.

---

## 2. Human Review Triggers

Human review is triggered by any of the following conditions, as defined in the escalation decision tree:

| Trigger | Source | Required Action |
|---|---|---|
| Severity Tier T3 or T4 assigned by AI | AI Classifier | Route to Priority or Crisis queue immediately |
| AI model confidence score < 0.85 on T2 or T3 case | AI Classifier | Route to Human Review queue with LOW_CONFIDENCE_OVERRIDE flag |
| CSAM/CSEM indicator detected (any tier) | Pre-screener | Route to CSAM Specialist queue — 30-minute response requirement |
| Reported user has 3+ enforcements in 90 days | Case history lookup | Escalate to T3 regardless of AI tier; route to Priority queue |
| Trusted reporter or verified organization submitted the report | Reporter metadata | Escalate T1 reports to T2; route to Standard Review queue |
| T1 AI auto-disposition confidence score < 0.90 | AI Classifier | Route to Human Review queue with T1_CONFIDENCE_INSUFFICIENT flag |
| Analyst manual escalation from any queue | Human analyst | Route to next tier queue; requires written escalation note |
| Post-auto-disposition QA sample selection | QA system | Route to QA review; no enforcement change unless defect found |

---

## 3. Queue Structure and Analyst Responsibilities

### 3.1 CSAM Specialist Queue

**Staffed by:** Certified CSAM Specialist Analysts (dedicated, not rotational)
**SLA:** First review within 30 minutes of routing; case closure within 1 hour
**Minimum analyst level:** CSAM Specialist (requires completion of NCMEC-aligned training and trauma-informed practice certification)

Analyst responsibilities include confirming or denying CSAM/CSEM classification with reference to applicable legal definitions, applying content hash to PhotoDNA-equivalent database for known-content flagging, initiating the law enforcement referral workflow if content is confirmed, documenting all review steps in the case record with timestamps, and immediately notifying the on-call T&S Lead and Legal Counsel upon confirmation.

**Wellness protocols:** CSAM Specialists are limited to a maximum of 4 hours of active CSAM case review per shift. Mandatory wellness check-ins are conducted by the CSAM Specialist Lead after each shift. Trauma support resources are available on demand.

---

### 3.2 Crisis Response Queue (T4)

**Staffed by:** Senior Analysts and above (minimum 2 years T&S experience)
**SLA:** First review within 1 hour; case closure or escalation within 2 hours
**Minimum analyst level:** Senior Analyst

Analyst responsibilities include confirming or denying T4 classification (the T4 AI signal should be treated as credible until proven otherwise), assessing imminence and specificity of any threat, coordinating with the on-call T&S Lead for decisions involving account termination or law enforcement referral, and documenting decision rationale in real time without deferring case notes. For credible physical threat cases, analysts engage the Law Enforcement Liaison immediately regardless of the account action taken.

---

### 3.3 Priority Review Queue (T3)

**Staffed by:** Mid-level Analysts and above
**SLA:** First review within 4 hours; case closure within 8 hours
**Minimum analyst level:** Analyst II

Analyst responsibilities include reviewing full content, account history, and prior report signals, applying the relevant policy clause from the enforcement matrix, escalating to T4 or the Crisis queue if review reveals imminent harm not captured by AI, completing all case documentation before moving to the next case, and flagging for QA review if the case involves novel or ambiguous policy application.

---

### 3.4 Standard Review Queue (T2)

**Staffed by:** All qualified analysts
**SLA:** First review within 24 hours; case closure within 48 hours
**Minimum analyst level:** Analyst I

Analyst responsibilities include reviewing reported content and account context, applying the enforcement matrix to determine the appropriate action, escalating to the Priority queue if review reveals T3-level signals not detected by AI, and completing case documentation including outcome code and routing reason code.

---

### 3.5 Human Review Queue (AI Confidence Override)

**Staffed by:** All qualified analysts
**SLA:** Inherits SLA of the report's assigned tier (T1: 72h, T2: 24h, T3: 4h)
**Minimum analyst level:** Analyst I

Analyst responsibilities include reviewing the AI classification and confidence score flag, validating or overriding the AI tier assignment, noting agreement or providing written justification for any override referencing specific policy criteria, and closing the case or re-routing per the updated classification.

---

## 4. Handoff Procedures

### 4.1 AI to Human Handoff

When the AI system routes a case to a human queue, the following information is pre-populated in the case management system for the receiving analyst: report content (verbatim or reference link), AI-assigned risk category and sub-category, AI-assigned severity tier, AI model confidence score, routing reason code, reporter metadata (account age, prior report history, trusted reporter flag), reported user metadata (account age, prior enforcement history, watch list status), timestamp of report submission and queue entry, and any active flags such as CSAM signal, LOW_CONFIDENCE_OVERRIDE, or REPEAT_OFFENDER.

Analysts must not begin case review until all pre-populated fields are present. If any field is missing, the analyst must flag the case with INTAKE_INCOMPLETE and notify the queue supervisor.

---

### 4.2 Human to Human Handoff (Escalation)

When an analyst escalates a case to a higher-tier queue, the following must be completed before transfer: update the severity tier in the case management system, add a written escalation note documenting the specific signals that triggered escalation, select the appropriate escalation reason code from the controlled list, notify the receiving queue's Tier Lead via the case management system notification function, and retain the original case ID with a sub-ID suffix on the escalated case.

---

### 4.3 Human to Automated Handoff (Downgrade to T1 Auto-Disposition)

If a human analyst determines that a case was incorrectly elevated and meets T1 auto-disposition criteria, a downgrade is permitted with written justification referencing the AI confidence score and specific policy criteria. Tier Lead approval is required for any downgrade from T3 or higher. Downgraded cases are logged as ANALYST_DOWNGRADE and automatically added to the weekly QA sample.

---

## 5. Analyst Training and Certification Requirements

| Queue | Required Training | Recertification |
|---|---|---|
| All queues | Platform policy fundamentals, case management system, unconscious bias in content moderation | Annual |
| Standard Review (T2) | Enforcement matrix, T2 policy deep-dives, QA defect code review | Semi-annual |
| Priority Review (T3) | Crisis escalation protocols, threat assessment fundamentals, legal referral procedures | Semi-annual |
| Crisis Response (T4) | Advanced threat assessment, law enforcement liaison procedures, incident response communications | Quarterly |
| CSAM Specialist | NCMEC-aligned CSAM identification training, trauma-informed practice, legal reporting obligations | Quarterly + annual recertification |

New analysts may not independently review T3 or higher cases until they have completed a minimum of 90 days on lower-tier queues and passed a calibration assessment with a score of 85% or higher.

---

## 6. Oversight and Accountability

Tier Leads monitor queue health including case volume, SLA compliance, and escalation rates in real time via the operations dashboard. The QA Lead conducts weekly random-sample audits per the QA Checklist and reports defect rates to the Head of Trust & Safety. The Head of Trust & Safety receives a weekly operations summary covering SLA performance, escalation volume, AI override rates, and any critical defects.

Human analyst decisions are fed into the AI model evaluation pipeline on a weekly basis. Key signals monitored include analyst override rate per risk category, false negative rate for cases auto-closed at T1 that are subsequently re-reported at T3+, and precision and recall per taxonomy sub-category. Significant degradation in model performance triggers a formal model review.

Every case in the case management system maintains a full, immutable audit trail including all AI classifications and confidence scores, all human review actions with analyst ID and timestamp, all escalations and overrides with justification notes, and all QA review findings. Audit trails are retained for a minimum of 3 years per data retention policy.

---

## Cross-Reference

| Document | Purpose |
|---|---|
| `docs/risk_taxonomy.md` | Category and severity tier definitions used in queue routing |
| `docs/escalation_decision_tree.md` | Automated routing logic that precedes human handoff |
| `docs/qa_checklist.md` | Quality assurance criteria applied during human review |
| `docs/responsible_ai_safeguards.md` | AI model governance, confidence thresholds, and bias monitoring |
| `docs/data_dictionary.md` | Field definitions for all case management system fields referenced here |
