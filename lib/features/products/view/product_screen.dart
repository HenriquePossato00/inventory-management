import 'package:flutter/material.dart';
import 'package:inventory_management/features/products/viewModel/product_view_model.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<Productviewmodel>();

    return Scaffold(
      appBar: AppBar(title: Text("Produtos")),
      body: vm.isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: vm.products.length,
              itemBuilder: (contex, index) {
                final product = vm.products[index];

                return ListTile(
                  title: Text(product.name),
                  subtitle: Text("Quantidade: ${product.quantity}"),
                  trailing: Text("R\$ ${product.price}"),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => vm.fetchProducts(),
        child: Icon(Icons.refresh),
      ),
    );
  }
}
