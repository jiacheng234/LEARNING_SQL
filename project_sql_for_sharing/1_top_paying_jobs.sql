/* Question: What are the top paying data analyst job? */

SELECT  
    job_id,
    job_title,
    job_location,
    job_country,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
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
