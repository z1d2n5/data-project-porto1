/*
Question: What are the top-paying data analyst jobs?
- Identify the top 10 highest-paying Data Analyst
 roles that are available remotely
- Focuses on job postings with specified salaries
 (remove nulls)
- BONUS: Include company names of top 10 roles
- Why? Highlight the top-paying opportunities for
 Data Analysts, offering insights into employment 
 options and location flexibility.
*/
-- Question : Quels sont les emplois d'analyste de données les mieux rémunérés ?
-- - Identifier les 10 postes d'analyste de données les mieux rémunérés
--  disponibles à distance.
-- - Se concentrer sur les offres d'emploi avec des salaires spécifiés
--  (supprimer les valeurs nulles).
-- - BONUS : inclure les noms des entreprises des 10 postes les mieux rémunérés.
-- - Pourquoi ? Mettre en avant les opportunités les mieux rémunérées pour les
--  analystes de données, en offrant des informations sur les options d'emploi 
--  et la flexibilité en matière de lieu de travail.


SELECT 
    name AS company_name,
    job_title,
    job_location,
    job_id,
    job_schedule_type,
    job_posted_date,
    salary_year_avg
FROM job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE job_title_short = 'Data Analyst' AND job_location = 'Anywhere' AND salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10;
