// ignore_for_file: library_private_types_in_public_api

import 'package:e_commerece_app/core/style/text/apptextstyle.dart';
import 'package:e_commerece_app/features/home/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AboutYourself extends StatefulWidget {
  const AboutYourself({super.key});

  @override
  _AboutYourselfState createState() => _AboutYourselfState();
}

class _AboutYourselfState extends State<AboutYourself> {
  String selectedGender = 'Men';
  String selectedAgeRange = 'Age Range';
  final List<String> ageRanges = ['18-24', '25-34', '35-44', '45-54', '55+'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(27.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 123.0),
              child: Text(
                'Tell us About yourself',
                style: AppTextStyles.black24w500,
              ),
            ),
            const SizedBox(height: 40),

            // Gender Selection
            Text(
              'Who do you shop for?',
              style: AppTextStyles.black16w500,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => selectedGender = 'Men'),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: selectedGender == 'Men'
                            ? const Color.fromARGB(255, 142, 108, 239)
                            : const Color.fromARGB(255, 244, 244, 244),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Center(
                        child: Text(
                          'Men',
                          style: TextStyle(
                            color: selectedGender == 'Men'
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => selectedGender = 'Women'),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: selectedGender == 'Women'
                            ? const Color.fromARGB(255, 142, 108, 239)
                            : const Color.fromARGB(255, 244, 244, 244),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Center(
                        child: Text(
                          'Women',
                          style: TextStyle(
                            color: selectedGender == 'Women'
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),

            // Age Range Dropdown
            Text(
              'How Old are you?',
              style: AppTextStyles.black16w500,
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 244, 244, 244),
                borderRadius: BorderRadius.circular(100),
              ),
              child: DropdownButton<String>(
                icon: SvgPicture.asset('assets/Icons/arrowdown2.svg'),
                value:
                    selectedAgeRange == 'Age Range' ? null : selectedAgeRange,
                hint: Text('Age Range', style: AppTextStyles.black16w500),
                isExpanded: true,
                underline: const SizedBox(),
                items: ageRanges.map((age) {
                  return DropdownMenuItem(
                    value: age,
                    child: Text(age),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedAgeRange = value!;
                  });
                },
              ),
            ),
            const Spacer(),
          ],
        ),
      ),

      // BottomAppBar with Finish Button
      bottomNavigationBar: BottomAppBar(
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 142, 108, 239),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text(
              'Finish',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
