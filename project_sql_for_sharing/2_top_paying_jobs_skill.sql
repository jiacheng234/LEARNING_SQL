/* What skills are required for the top paying data analyst job? */

WITH top_paying_jobs AS (

    SELECT  
        job_id,
        job_title,
        salary_year_avg,
        name as company_name
    FROM 
        job_postings_fact 
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_title_short = 'Data Analyst' AND
        salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)

SELECT 
    top_paying_jobs.*,
    skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY 
    salary_year_avg DESC

/* Observation:

Must-Have Skills: Python, SQL, R, Excel / Tableau / Power BI

Nice-to-Have: Pandas, Scikit-learn, Looker, AWS, BigQuery, Kubernetes

Calculate Upper Quartile Position:

SELECT
  PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY salary_year_avg) AS q3_salary
FROM top_paying_jobs;

Additional: Show each job_id with their required skills (using aggregation)

SELECT 
    top_paying_jobs.job_id,
    top_paying_jobs.job_title,
    top_paying_jobs.salary_year_avg,
    top_paying_jobs.company_name,
    STRING_AGG(skills_dim.skills,', ' ORDER BY skills_dim.skills) AS skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
GROUP BY 
    top_paying_jobs.job_id,
    top_paying_jobs.job_title,
    top_paying_jobs.salary_year_avg,
    top_paying_jobs.company_name
ORDER BY 
    salary_year_avg DESC
*/