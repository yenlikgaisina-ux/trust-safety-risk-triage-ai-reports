"""
Exploratory Data Analysis
Project: AI Trust & Safety Operations Case Study

This script analyses the synthetic Trust & Safety user reports dataset.

It produces:
- data quality checks
- category and severity summaries
- human review analysis
- model confidence analysis
- escalation workload analysis
- simple portfolio-ready charts
- a markdown summary report

Dataset: data/synthetic_user_reports.csv

Outputs:
images/
reports/eda_summary.md
"""

from pathlib import Path

import matplotlib.pyplot as plt
import pandas as pd


# ------------------------------------------------------------
# 1. File paths
# ------------------------------------------------------------

PROJECT_ROOT = Path(__file__).resolve().parents[1]
DATA_PATH = PROJECT_ROOT / "data" / "synthetic_user_reports.csv"
IMAGES_DIR = PROJECT_ROOT / "images"
REPORTS_DIR = PROJECT_ROOT / "reports"
SUMMARY_REPORT_PATH = REPORTS_DIR / "eda_summary.md"

IMAGES_DIR.mkdir(parents=True, exist_ok=True)
REPORTS_DIR.mkdir(parents=True, exist_ok=True)


# ------------------------------------------------------------
# 2. Load data
# ------------------------------------------------------------

def load_data(path: Path) -> pd.DataFrame:
    """Load the synthetic ticket dataset."""
    if not path.exists():
        raise FileNotFoundError(f"Dataset not found at: {path}")

    df = pd.read_csv(path)

    expected_columns = [
        "ticket_id",
        "created_at",
        "user_report",
        "risk_category",
        "subcategory",
        "severity",
        "sla_target_hours",
        "region",
        "channel",
        "language",
        "model_confidence",
        "escalation_team",
        "human_review_required",
        "final_action",
    ]

    missing_columns = [col for col in expected_columns if col not in df.columns]
    if missing_columns:
        raise ValueError(f"Missing expected columns: {missing_columns}")

    df["created_at"] = pd.to_datetime(df["created_at"], errors="coerce")
    df["model_confidence"] = pd.to_numeric(df["model_confidence"], errors="coerce")
    df["sla_target_hours"] = pd.to_numeric(df["sla_target_hours"], errors="coerce")

    # Normalise boolean field in case it is read as string from CSV.
    df["human_review_required"] = df["human_review_required"].astype(str).str.lower().map(
        {"true": True, "false": False}
    )

    return df


df = load_data(DATA_PATH)


# ------------------------------------------------------------
# 3. Data quality checks
# ------------------------------------------------------------

def run_data_quality_checks(data: pd.DataFrame) -> dict:
    """Run simple quality checks on the dataset."""
    checks = {
        "total_rows": len(data),
        "total_columns": len(data.columns),
        "duplicate_ticket_ids": int(data["ticket_id"].duplicated().sum()),
        "missing_ticket_ids": int(data["ticket_id"].isna().sum()),
        "missing_created_at": int(data["created_at"].isna().sum()),
        "missing_user_reports": int(data["user_report"].isna().sum()),
        "missing_risk_categories": int(data["risk_category"].isna().sum()),
        "missing_severity": int(data["severity"].isna().sum()),
        "missing_model_confidence": int(data["model_confidence"].isna().sum()),
        "min_model_confidence": round(float(data["model_confidence"].min()), 3),
        "max_model_confidence": round(float(data["model_confidence"].max()), 3),
    }

    return checks


quality_checks = run_data_quality_checks(df)


# ------------------------------------------------------------
# 4. Summary tables
# ------------------------------------------------------------

def percentage_table(data: pd.DataFrame, column: str) -> pd.DataFrame:
    """Create a count and percentage table for a categorical column."""
    output = (
        data[column]
        .value_counts(dropna=False)
        .rename_axis(column)
        .reset_index(name="ticket_count")
    )
    output["percentage_of_total"] = round(output["ticket_count"] / len(data) * 100, 2)
    return output


