# Human-in-the-Loop Review Process

## Project Context

This human-in-the-loop review process is part of the portfolio project:

AI Trust & Safety Operations Case Study: Risk Triage, Taxonomy Design and Escalation Workflow

The project uses fully synthetic user reports to demonstrate how AI-assisted triage can support Trust & Safety operations while keeping human judgement central for high-risk, ambiguous, or sensitive cases.

No real users, platforms, accounts, companies, or incidents are used in this project.

## Purpose

The purpose of this document is to define where human judgement is required in an AI-assisted Trust & Safety triage workflow.

AI can help organise, classify, summarise, and prioritise reports. However, it should not be the final decision-maker in cases involving safety, privacy, children, fraud, account access, or serious user impact.

This process is designed to ensure that automation supports reviewers rather than replacing them.

## Human-in-the-Loop Principles

The workflow is based on the following principles:

| Principle | Meaning |
|---|---|
| Human oversight | Humans remain responsible for high-risk and sensitive decisions. |
| Automation assistance | AI can help classify, summarise, and prioritise tickets. |
| Escalation by risk | Higher-risk tickets receive faster and more specialist review. |
| Explainability | Reviewers should understand why a ticket was classified or escalated. |
| Safety first | Ambiguous cases should be treated cautiously. |
| Auditability | Decisions, overrides, and final actions should be recorded. |
| Continuous improvement | Human feedback should improve taxonomy, QA, and model performance. |

## Workflow Overview

The human-in-the-loop process has six stages:

1. Ticket intake
2. Automated pre-classification
3. Risk and confidence checks
4. Human review and escalation
5. Final action
6. QA and feedback loop

## Stage 1: Ticket Intake

At intake, the system receives a synthetic user report and records structured metadata.

Example intake fields:

| Field | Description |
|---|---|
| ticket_id | Unique ticket identifier |
| created_at | Date and time the ticket was created |
| user_report | Free-text user report |
| channel | Source channel, such as web form, app, email, or support chat |
| region | Synthetic user region |
| language | Ticket language |
| initial_status | New, pending review, escalated, or closed |

The report should not be actioned at this stage. It first needs classification and risk assessment.

## Stage 2: Automated Pre-Classification

The automated system can support triage by generating an initial prediction.

Possible automated outputs:

| Output | Purpose |
|---|---|
| predicted_risk_category | Suggested primary risk category |
| predicted_subcategory | Suggested more specific risk type |
| predicted_severity | Suggested urgency level |
| model_confidence | Confidence score for the prediction |
| suggested_escalation_team | Recommended team for routing |
| suggested_sla_target | Recommended SLA target |
| suggested_summary | Short summary of the user report |
| human_review_required | Initial flag based on severity, confidence, and risk rules |

The automated prediction is not treated as final. It is an input for review.

## Stage 3: Risk and Confidence Checks

Before deciding whether a ticket can follow a standard path, the workflow checks for high-risk signals and model uncertainty.

Human review is required when any of the following conditions are met:

| Condition | Reason |
|---|---|
| Severity is Critical | Immediate or severe safety risk requires human judgement. |
| Severity is High | Significant user harm or operational risk may be present. |
| A minor may be involved | Child safety cases require specialist review. |
| Self-harm or crisis language appears | Sensitive safety risk requires human review. |
| Fraud or scam is suspected | Financial harm and account abuse require specialist review. |
| Personal data exposure is reported | Privacy risk requires careful handling. |
| Credible threat is reported | Threats require contextual judgement. |
| Model confidence is below 0.75 | Low confidence indicates uncertainty. |
| The ticket has multiple possible risk categories | Multi-risk cases need human prioritisation. |
| The report is ambiguous | Unclear evidence should not be fully automated. |
| The user is appealing a serious decision | Appeals require fairness and context. |
| The final action could affect user access or safety | High-impact outcomes require oversight. |

## Stage 4: Human Review

When human review is required, a trained reviewer examines the ticket and confirms or changes the automated recommendation.

The reviewer should assess:

| Review Area | Reviewer Question |
|---|---|
| Category | Does the predicted category match the main risk signal? |
| Subcategory | Is the subcategory specific and accurate? |
| Severity | Is the urgency level appropriate? |
| Escalation team | Is the ticket routed to the right team? |
| SLA | Is the response target correct? |
| Evidence | Is there enough information to support the decision? |
| User impact | Could the outcome significantly affect the user? |
| Safety impact | Could delay or error increase harm? |
| Privacy impact | Does the ticket involve personal or sensitive information? |
| Final action | What is the safest and most proportionate next step? |

## Reviewer Decision Options

The human reviewer can take one of several actions.

| Reviewer Decision | Description |
|---|---|
| Confirm prediction | Reviewer agrees with the automated classification and routing. |
| Change category | Reviewer assigns a different risk category. |
| Change severity | Reviewer increases or decreases urgency. |
| Change escalation team | Reviewer routes to a different team. |
| Request more information | Ticket cannot be resolved without more detail. |
| Escalate to specialist | Ticket requires expert review. |
| Mark as no action | No policy, safety, or operational issue is identified. |
| Close with user education | User receives explanation or guidance. |
| Flag for QA | Ticket should be reviewed for quality or process learning. |

