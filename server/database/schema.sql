CREATE TABLE product (
  id serial PRIMARY KEY,
  name text NOT NULL,
  slogan text,
  description text,
  category text NOT NULL,
  default_price int NOT NULL
);

CREATE TABLE styles (
  id serial PRIMARY KEY,
  productId integer NOT NULL,
  name text NOT NULL,
  sale_price integer,
  original_price integer,
  default_style integer,
  FOREIGN KEY (productId) REFERENCES product (id)
);

CREATE TABLE skus (
  id serial PRIMARY KEY,
  styleId integer NOT NULL,
  size text,
  quantity integer,
  FOREIGN KEY (styleId) REFERENCES styles (id)
);

CREATE TABLE features (
  id serial PRIMARY KEY,
  product_id integer NOT NULL,
  feature text,
  value text,
  FOREIGN KEY (product_id) REFERENCES product (id)
);

CREATE TABLE photos (
  id serial PRIMARY KEY,
  styleId integer NOT NULL,
  url text,
  thumbnail_url text,
  FOREIGN KEY (styleId) REFERENCES styles (id)
);

COPY product(id, name, slogan, description, category, default_price) FROM '/home/ubuntu/sdc/csvs/product.csv' DELIMITER ',' NULL AS 'null' CSV HEADER;
COPY styles(id, productId, name, sale_price, original_price, default_style) FROM '/home/ubuntu/sdc/csvs/styles.csv' DELIMITER ',' NULL AS 'null' CSV HEADER;
COPY skus(id, styleId, size, quantity) FROM '/home/ubuntu/sdc/csvs/skus.csv' DELIMITER ',' NULL AS 'null' CSV HEADER;
COPY features(id, product_id, feature, value) FROM '/home/ubuntu/sdc/csvs/features.csv' DELIMITER ',' NULL AS 'null' CSV HEADER;
COPY photos(id, styleId, url, thumbnail_url) FROM '/home/ubuntu/sdc/csvs/photos.csv' DELIMITER ',' NULL AS 'null' CSV HEADER;

CREATE INDEX featuresIndex ON features(product_id);
CREATE INDEX stylesIndex ON styles(productId);
CREATE INDEX photosIndex ON photos(styleId);