risk_category_summary = percentage_table(df, "risk_category")
severity_summary = percentage_table(df, "severity")
escalation_team_summary = percentage_table(df, "escalation_team")
final_action_summary = percentage_table(df, "final_action")
channel_summary = percentage_table(df, "channel")
region_summary = percentage_table(df, "region")

human_review_summary = (
    df["human_review_required"]
    .value_counts(dropna=False)
    .rename_axis("human_review_required")
    .reset_index(name="ticket_count")
)
human_review_summary["percentage_of_total"] = round(
    human_review_summary["ticket_count"] / len(df) * 100, 2
)

confidence_by_category = (
    df.groupby("risk_category")
    .agg(
        ticket_count=("ticket_id", "count"),
        avg_model_confidence=("model_confidence", "mean"),
        min_model_confidence=("model_confidence", "min"),
        max_model_confidence=("model_confidence", "max"),
    )
    .reset_index()
    .sort_values("avg_model_confidence")
)

confidence_by_category["avg_model_confidence"] = confidence_by_category[
    "avg_model_confidence"
].round(3)
confidence_by_category["min_model_confidence"] = confidence_by_category[
    "min_model_confidence"
].round(3)
confidence_by_category["max_model_confidence"] = confidence_by_category[
    "max_model_confidence"
].round(3)

human_review_by_category = (
    df.groupby("risk_category")
    .agg(
        total_tickets=("ticket_id", "count"),
        human_review_tickets=("human_review_required", "sum"),
    )
    .reset_index()
)
human_review_by_category["human_review_rate_percentage"] = round(
    human_review_by_category["human_review_tickets"]
    / human_review_by_category["total_tickets"]
    * 100,
    2,
)
human_review_by_category = human_review_by_category.sort_values(
    "human_review_rate_percentage", ascending=False
)

severity_by_category = pd.crosstab(df["risk_category"], df["severity"])


# ------------------------------------------------------------
# 5. Executive metrics
# ------------------------------------------------------------

total_tickets = len(df)
critical_tickets = int((df["severity"] == "Critical").sum())
high_tickets = int((df["severity"] == "High").sum())
urgent_tickets = int(df["severity"].isin(["Critical", "High"]).sum())
human_review_tickets = int(df["human_review_required"].sum())
low_confidence_tickets = int((df["model_confidence"] < 0.75).sum())
avg_model_confidence = round(float(df["model_confidence"].mean()), 3)

human_review_percentage = round(human_review_tickets / total_tickets * 100, 2)
urgent_percentage = round(urgent_tickets / total_tickets * 100, 2)
low_confidence_percentage = round(low_confidence_tickets / total_tickets * 100, 2)


# ------------------------------------------------------------
# 6. Chart helper
# ------------------------------------------------------------

def save_bar_chart(
    data: pd.DataFrame,
    x_col: str,
    y_col: str,
    title: str,
    xlabel: str,
    ylabel: str,
    output_filename: str,
    horizontal: bool = False,
) -> None:
    """Save a simple bar chart."""
    plt.figure(figsize=(10, 6))

    if horizontal:
        plt.barh(data[x_col], data[y_col])
        plt.xlabel(ylabel)
        plt.ylabel(xlabel)
        plt.gca().invert_yaxis()
    else:
        plt.bar(data[x_col], data[y_col])
        plt.xlabel(xlabel)
        plt.ylabel(ylabel)
        plt.xticks(rotation=45, ha="right")

    plt.title(title)
    plt.tight_layout()
    plt.savefig(IMAGES_DIR / output_filename, dpi=300)
    plt.close()


# ------------------------------------------------------------
# 7. Create charts
# ------------------------------------------------------------

save_bar_chart(
    data=risk_category_summary,
    x_col="risk_category",
    y_col="ticket_count",
    title="Tickets by Risk Category",
    xlabel="Risk Category",
    ylabel="Ticket Count",
    output_filename="tickets_by_risk_category.png",
    horizontal=True,
)

