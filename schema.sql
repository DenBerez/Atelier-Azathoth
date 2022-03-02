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