Severity downgrades should be handled carefully. Critical and High severity cases should not be downgraded without a documented human rationale.

## Stage 5: Specialist Escalation

Some tickets require specialist review beyond the first human reviewer.

| Escalation Path | Example Cases |
|---|---|
| Trust & Safety Specialist | Self-harm concern, threats, severe harassment |
| Child Safety Escalation | Any report involving possible risk to a minor |
| Fraud and Account Integrity | Scam, impersonation, suspicious payment, account takeover |
| Privacy Review | Personal data exposure, doxxing, unauthorised sharing |
| Policy Review | Misinformation, appeals, unclear moderation decisions |
| Support / Education | Low-risk policy explanation or user guidance |
| Human Review Queue | Ambiguous or low-confidence cases |

Specialist escalation should preserve the ticket history, model prediction, reviewer notes, and reason for escalation.

## Stage 6: Final Action

After review, the ticket receives a final action.

| Final Action | Description |
|---|---|
| No action | No issue found after review. |
| User education | User receives guidance or policy explanation. |
| Content review | Reported content is sent for moderation review. |
| Account security review | Suspicious login or account compromise is investigated. |
| Fraud investigation | Scam or payment risk is reviewed. |
| Privacy escalation | Personal data exposure is escalated. |
| Safety escalation | Urgent safety risk is escalated. |
| Child safety escalation | Minor-related concern is sent to specialist review. |
| Policy review | Unclear policy issue is sent to policy specialists. |
| Human review completed | Manual review confirms the outcome. |

Every final action should be documented clearly enough for QA review.

## Human Override Process

A human override occurs when the reviewer changes the automated recommendation.

Examples of overrides:

| Model Prediction | Human Decision | Reason |
|---|---|---|
| Policy confusion / Low | Privacy concern / High | Report contained personal data exposure. |
| Harassment / Medium | Threat / High | Reviewer identified credible threat language. |
| Account abuse / Medium | Fraud / High | Report included suspicious payment request. |
| Low risk / Low | Child safety concern / Critical | Reviewer identified possible minor involvement. |
| Scam or fraud / High | Policy confusion / Low | Report was actually asking about a moderation decision. |

Overrides should be recorded because they are valuable for model improvement and QA analysis.

## Override Documentation Template

Use this template when a reviewer changes an automated decision.

```text
Ticket ID:
Reviewer:
Review date:

Original model category:
Final human category:

Original model severity:
Final human severity:

Original escalation team:
Final escalation team:

Reason for override:
Evidence considered:
Final action:
QA flag required? Yes / No
```

## Confidence Thresholds

Model confidence should be used as a routing signal, not as proof that the model is correct.

| Confidence Score | Recommended Action |
|---:|---|
| 0.90 to 1.00 | Can proceed if severity is Low or Medium and no sensitive risk is detected. |
| 0.75 to 0.89 | Can proceed for low-risk cases, but review if risk signals appear. |
| 0.50 to 0.74 | Human review required. |
| Below 0.50 | Human review required and model output should be treated as unreliable. |

Important rule:

High model confidence should never bypass mandatory human review for High, Critical, child safety, self-harm, fraud, privacy exposure, or serious enforcement cases.

## Human Review Queue Prioritisation

The human review queue should be ordered by severity and SLA.

| Priority | Ticket Type | SLA |
|---:|---|---:|
| 1 | Critical safety or child safety cases | 1 hour |
| 2 | High severity fraud, privacy, threats, account compromise | 4 hours |
| 3 | Medium severity harassment, misinformation, unclear policy impact | 24 hours |
| 4 | Low-confidence but low-risk tickets | 24 to 72 hours |
| 5 | Low-risk policy questions | 72 hours |

If two tickets have the same severity, the older ticket should usually be reviewed first.

## Reviewer Notes Standards

Reviewer notes should be:

- clear
- concise
- evidence-based
- respectful
- free from unnecessary personal judgement
- specific enough for audit
- useful for future QA review

Good reviewer note example:

```text
User report describes unauthorised password change and loss of account access. Classified as Account abuse / unauthorised_login. Severity set to High because account takeover is suspected. Routed to Fraud and Account Integrity with 4-hour SLA.
```

Weak reviewer note example:

```text
Seems bad. Escalated.
```

## Human-in-the-Loop Controls

The workflow uses several controls to reduce automation risk.

| Control | Purpose |
|---|---|
| Mandatory review for High and Critical cases | Prevents high-risk automation-only decisions. |
| Low-confidence review threshold | Captures uncertain model outputs. |
| Human override logging | Tracks where humans disagree with AI. |
| Severity floor rules | Prevents risky cases being downgraded too easily. |
| Specialist escalation paths | Sends sensitive cases to trained teams. |
| QA sampling | Detects recurring decision errors. |
| SLA monitoring | Ensures urgent cases are handled quickly. |
| Reviewer notes | Supports auditability and learning. |

