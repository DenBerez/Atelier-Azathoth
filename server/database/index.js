const { Pool, Client } = require('pg');

// pools will use environment variables
// for connection information

const pool = new Pool({
  user: 'ubuntu',
  host: '52.53.156.193',
  database: 'pd',
  password: 'dennis',
  port: 5432,
});

// pool.query('SELECT NOW()', (err, res) => {
//   console.log(err, res);
//   pool.end();
// })

// you can also use async/await

// (async () => {
//   try {
//     const client = await pool.connect();
//     const res = await client.query(
//       "SELECT * FROM product WHERE id < 50;"
//     );

//     for (let row of res.rows) {
//       console.log(row);
//     }
//   } catch (err) {
//     console.error(err);
//   }
// })();

// clients will also use environment variables
// for connection information

// const client = new Client();
// await client.connect();
// const res = await client.query('SELECT NOW()');
// await client.end();

module.exports = pool;