import { Response } from 'express';
import { ApiResponse } from '@pos/shared';

export function sendSuccess<T>(res: Response, data: T, message = 'Success', statusCode = 200) {
  const payload: ApiResponse<T> = {
    success: true,
    message,
    data,
    timestamp: new Date().toISOString(),
  };
  return res.status(statusCode).json(payload);
}

export function sendError(res: Response, message = 'An error occurred', statusCode = 500, error?: string) {
  const payload: ApiResponse<null> = {
    success: false,
    message,
    error,
    timestamp: new Date().toISOString(),
  };
  return res.status(statusCode).json(payload);
}

