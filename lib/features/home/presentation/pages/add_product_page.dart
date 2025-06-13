import 'dart:io';
import 'package:e_commerece_app/core/network/api_urls.dart';
import 'package:e_commerece_app/features/home/data/data_source/product_remote_data_source.dart';
import 'package:e_commerece_app/features/home/presentation/managers/Auth/product_cubit.dart';
import 'package:e_commerece_app/features/home/presentation/managers/Auth/productstate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController discountPriceController = TextEditingController();
  final TextEditingController deliveryFeeController = TextEditingController();

  int? selectedCategoryId;
  File? image;
  bool _isLoadingCategories = false;
  List<Map<String, dynamic>> categories = [];
  String? _categoryError;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchCategories();
    });
  }

  Future<void> _fetchCategories() async {
    setState(() {
      _isLoadingCategories = true;
      _categoryError = null;
    });

    try {
      final cubit = BlocProvider.of<ProductCubit>(context);
      final result = await cubit.fetchCategories();

      result.fold(
        (error) {
          setState(() {
            _categoryError = error;
            _isLoadingCategories = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to load categories: $error')),
          );
        },
        (categories) {
          setState(() {
            this.categories = categories;
            _isLoadingCategories = false;
          });
        },
      );
    } catch (e) {
      setState(() {
        _categoryError = e.toString();
        _isLoadingCategories = false;
      });
    }
  }

  void _pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() => image = File(pickedImage.path));
    }
  }

  void _addProduct() {
    if (nameController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        priceController.text.isEmpty ||
        selectedCategoryId == null ||
        image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill all required fields')));
      return;
    }

    final price = double.tryParse(priceController.text);
    final discountPrice = discountPriceController.text.isNotEmpty
        ? double.tryParse(discountPriceController.text)
        : 0.0;
    final deliveryFee = deliveryFeeController.text.isNotEmpty
        ? double.tryParse(deliveryFeeController.text)
        : 0.0;

    if (price == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter a valid price')));
      return;
    }

    final params = CreateProductParams(
      imagePath: image!.path,
      imageName: image!.path.split('/').last,
      enName: nameController.text,
      enDescription: descriptionController.text,
      arName: nameController.text,
      arDescription: descriptionController.text,
      price: price,
      discountPrice: discountPrice ?? 0.0,
      categoryId: selectedCategoryId!,
      deliveryFee: deliveryFee ?? 0.0,
    );

    BlocProvider.of<ProductCubit>(context).uploadProduct(params);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Product')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Name
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Product Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Description
              TextField(
                controller: descriptionController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Price Fields
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: priceController,
                      decoration: const InputDecoration(
                        labelText: 'Price',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      controller: discountPriceController,
                      decoration: const InputDecoration(
                        labelText: 'Discount Price',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Category Dropdown
              InputDecorator(
                decoration: InputDecoration(
                  labelText: 'Category',
                  border: const OutlineInputBorder(),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                  errorText: _categoryError,
                ),
                child: _isLoadingCategories
                    ? const LinearProgressIndicator()
                    : DropdownButtonHideUnderline(
                        child: DropdownButton<int>(
                          value: selectedCategoryId,
                          isExpanded: true,
                          items: categories
                              .map((category) => DropdownMenuItem<int>(
                                    value: category['id'],
                                    child: Text(category['name']),
                                  ))
                              .toList(),
                          onChanged: (value) =>
                              setState(() => selectedCategoryId = value),
                          hint: const Text('Select Category'),
                        ),
                      ),
              ),
              const SizedBox(height: 16),

              // Delivery Fee
              TextField(
                controller: deliveryFeeController,
                decoration: const InputDecoration(
                  labelText: 'Delivery Fee',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              const SizedBox(height: 16),

              // Image Upload
              const Text('Product Image',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: image == null
                      ? const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add_a_photo, size: 40),
                              Text('Tap to upload photo'),
                            ],
                          ),
                        )
                      : Image.file(image!, fit: BoxFit.cover),
                ),
              ),
              const SizedBox(height: 24),
// Submit Button
              BlocConsumer<ProductCubit, ProductState>(
                listener: (context, state) {
                  // Handle loading state
                  if (state.isLoading) {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (_) =>
                          const Center(child: CircularProgressIndicator()),
                    );
                  }
                  // Handle success state
                  else if (state.productData != null) {
                    // Close loading dialog if open
                    if (Navigator.of(context, rootNavigator: true).canPop()) {
                      Navigator.of(context, rootNavigator: true).pop();
                    }

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Product added successfully')),
                    );
                    
                    // Delay navigation to allow snackbar to be visible
                    Future.delayed(const Duration(milliseconds: 1500), () {
                      Navigator.pop(context, true);
                    });
                  }
                  // Handle error state
                  else if (state.error != null) {
                    // Close loading dialog if open
                    if (Navigator.of(context, rootNavigator: true).canPop()) {
                      Navigator.of(context, rootNavigator: true).pop();
                    }

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error: ${state.error}')),
                    );
                  }
                },
                builder: (context, state) {
                  return SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: state.isLoading ? null : _addProduct,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Colors.blue,
                        // Disable button when loading
                        disabledBackgroundColor: Colors.blue.withOpacity(0.5),
                      ),
                      child: state.isLoading
                          ? const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text('Uploading...',
                                    style: TextStyle(color: Colors.white))
                              ],
                            )
                          : Text(
                              'Add Product',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
