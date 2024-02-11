--ukupan broj aplikacija po kategorijama
select category, count(*) as total_apps from app
group by category
order by count(*) desc;

--prosjecna ocjena (rating) po kategorijama
select category, ROUND(avg(rating),2) as avg_rating from app
group by category
order by avg_rating desc;

--nazivi aplikacija i zanrova iz kategorije 'Food & Drink' azuriranih tijekom srpnja 2018.
select genres, app.app_name from app
where last_updated between '2018-07-01' and '2018-07-31'
and genres = 'Food & Drink'

--prikaz deset aplikacija s najvise negativnih recenzija, ciji je prosjecni rating manji od 40.
select review.app_name, count(review.translated_review) as number_of_reviews from review
join app on app.id = review.app_id
where review.sentiment = 'Negative' and app.rating < 40  
group by review.app_name
order by number_of_reviews desc
limit 10;


--prosjecna polarizacija sentimenta i subjektivnost po kategorijama aplikacija. 
select app.category, 
ROUND(AVG(CASE 
	WHEN review.sentiment_polarity = 'nan' THEN NULL
	ELSE CAST(review.sentiment_polarity AS NUMERIC) END), 2) as avg_polarity,
ROUND(AVG(CASE
	WHEN review.sentiment_subjectivity = 'nan' THEN NULL
	ELSE CAST(review.sentiment_subjectivity AS NUMERIC) END), 2) as avg_subjectivity
from app
join review on app.id = review.app_id
group by app.category
order by category;

--nazivi aplikacija i ocjene cija je ocjena veca od prosjecne ocjene svih aplikacija
select app_name, rating 
from app
where rating > (select AVG(rating) from app);

--poredak aplikacija po zanrovima s obzirom na posljednje azuriranje
select app_name, last_updated, genres, row_number_of_last_update 
from
	(select app_name, last_updated, genres,
		dense_rank() over (partition by genres order by last_updated desc) as row_number_of_last_update
	from app) as ranked_apps
where row_number_of_last_update <=4

--prikaz trenda izmedu prethodnog i sadasnjeg sentiment polarity aplikacija ciji je rating veci od prosjeka ratinga svih aplikacija.
select r.app_name, r.translated_review, r.sentiment_polarity,
    LAG(r.sentiment_polarity) OVER (PARTITION BY r.app_name ORDER BY r.review_id) as previous_polarity
from review r
join app a on r.app_name = a.app_name
where a.rating > (select avg(app.rating) from app)
order by r.app_name;


