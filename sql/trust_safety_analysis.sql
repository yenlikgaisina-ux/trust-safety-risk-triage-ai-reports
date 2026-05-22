-- Trust & Safety Risk Triage SQL Analysis
-- Project: AI Trust & Safety Operations Case Study
-- Dataset: data/synthetic_user_reports.csv
--
-- Purpose:
-- This SQL file analyses 500 fully synthetic user reports to identify
-- risk distribution, severity patterns, escalation workload, human review
-- demand, model confidence issues, and SLA priorities.
--
-- Recommended engine:
-- DuckDB, SQLite, PostgreSQL, or any SQL environment after importing the CSV.
--
-- If using DuckDB, you can create a table directly from the CSV:
--
-- CREATE TABLE synthetic_user_reports AS
-- SELECT *
-- FROM read_csv_auto('data/synthetic_user_reports.csv');


-- ============================================================
-- 1. BASIC DATA QUALITY CHECKS
-- ============================================================

-- 1.1 Total number of records
SELECT
    COUNT(*) AS total_tickets
FROM synthetic_user_reports;


-- 1.2 Check for duplicate ticket IDs
SELECT
    ticket_id,
    COUNT(*) AS duplicate_count
FROM synthetic_user_reports
GROUP BY ticket_id
HAVING COUNT(*) > 1;


-- 1.3 Check for missing values in required fields
SELECT
    SUM(CASE WHEN ticket_id IS NULL OR ticket_id = '' THEN 1 ELSE 0 END) AS missing_ticket_id,
    SUM(CASE WHEN created_at IS NULL OR created_at = '' THEN 1 ELSE 0 END) AS missing_created_at,
    SUM(CASE WHEN user_report IS NULL OR user_report = '' THEN 1 ELSE 0 END) AS missing_user_report,
    SUM(CASE WHEN risk_category IS NULL OR risk_category = '' THEN 1 ELSE 0 END) AS missing_risk_category,
    SUM(CASE WHEN severity IS NULL OR severity = '' THEN 1 ELSE 0 END) AS missing_severity,
    SUM(CASE WHEN escalation_team IS NULL OR escalation_team = '' THEN 1 ELSE 0 END) AS missing_escalation_team
FROM synthetic_user_reports;


-- 1.4 Check that SLA targets match severity levels
SELECT
    severity,
    sla_target_hours,
    COUNT(*) AS ticket_count
FROM synthetic_user_reports
GROUP BY severity, sla_target_hours
ORDER BY severity, sla_target_hours;


-- ============================================================
-- 2. RISK CATEGORY ANALYSIS
-- ============================================================

-- 2.1 Ticket volume by risk category
SELECT
    risk_category,
    COUNT(*) AS ticket_count,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS percentage_of_total
FROM synthetic_user_reports
GROUP BY risk_category
ORDER BY ticket_count DESC;


-- 2.2 Ticket volume by subcategory
SELECT
    risk_category,
    subcategory,
    COUNT(*) AS ticket_count
FROM synthetic_user_reports
GROUP BY risk_category, subcategory
ORDER BY risk_category, ticket_count DESC;


-- 2.3 Top 10 most common subcategories
SELECT
    subcategory,
    risk_category,
    COUNT(*) AS ticket_count
FROM synthetic_user_reports
GROUP BY subcategory, risk_category
ORDER BY ticket_count DESC
LIMIT 10;


-- ============================================================
-- 3. SEVERITY ANALYSIS
-- ============================================================

-- 3.1 Ticket volume by severity
SELECT
    severity,
    COUNT(*) AS ticket_count,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS percentage_of_total
FROM synthetic_user_reports
GROUP BY severity
ORDER BY
    CASE severity
        WHEN 'Critical' THEN 1
        WHEN 'High' THEN 2
        WHEN 'Medium' THEN 3
        WHEN 'Low' THEN 4
        ELSE 5
    END;


-- 3.2 Severity distribution by risk category
SELECT
    risk_category,
    SUM(CASE WHEN severity = 'Critical' THEN 1 ELSE 0 END) AS critical_tickets,
    SUM(CASE WHEN severity = 'High' THEN 1 ELSE 0 END) AS high_tickets,
    SUM(CASE WHEN severity = 'Medium' THEN 1 ELSE 0 END) AS medium_tickets,
    SUM(CASE WHEN severity = 'Low' THEN 1 ELSE 0 END) AS low_tickets,
    COUNT(*) AS total_tickets
