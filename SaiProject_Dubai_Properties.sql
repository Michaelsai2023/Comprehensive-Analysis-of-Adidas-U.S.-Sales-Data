--- Dubai Properties Price per sqft from lowest to highest
SELECT * FROM dubai_properties
ORDER BY price ASC

--- Dubai Properties Price in USD (USD 1= 3.67 AED), Price highest to lowest
SELECT id, neighborhood, (price/3.67) AS price_USD, size_in_sqft, (price_per_sqft/3.67) AS price_per_sqft_USD, no_of_bedrooms 
FROM dubai_properties
ORDER BY price_USD DESC

---Dubai Properties Price in USD, Price_budget between USD 200,000 AND USD 300,000
SELECT id, neighborhood, (price/3.67) AS price_USD, size_in_sqft, (price_per_sqft/3.67) AS price_per_sqft_USD, no_of_bedrooms 
FROM dubai_properties
WHERE (price/3.67) <= 300000 AND (price/3.67) >= 200000
ORDER BY price_USD ASC

---Dubai Properties Price in USD, Price_budget between USD 100,000 AND USD 200,000
SELECT id, neighborhood, (price/3.67) AS price_USD, size_in_sqft, (price_per_sqft/3.67) AS price_per_sqft_USD, no_of_bedrooms 
FROM dubai_properties
WHERE (price/3.67) <= 200000 AND (price/3.67) >= 100000
ORDER BY price_USD ASC

---Dubai Properties Price in USD, including bedrooms, bathrooms, Medium quality, maidroom
SELECT id, neighborhood, (price/3.67) AS price_USD, size_in_sqft, (price_per_sqft/3.67) AS price_per_sqft_USD, no_of_bedrooms, no_of_bathrooms, quality, maid_room 
FROM dubai_properties
WHERE quality = 'Medium' AND no_of_bedrooms != 0 AND no_of_bathrooms != 0 AND maid_room !=0
ORDER BY price_USD ASC

---Dubai Properties Price in USD, where total_number of room >= 4
SELECT id, neighborhood, (price/3.67) AS price_USD, size_in_sqft, (price_per_sqft/3.67) AS price_per_sqft_USD, (no_of_bedrooms+no_of_bathrooms+ maid_room) AS total_rooms
FROM dubai_properties
WHERE (no_of_bedrooms+no_of_bathrooms+ maid_room) >=4
ORDER BY price_USD ASC

---Dubai Properties Price in USD, neighborhood like Dubai Sports City, including bedrooms, bathrooms, Medium quality
SELECT id, neighborhood, (price/3.67) AS price_USD, size_in_sqft, (price_per_sqft/3.67) AS price_per_sqft_USD, no_of_bedrooms, no_of_bathrooms, quality, maid_room 
FROM dubai_properties
WHERE neighborhood like '%Sports%' AND quality = 'Medium' AND no_of_bedrooms != 0 AND no_of_bathrooms != 0
ORDER BY price_USD ASC

---Dubai Properties Price in USD, High Quality, Fully Furished like balcony, built_in_wardrobes, central_ac, kitchen_appliances
SELECT id, neighborhood, (price/3.67) AS price_USD, size_in_sqft, (price_per_sqft/3.67) AS price_per_sqft_USD, balcony, built_in_wardrobes, central_ac, kitchen_appliances
FROM dubai_properties
WHERE quality = 'High' AND balcony != 0 AND built_in_wardrobes != 0 AND central_ac != 0 AND kitchen_appliances != 0
ORDER BY price_USD ASC

---Dubai Properties Price in GBP (~4.74 AED), GBP > 500,000, size_in_sqm > 100, with view of landmark, view of water
SELECT id, neighborhood, (price/4.74) AS price_GBP, (size_in_sqft/10.7639) AS size_in_sqm, ((price_per_sqft/4.74)/10.7639) AS price_per_sqm_GBP, view_of_landmark, view_of_water
FROM dubai_properties
WHERE (price/4.74) >= 500000 AND (size_in_sqft/10.7639) >= 100 AND view_of_landmark !=0 AND view_of_water != 0 
ORDER BY 1,2

