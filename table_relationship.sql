ALTER TABLE review
ADD COLUMN app_id INT;

-- Creating a foreign key constraint on the new 'app_id' column
ALTER TABLE review
ADD CONSTRAINT fk_app_id
FOREIGN KEY (app_id)
REFERENCES app(id);

--Establishing relationship
UPDATE review
SET app_id = app.id
FROM app
WHERE review.app_name = app.app_name;