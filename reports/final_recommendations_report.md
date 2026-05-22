# Final Recommendations Report

## Project Context

This report is part of the portfolio project:

AI Trust & Safety Operations Case Study: Risk Triage, Taxonomy Design and Escalation Workflow

The project uses 500 fully synthetic user reports to demonstrate how Trust & Safety teams can structure, classify, prioritise, escalate, analyse, and monitor user-submitted risk signals.

No real users, platforms, accounts, companies, or incidents are used in this project.

## Executive Summary

This project demonstrates how a Trust & Safety operations team could transform unstructured user reports into a structured AI-assisted triage workflow.

The workflow includes:

- a risk taxonomy
- severity levels
- escalation routing
- SLA targets
- human-in-the-loop review rules
- quality assurance checks
- responsible AI safeguards
- SQL analysis
- exploratory data analysis
- a simple machine learning classifier
- AI-assisted ticket summarisation
- dashboard planning and mockup generation

The goal is not to fully automate safety decisions. The goal is to show how AI and structured analytics can support human reviewers by improving consistency, visibility, prioritisation, and operational decision-making.

## Business Problem

Trust & Safety teams often receive large volumes of messy, free-text user reports. These reports may involve fraud, harassment, privacy concerns, account abuse, misinformation, policy confusion, self-harm concerns, child safety concerns, or platform integrity issues.

Without a structured triage process, teams may face:

- inconsistent categorisation
- slow escalation of urgent cases
- unclear ownership between teams
- poor visibility of workload
- missed high-risk reports
- weak quality assurance
- unsafe over-reliance on automation
- limited ability to monitor model performance

This project addresses that problem by designing a structured, responsible, and analytics-ready triage workflow.

## Dataset

The dataset contains 500 synthetic Trust & Safety user reports.

Each row represents one fictional ticket with the following fields:

- ticket ID
- created timestamp
- user report text
- risk category
- subcategory
- severity
- SLA target
- region
- channel
- language
- model confidence
- escalation team
- human review requirement
- final action

The dataset is stored at:

```text
data/synthetic_user_reports.csv
```

An enriched version with reviewer summaries is stored at:

```text
data/synthetic_user_reports_with_summaries.csv
```

## Methodology

The project followed a full workflow design process:

1. Defined a Trust & Safety risk taxonomy.
2. Created severity levels and SLA targets.
3. Designed an escalation decision tree.
4. Built a QA checklist.
5. Defined a human-in-the-loop review process.
6. Added responsible AI safeguards.
7. Generated 500 synthetic user reports.
8. Analysed the dataset using SQL.
9. Created exploratory data analysis scripts.
10. Built a simple risk category classifier.
11. Created a deterministic ticket summariser.
12. Designed and generated a dashboard mockup.
13. Developed final recommendations for operational improvement.

## Key Findings

## 1. Structured Taxonomy Makes Triage More Consistent

The risk taxonomy creates a shared language for classifying user reports.

The main risk categories are:

- Account abuse
- Scam or fraud
- Harassment
- Self-harm concern
- Misinformation
- Privacy concern
- Billing safety escalation
- Policy confusion
- Child safety concern
- Platform integrity

This structure helps convert messy free-text reports into consistent operational data.

## 2. Severity Rules Improve Prioritisation

The project uses four severity levels:

| Severity | SLA Target | Meaning |
|---|---:|---|
| Critical | 1 hour | Immediate or severe safety risk |
| High | 4 hours | Clear risk signal requiring specialist review |
| Medium | 24 hours | Plausible risk or unclear evidence |
| Low | 72 hours | Informational or low-risk support issue |

This supports queue prioritisation and helps urgent cases move faster.

## 3. Human Review Is a Safeguard, Not a Bottleneck

The workflow requires human review for:

- High severity tickets
- Critical severity tickets
- child safety concerns
- self-harm concerns
- fraud and scam cases
- privacy exposure cases
- low-confidence model predictions
- ambiguous or multi-risk reports

This ensures AI assists reviewers without replacing human judgement in sensitive decisions.

## 4. Model Confidence Should Drive Review, Not Blind Trust

The classifier and workflow use model confidence as a routing signal.

Low-confidence tickets should be routed to human review. High-confidence predictions can support workflow efficiency, but they should not bypass safeguards for sensitive categories.

This is especially important for Trust & Safety because false negatives can create serious harm.

## 5. Escalation Team Workload Should Be Monitored

The dashboard and SQL analysis show how tickets can be grouped by escalation team.

This helps identify where specialist capacity may be needed, especially for:

