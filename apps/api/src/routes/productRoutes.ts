import { Router } from 'express';
import { getProducts, getProductById } from '../controllers/productController';

export const productRoutes = Router();
productRoutes.get('/', getProducts);
productRoutes.get('/:id', getProductById);