---Dubai Properties Price in USD (~3.76 AED), over 1 million value, size_in_sqm > 100, with view of landmark, view of water
SELECT id, neighborhood, (price/3.76) AS price_USD, (size_in_sqft/10.7639) AS size_in_sqm, ((price_per_sqft/3.76)/10.7639) AS price_per_sqm_USD, view_of_landmark, view_of_water
FROM dubai_properties
WHERE (price/3.76) >= 1000000 AND (size_in_sqft/10.7639) >= 100 AND view_of_landmark !=0 AND view_of_water != 0 
ORDER BY 1,2

---Using WITH Clause for Dubai Properties Price in USD (~3.76 AED), over 1 million value, size_in_sqm > 100, with view of landmark, view of water
WITH Dubai_1m_USD AS
(
SELECT id, neighborhood, (price/3.76) AS price_USD, (size_in_sqft/10.7639) AS size_in_sqm, ((price_per_sqft/3.76)/10.7639) AS price_per_sqm_USD, view_of_landmark, view_of_water
FROM dubai_properties
WHERE (price/3.76) >= 1000000 AND (size_in_sqft/10.7639) >= 100 AND view_of_landmark !=0 AND view_of_water != 0 
)
SELECT * FROM Dubai_1m_USD
WHERE neighborhood like '%Jumeirah%' -- choose neighborhood
ORDER BY price_USD

---Create table as new_dubai_properties
CREATE TABLE new_dubai_properties (
    id INT PRIMARY KEY,
    neighborhood VARCHAR(50),
    price_USD NUMERIC,
    size_in_sqm NUMERIC,
    price_per_sqft_USD NUMERIC,
    view_of_landmark NUMERIC,
    view_of_water NUMERIC
);

--- Insert values into new table
INSERT INTO new_dubai_properties
VALUES 
(45533, 'Dubai City', 4900000, 500, 4560, 2,4),
(23452, 'ABC City Central', 1000000, 100, 10000, 1, 1),
(99999, 'Number 1 Central in Dubai', 5000000, 1000, 5000, 4, 5);

--- Check values of new_dubai_properties
SELECT * FROM new_dubai_properties

--- Update values in the table
UPDATE new_dubai_properties
SET neighborhood = 'Dubai City Central'
WHERE id= 23452;

--- Drop table if all information is completely wrong
DROP TABLE new_dubai_properties


---Create table as dubai_properties with 1 million value
CREATE TABLE dubai_properties_1million (
    id INT PRIMARY KEY,
    neighborhood VARCHAR(50),
    price_USD NUMERIC,
    size_in_sqm NUMERIC,
    price_per_sqft_USD NUMERIC,
    view_of_landmark NUMERIC,
    view_of_water NUMERIC
);

--- Insert data into the '1m_dubai_properties' by filtering and coverting converting from the "dubai_properties" table
INSERT INTO dubai_properties_1million
SELECT id, neighborhood, (price/3.76) AS price_USD, (size_in_sqft/10.7639) AS size_in_sqm, ((price_per_sqft/3.76)/10.7639) AS price_per_sqm_USD, view_of_landmark, view_of_water
FROM dubai_properties
WHERE (price/3.76) >= 1000000 AND (size_in_sqft/10.7639) >= 100 AND view_of_landmark !=0 AND view_of_water != 0; 

SELECT * FROM dubai_properties_1million

--- Create View for storing data for later visualization
CREATE VIEW dubai_properties_one_million AS
SELECT id, neighborhood, (price/3.76) AS price_USD, (size_in_sqft/10.7639) AS size_in_sqm, ((price_per_sqft/3.76)/10.7639) AS price_per_sqm_USD, view_of_landmark, view_of_water
FROM dubai_properties
WHERE (price/3.76) >= 1000000 AND (size_in_sqft/10.7639) >= 100 AND view_of_landmark !=0 AND view_of_water != 0; 

