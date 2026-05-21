# Risk Taxonomy

## Project Context

This risk taxonomy is part of the portfolio project:

**AI Trust & Safety Operations Case Study: Risk Triage, Taxonomy Design and Escalation Workflow**

The project uses fully synthetic user reports to demonstrate how messy risk signals can be converted into structured operational inputs for Trust & Safety, AI operations, risk triage, quality assurance, escalation, and workflow improvement.

No real users, platforms, companies, accounts, or incidents are used in this project.

## Purpose of the Taxonomy

The purpose of this taxonomy is to create a consistent structure for classifying user reports into risk categories, subcategories, severity levels, escalation routes, and service-level agreement targets.

A strong taxonomy helps Trust & Safety teams:

- classify incoming reports consistently
- identify high-risk cases quickly
- route urgent cases to the correct specialist team
- measure risk trends over time
- support quality assurance reviews
- improve human-in-the-loop decision-making
- create structured data for dashboards, SQL analysis, and machine learning models

## How to Use This Taxonomy

Each incoming ticket should be reviewed using the following steps:

1. Read the user report carefully.
2. Identify the primary risk category.
3. Select the most relevant subcategory.
4. Assign a severity level.
5. Apply the SLA target linked to the severity level.
6. Route the ticket to the correct escalation team.
7. Mark whether human review is required.
8. Record the final action taken.

Each ticket should have one primary risk category. If a ticket contains multiple risks, classify it according to the highest-risk issue.

## Primary Risk Categories

| Risk Category | Definition | Example Signal | Typical Severity |
|---|---|---|---|
| Account abuse | Reports involving compromised accounts, suspicious login activity, unauthorised access, or misuse of account features. | A user says their account settings changed without permission. | Medium / High |
| Scam or fraud | Reports involving deception, suspicious payments, impersonation, fake offers, or financial manipulation. | A user reports being asked to pay outside the platform. | High |
| Harassment | Reports involving targeted abuse, repeated unwanted contact, threats, or hostile behaviour. | A user reports repeated aggressive messages from another account. | Medium / High |
| Self-harm concern | Reports suggesting possible risk of self-harm, emotional crisis, or concern for another user's safety. | A user reports that someone appears to be in immediate distress. | High / Critical |
| Misinformation | Reports involving false, misleading, or potentially harmful claims. | A user reports dangerous health advice being shared. | Medium / High |
| Privacy concern | Reports involving personal data exposure, unauthorised sharing, deletion requests, or visibility concerns. | A user says private information was exposed publicly. | Medium / High |
| Billing safety escalation | Billing issues connected to fraud, coercion, suspicious charges, or account compromise. | A user reports unexpected charges after a suspected account takeover. | Medium / High |
| Policy confusion | Reports where the user does not understand a moderation decision, account action, or platform rule. | A user asks why their content was removed. | Low / Medium |
| Child safety concern | Reports involving potential risk to a minor or age-inappropriate contact/content. | A user reports suspicious interaction involving someone under 18. | Critical |
| Platform integrity | Reports involving spam, fake accounts, coordinated manipulation, bot-like behaviour, or abuse patterns. | Multiple accounts appear to post identical suspicious messages. | Medium / High |

## Subcategories

| Risk Category | Subcategories |
|---|---|
| Account abuse | unauthorised_login, suspicious_login_attempt, credential_stuffing_suspected, session_hijack_suspected, account_settings_changed, account_recovery_abuse |
| Scam or fraud | impersonation, off_platform_payment, fake_offer, advance_fee_scam, investment_scam, phishing_attempt, refund_abuse |
| Harassment | targeted_insults, repeated_unwanted_contact, threats, hate_directed_abuse, sexual_harassment, intimidation |
| Self-harm concern | self_disclosure, crisis_language, concern_about_other_user, potential_immediate_risk, non_immediate_distress |
| Misinformation | health_misinformation, safety_misinformation, manipulated_media, misleading_claims, harmful_instructional_content |
| Privacy concern | personal_data_exposure, unauthorised_sharing, deletion_request, doxxing_concern, visibility_misconfiguration |
| Billing safety escalation | suspicious_charge, payment_method_misuse, coerced_payment, refund_dispute_with_fraud_signal, billing_after_account_takeover |
| Policy confusion | content_removal_question, account_action_question, feature_restriction_question, appeal_request, unclear_policy_application |
| Child safety concern | minor_contact_concern, age_appropriate_content_concern, suspected_grooming_signal, minor_privacy_concern |
| Platform integrity | spam_network, coordinated_inauthentic_activity, bot_like_activity, fake_account_cluster, scripted_abuse, review_manipulation |

## Severity Levels

| Severity | Definition | Example | SLA Target |
|---|---|---|---|
| Low | Low-risk or informational issue with no immediate harm signal. | A user asks why a post was removed. | 72 hours |
| Medium | Potential risk exists, but urgency is limited or evidence is unclear. | A user reports unwanted messages but no threats. | 24 hours |
| High | Clear risk signal requiring specialist review or faster action. | A user reports impersonation, fraud, account compromise, or personal data exposure. | 4 hours |
| Critical | Immediate or severe safety risk requiring urgent escalation. | A report involves a minor, imminent harm, or urgent self-harm concern. | 1 hour |

## Severity Assignment Rules

Severity should be assigned according to the highest-risk signal in the ticket.

### Critical Severity

Assign **Critical** when the ticket includes:

