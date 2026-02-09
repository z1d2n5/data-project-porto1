# Introduction
📊 Plongez dans le marché de l'emploi dans le domaine des données ! Axé sur les postes d'analyste de données, ce projet explore 💰 les emplois les mieux rémunérés, 🔥 les compétences les plus recherchées et 📈 les domaines où la forte demande s'accompagne de salaires élevés dans le domaine de l'analyse de données.

🔍 Requêtes SQL ? Découvrez-les ici :[project_sql folder](/project_sql/)  

# Background
Motivé par la volonté de mieux comprendre le marché du travail des analystes de données, ce projet est né du désir d'identifier les compétences les mieux rémunérées et les plus recherchées, afin d'aider les autres à trouver l'emploi idéal.

### Les questions auxquelles je souhaitais répondre à travers mes requêtes SQL étaient les suivantes :

1. Quels sont les emplois d'analyste de données les mieux rémunérés ?
2. Quelles sont les compétences requises pour ces emplois très bien rémunérés ?
3. Quelles sont les compétences les plus recherchées chez les analystes de données ?
4. Quelles sont les compétences associées à des salaires plus élevés ?
5. Quelles sont les compétences les plus utiles à acquérir ?

# Outils que j'ai utilisés

Pour approfondir mes recherches sur le marché de l'emploi des analystes de données, j'ai exploité la puissance de plusieurs outils clés :

- **SQL :** la colonne vertébrale de mon analyse, qui m'a permis d'interroger la base de données et de mettre au jour des informations cruciales.
- **PostgreSQL :** le système de gestion de base de données choisi, idéal pour traiter les données relatives aux offres d'emploi.
- **Visual Studio Code :** mon outil de prédilection pour la gestion de bases de données et l'exécution de requêtes SQL.
- **Git & GitHub :** essentiels pour le contrôle des versions et le partage de mes scripts SQL et de mes analyses, garantissant la collaboration et le suivi des projets.

# L'analyse
Chaque requête de ce projet visait à examiner des aspects spécifiques du marché de l'emploi des analystes de données. Voici comment j'ai abordé chaque question :

### 1. Les emplois d'analyste de données les mieux rémunérés
Pour identifier les postes les mieux rémunérés, j'ai filtré les postes d'analyste de données en fonction du salaire annuel moyen et du lieu, en me concentrant sur les emplois à distance. Cette requête met en évidence les opportunités les mieux rémunérées dans ce domaine.


```sql
SELECT	
	job_id,
	job_title,
	job_location,
	job_schedule_type,
	salary_year_avg,
	job_posted_date,
    name AS company_name
FROM
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst' AND 
    job_location = 'Anywhere' AND 
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;
```
Voici le classement des meilleurs emplois d'analyste de données en 2023 :
- **Large fourchette salariale :** les 10 postes d'analyste de données les mieux rémunérés vont de 184 000 à 650 000 dollars, ce qui indique un potentiel salarial important dans ce domaine.
- **Diversité des employeurs :** des entreprises telles que SmartAsset, Meta et AT&T font partie de celles qui offrent des salaires élevés, ce qui témoigne d'un intérêt marqué dans différents secteurs.
- **Variété des intitulés de poste :** les intitulés de poste sont très variés, allant d'analyste de données à directeur de l'analyse, ce qui reflète la diversité des rôles et des spécialisations dans le domaine de l'analyse de données.

![Postes les mieux rémunérés](assets/1_top_paying_roles.png)
*Graphique à barres illustrant les 10 salaires les plus élevés pour les analystes de données ; ChatGPT a généré ce graphique à partir des résultats de ma requête SQL*


### 2. Compétences requises pour les emplois les mieux rémunérés
Afin de comprendre quelles sont les compétences requises pour les emplois les mieux rémunérés, j'ai croisé les offres d'emploi avec les données relatives aux compétences, ce qui m'a permis de mieux comprendre ce que les employeurs recherchent pour les postes hautement rémunérés.
 ```sql
WITH top_paying_jobs AS (
    SELECT	
        job_id,
        job_title,
        salary_year_avg,
        name AS company_name
    FROM
        job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_title_short = 'Data Analyst' AND 
        job_location = 'Anywhere' AND 
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
    salary_year_avg DESC;
```
Voici le classement des compétences les plus recherchées pour les 10 emplois d'analyste de données les mieux rémunérés en 2023 :
- **SQL** arrive en tête avec un score impressionnant de 8.
- **Python** suit de près avec un score de 7.
- **Tableau** est également très recherché, avec un score impressionnant de 6.
D'autres compétences telles que **R**, **Snowflake**, **Pandas** et **Excel** affichent des niveaux de demande variables.