- Fraud and Account Integrity
- Trust & Safety Review
- Privacy Review
- Child Safety Escalation
- Policy Review

Operational leaders can use this view to plan staffing, training, and escalation coverage.

## 6. AI-Assisted Summaries Can Improve Reviewer Efficiency

The ticket summariser creates structured reviewer notes including:

- user report summary
- risk rationale
- recommended next step
- SLA note
- human review note

This can reduce reviewer reading time and improve consistency, but summaries should remain decision-support only.

## 7. Dashboards Make Responsible AI Visible

The dashboard mockup makes key operational and responsible AI metrics visible, including:

- total tickets
- High and Critical tickets
- human review requirement
- low-confidence tickets
- model confidence by category
- escalation team workload
- priority review queue

This helps teams monitor both operational performance and AI governance.

## Recommendations

## Recommendation 1: Use the Taxonomy as the Foundation of the Workflow

The taxonomy should be treated as the central organising structure for the triage system.

Recommended actions:

- Use one primary risk category per ticket.
- Use subcategories for more detailed analysis.
- Review taxonomy gaps regularly.
- Add examples for confusing categories.
- Track category-level errors through QA.

Expected impact:

- more consistent classification
- easier SQL analysis
- clearer dashboards
- better training data for future models

## Recommendation 2: Apply Severity Floors for Sensitive Risks

Some categories should have minimum severity rules.

Recommended severity floors:

| Risk Signal | Minimum Severity |
|---|---|
| Child safety concern | Critical |
| Immediate self-harm concern | Critical |
| Fraud or scam | High |
| Account compromise | High |
| Personal data exposure | High |
| Credible threat | High |
| Low-confidence ambiguous harm signal | Medium |

Expected impact:

- fewer under-escalated cases
- stronger safety controls
- clearer reviewer expectations
- faster response for urgent tickets

## Recommendation 3: Keep Human Review Mandatory for High-Impact Cases

AI should support triage, but not make final decisions in sensitive cases.

Human review should remain mandatory for:

- High severity tickets
- Critical severity tickets
- child safety cases
- self-harm concerns
- privacy exposure
- fraud or scam reports
- account compromise
- credible threats
- serious appeals
- low-confidence model predictions

Expected impact:

- safer decision-making
- reduced automation risk
- better accountability
- stronger responsible AI posture

## Recommendation 4: Monitor Model Confidence by Category

Average confidence should be tracked by risk category.

Categories with lower confidence may need:

- more training examples
- clearer taxonomy definitions
- reviewer guidance
- stronger rule-based safeguards
- additional QA sampling

Expected impact:

- better model governance
- improved reviewer trust
- earlier detection of weak categories
- safer use of automation

## Recommendation 5: Build a Priority Review Queue

A practical review queue should sort tickets by:

1. Critical severity
2. High severity
3. Low model confidence
4. Sensitive category
5. Oldest created date

Recommended priority logic:

| Priority | Ticket Type |
|---:|---|
| 1 | Critical severity |
| 2 | High severity |
| 3 | Low-confidence prediction |
| 4 | Medium severity |
| 5 | Low severity |

Expected impact:

- faster urgent review
- better SLA compliance
- clearer reviewer workflow
- reduced risk of missed high-priority cases

## Recommendation 6: Use QA Reviews to Improve the System

QA should not only check individual tickets. It should create feedback for the whole workflow.

QA should monitor:

- category accuracy
- severity accuracy
- escalation accuracy
- SLA correctness
- human review correctness
- model false positives
- model false negatives
- repeat error patterns

Expected impact:

- continuous improvement
- better reviewer consistency
- stronger model evaluation
- clearer operational governance

## Recommendation 7: Make Responsible AI Metrics Visible in Dashboards

The dashboard should include responsible AI indicators, not only workload metrics.

Recommended dashboard metrics:

| Metric | Purpose |
|---|---|
| Human review rate | Shows how much work requires manual judgement |
| Low-confidence tickets | Shows automation uncertainty |
| Average confidence by category | Shows where model performance may vary |
| High/Critical tickets requiring review | Confirms safeguard compliance |
| Sensitive category routing | Confirms correct escalation |
| Human override rate | Shows disagreement between model and reviewer |

Expected impact:

- stronger AI governance
- easier auditability
- better stakeholder trust
- clearer safety controls

## Recommendation 8: Add Future SLA Outcome Fields

The current dataset includes SLA targets but not final resolution timing.

Future versions should add:

