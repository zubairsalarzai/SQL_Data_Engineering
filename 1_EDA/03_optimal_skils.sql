/*
Question: What are the most optimal skills for data engineers—balancing both demand and salary?
- Create a ranking column that combines demand count and median salary to identify the most valuable skills.
- Focus only on remote Data Engineer positions with specified annual salaries.
- Why?
    - This approach highlights skills that balance market demand and financial reward. It weights core skills appropriately instead of letting rare, outlier skills distort the results.
    - The natural log transformation ensures that both high-salary and widely in-demand skills surface as the most practical and valuable to learn for data engineering careers.
*/




SELECT 
    sd.skills,
   ROUND( MEDiaN(jpf.salary_year_avg),0 )AS medain_salary,
    COUNT(jpf.salary_year_avg) AS demand_count
FROM job_postings_fact jpf
INNER JOIN skills_job_dim sjd ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim sd ON sjd.skill_id = sd.skill_id
WHERE
    jpf.job_title_short = 'Data Engineer' 
    AND jpf.job_work_from_home = True 
GROUP BY
    sd.skills
HAVING 
    COUNT(jpf.*)> 100
ORDER BY
    medain_salary DESC
LIMIT 25;