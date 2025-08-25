import { Router } from 'express';
import { getDbState } from '../config/db';

export const healthRouter = Router();

healthRouter.get('/health', (_req, res) => {
  res.json({
    status: 'ok',
    db: getDbState(),
    timestamp: new Date().toISOString(),
  });
});