- resolved_at
- response_time_hours
- sla_met
- reviewer_decision
- human_override
- qa_score
- qa_outcome
- qa_error_type

Expected impact:

- stronger operational analysis
- better SLA reporting
- more realistic dashboarding
- deeper QA analysis
- stronger portfolio evidence

## Recommendation 9: Expand the Classifier Carefully

The current classifier is a simple TF-IDF and Logistic Regression model. This is appropriate for a transparent portfolio demonstration.

Future improvements could include:

- comparing multiple models
- adding confidence calibration
- reviewing false negatives
- testing on more varied synthetic text
- adding severity prediction
- adding multi-label classification for multi-risk tickets
- creating an error analysis notebook

Expected impact:

- stronger machine learning demonstration
- deeper model evaluation
- better responsible AI discussion
- more realistic Trust & Safety workflow

## Recommendation 10: Position the Project as AI Operations, Not Just Data Science

This project is strongest when presented as an AI operations and Trust & Safety workflow project.

The strongest positioning is:

"This project demonstrates how AI-assisted triage can turn messy user reports into structured risk categories, escalation decisions, QA checks, and responsible human-in-the-loop workflows."

This is more powerful than presenting it only as a classifier.

## Operational Roadmap

## Phase 1: Foundation

Completed in this project:

- risk taxonomy
- severity framework
- escalation decision tree
- QA checklist
- human-in-the-loop process
- responsible AI safeguards
- data dictionary

## Phase 2: Data and Analytics

Completed in this project:

- synthetic dataset generation
- SQL analysis
- exploratory analysis
- summary report generation
- dashboard mockup

## Phase 3: AI Assistance

Completed in this project:

- risk category classifier
- model evaluation
- confusion matrix
- top feature extraction
- AI-assisted ticket summariser
- reviewer summary examples

## Phase 4: Future Improvements

Recommended next steps:

- add simulated resolution timestamps
- add SLA met/missed analysis
- add QA outcomes
- add human override tracking
- create Streamlit dashboard
- create Power BI or Tableau version
- convert scripts into notebooks
- improve README storytelling
- write LinkedIn case study post

## Risk Controls

This project includes the following controls:

| Risk | Control |
|---|---|
| Automation overreach | Mandatory human review for high-risk cases |
| Missed urgent cases | Severity floors and escalation decision tree |
| Low model confidence | Human review threshold below 0.75 |
| Privacy risk | Fully synthetic dataset |
| Unclear accountability | Human-in-the-loop process and reviewer notes |
| Inconsistent review | QA checklist and taxonomy definitions |
| Poor visibility | Dashboard metrics and SQL analysis |
| Model blind spots | Confidence monitoring and confusion matrix |

## Limitations

This project is intentionally limited because it is a public portfolio project.

Limitations include:

- all data is synthetic
- no real user reports are used
- no real production policy is implemented
- no live moderation system is connected
- model confidence values are simulated in the dataset
- the classifier is trained on simplified synthetic text
- real-world Trust & Safety reports would be more complex and ambiguous
- the project does not include legal, regulatory, or production privacy review

These limitations are acceptable for the purpose of demonstrating workflow design, AI operations thinking, and responsible AI awareness.

## Business Value

This project shows how Trust & Safety and AI Operations teams can use structured workflows to:

- reduce inconsistent triage
- prioritise urgent reports
- route cases to the correct team
- monitor human review demand
- make model uncertainty visible
- support reviewer decision-making
- improve QA and governance
- create audit-ready documentation
- build safer AI-assisted operations

## Portfolio Value

This project demonstrates practical skills in:

- Trust & Safety operations
- AI risk triage
- taxonomy design
- escalation workflow design
- SLA mapping
- SQL analysis
- Python data analysis
- machine learning classification
- dashboard planning
- responsible AI safeguards
- human-in-the-loop review
- quality assurance design
- operational reporting
- data storytelling

## Final Conclusion

This project demonstrates a complete AI-assisted Trust & Safety triage workflow from raw user reports to structured classification, escalation, analysis, summarisation, dashboarding, and final recommendations.

The strongest part of the project is the combination of operational thinking and responsible AI design.

Rather than presenting AI as a replacement for human reviewers, the project shows how AI can support safer, faster, and more consistent triage while keeping human judgement central for high-risk and sensitive cases.

This makes the project relevant for roles in:

- Trust & Safety Operations
- AI Operations
- Risk Operations
- Data Analysis
- Responsible AI
- Policy Operations
- Safety Product Operations
- AI Governance
- Technical Program Support
- Operational Analytics
