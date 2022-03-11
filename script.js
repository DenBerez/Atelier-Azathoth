import http from 'k6/http';
import { sleep } from 'k6';

export const options = {
  vus: 50,
  duration: '60s',
};

export default function () {
  http.get('http://54.219.105.222:3000/products');
  sleep(1);
}