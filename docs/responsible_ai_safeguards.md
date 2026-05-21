# Responsible AI Safeguards

## Project Context

This responsible AI safeguards document is part of the portfolio project:

AI Trust & Safety Operations Case Study: Risk Triage, Taxonomy Design and Escalation Workflow

The project uses fully synthetic user reports to demonstrate how AI-assisted triage can support Trust & Safety operations while reducing risks linked to automation, bias, privacy, explainability, and unsafe decision-making.

No real users, platforms, accounts, companies, or incidents are used in this project.

## Purpose

The purpose of this document is to define responsible AI safeguards for an AI-assisted Trust & Safety triage system.

The system is designed to help organise and prioritise user reports. It should not replace human judgement in sensitive or high-impact decisions.

Responsible AI safeguards are needed to make sure that:

- high-risk cases are not missed
- automation does not make final decisions in sensitive cases
- users are not negatively affected by unexplained model outputs
- synthetic data is clearly separated from real user data
- privacy risks are reduced
- human reviewers remain accountable for final outcomes
- model performance is monitored over time
- quality assurance findings are used to improve the workflow

## Responsible AI Principles

| Principle | Meaning in This Project |
|---|---|
| Human oversight | Humans review high-risk, sensitive, ambiguous, and low-confidence cases. |
| Safety first | Potential harm is escalated cautiously, especially in child safety, self-harm, fraud, and privacy cases. |
| Explainability | Model predictions should be understandable to reviewers. |
| Accountability | Final decisions should have a clear owner and documented rationale. |
| Privacy protection | No real personal data should be used in the synthetic dataset. |
| Fairness | The system should be monitored for inconsistent performance across categories and regions. |
| Proportionality | Actions should match the severity and evidence in the ticket. |
| Auditability | Decisions, overrides, and quality outcomes should be recorded. |
| Continuous improvement | Human feedback and QA findings should improve the taxonomy, workflow, and model. |

## AI System Role

In this project, AI is used as a support tool.

The AI system may help with:

| AI-Assisted Task | Purpose |
|---|---|
| Ticket classification | Suggest a risk category and subcategory. |
| Severity prediction | Estimate urgency level. |
| SLA mapping | Suggest response target based on severity. |
| Escalation routing | Recommend the appropriate review team. |
| Ticket summarisation | Create a concise summary for reviewers. |
| Pattern detection | Identify trends in risk categories and severity. |
| Dashboard preparation | Support structured reporting and analytics. |

The AI system should not independently make final decisions in high-impact cases.

## Decisions That Must Not Be Fully Automated

The following decisions require human review:

| Decision Type | Why Human Review Is Required |
|---|---|
| Critical severity classification | Immediate or severe harm risk requires human judgement. |
| Child safety escalation | Cases involving minors require specialist review. |
| Self-harm or crisis concern | Sensitive safety cases require careful human assessment. |
| Fraud or scam investigation | Financial harm and deception require contextual review. |
| Account compromise | Account access decisions may significantly affect users. |
| Personal data exposure | Privacy risks require careful handling. |
| Credible threats | Threat assessment requires context and judgement. |
| Serious enforcement appeal | Fairness and user impact require human oversight. |
| Low-confidence model predictions | Uncertain automation should not be trusted alone. |
| Ambiguous multi-risk cases | A human should decide the highest-risk signal. |

## Human Oversight Safeguards

| Safeguard | Description |
|---|---|
| Mandatory review for High and Critical tickets | Prevents serious cases from being handled only by automation. |
| Human review for model confidence below 0.75 | Captures cases where the model is uncertain. |
| Specialist escalation paths | Sends sensitive tickets to appropriate teams. |
| Human override logging | Records where reviewers disagree with the model. |
| Reviewer rationale requirement | Ensures decisions can be explained later. |
| QA sampling | Checks whether decisions are accurate and consistent. |
| Escalation audit trail | Maintains a record of category, severity, routing, and final action. |

## Model Confidence Safeguards

Model confidence should be treated as a decision-support signal, not proof that the model is correct.

| Confidence Score | Recommended Handling |
|---:|---|
| 0.90 to 1.00 | Can support low-risk routing if no sensitive risk is detected. |
| 0.75 to 0.89 | Acceptable for low-risk assistance but still review sensitive cases. |
| 0.50 to 0.74 | Human review required. |
| Below 0.50 | Human review required; model output should be treated as unreliable. |

Important rule:

High confidence should never bypass human review for High, Critical, child safety, self-harm, privacy, fraud, or serious enforcement cases.

## Privacy Safeguards

This project uses synthetic data only.

Privacy safeguards include:

| Safeguard | Purpose |
|---|---|
| No real user data | Prevents exposure of real personal information. |
| No real platform names | Avoids misrepresenting real companies or systems. |
| No real account details | Prevents accidental identification. |
| No real incident descriptions | Keeps the project educational and safe. |
| Synthetic ticket IDs | Avoids linking records to real users. |
| Fictional reports only | Demonstrates workflow without using sensitive data. |
| Clear dataset labelling | Makes it obvious that the data is synthetic. |

## Data Minimisation

The synthetic dataset should include only fields needed for the portfolio analysis.

Recommended included fields:

| Field | Reason for Inclusion |
|---|---|
| ticket_id | Enables tracking and analysis. |
| created_at | Supports trend and SLA analysis. |
| user_report | Provides text for classification. |
| risk_category | Supports taxonomy and analytics. |
| subcategory | Enables more detailed analysis. |
| severity | Supports prioritisation. |
| sla_target_hours | Supports operational performance analysis. |
| escalation_team | Supports routing analysis. |
| model_confidence | Supports automation governance. |
| human_review_required | Supports human-in-the-loop analysis. |
| final_action | Supports workflow outcome analysis. |

Fields that should not be included:

| Excluded Field | Reason |
|---|---|
| Real names | Not needed and creates privacy risk. |
| Real emails | Not needed and creates privacy risk. |
| Real phone numbers | Not needed and creates privacy risk. |
| Real addresses | Not needed and creates privacy risk. |
| Real account IDs | Not needed and creates privacy risk. |
| Real platform identifiers | Not needed and may misrepresent real systems. |
| Real payment details | Not needed and creates financial data risk. |

## Bias and Fairness Safeguards

Even synthetic datasets can accidentally create unrealistic or unfair patterns.

The project should monitor for:

| Risk | Example | Safeguard |
|---|---|---|
| Category imbalance | Too many fraud tickets and too few privacy tickets. | Check category distribution. |
| Severity imbalance | Most tickets labelled High. | Review severity distribution. |
| Regional bias | One region associated with more severe reports. | Use balanced synthetic region assignment. |
| Language bias | Non-English tickets always classified as higher risk. | Review performance by language. |
| Keyword bias | Certain words cause over-escalation. | Use QA review and model error analysis. |
| Under-detection | Sensitive categories missed due to vague wording. | Use human review and safety keyword checks. |

## Explainability Safeguards

Reviewers should understand why a ticket was classified in a particular way.

Useful explainability features:

| Feature | Purpose |
|---|---|
| Predicted category | Shows the model recommendation. |
| Confidence score | Shows how certain the model is. |
| Key terms or signals | Helps reviewer understand the prediction. |
| Rule-based escalation reason | Explains why severity or team was assigned. |
| Human reviewer notes | Records final rationale. |
| Override reason | Documents disagreement between model and reviewer. |

A model output should not be accepted simply because it appears confident.

## Safety Safeguards

The system should prioritise user safety over speed or automation efficiency.

| Safety Risk | Safeguard |
|---|---|
| Child safety concern missed | Any minor-related signal routes to Critical and specialist review. |
| Self-harm concern missed | Crisis or self-harm language routes to human review. |
| Fraud under-classified | Financial harm or impersonation routes to High severity. |
| Privacy exposure delayed | Personal data exposure routes to Privacy Review. |
| Threat treated as low risk | Credible threat language routes to Trust & Safety Review. |
| Ambiguous harm ignored | Ambiguous cases receive severity floor and human review. |

## Misclassification Controls

The workflow should reduce the risk of incorrect classification.

| Control | Description |
|---|---|
| Taxonomy definitions | Provides clear category boundaries. |
| Severity assignment rules | Reduces inconsistent urgency decisions. |
| Escalation decision tree | Provides structured routing logic. |
| QA checklist | Detects category, severity, and routing errors. |
| Human review queue | Captures uncertain or sensitive cases. |
| Override tracking | Identifies where model predictions fail. |
| Model performance review | Monitors accuracy and false negatives. |

## False Negative Risk

False negatives are especially important in Trust & Safety because they can allow harmful cases to remain unresolved.

Examples of high-risk false negatives:

| False Negative | Potential Harm |
|---|---|
| Child safety concern classified as policy confusion | Urgent safety issue may be delayed. |
| Self-harm concern classified as low-risk support | Crisis response may be missed. |
| Fraud report classified as billing question | Financial harm may continue. |
| Privacy exposure classified as general complaint | Personal data may remain exposed. |
| Threat classified as harassment only | Severity may be too low. |

False negatives in safety-critical categories should be reviewed with extra care.

## False Positive Risk

False positives also matter because over-escalation can create operational burden and unfair outcomes.

Examples:

| False Positive | Potential Harm |
|---|---|
| Policy confusion classified as fraud | Unnecessary specialist workload. |
| Low-risk disagreement classified as harassment | Over-enforcement risk. |
| General health discussion classified as misinformation | Unfair moderation risk. |
| Simple account issue classified as account compromise | Unnecessary escalation. |

