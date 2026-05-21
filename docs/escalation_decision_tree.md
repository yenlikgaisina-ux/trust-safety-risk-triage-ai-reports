# Escalation Decision Tree

## Project Context

This escalation decision tree is part of the portfolio project:

AI Trust & Safety Operations Case Study: Risk Triage, Taxonomy Design and Escalation Workflow

The purpose of this document is to show how incoming user reports can be routed from initial intake to the correct severity level, escalation team, SLA target, and review process.

The project uses fully synthetic user reports only. No real users, real platforms, real accounts, or real incidents are included.

## Purpose

A Trust & Safety triage system needs clear routing logic so that urgent and high-risk reports are identified quickly and handled by the right team.

This decision tree helps convert unstructured user reports into operational decisions, including:

- risk severity
- escalation team
- SLA target
- human review requirement
- final action pathway
- quality assurance flagging

The decision tree is designed to be simple enough for a reviewer to apply quickly, while still supporting automation and analytics.

## How to Use This Decision Tree

For each incoming report:

1. Read the full user report.
2. Check for immediate safety risks first.
3. Check whether a minor may be involved.
4. Check for fraud, account abuse, privacy, harassment, misinformation, or policy confusion.
5. Assign the highest applicable severity.
6. Route the case to the correct escalation team.
7. Mark whether human review is required.
8. Apply the correct SLA target.
9. Record the final action.

If a case fits multiple categories, route it according to the highest-risk signal.

## Step 1: Check for Immediate Safety Risk

Ask: Does the report suggest immediate risk of harm to the user or another person?

Examples:

- self-harm or crisis language
- credible threat of violence
- urgent fear for someone's safety
- report suggesting imminent danger
- severe distress requiring urgent escalation

| Answer | Action |
|---|---|
| Yes | Assign Critical severity and route to Trust & Safety Specialist |
| No | Continue to Step 2 |

Default SLA: 1 hour. Human review: Required.

## Step 2: Check Whether a Minor May Be Involved

Ask: Does the report involve a child, teenager, younger sibling, student, or anyone who may be under 18?

Examples:

- suspicious adult contact with a minor
- age-inappropriate content shown to a minor
- minor privacy concern
- suspected grooming signal
- report from a parent, sibling, teacher, or guardian

| Answer | Action |
|---|---|
| Yes | Assign Critical severity and route to Child Safety Escalation |
| No | Continue to Step 3 |

Default SLA: 1 hour. Human review: Required.

Rule: Any case involving a minor should be treated as Critical until reviewed by a trained specialist.

## Step 3: Check for Fraud, Scam, or Account Compromise

Ask: Does the report involve financial manipulation, impersonation, suspicious payments, phishing, or account takeover?

Examples:

- user asked to pay outside the platform
- suspicious charge
- account accessed without permission
- password changed unexpectedly
- impersonation of another user or organisation
- fake investment opportunity
- phishing link
- coercive payment request

| Answer | Action |
|---|---|
| Yes | Assign High severity and route to Fraud and Account Integrity |
| No | Continue to Step 4 |

Default SLA: 4 hours. Human review: Required.

Severity note: If the fraud report also includes immediate safety risk, threats, or a minor, upgrade to Critical.

## Step 4: Check for Privacy Risk

Ask: Does the report involve personal data exposure, unauthorised sharing, doxxing, or deletion-related risk?

Examples:

- phone number posted publicly
- home address exposed
- private image or document shared without consent
- user requests removal of personal data
- visibility setting exposed information unexpectedly
- doxxing concern

| Answer | Action |
|---|---|
| Yes, clear exposure | Assign High severity and route to Privacy Review |
| Yes, unclear exposure | Assign Medium severity and route to Privacy Review |
| No | Continue to Step 5 |

| Severity | SLA |
|---|---|
| High | 4 hours |
| Medium | 24 hours |

Human review: Usually required.

## Step 5: Check for Harassment, Threats, or Targeted Abuse

Ask: Does the report involve abusive behaviour, repeated unwanted contact, targeted insults, intimidation, hate-directed abuse, or threats?

Examples:

- repeated unwanted messages
- targeted insults
- threatening language
- sexual harassment
- intimidation
- hate-directed abuse
- coordinated harassment

| Answer | Action |
|---|---|
| Yes, credible threat or severe abuse | Assign High severity and route to Trust & Safety Review |
| Yes, repeated or targeted abuse | Assign Medium severity and route to Trust & Safety Review |
| No | Continue to Step 6 |

| Severity | SLA |
|---|---|
| High | 4 hours |
| Medium | 24 hours |

Human review: Required for threats, repeated abuse, or hate-directed abuse.

## Step 6: Check for Harmful Misinformation

Ask: Does the report involve false, misleading, or potentially harmful claims?

Examples:

- dangerous health advice
- unsafe instructions
- manipulated media
- misleading safety information
- false claim likely to cause real-world harm

| Answer | Action |
|---|---|
| Yes, high harm potential | Assign High severity and route to Policy Review |
| Yes, limited or unclear harm potential | Assign Medium severity and route to Policy Review |
| No | Continue to Step 7 |

| Severity | SLA |
|---|---|
| High | 4 hours |
| Medium | 24 hours |

Human review: Required when harm potential is high or policy interpretation is needed.

## Step 7: Check for Policy Confusion or Appeal

Ask: Is the user mainly asking for clarification about a policy, moderation action, feature restriction, or account decision?

Examples:

- user asks why content was removed
- user asks why account access was restricted
- user wants to appeal an action
- user does not understand a platform rule
- user asks what policy was violated

| Answer | Action |
|---|---|
| Simple policy question | Assign Low severity and route to Support / Education |
| Appeal or unclear policy impact | Assign Medium severity and route to Policy Review |
| No | Continue to Step 8 |

| Severity | SLA |
|---|---|
| Medium | 24 hours |
| Low | 72 hours |

Human review: Required for serious appeals or unclear enforcement decisions.

## Step 8: Check for Low Confidence or Ambiguity

Ask: Is the category unclear, is the model confidence low, or does the ticket contain multiple possible risks?

Examples:

- vague report
- incomplete evidence
- multiple risk categories
- model confidence below 0.75
- classifier prediction conflicts with rule-based severity logic
- user report contains unclear emotional or safety language

| Answer | Action |
|---|---|
| Yes | Route to Human Review Queue |
| No | Continue to standard support handling |

| Possible Harm Level | Severity Floor | SLA |
|---|---|---|
| No clear harm | Low | 72 hours |
| Possible harm | Medium | 24 hours |
| Clear harm | High | 4 hours |
| Immediate or severe harm | Critical | 1 hour |

## Escalation Routing Summary

| Risk Signal | Severity | Escalation Team | SLA | Human Review |
|---|---|---|---|---|
| Immediate safety risk | Critical | Trust & Safety Specialist | 1 hour | Required |
| Minor involved | Critical | Child Safety Escalation | 1 hour | Required |
| Fraud or scam | High | Fraud and Account Integrity | 4 hours | Required |
| Account compromise | High | Fraud and Account Integrity | 4 hours | Required |
| Personal data exposure | High | Privacy Review | 4 hours | Required |
| Unclear privacy concern | Medium | Privacy Review | 24 hours | Usually required |
| Credible threat | High | Trust & Safety Review | 4 hours | Required |
| Repeated harassment | Medium | Trust & Safety Review | 24 hours | Required |
| Harmful misinformation | Medium / High | Policy Review | 4 to 24 hours | Usually required |
| Policy confusion | Low | Support / Education | 72 hours | Not always required |
| Appeal or unclear policy decision | Medium | Policy Review | 24 hours | Usually required |
| Low-confidence classification | Severity floor applies | Human Review Queue | Based on severity | Required |

## SLA Targets

| Severity | SLA Target | Operational Meaning |
|---|---|---|
| Critical | 1 hour | Immediate escalation required |
| High | 4 hours | Specialist review required same day |
| Medium | 24 hours | Review within one working day |
| Low | 72 hours | Standard support response |

## Human Review Rules

Human review is required when:

