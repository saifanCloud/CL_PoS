import { Router } from 'express';
import { healthRoutes } from './healthRoutes';
import { productRoutes } from './productRoutes';
import { orderRoutes } from './orderRoutes';

export const apiRouter = Router();

apiRouter.use('/health', healthRoutes);
apiRouter.use('/products', productRoutes);
apiRouter.use('/orders', orderRoutes);

