import { Request, Response } from 'express';
import { Order, OrderStatus, PaymentMethod } from '@pos/shared';
import { sendSuccess, sendError } from '../utils/response';

const sampleOrders: Order[] = [];

export const createOrder = (req: Request, res: Response) => {
  const { cashierId, storeId, items, paymentMethod, amountPaid } = req.body;

  if (!items || !Array.isArray(items) || items.length === 0) {
    return sendError(res, 'Items list cannot be empty', 400);
  }

  const subtotal = items.reduce((acc: number, item: any) => acc + (item.unitPrice * item.quantity), 0);
  const tax = Math.round(subtotal * 0.11); // 11% PPN
  const discount = 0;
  const total = subtotal + tax - discount;
  const change = (amountPaid || total) - total;

  const newOrder: Order = {
    id: `ord-${Date.now()}`,
    orderNumber: `INV-${Date.now().toString().slice(-6)}`,
    cashierId: cashierId || 'cashier-1',
    storeId: storeId || 'store-central',
    items,
    subtotal,
    tax,
    discount,
    total,
    amountPaid: amountPaid || total,
    change: change >= 0 ? change : 0,
    paymentMethod: paymentMethod || PaymentMethod.CASH,
    status: OrderStatus.COMPLETED,
    createdAt: new Date().toISOString(),
    updatedAt: new Date().toISOString(),
  };

  sampleOrders.push(newOrder);

  return sendSuccess(res, newOrder, 'Order created successfully', 201);
};

export const getOrders = (_req: Request, res: Response) => {
  return sendSuccess(res, sampleOrders, 'Orders fetched successfully');
};

