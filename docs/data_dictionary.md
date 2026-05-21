# Data Dictionary

## Project Context

This data dictionary is part of the portfolio project:

AI Trust & Safety Operations Case Study: Risk Triage, Taxonomy Design and Escalation Workflow

The project uses a fully synthetic dataset of user reports to demonstrate how Trust & Safety teams can structure messy risk signals for triage, escalation, quality assurance, SQL analysis, machine learning, and dashboard reporting.

No real users, platforms, accounts, companies, or incidents are used in this project.

## Purpose

The purpose of this data dictionary is to define every field used in the synthetic Trust & Safety dataset.

A clear data dictionary helps ensure that:

- dataset columns are easy to understand
- analysis is reproducible
- SQL queries use consistent field meanings
- dashboards are easier to interpret
- model inputs and outputs are documented
- quality assurance checks are easier to perform
- portfolio reviewers can quickly understand the project structure

## Dataset Name

```text
synthetic_user_reports.csv
```

## Dataset Location

```text
data/synthetic_user_reports.csv
```

## Dataset Description

This dataset contains synthetic user reports submitted to a fictional AI-enabled Trust & Safety triage workflow.

Each row represents one fictional user report.

The dataset is designed to support:

- risk category analysis
- severity distribution analysis
- SLA analysis
- escalation routing analysis
- human review analysis
- model confidence analysis
- SQL analysis
- Python exploratory data analysis
- basic text classification
- dashboard visualisation
- final recommendations reporting

## Important Note on Synthetic Data

All records in this dataset are fictional.

The dataset does not include:

- real names
- real emails
- real phone numbers
- real addresses
- real account IDs
- real payment details
- real platform names
- real incident reports
- real user-generated content

The dataset is created for educational and portfolio purposes only.

## Dataset Grain

Each row represents:

```text
One synthetic user report / one support or Trust & Safety ticket
```

The expected unique identifier is:

```text
ticket_id
```

## Expected Number of Records

The initial dataset should contain approximately:

```text
500 synthetic tickets
```

This number can be increased later if needed for modelling or dashboard development.

## Field Summary

| Column Name | Type | Description |
|---|---|---|
| ticket_id | String | Unique identifier for each synthetic ticket. |
| created_at | DateTime | Synthetic timestamp showing when the ticket was created. |
| user_report | Text | Free-text synthetic user report. |
| risk_category | Categorical | Primary risk category assigned to the ticket. |
| subcategory | Categorical | More specific risk type within the primary category. |
| severity | Categorical | Urgency level assigned to the ticket. |
| sla_target_hours | Integer | Number of hours within which the ticket should be reviewed or actioned. |
| region | Categorical | Synthetic region associated with the report. |
| channel | Categorical | Intake channel where the report was submitted. |
| language | Categorical | Language of the synthetic report. |
| model_confidence | Float | Simulated model confidence score between 0 and 1. |
| escalation_team | Categorical | Team responsible for reviewing or handling the ticket. |
| human_review_required | Boolean | Indicates whether manual human review is required. |
| final_action | Categorical | Final workflow action assigned to the ticket. |

## Detailed Field Definitions

### ticket_id

| Attribute | Detail |
|---|---|
| Data type | String |
| Example | TKT-0001 |
| Required | Yes |
| Unique | Yes |
| Nullable | No |

#### Description

A unique identifier assigned to each synthetic ticket.

#### Purpose

Used to track, join, review, and reference individual tickets across analysis, QA checks, dashboards, and reports.

#### Example Values

```text
TKT-0001
TKT-0002
TKT-0003
```

---

### created_at

| Attribute | Detail |
|---|---|
| Data type | DateTime |
| Example | 2026-01-15 09:42:00 |
| Required | Yes |
| Unique | No |
| Nullable | No |

#### Description

Synthetic timestamp showing when the user report was created.

#### Purpose

Used for time-based analysis, including ticket volume by date, SLA monitoring, and trend reporting.

#### Example Values

```text
2026-01-15 09:42:00
2026-02-03 14:18:00
2026-03-21 19:05:00
```

---

### user_report

| Attribute | Detail |
|---|---|
| Data type | Text |
| Example | Someone changed my password and I cannot access my account. |
| Required | Yes |
| Unique | Usually |
| Nullable | No |

#### Description

The free-text synthetic report submitted by a fictional user.

#### Purpose

Used as the main text input for classification, summarisation, NLP analysis, and model training.

#### Example Values

```text
Someone changed my password and I cannot access my account.
A user posted my phone number in a public comment.
I do not understand why my post was removed.
```

#### Notes

The text should remain fictional and should not contain real personal data.

---

### risk_category

