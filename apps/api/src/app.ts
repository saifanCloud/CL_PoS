import express from 'express';
import cors from 'cors';
import helmet from 'helmet';
import morgan from 'morgan';
import { config } from './config/env';
import { apiRouter } from './routes';
import { errorHandler, notFoundHandler } from './middlewares/errorHandler';

export const app = express();

// Middlewares
app.use(helmet());
app.use(cors({ origin: config.corsOrigin }));
app.use(express.json());
app.use(morgan('dev'));

// Routes
app.use('/api', apiRouter);

// Error Handling
app.use(notFoundHandler);
app.use(errorHandler);

