# Quality Assurance Checklist

## Project Context

This quality assurance checklist is part of the portfolio project:

AI Trust & Safety Operations Case Study: Risk Triage, Taxonomy Design and Escalation Workflow

The project uses fully synthetic user reports to demonstrate how Trust & Safety teams can review triage decisions, monitor quality, reduce classification errors, and improve operational consistency.

No real users, platforms, accounts, companies, or incidents are used in this project.

## Purpose

The purpose of this checklist is to define how triage decisions should be reviewed for quality, accuracy, consistency, fairness, and operational safety.

A Trust & Safety triage workflow should not only classify reports quickly. It should also ensure that:

- high-risk cases are not missed
- urgent reports are escalated on time
- categories and severity levels are applied consistently
- automation does not override human judgement in sensitive cases
- reviewers can explain why a decision was made
- quality issues are tracked and used to improve the process

This checklist can be used by reviewers, QA analysts, team leads, policy specialists, and operations managers.

## QA Review Goals

The QA process should answer five main questions:

1. Was the ticket classified correctly?
2. Was the severity level appropriate?
3. Was the escalation path correct?
4. Was the final action reasonable and explainable?
5. Was the case handled safely and within SLA?

## QA Sampling Strategy

Not every ticket needs full manual QA review. The review sample should prioritise higher-risk and higher-impact cases.

| Ticket Type | Recommended QA Rate | Reason |
|---|---:|---|
| Critical severity tickets | 100% | Highest safety risk |
| High severity tickets | 50% to 100% | Significant user harm or operational risk |
| Medium severity tickets | 10% to 25% | Useful for trend monitoring and consistency checks |
| Low severity tickets | 5% to 10% | Lower risk but useful for detecting systematic errors |
| Low-confidence model predictions | 100% | Automation uncertainty requires review |
| Human override cases | 100% | Important for model and process improvement |
| Appeals or disputed decisions | 100% | Higher fairness and user impact |
| New or changed policy areas | 25% to 50% | Monitor adoption and interpretation |

## Ticket-Level QA Checklist

Use this checklist for each reviewed ticket.

| QA Question | Pass Criteria | Pass / Fail / Notes |
|---|---|---|
| Was the user report read in full? | Reviewer considered the full report, not only keywords. |  |
| Was the primary risk category correct? | Category matches the main risk signal in the report. |  |
| Was the subcategory correct? | Subcategory is specific and consistent with taxonomy definitions. |  |
| Was the highest-risk signal identified? | The most serious risk in the ticket was not missed. |  |
| Was the severity level correct? | Severity matches the risk level and escalation rules. |  |
| Was the SLA target correct? | SLA aligns with assigned severity. |  |
| Was the escalation team correct? | Ticket was routed to the appropriate specialist or support team. |  |
| Was human review correctly required or not required? | Human review flag matches the rules. |  |
| Was the final action appropriate? | Action taken was proportionate to the risk and evidence. |  |
| Was the decision explainable? | A reviewer could justify the decision clearly. |  |
| Was the ticket handled within SLA? | Response or escalation occurred within target time. |  |
| Was automation used safely? | Automated outputs did not replace required human judgement. |  |
| Were sensitive categories handled carefully? | Child safety, self-harm, privacy, and fraud cases received appropriate review. |  |
| Was there evidence of over-escalation or under-escalation? | Severity and routing were proportionate. |  |
| Was the outcome documented clearly? | Ticket record contains enough information for audit and learning. |  |

## Category Accuracy Checklist

Use this section to verify whether the correct risk category was selected.

| Risk Category | QA Check |
|---|---|
| Account abuse | Does the report clearly involve unauthorised access, suspicious login activity, or account misuse? |
| Scam or fraud | Does the report involve deception, impersonation, payment manipulation, phishing, or financial harm? |
| Harassment | Does the report involve targeted abuse, threats, intimidation, or repeated unwanted contact? |
| Self-harm concern | Does the report suggest emotional crisis, possible self-harm, or concern for another user's safety? |
| Misinformation | Does the report involve false or misleading claims with potential harm? |
| Privacy concern | Does the report involve personal data exposure, doxxing, deletion requests, or unauthorised sharing? |
| Billing safety escalation | Is the billing issue connected to suspicious activity, coercion, fraud, or account compromise? |
| Policy confusion | Is the user primarily asking for explanation, appeal, or clarification of a moderation decision? |
| Child safety concern | Does the report involve a minor or possible risk to someone under 18? |
| Platform integrity | Does the report involve spam, fake accounts, bots, coordinated activity, or manipulation? |

## Severity Accuracy Checklist

Severity should be reviewed carefully because it determines urgency, SLA, and escalation.

| Severity | QA Check |
|---|---|
| Critical | Was there immediate or severe safety risk, child safety concern, or crisis signal? |
| High | Was there clear harm potential, fraud, privacy exposure, account compromise, or serious abuse? |
| Medium | Was there plausible risk, unclear evidence, repeated behaviour, or policy impact requiring review? |
| Low | Was the case informational, low risk, or mainly a standard support/policy education issue? |