| Attribute | Detail |
|---|---|
| Data type | Categorical |
| Example | Scam or fraud |
| Required | Yes |
| Unique | No |
| Nullable | No |

#### Description

The primary Trust & Safety risk category assigned to the ticket.

#### Purpose

Used for taxonomy analysis, routing, dashboard reporting, and model classification.

#### Allowed Values

| Value | Description |
|---|---|
| Account abuse | Suspicious login, account takeover, unauthorised access, or account misuse. |
| Scam or fraud | Deception, suspicious payments, impersonation, or financial manipulation. |
| Harassment | Targeted abuse, threats, intimidation, or repeated unwanted contact. |
| Self-harm concern | Possible emotional crisis, self-harm concern, or concern for another user's safety. |
| Misinformation | False or misleading claims with potential harm. |
| Privacy concern | Personal data exposure, doxxing, deletion requests, or unauthorised sharing. |
| Billing safety escalation | Billing issue connected to fraud, coercion, or account misuse. |
| Policy confusion | User confusion about moderation, account action, appeals, or platform rules. |
| Child safety concern | Potential risk involving a minor. |
| Platform integrity | Spam, fake accounts, bots, manipulation, or coordinated abuse. |

---

### subcategory

| Attribute | Detail |
|---|---|
| Data type | Categorical |
| Example | unauthorised_login |
| Required | Yes |
| Unique | No |
| Nullable | No |

#### Description

A more specific classification within the primary risk category.

#### Purpose

Used for more detailed analysis and improved routing.

#### Example Values by Category

| Risk Category | Example Subcategories |
|---|---|
| Account abuse | unauthorised_login, suspicious_login_attempt, credential_stuffing_suspected, account_settings_changed |
| Scam or fraud | impersonation, off_platform_payment, fake_offer, phishing_attempt, investment_scam |
| Harassment | targeted_insults, repeated_unwanted_contact, threats, hate_directed_abuse |
| Self-harm concern | self_disclosure, crisis_language, concern_about_other_user |
| Misinformation | health_misinformation, safety_misinformation, manipulated_media, misleading_claims |
| Privacy concern | personal_data_exposure, unauthorised_sharing, deletion_request, doxxing_concern |
| Billing safety escalation | suspicious_charge, payment_method_misuse, coerced_payment, billing_after_account_takeover |
| Policy confusion | content_removal_question, account_action_question, appeal_request, unclear_policy_application |
| Child safety concern | minor_contact_concern, suspected_grooming_signal, age_appropriate_content_concern |
| Platform integrity | spam_network, coordinated_inauthentic_activity, bot_like_activity, fake_account_cluster |

---

### severity

| Attribute | Detail |
|---|---|
| Data type | Categorical |
| Example | High |
| Required | Yes |
| Unique | No |
| Nullable | No |

#### Description

The urgency level assigned to the ticket.

#### Purpose

Used for SLA assignment, queue prioritisation, escalation routing, QA checks, and dashboard reporting.

#### Allowed Values

| Value | Description | SLA Target |
|---|---|---|
| Low | Low-risk or informational issue with no immediate harm signal. | 72 hours |
| Medium | Potential risk exists, but urgency is limited or evidence is unclear. | 24 hours |
| High | Clear risk signal requiring specialist review or faster action. | 4 hours |
| Critical | Immediate or severe safety risk requiring urgent escalation. | 1 hour |

---

### sla_target_hours

| Attribute | Detail |
|---|---|
| Data type | Integer |
| Example | 4 |
| Required | Yes |
| Unique | No |
| Nullable | No |

#### Description

The target number of hours within which the ticket should be reviewed or actioned.

#### Purpose

Used to measure operational responsiveness and SLA compliance.

#### Allowed Values

| Severity | SLA Target Hours |
|---|---:|
| Critical | 1 |
| High | 4 |
| Medium | 24 |
| Low | 72 |

---

### region

| Attribute | Detail |
|---|---|
| Data type | Categorical |
| Example | UK |
| Required | Yes |
| Unique | No |
| Nullable | No |

#### Description

Synthetic region assigned to the ticket.

#### Purpose

Used for dashboard segmentation and fairness monitoring.

#### Example Values

```text
UK
Europe
North America
Asia-Pacific
Middle East
Africa
Latin America
Global / Unknown
```

#### Notes

Regions are synthetic and should not be interpreted as real user locations.

---

### channel

| Attribute | Detail |
|---|---|
| Data type | Categorical |
| Example | Web form |
| Required | Yes |
| Unique | No |
| Nullable | No |

#### Description

The fictional intake channel through which the user report was submitted.

#### Purpose

