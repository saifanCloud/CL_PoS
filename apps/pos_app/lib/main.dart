import 'package:flutter/material.dart';
import 'features/catalog/product_model.dart';

void main() {
  runApp(const PosApplication());
}

class PosApplication extends StatelessWidget {
  const PosApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CL Point of Sale',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1E88E5),
          brightness: Brightness.light,
        ),
      ),
      home: const PosCashierPage(),
    );
  }
}

class PosCashierPage extends StatefulWidget {
  const PosCashierPage({super.key});

  @override
  State<PosCashierPage> createState() => _PosCashierPageState();
}

class _PosCashierPageState extends State<PosCashierPage> {
  final List<ProductItem> _products = const [
    ProductItem(
      id: 'prod-1',
      name: 'Kopi Susu Aren',
      sku: 'BEV-001',
      price: 18000,
      category: 'Minuman',
    ),
    ProductItem(
      id: 'prod-2',
      name: 'Croissant Butter',
      sku: 'BAK-001',
      price: 22000,
      category: 'Pastry',
    ),
    ProductItem(
      id: 'prod-3',
      name: 'Americano Ice',
      sku: 'BEV-002',
      price: 15000,
      category: 'Minuman',
    ),
    ProductItem(
      id: 'prod-4',
      name: 'Matcha Latte',
      sku: 'BEV-003',
      price: 24000,
      category: 'Minuman',
    ),
    ProductItem(
      id: 'prod-5',
      name: 'Sandwich Toast',
      sku: 'BAK-002',
      price: 20000,
      category: 'Makanan',
    ),
  ];

  final Map<String, int> _cart = {};

  void _addToCart(ProductItem product) {
    setState(() {
      _cart[product.id] = (_cart[product.id] ?? 0) + 1;
    });
  }

  void _removeFromCart(ProductItem product) {
    setState(() {
      if (!_cart.containsKey(product.id)) return;
      if (_cart[product.id]! > 1) {
        _cart[product.id] = _cart[product.id]! - 1;
      } else {
        _cart.remove(product.id);
      }
    });
  }

  double get _totalPrice {
    double total = 0;
    for (final entry in _cart.entries) {
      final product = _products.firstWhere((p) => p.id == entry.key);
      total += product.price * entry.value;
    }
    return total;
  }

  int get _totalItemsCount {
    return _cart.values.fold(0, (sum, count) => sum + count);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CL PoS - Kasir', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                _cart.clear();
              });
            },
            tooltip: 'Reset Keranjang',
          ),
        ],
      ),
      body: Row(
        children: [
          // Product Catalog Grid
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 220,
                  childAspectRatio: 0.85,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: _products.length,
                itemBuilder: (context, index) {
                  final product = _products[index];
                  final qtyInCart = _cart[product.id] ?? 0;

                  return Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: InkWell(
                      onTap: () => _addToCart(product),
                      borderRadius: BorderRadius.circular(12),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 60,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.local_cafe,
                                  color: Theme.of(context).colorScheme.primary,
                                  size: 32,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Text(
                              product.name,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Rp ${product.price.toStringAsFixed(0)}',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 6),
                            if (qtyInCart > 0)
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primary,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  '$qtyInCart di keranjang',
                                  style: const TextStyle(color: Colors.white, fontSize: 11),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // Cart Section (Sidebar)
          Container(
            width: 320,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              border: Border(
                left: BorderSide(color: Colors.grey.shade300),
              ),
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  child: Row(
                    children: [
                      const Icon(Icons.shopping_bag_outlined),
                      const SizedBox(width: 8),
                      Text(
                        'Keranjang ($_totalItemsCount)',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: _cart.isEmpty
                      ? const Center(
                          child: Text(
                            'Keranjang masih kosong\nPilih menu untuk menambahkan',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey),
                          ),
                        )
                      : ListView.separated(
                          itemCount: _cart.keys.length,
                          separatorBuilder: (_, __) => const Divider(height: 1),
                          itemBuilder: (context, index) {
                            final productId = _cart.keys.elementAt(index);
                            final product = _products.firstWhere((p) => p.id == productId);
                            final qty = _cart[productId]!;

                            return ListTile(
                              title: Text(product.name, style: const TextStyle(fontSize: 14)),
                              subtitle: Text('Rp ${product.price.toStringAsFixed(0)} x $qty'),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.remove_circle_outline, size: 20),
                                    onPressed: () => _removeFromCart(product),
                                  ),
                                  Text('$qty', style: const TextStyle(fontWeight: FontWeight.bold)),
                                  IconButton(
                                    icon: const Icon(Icons.add_circle_outline, size: 20),
                                    onPressed: () => _addToCart(product),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainerHighest,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 4,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Total Pembayaran', style: TextStyle(fontSize: 14)),
                          Text(
                            'Rp ${_totalPrice.toStringAsFixed(0)}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        height: 46,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).colorScheme.primary,
                            foregroundColor: Colors.white,
                          ),
                          onPressed: _cart.isEmpty
                              ? null
                              : () {
                                  showDialog(
                                    context: context,
                                    builder: (ctx) => AlertDialog(
                                      title: const Text('Konfirmasi Pembayaran'),
                                      content: Text(
                                        'Proses transaksi sebesar Rp ${_totalPrice.toStringAsFixed(0)}?',
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.pop(ctx),
                                          child: const Text('Batal'),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(ctx);
                                            setState(() {
                                              _cart.clear();
                                            });
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(
                                                content: Text('Pembayaran berhasil dicatat!'),
                                                backgroundColor: Colors.green,
                                              ),
                                            );
                                          },
                                          child: const Text('Bayar'),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                          icon: const Icon(Icons.payment),
                          label: const Text('Bayar Sekarang', style: TextStyle(fontSize: 16)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}