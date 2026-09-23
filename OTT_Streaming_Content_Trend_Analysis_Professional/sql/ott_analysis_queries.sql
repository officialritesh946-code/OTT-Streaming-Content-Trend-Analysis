-- OTT Streaming Content Trend Analysis (SQLite)
-- Verified scope: Netflix catalog snapshot
DROP TABLE IF EXISTS netflix_titles;
CREATE TABLE netflix_titles (
 show_id TEXT PRIMARY KEY,type TEXT,title TEXT,director TEXT,cast TEXT,country TEXT,
 date_added TEXT,release_year INTEGER,rating TEXT,duration TEXT,listed_in TEXT,description TEXT,
 platform TEXT,added_year INTEGER,added_month TEXT,duration_value REAL,duration_unit TEXT);

-- Import data/processed/netflix_cleaned_enriched.csv into the table, then run:

-- 1. Content mix
SELECT type, COUNT(*) AS title_count FROM netflix_titles GROUP BY type ORDER BY title_count DESC;

-- 2. Titles added by year
SELECT added_year, COUNT(*) AS titles_added FROM netflix_titles WHERE added_year IS NOT NULL GROUP BY added_year ORDER BY added_year;

-- 3. Release-year trend
SELECT release_year, COUNT(*) AS title_count FROM netflix_titles GROUP BY release_year ORDER BY release_year;

-- 4. Ratings
SELECT COALESCE(rating,'Not Rated') AS rating, COUNT(*) AS title_count FROM netflix_titles GROUP BY COALESCE(rating,'Not Rated') ORDER BY title_count DESC;

-- 5. Average movie duration
SELECT ROUND(AVG(duration_value),2) AS avg_movie_minutes FROM netflix_titles WHERE type='Movie' AND duration_unit='min';

-- 6. Top categories
WITH RECURSIVE split(show_id,rest,genre) AS (
 SELECT show_id,listed_in||',','' FROM netflix_titles WHERE listed_in IS NOT NULL
 UNION ALL SELECT show_id,substr(rest,instr(rest,',')+1),trim(substr(rest,1,instr(rest,',')-1))
 FROM split WHERE instr(rest,',')>0)
SELECT genre,COUNT(DISTINCT show_id) AS title_count FROM split WHERE genre<>'' GROUP BY genre ORDER BY title_count DESC LIMIT 10;

-- 7. Top countries
WITH RECURSIVE split(show_id,rest,country_name) AS (
 SELECT show_id,country||',','' FROM netflix_titles WHERE country IS NOT NULL
 UNION ALL SELECT show_id,substr(rest,instr(rest,',')+1),trim(substr(rest,1,instr(rest,',')-1))
 FROM split WHERE instr(rest,',')>0)
SELECT country_name,COUNT(DISTINCT show_id) AS title_count FROM split WHERE country_name<>'' GROUP BY country_name ORDER BY title_count DESC LIMIT 10;

-- 8. Recent content
SELECT type,COUNT(*) AS titles FROM netflix_titles WHERE release_year>=2017 GROUP BY type ORDER BY titles DESC;

-- 9. Missing-value audit
SELECT
 SUM(CASE WHEN director IS NULL OR TRIM(director)='' THEN 1 ELSE 0 END) missing_director,
 SUM(CASE WHEN cast IS NULL OR TRIM(cast)='' THEN 1 ELSE 0 END) missing_cast,
 SUM(CASE WHEN country IS NULL OR TRIM(country)='' THEN 1 ELSE 0 END) missing_country,
 SUM(CASE WHEN date_added IS NULL OR TRIM(date_added)='' THEN 1 ELSE 0 END) missing_date_added,
 SUM(CASE WHEN rating IS NULL OR TRIM(rating)='' THEN 1 ELSE 0 END) missing_rating,
 SUM(CASE WHEN duration IS NULL OR TRIM(duration)='' THEN 1 ELSE 0 END) missing_duration
FROM netflix_titles;