severity_order = ["Critical", "High", "Medium", "Low"]
severity_chart_data = (
    severity_summary.set_index("severity")
    .reindex(severity_order)
    .dropna()
    .reset_index()
)

save_bar_chart(
    data=severity_chart_data,
    x_col="severity",
    y_col="ticket_count",
    title="Tickets by Severity",
    xlabel="Severity",
    ylabel="Ticket Count",
    output_filename="tickets_by_severity.png",
)

save_bar_chart(
    data=escalation_team_summary,
    x_col="escalation_team",
    y_col="ticket_count",
    title="Escalation Team Workload",
    xlabel="Escalation Team",
    ylabel="Ticket Count",
    output_filename="escalation_team_workload.png",
    horizontal=True,
)

save_bar_chart(
    data=confidence_by_category,
    x_col="risk_category",
    y_col="avg_model_confidence",
    title="Average Model Confidence by Risk Category",
    xlabel="Risk Category",
    ylabel="Average Model Confidence",
    output_filename="avg_model_confidence_by_category.png",
    horizontal=True,
)

save_bar_chart(
    data=human_review_by_category,
    x_col="risk_category",
    y_col="human_review_rate_percentage",
    title="Human Review Rate by Risk Category",
    xlabel="Risk Category",
    ylabel="Human Review Rate (%)",
    output_filename="human_review_rate_by_category.png",
    horizontal=True,
)

save_bar_chart(
    data=final_action_summary,
    x_col="final_action",
    y_col="ticket_count",
    title="Final Action Distribution",
    xlabel="Final Action",
    ylabel="Ticket Count",
    output_filename="final_action_distribution.png",
    horizontal=True,
)


# ------------------------------------------------------------
# 8. Priority queue sample
# ------------------------------------------------------------

priority_queue = df.copy()

priority_queue["priority_rank"] = priority_queue.apply(
    lambda row: 1
    if row["severity"] == "Critical"
    else 2
    if row["severity"] == "High"
    else 3
    if row["model_confidence"] < 0.75
    else 4
    if row["severity"] == "Medium"
    else 5,
    axis=1,
)

priority_queue = priority_queue.sort_values(
    by=["priority_rank", "model_confidence", "created_at"],
    ascending=[True, True, True],
)

priority_sample = priority_queue[
    [
        "ticket_id",
        "created_at",
        "risk_category",
        "subcategory",
        "severity",
        "sla_target_hours",
        "model_confidence",
        "escalation_team",
        "human_review_required",
        "final_action",
        "user_report",
    ]
].head(20)


# ------------------------------------------------------------
# 9. Write markdown report
# ------------------------------------------------------------

def dataframe_to_markdown(data: pd.DataFrame) -> str:
    """Convert a DataFrame to markdown without the index."""
    return data.to_markdown(index=False)