![Compétences les mieux rémunérées](assets/2_top_paying_roles_skills.png)
*Graphique à barres visualisant le nombre de compétences pour les 10 emplois les mieux rémunérés pour les analystes de données ; ChatGPT a généré ce graphique à partir des résultats de ma requête SQL*

### 3. Compétences recherchées pour les analystes de données

Cette requête a permis d'identifier les compétences les plus fréquemment demandées dans les offres d'emploi, en mettant l'accent sur les domaines à forte demande.

```sql
SELECT 
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' 
    AND job_work_from_home = True 
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT 5;
```
Voici le détail des compétences les plus demandées pour les analystes de données en 2023
- **SQL** et **Excel** restent fondamentaux, soulignant la nécessité de solides compétences de base en matière de traitement des données et de manipulation de feuilles de calcul.
- La **programmation** et les **outils de visualisation** tels que **Python**, **Tableau** et **Power BI** sont essentiels, ce qui souligne l'importance croissante des compétences techniques dans la narration de données et l'aide à la décision.


| Skills   | Demand Count |
|----------|--------------|
| SQL      | 7291         |
| Excel    | 4611         |
| Python   | 4330         |
| Tableau  | 3745         |
| Power BI | 2609         |

*Tableau des 5 compétences les plus recherchées dans les offres d'emploi d'analyste de données*

### 4. Compétences en fonction du salaire
L'analyse des salaires moyens associés aux différentes compétences a permis de déterminer quelles sont celles qui sont les mieux rémunérées.

```sql
SELECT 
    skills,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = True 
GROUP BY
    skills
ORDER BY
    avg_salary DESC
LIMIT 25;
```
Voici une analyse des résultats concernant les compétences les mieux rémunérées pour les analystes de données :
- **Forte demande en compétences en matière de mégadonnées et d'apprentissage automatique :** les salaires les plus élevés sont ceux des analystes compétents en technologies de mégadonnées (PySpark, Couchbase), en outils d'apprentissage automatique (DataRobot, Jupyter) et en bibliothèques Python (Pandas, NumPy), ce qui reflète la grande importance accordée par le secteur aux capacités de traitement des données et de modélisation prédictive.
- **Compétences en développement et déploiement de logiciels :** la connaissance des outils de développement et de déploiement (GitLab, Kubernetes, Airflow) indique un croisement lucratif entre l'analyse de données et l'ingénierie, avec une prime accordée aux compétences qui facilitent l'automatisation et la gestion efficace des pipelines de données.
- **Expertise en cloud computing :** la maîtrise des outils d'ingénierie cloud et de données (Elasticsearch, Databricks, GCP) souligne l'importance croissante des environnements d'analyse basés sur le cloud, ce qui suggère que la maîtrise du cloud augmente considérablement le potentiel de revenus dans le domaine de l'analyse de données.


| Skills        | Average Salary ($) |
|---------------|-------------------:|
| pyspark       |            208,172 |
| bitbucket     |            189,155 |
| couchbase     |            160,515 |
| watson        |            160,515 |
| datarobot     |            155,486 |
| gitlab        |            154,500 |
| swift         |            153,750 |
| jupyter       |            152,777 |
| pandas        |            151,821 |
| elasticsearch |            145,000 |
*Tableau des salaires moyens pour les 10 compétences les mieux rémunérées chez les analystes de données*

### 5. Compétences les plus intéressantes à acquérir

En combinant les informations issues des données sur la demande et les salaires, cette requête visait à identifier les compétences à la fois très demandées et très bien rémunérées, afin d'offrir une orientation stratégique pour le développement des compétences.

```sql
SELECT 
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = True 
GROUP BY
    skills_dim.skill_id
HAVING
    COUNT(skills_job_dim.job_id) > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;
```

