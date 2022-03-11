const express = require("express");
require('newrelic');
const pool = require("./database/index.js");

const app = express();

//Get all products
app.get('/products', async (req, res) => {
  try {
    // const client = await pool.connect();
    const request = await pool.query(
      `SELECT * FROM product LIMIT 10;`
    );
    res.send(request.rows);
  } catch (err) {
    console.error(err);
  };
});

//Get specific product and its features
app.get('/products/:product_id', async (req, res) => {
  try {
    // const client = await pool.connect();
    const request = await pool.query(
      `SELECT * FROM product p INNER JOIN features f ON (f.product_id = $1) WHERE p.id = $1;`, [req.params.product_id]
    );
    res.send(request.rows);
  } catch (err) {
    console.error(err);
  };
});

//Get all styles, photos, and skus for a specific product
app.get('/products/:product_id/styles', async (req, res) => {
    try {
      // const client = await pool.connect();
      const request = await pool.query(
        `SELECT json_build_object(
          'product_id',
          (SELECT id FROM product WHERE id = $1),
          'results',
          (SELECT array_agg(
            json_build_object(
              'style_id', id,
              'name', name,
              'original_price', original_price,
              'sale_price', sale_price,
              'default?', default_style,
              'photos', (SELECT array_agg(
                json_build_object(
                  'thumbnail_url', thumbnail_url,
                  'url', url)) FROM photos WHERE styleId = styles.id),
          'skus',
          (SELECT json_object_agg(
            id, (SELECT json_build_object(
              'quantity', quantity,
              'size', size) FROM skus WHERE id = $1)) FROM styles WHERE productId = $1)))
          FROM styles WHERE productId = $1));`, [req.params.product_id]
      );
      res.send(request.rows[0].json_build_object);
    } catch (err) {
      console.error(err);
    };
});

app.listen(3000);