Used to analyse ticket source patterns and operational workload.

#### Example Values

```text
Web form
Mobile app
Email support
Live chat
In-product report
Appeal form
```

---

### language

| Attribute | Detail |
|---|---|
| Data type | Categorical |
| Example | English |
| Required | Yes |
| Unique | No |
| Nullable | No |

#### Description

The language assigned to the synthetic report.

#### Purpose

Used for analysis of ticket handling across language groups and to monitor possible model performance differences.

#### Example Values

```text
English
Spanish
French
German
Arabic
Russian
Other
```

#### Notes

The initial dataset can keep all reports in English while still using this field for segmentation. If multilingual text is added later, it should remain synthetic.

---

### model_confidence

| Attribute | Detail |
|---|---|
| Data type | Float |
| Example | 0.87 |
| Required | Yes |
| Unique | No |
| Nullable | No |

#### Description

A simulated confidence score representing how confident the model is in its classification.

#### Purpose

Used to decide whether a ticket should be routed to human review.

#### Expected Range

```text
0.00 to 1.00
```

#### Recommended Interpretation

| Confidence Score | Interpretation | Recommended Action |
|---|---|---|
| 0.90 to 1.00 | High confidence | Can support low-risk routing if no sensitive risk is present. |
| 0.75 to 0.89 | Moderate to high confidence | Acceptable for low-risk cases, but review sensitive cases. |
| 0.50 to 0.74 | Low confidence | Human review required. |
| Below 0.50 | Very low confidence | Human review required and model output should be treated cautiously. |

---

### escalation_team

| Attribute | Detail |
|---|---|
| Data type | Categorical |
| Example | Fraud and Account Integrity |
| Required | Yes |
| Unique | No |
| Nullable | No |

#### Description

The team responsible for handling or reviewing the ticket.

#### Purpose

Used for routing analysis, workload analysis, SLA tracking, and operational design.

#### Allowed Values

| Escalation Team | Handles |
|---|---|
| Trust & Safety Review | Harassment, threats, self-harm concerns, general safety abuse. |
| Child Safety Escalation | Any report involving possible risk to a minor. |
| Fraud and Account Integrity | Scams, impersonation, account compromise, suspicious payments. |
| Privacy Review | Personal data exposure, doxxing, unauthorised sharing. |
| Policy Review | Misinformation, appeals, unclear moderation decisions. |
| Support / Education | Low-risk policy questions or standard guidance. |
| Human Review Queue | Ambiguous, multi-risk, or low-confidence tickets. |

---

### human_review_required

| Attribute | Detail |
|---|---|
| Data type | Boolean |
| Example | True |
| Required | Yes |
| Unique | No |
| Nullable | No |

#### Description

Indicates whether the ticket requires manual human review.

#### Purpose

Used to measure human-in-the-loop workload and responsible AI safeguards.

#### Allowed Values

```text
True
False
```

#### Human Review Should Be True When

Human review is required when:

- severity is High or Critical
- a minor may be involved
- self-harm or crisis language appears
- fraud or scam is suspected
- personal data exposure is reported
- credible threat is reported
- model confidence is below 0.75
- the ticket is ambiguous
- the ticket has multiple possible risk categories
- the final action could significantly affect user safety or access

---

### final_action

| Attribute | Detail |
|---|---|
| Data type | Categorical |
| Example | Fraud investigation |
| Required | Yes |
| Unique | No |
| Nullable | No |

#### Description

The final workflow action assigned to the ticket after triage.

#### Purpose

Used to analyse operational outcomes and workflow effectiveness.

#### Allowed Values

| Final Action | Description |
|---|---|
| No action | No policy, safety, or operational issue found. |
| User education | User receives guidance or policy explanation. |
| Content review | Reported content is sent for review. |
| Account security review | Suspicious login or account compromise is investigated. |
| Fraud investigation | Scam, impersonation, or payment risk is reviewed. |
| Privacy escalation | Personal data exposure or privacy issue is escalated. |
| Safety escalation | Urgent harm or safety risk is escalated. |
| Child safety escalation | Minor-related concern is sent to specialist review. |
| Policy review | Unclear or disputed policy issue is reviewed. |
| Human review required | Manual review is required before final decision. |

---

## Derived Fields for Future Analysis

The initial dataset may later be expanded with derived fields.

