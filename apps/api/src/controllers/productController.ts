import { Request, Response } from 'express';
import { Product } from '@pos/shared';
import { sendSuccess, sendError } from '../utils/response';

// In-memory initial sample products for quick start
const sampleProducts: Product[] = [
  {
    id: 'prod-1',
    name: 'Kopi Susu Gula Aren',
    sku: 'BEV-001',
    barcode: '899123456001',
    categoryId: 'cat-beverage',
    price: 18000,
    costPrice: 8000,
    stock: 50,
    unit: 'cup',
    isActive: true,
    createdAt: new Date().toISOString(),
    updatedAt: new Date().toISOString(),
  },
  {
    id: 'prod-2',
    name: 'Croissant Butter',
    sku: 'BAK-001',
    barcode: '899123456002',
    categoryId: 'cat-bakery',
    price: 22000,
    costPrice: 11000,
    stock: 25,
    unit: 'pcs',
    isActive: true,
    createdAt: new Date().toISOString(),
    updatedAt: new Date().toISOString(),
  },
  {
    id: 'prod-3',
    name: 'Americano Ice',
    sku: 'BEV-002',
    barcode: '899123456003',
    categoryId: 'cat-beverage',
    price: 15000,
    costPrice: 5000,
    stock: 80,
    unit: 'cup',
    isActive: true,
    createdAt: new Date().toISOString(),
    updatedAt: new Date().toISOString(),
  },
];

export const getProducts = (_req: Request, res: Response) => {
  return sendSuccess(res, sampleProducts, 'Products fetched successfully');
};

export const getProductById = (req: Request, res: Response) => {
  const { id } = req.params;
  const product = sampleProducts.find((p) => p.id === id);
  if (!product) {
    return sendError(res, 'Product not found', 404);
  }
  return sendSuccess(res, product, 'Product details');
};