The goal is not only to catch more risk, but to route cases proportionately.

## Human Override Safeguards

Human overrides should be recorded and analysed.

| Override Field | Purpose |
|---|---|
| original_model_category | Shows the model prediction. |
| final_human_category | Shows corrected category. |
| original_model_severity | Shows model severity. |
| final_human_severity | Shows corrected severity. |
| override_reason | Explains why the human changed the decision. |
| reviewer_id | Supports accountability in a production system. |
| review_date | Supports audit and trend analysis. |
| qa_flag | Marks tickets for further quality review. |

In this portfolio project, reviewer IDs should be fictional or omitted.

## Auditability Safeguards

A safe workflow should leave a clear audit trail.

Each ticket should ideally record:

| Audit Field | Purpose |
|---|---|
| ticket_id | Unique reference. |
| model_prediction | Shows automated recommendation. |
| model_confidence | Shows uncertainty level. |
| human_review_required | Shows whether manual review was required. |
| human_decision | Shows final human outcome where applicable. |
| escalation_team | Shows routing path. |
| sla_target_hours | Shows expected response time. |
| final_action | Shows outcome. |
| qa_outcome | Shows quality review result. |
| override_reason | Shows reason for disagreement with model. |

## QA and Monitoring Safeguards

Responsible AI requires ongoing monitoring.

Recommended monitoring metrics:

| Metric | Purpose |
|---|---|
| Category accuracy | Measures whether tickets are classified correctly. |
| Severity accuracy | Measures whether urgency is assigned correctly. |
| False negative rate | Identifies missed risks. |
| False positive rate | Identifies over-escalation. |
| Human override rate | Shows model-reviewer disagreement. |
| Low-confidence review rate | Confirms uncertain cases are reviewed. |
| SLA compliance rate | Measures operational responsiveness. |
| Critical case response time | Monitors urgent safety handling. |
| QA pass rate | Measures decision quality. |
| Error rate by category | Identifies weak areas in taxonomy or model. |

## Model Evaluation Safeguards

The classifier should be evaluated beyond overall accuracy.

Useful evaluation views:

| Evaluation View | Why It Matters |
|---|---|
| Accuracy by risk category | Reveals categories the model struggles with. |
| Precision by category | Shows whether the model over-predicts a category. |
| Recall by category | Shows whether the model misses a category. |
| Confusion matrix | Shows which categories are confused with each other. |
| Error review | Helps identify taxonomy or training data issues. |
| Confidence calibration | Checks whether confidence scores are meaningful. |
| High-risk false negative review | Focuses on the most harmful errors. |

For this project, recall for sensitive categories is especially important.

## Responsible Use of Synthetic Data

Synthetic data is useful for portfolio work because it avoids using real user reports.

However, synthetic data also has limits.

| Benefit | Limitation |
|---|---|
| Avoids real personal data | May not reflect real-world complexity. |
| Allows safe public sharing | May contain simplified patterns. |
| Supports reproducibility | Model performance may look better than in production. |
| Good for demonstrating workflow | Not suitable for real-world deployment without validation. |

The README and project documentation should clearly state that all data is synthetic.

## Limitations

This project does not claim to be a production-ready Trust & Safety system.

Limitations include:

- synthetic data may not capture real-world ambiguity
- model performance on synthetic reports may not generalise
- no real policy enforcement is involved
- no real user harm assessment is performed
- no legal or regulatory assessment is included
- no live moderation system is connected
- no production privacy review is included
- no specialist child safety or crisis response review is included

These limitations should be clearly disclosed in the README and final report.

## Responsible AI Checklist

Use this checklist before publishing the project.

| Check | Status |
|---|---|
| Dataset is fully synthetic. |  |
| No real names, emails, phone numbers, or addresses are included. |  |
| No real platforms or companies are named in the ticket data. |  |
| High and Critical cases require human review. |  |
| Child safety cases require specialist escalation. |  |
| Self-harm and crisis cases require human review. |  |
| Low-confidence model predictions require human review. |  |
| Model confidence is used cautiously. |  |
| Human overrides are recorded. |  |
| QA checklist is included. |  |
| Limitations are clearly stated. |  |
| Project is labelled as educational and portfolio-based. |  |

## Portfolio Relevance

This document demonstrates skills relevant to:

- responsible AI design
- AI governance
- human-in-the-loop workflows
- Trust & Safety operations
- risk management
- privacy-aware project design
- model monitoring
- quality assurance
- escalation governance
- ethical use of synthetic data

## Notes

This document is for portfolio and educational purposes only. It is not a production safety policy, legal framework, privacy policy, or operational Trust & Safety procedure. A real-world system would require expert policy review, privacy assessment, legal review, specialist safety input, and ongoing governance.
