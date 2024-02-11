CREATE TABLE app (

id INT primary key NOT NULL,
app_name VARCHAR,
category VARCHAR,
rating INT,
reviews INT,
size VARCHAR,
installs VARCHAR,
type VARCHAR,
price INT,
content_rating VARCHAR,
genres VARCHAR,
last_updated DATE,
current_ver VARCHAR,
android_ver VARCHAR);

CREATE TABLE review (

review_id INT PRIMARY KEY NOT NULL,
app_name VARCHAR,
translated_review VARCHAR,
sentiment VARCHAR,
sentiment_polarity VARCHAR,
sentiment_subjectivity VARCHAR);

