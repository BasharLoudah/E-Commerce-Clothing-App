// ignore_for_file: constant_identifier_names

class ApiUrls {
  // Base URLs
  static const String baseURl_provider_app =
      'http://94.72.98.154/abdulrahim/public/api';
  static const String baseURl_ecommerce = 'https://api.escuelajs.co/api/v1';

  // Authentication Endpoints
  static const String login = '$baseURl_provider_app/auth/login';
  static const String register = '$baseURl_provider_app/auth/register';
  static const String logout = '$baseURl_provider_app/auth/logout';
  static const String registerAsProvider =
      '$baseURl_provider_app/auth/register-as-provider';
  static String changeAppointmentStatus(int appointmentId) =>
      '$baseURl_provider_app/appointments/change-status/$appointmentId';

  // Product Endpoints
  static const String getProducts = '$baseURl_provider_app/products';
  static String getProductDetails(String productId) =>
      '$baseURl_provider_app/products/$productId';
  static const String storeProduct = '$baseURl_provider_app/products';
  static String updateProduct(String productId) =>
      '$baseURl_provider_app/products/$productId';
  static String deleteProduct(String productId) =>
      '$baseURl_provider_app/products/$productId';

  // Service Endpoints
  static const String getServices = '$baseURl_provider_app/services';
  static String getServiceDetails(String serviceId) =>
      '$baseURl_provider_app/services/$serviceId';
  static const String storeService = '$baseURl_provider_app/services';

  // Category Endpoints
  static const String getCategories = '$baseURl_provider_app/categories';
  static const String storeCategory = '$baseURl_provider_app/categories';

  // User Endpoints
  static const String userProfile = '$baseURl_provider_app/user/profile';

  // Ecommerce Endpoints (Platzi Fake Store)
  static const String ecomCategory = '$baseURl_ecommerce/categories/';
  static const String ecomProduct = '$baseURl_ecommerce/products/';
}