- severity is Critical
- severity is High
- a minor may be involved
- the report contains self-harm or crisis language
- the report includes credible threats
- the report involves financial fraud
- the report involves personal data exposure
- model confidence is below 0.75
- the report has multiple possible risk categories
- the user is appealing a serious action
- the recommended action could significantly affect user access or safety

Automation can assist with routing, but it should not be the final decision-maker for high-risk or ambiguous cases.

## Final Action Options

| Final Action | Description |
|---|---|
| No action | No policy or safety issue found |
| User education | Provide explanation, policy guidance, or next steps |
| Content review | Send reported content for review |
| Account security review | Investigate suspicious login or account takeover |
| Fraud investigation | Review scam, payment, or impersonation signals |
| Privacy escalation | Review possible personal data exposure |
| Safety escalation | Escalate urgent harm or crisis-related case |
| Child safety escalation | Escalate any case involving possible risk to a minor |
| Policy review | Send unclear or contested policy cases for specialist review |
| Human review required | Hold automated action until manual review is completed |

## Example Routing Scenarios

| User Report | Decision Path | Severity | Team | SLA |
|---|---|---|---|---|
| "Someone changed my password and I can't get back into my account." | Fraud/account compromise | High | Fraud and Account Integrity | 4 hours |
| "A user posted my phone number in a public comment." | Privacy risk | High | Privacy Review | 4 hours |
| "Someone keeps messaging me after I asked them to stop." | Harassment | Medium | Trust & Safety Review | 24 hours |
| "This account is telling people to send money through a private payment link." | Scam/fraud | High | Fraud and Account Integrity | 4 hours |
| "I'm worried an adult is contacting my younger sibling." | Minor involved | Critical | Child Safety Escalation | 1 hour |
| "I don't understand why my post was removed." | Policy confusion | Low | Support / Education | 72 hours |
| "This post is giving dangerous medical advice." | Harmful misinformation | High | Policy Review | 4 hours |

## Automation Logic

The decision tree can be translated into rule-based logic or used alongside a machine learning classifier.

Example pseudo-logic:

```
IF immediate_safety_risk = true:
    severity = Critical
    escalation_team = Trust & Safety Specialist
    human_review_required = true
    sla_target_hours = 1

ELSE IF minor_involved = true:
    severity = Critical
    escalation_team = Child Safety Escalation
    human_review_required = true
    sla_target_hours = 1

ELSE IF fraud_or_account_compromise = true:
    severity = High
    escalation_team = Fraud and Account Integrity
    human_review_required = true
    sla_target_hours = 4

ELSE IF privacy_exposure = true:
    severity = High
    escalation_team = Privacy Review
    human_review_required = true
    sla_target_hours = 4

ELSE IF model_confidence < 0.75:
    escalation_team = Human Review Queue
    human_review_required = true
    severity = severity_floor

ELSE:
    route based on predicted risk category
```

## Quality Assurance Checks

For each reviewed ticket, QA should check:

- Was the highest-risk signal identified?
- Was the correct severity assigned?
- Was the correct escalation team selected?
- Was the SLA target correct?
- Was human review correctly required or not required?
- Was the final action appropriate?
- Was the decision explainable?
- Was the ticket handled within the SLA?
- Was there any over-reliance on automation?

## Risk Controls

| Control | Purpose |
|---|---|
| Highest-risk signal rule | Prevents serious risks being hidden inside lower-risk tickets |
| Mandatory human review for High/Critical cases | Reduces risk of harmful automated decisions |
| Severity floor for ambiguous cases | Prevents under-classification of unclear reports |
| SLA targets | Supports timely response to urgent cases |
| Escalation team mapping | Ensures specialist handling |
| QA review | Detects workflow and classification errors |
| Model confidence threshold | Identifies cases where automation is uncertain |

## Portfolio Relevance

This decision tree demonstrates practical skills in:

- Trust & Safety operations
- risk triage design
- escalation workflow design
- SLA mapping
- operational decision-making
- responsible automation
- human-in-the-loop review
- AI-assisted workflow design
- process documentation
- safety-focused product operations

## Notes

This decision tree is designed for portfolio demonstration only. It is not a real-world platform policy and should not be used as an operational safety procedure without expert review, legal review, policy validation, and specialist input.