## Severity Error Examples

| Error Type | Example | Why It Matters |
|---|---|---|
| Under-classification | A child safety concern marked as Medium instead of Critical. | May delay urgent intervention. |
| Under-classification | Account takeover marked as Low support issue. | May allow further user harm. |
| Over-classification | Simple policy question marked as High. | Creates unnecessary workload for specialists. |
| Over-classification | Mild confusion routed to urgent Trust & Safety review. | Reduces capacity for genuinely high-risk cases. |
| Wrong severity floor | Ambiguous self-harm language treated as Low. | Fails to protect uncertain but serious cases. |

## Escalation Accuracy Checklist

| Escalation Team | Correct Routing Examples |
|---|---|
| Trust & Safety Review | Harassment, threats, self-harm concern, general safety abuse |
| Child Safety Escalation | Any ticket involving possible risk to a minor |
| Fraud and Account Integrity | Scams, impersonation, account takeover, suspicious payments |
| Privacy Review | Personal data exposure, doxxing, unauthorised sharing |
| Policy Review | Misinformation, appeals, unclear moderation decisions |
| Support / Education | Low-risk policy confusion or standard support guidance |
| Human Review Queue | Ambiguous, multi-risk, or low-confidence tickets |

## Human Review Checklist

Human review is required when any of the following are true:

| Condition | Human Review Required? |
|---|---|
| Severity is Critical | Yes |
| Severity is High | Yes |
| Minor may be involved | Yes |
| Self-harm or crisis language appears | Yes |
| Credible threat is reported | Yes |
| Financial fraud is suspected | Yes |
| Personal data exposure is reported | Yes |
| Model confidence is below 0.75 | Yes |
| Category is ambiguous | Yes |
| Multiple risk categories are present | Yes |
| User is appealing a serious enforcement decision | Yes |
| Case could significantly affect user access, safety, or rights | Yes |

## Model-Assisted QA Checks

If a machine learning classifier or AI assistant is used, QA should check:

| QA Question | Pass Criteria |
|---|---|
| Was model confidence recorded? | Each model-assisted decision includes a confidence score. |
| Was low confidence routed to human review? | Any prediction below threshold is reviewed manually. |
| Was the model output explainable? | Reviewer can identify why the model suggested the category. |
| Did automation miss any high-risk signal? | Safety-critical keywords or context were not ignored. |
| Did automation over-prioritise keywords? | The model did not classify only by keywords without context. |
| Was the final decision made by a human where required? | High, Critical, ambiguous, and sensitive cases were not fully automated. |
| Were human overrides recorded? | Disagreements are stored for analysis and future improvement. |

## SLA QA Checklist

| Severity | SLA Target | QA Check |
|---|---:|---|
| Critical | 1 hour | Was the case escalated immediately? |
| High | 4 hours | Was the case reviewed by a specialist within target? |
| Medium | 24 hours | Was the case reviewed within one working day? |
| Low | 72 hours | Was the case handled within standard support timing? |

## SLA Failure Categories

If SLA was missed, record the reason.

| SLA Failure Reason | Description |
|---|---|
| Misclassified severity | Ticket was assigned too low a severity. |
| Routing delay | Ticket went to the wrong queue or team. |
| Reviewer capacity issue | Correctly routed but not reviewed in time. |
| Tooling issue | Workflow, dashboard, or notification failed. |
| Ambiguous policy | Reviewer waited for clarification. |
| Missing information | Ticket lacked enough detail to act quickly. |
| Process gap | No clear owner or escalation path existed. |

## Final Action QA Checklist

| Final Action | QA Check |
|---|---|
| No action | Was there genuinely no safety or policy issue? |
| User education | Was the response clear, helpful, and appropriate? |
| Content review | Was content routed for review where needed? |
| Account security review | Was suspicious account activity handled correctly? |
| Fraud investigation | Were scam or payment signals escalated appropriately? |
| Privacy escalation | Was personal data exposure handled with urgency? |
| Safety escalation | Was urgent harm risk escalated immediately? |
| Child safety escalation | Was any minor-related concern escalated to the correct specialist path? |
| Policy review | Was unclear policy interpretation sent to the right team? |
| Human review required | Was manual judgement used before final action? |

## Reviewer Notes Template

Use this template when documenting QA findings.

```text
Ticket ID:
QA reviewer:
Review date:

Original category:
QA category:

Original severity:
QA severity:

Original escalation team:
QA escalation team:

Was human review required? Yes / No

Was SLA met? Yes / No

Decision quality: Pass / Partial pass / Fail

Main issue identified:
Category error / Severity error / Routing error / SLA error / Documentation error / Automation issue / Other

Reviewer notes:

Recommended improvement:
```

## QA Scoring Rubric

