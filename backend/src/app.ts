import express from 'express';
import cors from 'cors';
import { healthRouter } from './routes/health';

const app = express();

app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.get('/', (_req, res) => {
  res.send('AfriHomes API');
});

app.use('/api', healthRouter);

export default app;