## Feedback Loop

Human review should improve the system over time.

Feedback should be used to update:

| Area | Example Improvement |
|---|---|
| Taxonomy | Add clearer examples for confusing categories. |
| Escalation rules | Adjust routing when cases are repeatedly misrouted. |
| Model training data | Use corrected labels to improve classification. |
| QA checklist | Add new error types or review questions. |
| Reviewer guidance | Clarify policy interpretation or severity rules. |
| Dashboard metrics | Track new quality or risk indicators. |
| SLA design | Adjust targets if operational evidence shows mismatch. |

## Continuous Improvement Cycle

Recommended cycle:

1. Collect model predictions and human decisions.
2. Identify human overrides.
3. Review false positives and false negatives.
4. Analyse SLA breaches and escalation errors.
5. Update taxonomy and decision tree.
6. Improve training data and model features.
7. Re-test classifier performance.
8. Update reviewer guidance.
9. Monitor whether error rates improve.

## Example Human-in-the-Loop Flow

```text
1. User submits report:
   "Someone is pretending to be me and asking others for money."

2. Model prediction:
   Risk category: Scam or fraud
   Subcategory: impersonation
   Severity: High
   Confidence: 0.88
   Escalation team: Fraud and Account Integrity
   Human review required: Yes

3. Human reviewer checks:
   - impersonation signal is present
   - financial harm signal is present
   - High severity is appropriate
   - Fraud and Account Integrity is correct

4. Reviewer confirms prediction.

5. Final action:
   Fraud investigation opened.
   User receives account safety guidance.
   Ticket is marked for QA sample because it is High severity.
```

## Example Override Flow

```text
1. User submits report:
   "I don't know why my post was removed, but it included my phone number and now people are contacting me."

2. Model prediction:
   Risk category: Policy confusion
   Severity: Low
   Confidence: 0.81

3. Human reviewer identifies:
   - personal data exposure
   - possible privacy risk
   - user impact beyond policy confusion

4. Human override:
   Risk category changed to Privacy concern
   Subcategory changed to personal_data_exposure
   Severity changed to High
   Escalation team changed to Privacy Review
   SLA changed to 4 hours

5. Final action:
   Privacy escalation opened.
   Ticket added to QA review because of model under-classification.
```

## Human Review Metrics

The following metrics help evaluate the effectiveness of the human-in-the-loop process.

| Metric | Definition | Why It Matters |
|---|---|---|
| Human review rate | Percentage of tickets reviewed by humans. | Shows how much automation relies on oversight. |
| Override rate | Percentage of model predictions changed by humans. | Measures model alignment with reviewer judgement. |
| Critical override rate | Percentage of serious model errors corrected by humans. | Measures safety value of human review. |
| Low-confidence review rate | Percentage of low-confidence cases reviewed. | Confirms uncertainty controls are working. |
| SLA compliance for reviewed cases | Percentage of human-reviewed tickets handled within SLA. | Measures operational responsiveness. |
| Escalation accuracy after review | Percentage routed correctly after human review. | Measures human review quality. |
| QA pass rate | Percentage of reviewed tickets passing QA. | Measures reviewer consistency. |
| Repeat error rate | Recurring error patterns found in QA. | Identifies process improvement opportunities. |

## Risks of Over-Automation

This workflow is designed to avoid the following risks:

| Risk | Example | Mitigation |
|---|---|---|
| Under-escalation | Model marks self-harm concern as Low. | Mandatory review for safety keywords and low confidence. |
| Over-escalation | Model routes simple policy questions to urgent queue. | QA sampling and reviewer correction. |
| False confidence | High confidence prediction is wrong. | Mandatory human review for sensitive categories. |
| Missing context | Model focuses on keywords but misses meaning. | Human judgement for ambiguous cases. |
| Inconsistent decisions | Reviewers interpret categories differently. | Taxonomy, QA checklist, and reviewer guidance. |
| Unclear accountability | Nobody owns the final decision. | Human reviewer records final action and rationale. |

## Ethical and Responsible AI Considerations

The human-in-the-loop process supports responsible AI by ensuring:

- AI is used as an assistant, not the final authority for high-impact decisions
- sensitive cases receive human judgement
- users are not affected only by opaque automated predictions
- model uncertainty is treated cautiously
- decisions can be reviewed and explained
- human overrides are captured and used for improvement
- safety-critical false negatives are monitored closely
- synthetic data is clearly separated from real user data

## Portfolio Relevance

This document demonstrates practical understanding of:

- human-in-the-loop AI design
- Trust & Safety operations
- AI-assisted risk triage
- escalation governance
- reviewer workflow design
- model confidence thresholds
- override handling
- quality assurance feedback loops
- responsible AI safeguards
- operational risk management

## Notes

This document is designed for portfolio and educational purposes only. It is not a real-world safety policy, legal process, or production Trust & Safety workflow. A production version would require expert policy review, legal input, privacy assessment, specialist safety expertise, and ongoing monitoring.
