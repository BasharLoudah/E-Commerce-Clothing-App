import 'package:e_commerece_app/features/home/data/data_source/homepage_not_this_project/RemoteCategoryDataSource.dart';
import 'package:e_commerece_app/features/home/data/data_source/homepage_not_this_project/homepage_not_thisproject_remoteProductDataSource.dart';
import 'package:e_commerece_app/features/home/presentation/managers/CategoryCubit.dart';
import 'package:e_commerece_app/features/home/presentation/managers/productcubit.dart';
import 'package:e_commerece_app/features/home/presentation/widgets/bottom_sheet_acc_new_item_widget.dart';
import 'package:e_commerece_app/features/home/presentation/widgets/category_list_widget.dart';

import 'package:e_commerece_app/features/home/presentation/widgets/top_selling_section.dart';
import 'package:e_commerece_app/features/home/presentation/widgets/search_section.dart';
import 'package:e_commerece_app/features/home/presentation/widgets/top_section_homePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController categoryTitleController = TextEditingController();
  final TextEditingController dateTitleController = TextEditingController();
  final int _currentIndex = 0;
  late Widget _currentPage;

  final List<Widget> _pages = [
    const SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              TopSectionHomePage(),
              SizedBox(height: 20),
              SearchSectionHomePage(),
              SizedBox(height: 10),
              CategoryListWidget(),
              SizedBox(height: 10),
              TopSellingSectionPage(),
            ],
          ),
        ),
      ),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _currentPage = _pages[_currentIndex];
  }

  @override
  void dispose() {
    categoryTitleController.dispose();
    dateTitleController.dispose();
    super.dispose();
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
        child: _currentPage,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddNewItemBottomSheet(context),
        child: const Icon(Icons.add),
      ),

    );
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





// ElevatedButton(
//                 onPressed: () {
//                   context.setLocale(Locale('en'));

//                 },
//                 child: Text('English')),
//             // Text('Hello 3'),
//             ElevatedButton(
//                 onPressed: () {
//                   context.setLocale(Locale('ar'));
//                 },
//                 child: Text('Arabic'))