| Skill ID | Skills     | Demand Count | Average Salary ($) |
|----------|------------|--------------|-------------------:|
| 8        | go         | 27           |            115,320 |
| 234      | confluence | 11           |            114,210 |
| 97       | hadoop     | 22           |            113,193 |
| 80       | snowflake  | 37           |            112,948 |
| 74       | azure      | 34           |            111,225 |
| 77       | bigquery   | 13           |            109,654 |
| 76       | aws        | 32           |            108,317 |
| 4        | java       | 17           |            106,906 |
| 194      | ssis       | 12           |            106,683 |
| 233      | jira       | 20           |            104,918 |

*Tableau des compétences les plus recherchées pour les analystes de données, classées par salaire*

Voici une liste des compétences les plus recherchées pour les analystes de données en 2023 :
- **Langages de programmation très demandés :** Python et R se distinguent par leur forte demande, avec respectivement 236 et 148 demandes. Malgré leur forte demande, leurs salaires moyens sont d'environ 101 397 dollars pour Python et 100 499 dollars pour R, ce qui indique que la maîtrise de ces langages est très appréciée, mais aussi largement répandue.
- **Outils et technologies cloud :** les compétences dans des technologies spécialisées telles que Snowflake, Azure, AWS et BigQuery font l'objet d'une demande importante et offrent des salaires moyens relativement élevés, ce qui souligne l'importance croissante des plateformes cloud et des technologies big data dans l'analyse des données.
- **Outils de veille économique et de visualisation :** Tableau et Looker, avec respectivement 230 et 49 demandes et des salaires moyens d'environ 99 288 $ et 103 795 $, soulignent le rôle essentiel de la visualisation des données et de la veille économique dans l'obtention d'informations exploitables à partir des données.
- **Technologies de bases de données :** la demande de compétences en bases de données traditionnelles et NoSQL (Oracle, SQL Server, NoSQL), avec des salaires moyens compris entre 97 786 et 104 534 dollars, reflète le besoin constant d'expertise en matière de stockage, de récupération et de gestion des données.

# Ce que j'ai appris

Tout au long de cette aventure, j'ai considérablement amélioré ma boîte à outils SQL grâce à quelques fonctionnalités très puissantes :

- **🧩 Création de requêtes complexes :** j'ai maîtrisé l'art du SQL avancé, fusionnant des tables comme un pro et utilisant les clauses WITH pour des manipulations de tables temporaires dignes d'un ninja.
- **📊 Agrégation de données :** je me suis familiarisé avec GROUP BY et j'ai transformé les fonctions d'agrégation telles que COUNT() et AVG() en mes acolytes pour résumer les données.
- **💡 Magie analytique :** j'ai amélioré mes compétences en matière de résolution de problèmes concrets, transformant les questions en requêtes SQL exploitables et pertinentes.

# Conclusions

### Perspectives
L'analyse a permis de dégager plusieurs perspectives générales :

1. **Emplois les mieux rémunérés dans le domaine de l'analyse de données** : les emplois les mieux rémunérés pour les analystes de données qui permettent le travail à distance offrent une large gamme de salaires, le plus élevé pouvant atteindre 650 000 dollars !
2. **Compétences requises pour les emplois les mieux rémunérés** : les emplois d'analyste de données les mieux rémunérés exigent une maîtrise avancée du langage SQL, ce qui suggère qu'il s'agit d'une compétence essentielle pour obtenir un salaire élevé.
3. **Compétences les plus demandées** : le langage SQL est également la compétence la plus demandée sur le marché de l'emploi des analystes de données, ce qui la rend indispensable pour les demandeurs d'emploi.
4. **Compétences associées à des salaires plus élevés** : les compétences spécialisées, telles que SVN et Solidity, sont associées aux salaires moyens les plus élevés, ce qui indique une prime pour l'expertise de niche.
5. **Compétences optimales pour la valeur sur le marché du travail** : SQL est en tête de la demande et offre un salaire moyen élevé, ce qui en fait l'une des compétences les plus optimales que les analystes de données doivent acquérir pour maximiser leur valeur sur le marché.

### Conclusion

Ce projet m'a permis d'améliorer mes compétences en SQL et m'a fourni des informations précieuses sur le marché de l'emploi des analystes de données. Les résultats de l'analyse servent de guide pour hiérarchiser le développement des compétences et les efforts de recherche d'emploi. Les aspirants analystes de données peuvent mieux se positionner sur un marché de l'emploi concurrentiel en se concentrant sur les compétences très demandées et très rémunératrices. Cette exploration souligne l'importance de l'apprentissage continu et de l'adaptation aux nouvelles tendances dans le domaine de l'analyse de données.
