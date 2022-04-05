import http from 'k6/http';
import { sleep } from 'k6';

export const options = {
  vus: 1500,
  duration: '15s',
};

export default function () {
  http.get('http://54.241.43.202/products');
  sleep(1);
}