summary_report = f"""# Exploratory Data Analysis Summary

## Project Context

This report is part of the portfolio project:

**AI Trust & Safety Operations Case Study: Risk Triage, Taxonomy Design and Escalation Workflow**

The dataset contains 500 fully synthetic user reports. No real users, accounts, platforms, companies, or incidents are included.

## Executive Summary

| Metric | Value |
|---|---:|
| Total tickets | {total_tickets} |
| Critical tickets | {critical_tickets} |
| High tickets | {high_tickets} |
| High or Critical tickets | {urgent_tickets} |
| High or Critical percentage | {urgent_percentage}% |
| Tickets requiring human review | {human_review_tickets} |
| Human review percentage | {human_review_percentage}% |
| Low-confidence tickets | {low_confidence_tickets} |
| Low-confidence percentage | {low_confidence_percentage}% |
| Average model confidence | {avg_model_confidence} |

## Data Quality Checks

| Check | Result |
|---|---:|
| Total rows | {quality_checks["total_rows"]} |
| Total columns | {quality_checks["total_columns"]} |
| Duplicate ticket IDs | {quality_checks["duplicate_ticket_ids"]} |
| Missing ticket IDs | {quality_checks["missing_ticket_ids"]} |
| Missing created_at values | {quality_checks["missing_created_at"]} |
| Missing user reports | {quality_checks["missing_user_reports"]} |
| Missing risk categories | {quality_checks["missing_risk_categories"]} |
| Missing severity values | {quality_checks["missing_severity"]} |
| Missing model confidence values | {quality_checks["missing_model_confidence"]} |
| Minimum model confidence | {quality_checks["min_model_confidence"]} |
| Maximum model confidence | {quality_checks["max_model_confidence"]} |

## Tickets by Risk Category

{dataframe_to_markdown(risk_category_summary)}

## Tickets by Severity

{dataframe_to_markdown(severity_summary)}

## Human Review Requirement

{dataframe_to_markdown(human_review_summary)}

## Human Review Rate by Risk Category

{dataframe_to_markdown(human_review_by_category)}

## Average Model Confidence by Risk Category

{dataframe_to_markdown(confidence_by_category)}

## Escalation Team Workload

{dataframe_to_markdown(escalation_team_summary)}

## Final Action Distribution

{dataframe_to_markdown(final_action_summary)}

## Channel Distribution

{dataframe_to_markdown(channel_summary)}

## Region Distribution

{dataframe_to_markdown(region_summary)}

## Severity by Risk Category

{severity_by_category.to_markdown()}

## Priority Review Queue Sample

The table below shows the first 20 tickets in a simple priority queue. Critical tickets appear first, followed by High severity tickets and low-confidence cases.

{dataframe_to_markdown(priority_sample)}

## Chart Outputs

The script creates the following chart files in the images/ folder:

| Chart | File |
|---|---|
| Tickets by risk category | images/tickets_by_risk_category.png |
| Tickets by severity | images/tickets_by_severity.png |
| Escalation team workload | images/escalation_team_workload.png |
| Average model confidence by category | images/avg_model_confidence_by_category.png |
| Human review rate by category | images/human_review_rate_by_category.png |
| Final action distribution | images/final_action_distribution.png |

## Key Observations

1. The dataset supports analysis across risk category, severity, escalation team, model confidence, human review requirement, and final action.
2. High and Critical tickets represent the most urgent operational workload.
3. Human review demand is driven by severity, sensitive categories, and model confidence thresholds.
4. Low-confidence predictions are useful for identifying tickets that should not be handled through automation alone.
5. Escalation team workload helps identify where specialist review capacity may be required.
6. The dataset is suitable for SQL analysis, dashboard design, and a basic text classification model.

## Responsible AI Notes

This project uses synthetic data only. The model confidence scores are simulated and should be interpreted as workflow signals, not real production model outputs.

The analysis supports a human-in-the-loop approach where AI can assist with triage, but human review is required for sensitive, high-risk, ambiguous, or low-confidence cases.
"""

SUMMARY_REPORT_PATH.write_text(summary_report, encoding="utf-8")


# ------------------------------------------------------------
# 10. Print useful outputs
# ------------------------------------------------------------

print("EDA complete.")
print(f"Rows analysed: {total_tickets}")
print(f"Charts saved to: {IMAGES_DIR}")
print(f"Summary report saved to: {SUMMARY_REPORT_PATH}")

print("\nExecutive metrics:")
print(f"- Critical tickets: {critical_tickets}")
print(f"- High tickets: {high_tickets}")
print(f"- High or Critical tickets: {urgent_tickets} ({urgent_percentage}%)")
print(f"- Human review required: {human_review_tickets} ({human_review_percentage}%)")
print(f"- Low-confidence tickets: {low_confidence_tickets} ({low_confidence_percentage}%)")
print(f"- Average model confidence: {avg_model_confidence}")
