import 'package:e_commerece_app/features/home/data/data_source/homepage_not_this_project/RemoteCategoryDataSource.dart';
import 'package:e_commerece_app/features/home/data/data_source/homepage_not_this_project/homepage_not_thisproject_remoteProductDataSource.dart';
import 'package:e_commerece_app/features/home/presentation/managers/CategoryCubit.dart';
import 'package:e_commerece_app/features/home/presentation/managers/productcubit.dart';
import 'package:e_commerece_app/features/home/presentation/pages/home_page.dart';
import 'package:e_commerece_app/features/home/presentation/pages/product_services_page.dart';
import 'package:e_commerece_app/features/home/presentation/pages/settings_page.dart';
import 'package:e_commerece_app/features/home/presentation/widgets/bottom_sheet_acc_new_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({super.key});

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  final TextEditingController categoryTitleController = TextEditingController();
  final TextEditingController dateTitleController = TextEditingController();
  final PageController _pageController = PageController(initialPage: 0);
  final List<ValueNotifier<double>> _iconScales =
      List.generate(3, (_) => ValueNotifier(1.0));
  int _currentIndex = 0;

  @override
  void dispose() {
    categoryTitleController.dispose();
    dateTitleController.dispose();
    _pageController.dispose();
    for (final scale in _iconScales) {
      scale.dispose();
    }
    super.dispose();
  }

  void navigateToPage(int index) {
    setState(() {
      _currentIndex = index;
      _iconScales[_currentIndex].value = 1.5;
      for (int i = 0; i < _iconScales.length; i++) {
        if (i != _currentIndex) _iconScales[i].value = 1.0;
      }
      _pageController.jumpToPage(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) =>
                CategoryCubit(RemoteCategoryDataSource())..fetchCategories(),
          ),
          BlocProvider(
            create: (_) =>
                Productcubit(RemoteProductDataSource())..fetchProdcuts(),
          ),
        ],
        child: PageView(
          controller: _pageController,
          // physics: const NeverScrollableScrollPhysics(),
          children: const [
            HomePage(),
            AddProductServicesPage(),
            SettingsPage(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddNewItemBottomSheet(context),
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildAnimatedIcon(
              icon: Icons.home,
              index: 0,
            ),
            _buildAnimatedIcon(
              icon: Icons.add,
              index: 1,
            ),
            _buildAnimatedIcon(
              icon: Icons.settings,
              index: 2,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedIcon({required IconData icon, required int index}) {
    return GestureDetector(
      onTap: () => _changePage(index),
      child: ValueListenableBuilder<double>(
        valueListenable: _iconScales[index],
        builder: (context, scale, child) {
          return AnimatedScale(
            scale: scale,
            duration: const Duration(milliseconds: 200),
            child: child,
          );
        },
        child: Icon(
          icon,
          color: _currentIndex == index
              ? const Color.fromARGB(255, 145, 33, 165)
              : null, // Dynamic color
        ),
      ),
    );
  }

  void _changePage(int index) {
    setState(() {
      _currentIndex = index;
      _iconScales[_currentIndex].value = 1.5;
      for (int i = 0; i < _iconScales.length; i++) {
        if (i != _currentIndex) {
          _iconScales[i].value = 1.0;
        }
        _pageController.animateToPage(
          index,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _showAddNewItemBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return BottomSheetAccNewItemWidget(
          categoryTitleController: categoryTitleController,
          dateController: dateTitleController,
        );
      },
    );
  }
}
