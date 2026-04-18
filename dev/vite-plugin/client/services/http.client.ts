import axios from 'axios';
import {
  EDITOR_HOST, EDITOR_PORT,
} from '@dev/constants';

export const httpClient = axios.create({
  baseURL: `http://${EDITOR_HOST}:${EDITOR_PORT}/dev`,
});