- immediate risk of physical harm
- self-harm or crisis language suggesting urgency
- threats involving serious violence
- potential child safety concern
- suspected grooming or exploitation risk
- a minor involved in a harmful or suspicious interaction

Critical tickets should never be handled only through automation. They require immediate human review.

### High Severity

Assign **High** when the ticket includes:

- suspected account takeover
- financial fraud
- impersonation with harm potential
- personal data exposure
- credible threats
- harmful misinformation with possible real-world consequences
- suspicious charges linked to account misuse
- coordinated abuse affecting multiple users

High severity tickets should be reviewed by a trained specialist or escalation team.

### Medium Severity

Assign **Medium** when the ticket includes:

- unclear but plausible harm signal
- repeated unwanted contact
- policy confusion with potential user impact
- privacy concern without clear exposure
- misinformation with limited immediate harm
- billing issue with possible but unconfirmed risk

Medium severity tickets should be reviewed within 24 hours.

### Low Severity

Assign **Low** when the ticket includes:

- general policy confusion
- low-risk user questions
- no clear harm signal
- no urgent safety issue
- simple support or education need

Low severity tickets can usually be handled by standard support workflows.

## Severity Escalation Principles

The following principles should guide reviewer judgement:

1. If there is uncertainty between two severity levels, choose the higher severity.
2. If the report involves a minor, assign Critical by default.
3. If the report includes immediate danger, assign Critical.
4. If the report includes financial loss or suspected fraud, assign at least High.
5. If the report includes personal data exposure, assign at least Medium and escalate to Privacy Review if evidence is clear.
6. If a classifier has low confidence, route to human review.
7. Automation may assist with classification, but severity downgrades should require human review.

## Escalation Teams

| Escalation Team | Handles |
|---|---|
| Trust & Safety Review | Harassment, threats, self-harm concerns, abuse reports, general high-risk safety cases |
| Child Safety Escalation | Any report involving minors or suspected child safety risk |
| Fraud and Account Integrity | Scams, impersonation, account compromise, suspicious payments, platform manipulation |
| Privacy Review | Personal data exposure, unauthorised sharing, doxxing concerns, deletion-related risk |
| Policy Review | Misinformation, policy confusion, unclear moderation decisions, appeals |
| Support / Education | Low-risk policy questions, basic account guidance, non-urgent user confusion |
| Human Review Queue | Ambiguous, low-confidence, or multi-risk tickets requiring manual judgement |

## Human Review Requirements

Human review is required when:

- severity is High or Critical
- the ticket involves a minor
- the ticket includes self-harm or crisis language
- the model confidence score is below 0.75
- the ticket contains multiple risk categories
- the report is ambiguous but potentially harmful
- the user is appealing a serious enforcement action
- the case may require policy interpretation
- the case involves personal data exposure
- the model recommendation conflicts with rule-based severity logic

## Example Classification

| User Report | Risk Category | Subcategory | Severity | Escalation Team |
|---|---|---|---|---|
| "Someone changed my password and I can't access my account anymore." | Account abuse | unauthorised_login | High | Fraud and Account Integrity |
| "A person keeps messaging me even after I asked them to stop." | Harassment | repeated_unwanted_contact | Medium | Trust & Safety Review |
| "This account is asking people to send money outside the platform." | Scam or fraud | off_platform_payment | High | Fraud and Account Integrity |
| "A user posted my phone number publicly." | Privacy concern | personal_data_exposure | High | Privacy Review |
| "I don't understand why my post was removed." | Policy confusion | content_removal_question | Low | Support / Education |
| "I'm worried this adult is contacting my younger sibling." | Child safety concern | minor_contact_concern | Critical | Child Safety Escalation |

## Quality Assurance Checks

Reviewers should check:

- Was the correct primary category selected?
- Was the subcategory specific enough?
- Was the severity level appropriate?
- Was the SLA target correctly assigned?
- Was the correct escalation team selected?
- Was human review required and correctly marked?
- Was the final action consistent with the risk level?
- Was the case handled within the SLA?
- Was the classification explainable?

## Taxonomy Maintenance

This taxonomy should be reviewed regularly to ensure it remains useful and accurate.

Recommended review cycle:

| Review Activity | Frequency |
|---|---|
| Review misclassified tickets | Weekly |
| Review unclear or disputed cases | Weekly |
| Update category examples | Monthly |
| Review SLA performance by severity | Monthly |
| Evaluate classifier performance by category | Monthly |
| Full taxonomy review | Quarterly |

## Success Metrics

The taxonomy can be evaluated using the following metrics:

| Metric | Purpose |
|---|---|
| Classification accuracy | Measures whether tickets are assigned to the correct risk category |
| Severity accuracy | Measures whether the urgency level is correctly assigned |
| SLA compliance rate | Measures whether tickets are handled within target time |
| Escalation precision | Measures whether tickets are routed to the correct team |
| Human review override rate | Measures how often humans disagree with automated classification |
| Critical case response time | Measures speed of response for the most urgent cases |
| Ambiguous case rate | Measures how often reports require manual judgement |

## Portfolio Relevance

This taxonomy demonstrates skills relevant to Trust & Safety, AI operations, risk analysis, and data-driven workflow design, including:

- taxonomy design
- operational risk classification
- escalation logic
- SLA design
- human-in-the-loop review
- responsible AI safeguards
- quality assurance thinking
- structured data preparation
- analytics-ready workflow design

## Notes

This project is for portfolio and educational purposes only. The dataset, tickets, and examples are synthetic. The taxonomy is designed to demonstrate operational thinking and should not be treated as a real-world safety policy.