Each reviewed ticket can be scored using a simple 0 to 3 scale.

| Score | Meaning | Description |
|---|---|---|
| 3 | Excellent | Correct category, severity, routing, SLA, and documentation. |
| 2 | Acceptable | Minor issue, but no meaningful safety or user impact. |
| 1 | Needs improvement | One significant error in category, severity, routing, or documentation. |
| 0 | Unsafe or incorrect | Serious error that could cause harm, delay, or unfair outcome. |

## QA Outcome Categories

| Outcome | Meaning |
|---|---|
| Pass | Decision was correct and well documented. |
| Partial pass | Mostly correct, with minor improvement needed. |
| Fail | Incorrect decision or missing required process step. |
| Critical fail | Serious error affecting safety, privacy, fairness, or urgent escalation. |

## Common QA Findings

| Finding | Example | Recommended Fix |
|---|---|---|
| Category too broad | Privacy case labelled as policy confusion. | Improve taxonomy examples and reviewer training. |
| Severity too low | Fraud report marked as Medium instead of High. | Add rule-based severity floor. |
| Wrong team assignment | Doxxing concern sent to general support. | Improve escalation mapping. |
| Missing human review | Critical case handled automatically. | Add mandatory human review rule. |
| SLA mismatch | High severity case assigned 24-hour SLA. | Automate SLA mapping by severity. |
| Poor documentation | Final action recorded without reasoning. | Add required reviewer notes field. |
| Model overconfidence | Classifier predicts Low with high confidence despite risk terms. | Add safety keyword checks and override rules. |

## QA Metrics

The following metrics can be tracked in the project dashboard.

| Metric | Definition | Why It Matters |
|---|---|---|
| Category accuracy rate | Percentage of tickets with correct risk category. | Measures taxonomy and classifier performance. |
| Severity accuracy rate | Percentage of tickets with correct severity. | Measures safety-critical triage quality. |
| Escalation accuracy rate | Percentage routed to the correct team. | Measures workflow effectiveness. |
| SLA compliance rate | Percentage handled within SLA. | Measures operational responsiveness. |
| Human review override rate | Percentage where human reviewers changed model output. | Measures automation reliability. |
| Critical fail rate | Percentage of tickets with serious safety errors. | Measures highest-risk quality failures. |
| Average QA score | Mean score across reviewed tickets. | Gives overall quality trend. |
| Repeat error rate | Recurring error types across reviewed samples. | Identifies training or process gaps. |

## QA Dashboard Fields

The synthetic dataset can support QA dashboard fields such as:

| Field | Purpose |
|---|---|
| ticket_id | Unique ticket reference |
| risk_category | Category assigned to the ticket |
| severity | Urgency level |
| sla_target_hours | SLA target based on severity |
| escalation_team | Team responsible for review |
| human_review_required | Whether manual review is needed |
| model_confidence | Confidence score from classifier |
| qa_score | QA rating from 0 to 3 |
| qa_outcome | Pass, partial pass, fail, or critical fail |
| qa_error_type | Type of quality issue identified |
| sla_met | Whether the ticket met SLA |
| final_action | Final operational outcome |

## Review Cadence

| QA Activity | Frequency |
|---|---|
| Critical ticket review | Daily |
| High severity sampling | Daily or weekly |
| Medium and Low sampling | Weekly |
| Human override review | Weekly |
| SLA breach review | Weekly |
| Taxonomy gap review | Monthly |
| Model performance review | Monthly |
| Full QA framework review | Quarterly |

## Continuous Improvement Loop

QA findings should feed back into process improvement.

Recommended loop:

1. Review sampled tickets.
2. Identify errors and patterns.
3. Categorise findings by error type.
4. Update taxonomy examples if needed.
5. Update escalation rules if needed.
6. Improve reviewer guidance.
7. Adjust model thresholds or features.
8. Re-test using future QA samples.
9. Track whether error rates improve over time.

## Responsible AI Considerations

The QA process should ensure that automation supports human judgement rather than replacing it in sensitive areas.

Key safeguards:

- Do not fully automate High or Critical decisions.
- Route low-confidence predictions to human review.
- Record human overrides.
- Monitor model performance across categories.
- Avoid relying only on keywords.
- Use explainable features where possible.
- Review false negatives carefully, especially for safety-critical categories.
- Keep synthetic data clearly labelled as synthetic.
- Avoid including real personal data in training or testing.

## Portfolio Relevance

This QA checklist demonstrates skills relevant to Trust & Safety, AI operations, risk management, and data quality, including:

- quality assurance design
- operational risk review
- escalation accuracy checking
- SLA monitoring
- human-in-the-loop governance
- automation oversight
- audit readiness
- process improvement
- dashboard metric design
- responsible AI thinking

## Notes

This checklist is designed for portfolio and educational purposes only. It is not a real-world safety policy or production QA framework. A production system would require legal review, policy review, specialist safety expertise, privacy assessment, and continuous monitoring.
