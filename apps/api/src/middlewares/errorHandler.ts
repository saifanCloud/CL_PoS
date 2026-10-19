import { Request, Response, NextFunction } from 'express';
import { sendError } from '../utils/response';

export function errorHandler(
  err: Error,
  _req: Request,
  res: Response,
  _next: NextFunction
) {
  console.error('Unhandled Error:', err);
  return sendError(res, err.message || 'Internal Server Error', 500);
}

export function notFoundHandler(_req: Request, res: Response) {
  return sendError(res, 'Route not found', 404);
}

