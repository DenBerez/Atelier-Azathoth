SELECT * FROM product p INNER JOIN features f ON (f.product_id = p.id) WHERE p.id = $1;
SELECT json_build_object('product_id', (SELECT sale_price FROM product WHERE productId = 1), 'results', (SELECT original_price FROM styles WHERE styles.productId = 1)) FROM styles WHERE styles.productId = 1;
SELECT json_build_object('results', (SELECT productId FROM styles, product where product.id = styles.productId)) FROM styles WHERE styles.productId = 1;
SELECT json_build_object('product_id', (SELECT sale_price FROM styles WHERE id = 1)) FROM styles WHERE styles.productId = 1;

Works
SELECT json_build_object('product_id', (SELECT sale_price FROM styles WHERE id = 1), 'results', (SELECT original_price FROM styles WHERE id = 1)) FROM styles WHERE productId = 1;

Better
SELECT json_build_object('product_id', (SELECT id FROM product WHERE id = 1),
'results', (SELECT array_agg(json_build_object('style_id', id, 'name', name, 'original_price', original_price, 'sale_price', sale_price, 'default?', default_style, 'photos',
(SELECT array_agg(json_build_object('thumbnail_url', thumbnail_url, 'url', url)) FROM photos WHERE styleId = styles.id),
'skus', 1))
FROM styles WHERE productId = 1));

SELECT json_build_object(
  'product_id',
  (SELECT id FROM product WHERE id = 1),
  'results',
  (SELECT array_agg(json_build_object('style_id', id, 'name', name, 'original_price', original_price, 'sale_price', sale_price, 'default?', default_style, 'photos',
  (SELECT array_agg(json_build_object('thumbnail_url', thumbnail_url, 'url', url)) FROM photos WHERE styleId = styles.id),
  'skus',
  (SELECT json_object_agg(id, (SELECT json_build_object('quantity', quantity, 'size', size) FROM skus WHERE id = 1)) FROM styles WHERE productId = 1)))
  FROM styles WHERE productId = 1));

(SELECT json_object_agg(id, (SELECT json_build_object('quantity', quantity, 'size', size) FROM skus WHERE id = 1)) FROM styles WHERE productId = 1);

(SELECT json_build_object((SELECT id FROM skus WHERE styleId = styles.id),
  (SELECT json_build_object('quantity', quantity, 'size', size) FROM skus WHERE styleId = styles.id)))



SELECT json_build_object('product_id', (SELECT id FROM product), 'results', (SELECT * FROM styles), 'skus', (SELECT json_build_object((SELECT id FROM skus), (SELECT json_build_object('quantity', (SELECT quantity FROM styles),'size', (SELECT size FROM styles)))))) from styles limit 10;


SELECT json_build_object(
          'product_id',
          (SELECT id FROM product WHERE id = 3),
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
              'size', size) FROM skus WHERE id = 3)) FROM styles WHERE productId = 3)))
          FROM styles WHERE productId = 3));




{
  "product_id" : 1,
  "results" : [
    {
      "style_id" : 1,
      "name" : "Forest Green & Black",
      "original_price" : 140,
      "sale_price" : null,
      "default?" : 1,
      "photos" : [
        {"thumbnail_url" : "https://images.unsplash.com/photo-1501088430049-71c79fa3283e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=300&q=80",
          "url" : "https://images.unsplash.com/photo-1501088430049-71c79fa3283e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=668&q=80"},
        {"thumbnail_url" : "https://images.unsplash.com/photo-1534011546717-407bced4d25c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=300&q=80",
          "url" : "https://images.unsplash.com/photo-1534011546717-407bced4d25c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2734&q=80"},
        {"thumbnail_url" : "https://images.unsplash.com/photo-1549831243-a69a0b3d39e0?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=300&q=80",
          "url" : "https://images.unsplash.com/photo-1549831243-a69a0b3d39e0?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2775&q=80"},
        {"thumbnail_url" : "https://images.unsplash.com/photo-1527522883525-97119bfce82d?ixlib=rb-1.2.1&auto=format&fit=crop&w=300&q=80",
          "url" : "https://images.unsplash.com/photo-1527522883525-97119bfce82d?ixlib=rb-1.2.1&auto=format&fit=crop&w=668&q=80"},
        {"thumbnail_url" : "https://images.unsplash.com/photo-1556648202-80e751c133da?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=300&q=80",
          "url" : "https://images.unsplash.com/photo-1556648202-80e751c133da?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=668&q=80"},
        {"thumbnail_url" : "https://images.unsplash.com/photo-1532543491484-63e29b3c1f5d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=300&q=80",
          "url" : "https://images.unsplash.com/photo-1532543491484-63e29b3c1f5d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1000&q=80"}
      ],
      "skus" : 1
    },
    ...]
}