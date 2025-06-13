import 'package:dartz/dartz.dart' as dz;
import 'package:dio/dio.dart';
import 'package:e_commerece_app/features/home/data/data_source/product_remote_data_source.dart';
import 'package:e_commerece_app/features/home/data/data_source/service_remote_data_source.dart';
import 'package:e_commerece_app/features/home/data/models/data_model.dart';
import 'package:e_commerece_app/features/home/presentation/managers/Auth/product_cubit.dart';
import 'package:e_commerece_app/features/home/presentation/pages/add_product_page.dart';
import 'package:e_commerece_app/features/home/presentation/pages/add_service_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AddProductServicesPage extends StatefulWidget {
  const AddProductServicesPage({super.key});

  @override
  State<AddProductServicesPage> createState() => _AddProductServicesPageState();
}

class _AddProductServicesPageState extends State<AddProductServicesPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late Future<dz.Either<String, List<Product>>> _productsFuture;
  late Future<List<Service>> _servicesFuture;

  final Dio _dio = Dio();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  late ProductRemoteDataSource _productRemoteDataSource;
  late ServiceRemoteDataSource _serviceRemoteDataSource;

  String? _successMessage;
  bool _loadingProducts = true;
  bool _loadingServices = true;
  List<Product> _products = [];
  List<Service> _services = [];
  String? _productsError;
  String? _servicesError;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _productRemoteDataSource =
        ProductRemoteDataSource(dio: _dio, storage: _storage);
    _serviceRemoteDataSource = ServiceRemoteDataSource();
    _loadProducts();
    _loadServices();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadProducts() async {
    setState(() => _loadingProducts = true);
    _productsFuture = _productRemoteDataSource.fetchProducts();

    final result = await _productsFuture;
    result.fold(
      (error) => setState(() {
        _productsError = error;
        _loadingProducts = false;
      }),
      (products) => setState(() {
        _products = products;
        _loadingProducts = false;
      }),
    );
  }

  Future<void> _loadServices() async {
    setState(() => _loadingServices = true);
    try {
      _servicesFuture = _serviceRemoteDataSource.fetchServices();
      final services = await _servicesFuture;
      setState(() {
        _services = services;
        _loadingServices = false;
      });
    } catch (e) {
      setState(() {
        _servicesError = e.toString();
        _loadingServices = false;
      });
    }
  }

  void _showSuccessMessage(String message) {
    setState(() => _successMessage = message.tr());
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) setState(() => _successMessage = null);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('add_products_services'.tr()),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'products'.tr()),
            Tab(text: 'services'.tr()),
          ],
        ),
      ),
      body: Column(
        children: [
          if (_successMessage != null) _buildSuccessBanner(_successMessage!),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildProductList(),
                _buildServiceList(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: _buildFloatingActionButtons(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildSuccessBanner(String message) {
    return Container(
      color: Colors.green,
      width: double.infinity,
      padding: const EdgeInsets.all(8.0),
      child: Text(
        message,
        style: const TextStyle(color: Colors.white),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildFloatingActionButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FloatingActionButton(
            heroTag: "productButton",
            onPressed: () => _navigateToAddProduct(context),
            backgroundColor: Colors.blue,
            tooltip: 'add_product'.tr(),
            child: const Icon(Icons.add, color: Colors.white),
          ),
          FloatingActionButton(
            heroTag: "serviceButton",
            onPressed: () => _navigateToAddService(context),
            backgroundColor: Colors.green,
            tooltip: 'add_service'.tr(),
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Future<void> _navigateToAddProduct(BuildContext context) async {
    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (_) => ProductCubit(
            dataSource: ProductRemoteDataSource(dio: _dio, storage: _storage),
          ),
          child: const AddProductPage(),
        ),
      ),
    );

    if (result == true) {
      _loadProducts();
      _showSuccessMessage('product_added_successfully');
    }
  }

  Future<void> _navigateToAddService(BuildContext context) async {
    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (_) => const AddServicePage()),
    );

    if (result == true) {
      _loadServices();
      _showSuccessMessage('service_added_successfully');
    }
  }

  Widget _buildProductList() {
    if (_loadingProducts) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_productsError != null) {
      return Center(child: Text(_productsError!));
    }

    if (_products.isEmpty) {
      return Center(child: Text('no_products_available'.tr()));
    }

    return GridView.builder(
      padding: const EdgeInsets.all(12.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
      ),
      itemCount: _products.length,
      itemBuilder: (context, index) {
        final product = _products[index];
        return Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.network(
                    product.image,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    errorBuilder: (context, error, stackTrace) =>
                        const Center(child: Icon(Icons.error)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '\$${product.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildServiceList() {
    if (_loadingServices) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_servicesError != null) {
      return Center(child: Text(_servicesError!));
    }

    if (_services.isEmpty) {
      return Center(child: Text('no_services_available'.tr()));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12.0),
      itemCount: _services.length,
      itemBuilder: (context, index) {
        final service = _services[index];
        return Card(
          elevation: 2,
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            contentPadding: const EdgeInsets.all(12),
            leading: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(service.imageUrl),
                ),
              ),
            ),
            title: Text(
              service.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              service.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            // Using cost instead of price if available
            trailing: Text(
              '\$${service.price.toStringAsFixed(2)}',
              style: const TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }
}
//now i want upload flutter project , what is the correct Structure  for it 
// where its e_commerece app  