| Derived Field | Description |
|---|---|
| created_date | Date extracted from created_at. |
| created_month | Month extracted from created_at. |
| created_week | Week number extracted from created_at. |
| sla_due_at | Timestamp calculated from created_at plus sla_target_hours. |
| resolved_at | Synthetic timestamp showing when the case was resolved. |
| response_time_hours | Time between created_at and resolved_at. |
| sla_met | Whether response_time_hours is less than or equal to sla_target_hours. |
| qa_score | QA score from 0 to 3. |
| qa_outcome | Pass, partial pass, fail, or critical fail. |
| qa_error_type | Type of quality issue found during QA. |
| model_prediction_correct | Whether the model prediction matched the final human label. |
| human_override | Whether the human reviewer changed the model recommendation. |

## Suggested Data Quality Checks

Before using the dataset for analysis, check the following:

| Check | Expected Result |
|---|---|
| ticket_id has no duplicates | Every ticket should have a unique ID. |
| required fields are not null | No missing values in required columns. |
| severity values are valid | Only Low, Medium, High, or Critical. |
| SLA values match severity | Critical = 1, High = 4, Medium = 24, Low = 72. |
| model_confidence is between 0 and 1 | No values below 0 or above 1. |
| human_review_required is boolean | Values should be True or False. |
| escalation_team values are valid | Only approved team names should appear. |
| final_action values are valid | Only approved final actions should appear. |
| risk_category values are valid | Only approved taxonomy categories should appear. |
| subcategory matches risk_category | Subcategory should belong to the assigned category. |

## Example Record

| Column | Example Value |
|---|---|
| ticket_id | TKT-0001 |
| created_at | 2026-01-15 09:42:00 |
| user_report | Someone changed my password and I cannot access my account. |
| risk_category | Account abuse |
| subcategory | unauthorised_login |
| severity | High |
| sla_target_hours | 4 |
| region | UK |
| channel | Web form |
| language | English |
| model_confidence | 0.86 |
| escalation_team | Fraud and Account Integrity |
| human_review_required | True |
| final_action | Account security review |

## Analytics Use Cases

This dataset can support the following analysis questions:

| Question | Relevant Fields |
|---|---|
| Which risk categories appear most often? | risk_category |
| Which severity levels dominate the queue? | severity |
| Which teams receive the most escalations? | escalation_team |
| How much work requires human review? | human_review_required |
| Which categories have lower model confidence? | risk_category, model_confidence |
| How many tickets are High or Critical? | severity |
| Are SLA targets distributed appropriately? | severity, sla_target_hours |
| Which intake channels generate the most high-risk tickets? | channel, severity |
| Are certain regions overrepresented in high-severity tickets? | region, severity |
| Which final actions are most common? | final_action |

## SQL Analysis Relevance

This data dictionary supports SQL queries such as:

- count tickets by risk category
- count tickets by severity
- calculate percentage of tickets requiring human review
- identify categories with lowest average model confidence
- analyse escalation team workload
- compare SLA targets across severity levels
- find high-risk tickets by region or channel
- identify tickets that should receive QA review

## Machine Learning Relevance

The dataset can be used for a basic text classification model.

Suggested setup:

| Element | Field |
|---|---|
| Input text | user_report |
| Target label | risk_category |
| Optional target | severity |
| Model confidence | model_confidence |
| Human review flag | human_review_required |

Example modelling task:

```text
Predict risk_category from user_report using TF-IDF and Logistic Regression.
```

Possible evaluation outputs:

- accuracy score
- classification report
- confusion matrix
- category-level precision
- category-level recall
- category-level F1 score

## Dashboard Relevance

This dataset can support dashboard visuals such as:

| Visual | Fields |
|---|---|
| Tickets by risk category | risk_category |
| Tickets by severity | severity |
| Escalation team workload | escalation_team |
| Human review required percentage | human_review_required |
| Average model confidence by category | risk_category, model_confidence |
| SLA target distribution | sla_target_hours |
| Ticket volume by date | created_at |
| Final actions breakdown | final_action |
| Region and channel breakdown | region, channel |

## Responsible AI Notes

Because this dataset is designed for an AI-assisted triage workflow, it should be used with the following safeguards:

- Treat model outputs as recommendations, not final decisions.
- Require human review for High and Critical cases.
- Require human review for low-confidence predictions.
- Review false negatives carefully, especially for sensitive categories.
- Clearly label all data as synthetic.
- Do not add real user reports to the dataset.
- Do not publish real personal information.
- Do not claim that the model is production-ready.

## Portfolio Relevance

This data dictionary demonstrates skills in:

- structured dataset design
- documentation
- data governance
- Trust & Safety workflow design
- analytics planning
- SQL-readiness
- machine learning-readiness
- dashboard planning
- responsible AI documentation
- quality assurance support

## Notes

This data dictionary is for portfolio and educational purposes only. It does not describe a production Trust & Safety system. A real-world implementation would require privacy review, policy review, legal input, operational testing, security controls, and expert safety oversight.