FROM synthetic_user_reports
GROUP BY risk_category
ORDER BY critical_tickets DESC, high_tickets DESC, total_tickets DESC;


-- 3.3 High and Critical tickets requiring urgent attention
SELECT
    ticket_id,
    created_at,
    risk_category,
    subcategory,
    severity,
    sla_target_hours,
    escalation_team,
    model_confidence,
    human_review_required,
    final_action,
    user_report
FROM synthetic_user_reports
WHERE severity IN ('High', 'Critical')
ORDER BY
    CASE severity
        WHEN 'Critical' THEN 1
        WHEN 'High' THEN 2
        ELSE 3
    END,
    created_at;


-- ============================================================
-- 4. HUMAN REVIEW ANALYSIS
-- ============================================================

-- 4.1 Overall human review requirement
SELECT
    human_review_required,
    COUNT(*) AS ticket_count,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS percentage_of_total
FROM synthetic_user_reports
GROUP BY human_review_required
ORDER BY ticket_count DESC;


-- 4.2 Human review rate by risk category
SELECT
    risk_category,
    COUNT(*) AS total_tickets,
    SUM(CASE WHEN human_review_required = 'True' THEN 1 ELSE 0 END) AS human_review_tickets,
    ROUND(
        100.0 * SUM(CASE WHEN human_review_required = 'True' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS human_review_rate_percentage
FROM synthetic_user_reports
GROUP BY risk_category
ORDER BY human_review_rate_percentage DESC, total_tickets DESC;


-- 4.3 Human review rate by severity
SELECT
    severity,
    COUNT(*) AS total_tickets,
    SUM(CASE WHEN human_review_required = 'True' THEN 1 ELSE 0 END) AS human_review_tickets,
    ROUND(
        100.0 * SUM(CASE WHEN human_review_required = 'True' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS human_review_rate_percentage
FROM synthetic_user_reports
GROUP BY severity
ORDER BY
    CASE severity
        WHEN 'Critical' THEN 1
        WHEN 'High' THEN 2
        WHEN 'Medium' THEN 3
        WHEN 'Low' THEN 4
        ELSE 5
    END;


-- ============================================================
-- 5. MODEL CONFIDENCE ANALYSIS
-- ============================================================

-- 5.1 Average model confidence by risk category
SELECT
    risk_category,
    COUNT(*) AS ticket_count,
    ROUND(AVG(model_confidence), 3) AS avg_model_confidence,
    ROUND(MIN(model_confidence), 3) AS min_model_confidence,
    ROUND(MAX(model_confidence), 3) AS max_model_confidence
FROM synthetic_user_reports
GROUP BY risk_category
ORDER BY avg_model_confidence ASC;


-- 5.2 Average model confidence by severity
SELECT
    severity,
    COUNT(*) AS ticket_count,
    ROUND(AVG(model_confidence), 3) AS avg_model_confidence,
    ROUND(MIN(model_confidence), 3) AS min_model_confidence,
    ROUND(MAX(model_confidence), 3) AS max_model_confidence
FROM synthetic_user_reports
GROUP BY severity
ORDER BY
    CASE severity
        WHEN 'Critical' THEN 1
        WHEN 'High' THEN 2
        WHEN 'Medium' THEN 3
        WHEN 'Low' THEN 4
        ELSE 5
    END;


-- 5.3 Low-confidence tickets requiring human review
SELECT
    ticket_id,
    created_at,
    risk_category,
    subcategory,
    severity,
    model_confidence,
    escalation_team,
    human_review_required,
    user_report
FROM synthetic_user_reports
WHERE model_confidence < 0.75
ORDER BY model_confidence ASC, severity;


-- 5.4 Low-confidence rate by risk category
SELECT
    risk_category,
    COUNT(*) AS total_tickets,
    SUM(CASE WHEN model_confidence < 0.75 THEN 1 ELSE 0 END) AS low_confidence_tickets,
    ROUND(
        100.0 * SUM(CASE WHEN model_confidence < 0.75 THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS low_confidence_rate_percentage
FROM synthetic_user_reports
GROUP BY risk_category
ORDER BY low_confidence_rate_percentage DESC, total_tickets DESC;


-- ============================================================
-- 6. ESCALATION TEAM WORKLOAD
-- ============================================================

-- 6.1 Ticket workload by escalation team
SELECT
    escalation_team,
    COUNT(*) AS ticket_count,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS percentage_of_total
FROM synthetic_user_reports
GROUP BY escalation_team
ORDER BY ticket_count DESC;


-- 6.2 Escalation team workload by severity
SELECT
    escalation_team,
    SUM(CASE WHEN severity = 'Critical' THEN 1 ELSE 0 END) AS critical_tickets,
    SUM(CASE WHEN severity = 'High' THEN 1 ELSE 0 END) AS high_tickets,
    SUM(CASE WHEN severity = 'Medium' THEN 1 ELSE 0 END) AS medium_tickets,
    SUM(CASE WHEN severity = 'Low' THEN 1 ELSE 0 END) AS low_tickets,
    COUNT(*) AS total_tickets
FROM synthetic_user_reports
GROUP BY escalation_team
ORDER BY critical_tickets DESC, high_tickets DESC, total_tickets DESC;


-- 6.3 Teams with the highest urgent workload
SELECT
    escalation_team,
    COUNT(*) AS urgent_ticket_count
FROM synthetic_user_reports
WHERE severity IN ('High', 'Critical')
GROUP BY escalation_team
ORDER BY urgent_ticket_count DESC;


-- ============================================================
-- 7. SLA ANALYSIS
-- ============================================================

-- 7.1 SLA target distribution
SELECT
    sla_target_hours,
    COUNT(*) AS ticket_count,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS percentage_of_total
FROM synthetic_user_reports
GROUP BY sla_target_hours
ORDER BY sla_target_hours ASC;


-- 7.2 Average SLA target by risk category
SELECT
    risk_category,
    COUNT(*) AS ticket_count,
    ROUND(AVG(sla_target_hours), 2) AS avg_sla_target_hours,
    MIN(sla_target_hours) AS shortest_sla_hours,
    MAX(sla_target_hours) AS longest_sla_hours
FROM synthetic_user_reports
GROUP BY risk_category
ORDER BY avg_sla_target_hours ASC;


-- 7.3 Tickets with the shortest SLA targets
SELECT
    ticket_id,
    created_at,
    risk_category,
    subcategory,
    severity,
    sla_target_hours,
    escalation_team,
    user_report
FROM synthetic_user_reports
WHERE sla_target_hours IN (1, 4)
ORDER BY sla_target_hours ASC, created_at ASC;


-- ============================================================
-- 8. CHANNEL AND REGION ANALYSIS
-- ============================================================

-- 8.1 Ticket volume by intake channel
SELECT
    channel,
    COUNT(*) AS ticket_count,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS percentage_of_total
FROM synthetic_user_reports
GROUP BY channel
ORDER BY ticket_count DESC;


-- 8.2 High and Critical tickets by channel
SELECT
    channel,
    COUNT(*) AS urgent_ticket_count
FROM synthetic_user_reports
WHERE severity IN ('High', 'Critical')
GROUP BY channel
ORDER BY urgent_ticket_count DESC;


-- 8.3 Ticket volume by region
SELECT
    region,
    COUNT(*) AS ticket_count,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS percentage_of_total
FROM synthetic_user_reports
GROUP BY region
ORDER BY ticket_count DESC;


-- 8.4 High and Critical tickets by region
SELECT
    region,
    COUNT(*) AS urgent_ticket_count
FROM synthetic_user_reports
WHERE severity IN ('High', 'Critical')
GROUP BY region
ORDER BY urgent_ticket_count DESC;


-- ============================================================
-- 9. FINAL ACTION ANALYSIS
-- ============================================================

-- 9.1 Final action distribution
SELECT
    final_action,
    COUNT(*) AS ticket_count,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS percentage_of_total
FROM synthetic_user_reports
GROUP BY final_action
ORDER BY ticket_count DESC;


-- 9.2 Final action by severity
SELECT
    final_action,
    SUM(CASE WHEN severity = 'Critical' THEN 1 ELSE 0 END) AS critical_tickets,
    SUM(CASE WHEN severity = 'High' THEN 1 ELSE 0 END) AS high_tickets,
    SUM(CASE WHEN severity = 'Medium' THEN 1 ELSE 0 END) AS medium_tickets,
    SUM(CASE WHEN severity = 'Low' THEN 1 ELSE 0 END) AS low_tickets,
    COUNT(*) AS total_tickets
FROM synthetic_user_reports
GROUP BY final_action
ORDER BY critical_tickets DESC, high_tickets DESC, total_tickets DESC;


-- ============================================================
-- 10. PRIORITY REVIEW QUEUE
-- ============================================================

-- 10.1 Build an ordered priority queue for operational review
SELECT
    ticket_id,
    created_at,
    risk_category,
    subcategory,
    severity,
    sla_target_hours,
    model_confidence,
    escalation_team,
    human_review_required,
    final_action,
    user_report,
    CASE
        WHEN severity = 'Critical' THEN 1
        WHEN severity = 'High' THEN 2
        WHEN model_confidence < 0.75 THEN 3
        WHEN severity = 'Medium' THEN 4
        ELSE 5
    END AS priority_rank
FROM synthetic_user_reports
ORDER BY
    priority_rank ASC,
    model_confidence ASC,
    created_at ASC;


-- 10.2 Tickets most likely to need careful human judgement
SELECT
    ticket_id,
    risk_category,
    subcategory,
    severity,
    model_confidence,
    escalation_team,
    human_review_required,
    user_report
FROM synthetic_user_reports
WHERE
    severity IN ('High', 'Critical')
    OR model_confidence < 0.75
    OR risk_category IN (
        'Child safety concern',
        'Self-harm concern',
        'Privacy concern',
        'Scam or fraud',
        'Billing safety escalation'
    )
ORDER BY
    CASE severity
        WHEN 'Critical' THEN 1
        WHEN 'High' THEN 2
        WHEN 'Medium' THEN 3
        WHEN 'Low' THEN 4
        ELSE 5
    END,
    model_confidence ASC;


-- ============================================================
-- 11. RESPONSIBLE AI SAFEGUARD CHECKS
-- ============================================================

-- 11.1 Check whether all High and Critical tickets require human review
SELECT
    severity,
    human_review_required,
    COUNT(*) AS ticket_count
FROM synthetic_user_reports
WHERE severity IN ('High', 'Critical')
GROUP BY severity, human_review_required
ORDER BY severity, human_review_required;


-- 11.2 Check whether low-confidence tickets require human review
SELECT
    human_review_required,
    COUNT(*) AS low_confidence_ticket_count
FROM synthetic_user_reports
WHERE model_confidence < 0.75
GROUP BY human_review_required;


-- 11.3 Check whether sensitive categories require human review
SELECT
    risk_category,
    human_review_required,
    COUNT(*) AS ticket_count
FROM synthetic_user_reports
WHERE risk_category IN (
    'Child safety concern',
    'Self-harm concern',
    'Privacy concern',
    'Scam or fraud',
    'Billing safety escalation'
)
GROUP BY risk_category, human_review_required
ORDER BY risk_category, human_review_required;


-- ============================================================
-- 12. EXECUTIVE SUMMARY OUTPUTS
-- ============================================================

-- 12.1 Executive summary metrics
SELECT
    COUNT(*) AS total_tickets,
    SUM(CASE WHEN severity = 'Critical' THEN 1 ELSE 0 END) AS critical_tickets,
    SUM(CASE WHEN severity = 'High' THEN 1 ELSE 0 END) AS high_tickets,
    SUM(CASE WHEN human_review_required = 'True' THEN 1 ELSE 0 END) AS human_review_required_tickets,
    ROUND(
        100.0 * SUM(CASE WHEN human_review_required = 'True' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS human_review_required_percentage,
    ROUND(AVG(model_confidence), 3) AS average_model_confidence,
    SUM(CASE WHEN model_confidence < 0.75 THEN 1 ELSE 0 END) AS low_confidence_tickets
FROM synthetic_user_reports;


-- 12.2 Main operational risk areas
SELECT
    risk_category,
    COUNT(*) AS total_tickets,
    SUM(CASE WHEN severity IN ('High', 'Critical') THEN 1 ELSE 0 END) AS urgent_tickets,
    SUM(CASE WHEN human_review_required = 'True' THEN 1 ELSE 0 END) AS human_review_tickets,
    ROUND(AVG(model_confidence), 3) AS avg_model_confidence
FROM synthetic_user_reports
GROUP BY risk_category
ORDER BY urgent_tickets DESC, human_review_tickets DESC, total_tickets DESC;


-- 12.3 Suggested QA sample
SELECT
    ticket_id,
    risk_category,
    subcategory,
    severity,
    model_confidence,
    escalation_team,
    final_action,
    user_report
FROM synthetic_user_reports
WHERE
    severity IN ('Critical', 'High')
    OR model_confidence < 0.75
ORDER BY
    CASE severity
        WHEN 'Critical' THEN 1
        WHEN 'High' THEN 2
        WHEN 'Medium' THEN 3
        WHEN 'Low' THEN 4
        ELSE 5
    END,
    model_confidence ASC
LIMIT 50;
