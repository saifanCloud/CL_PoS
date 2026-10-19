import { Request, Response } from 'express';
import { sendSuccess } from '../utils/response';

export const getHealth = (_req: Request, res: Response) => {
  return sendSuccess(res, {
    status: 'online',
    service: 'Point of Sale API',
    uptime: process.uptime(),
  }, 'Service is healthy');
};

