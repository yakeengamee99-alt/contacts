import 'dart:io';

import 'package:contact_assignment/core/theme/app_colors.dart';
import 'package:contact_assignment/core/theme/app_fonts.dart';
import 'package:contact_assignment/ui/widgets/add_contact_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HomeScreens extends StatefulWidget {
  const HomeScreens({super.key});

  @override
  State<HomeScreens> createState() => _HomeScreensState();
}

class _HomeScreensState extends State<HomeScreens> {
  List<Map<String, String?>> contacts = [];

  Future<void> openAddContact() async {
    final contact = await showModalBottomSheet<Map<String, String?>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.darkBlue,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (context) => const AddContactBottomSheet(),
    );

    if (contact != null) {
      setState(() {
        contacts.add(contact);
      });
    }
  }

  void deleteContact(int index) {
    setState(() {
      contacts.removeAt(index);
    });
  }

  void deleteLastContact() {
    if (contacts.isNotEmpty) {
      setState(() {
        contacts.removeLast();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBlue,

      // أزرار الإضافة والحذف العائمة
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (contacts.isNotEmpty) ...[
            FloatingActionButton(
              heroTag: 'delete_btn',
              onPressed: deleteLastContact,
              backgroundColor: const Color(0xFFF93E3E),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            const SizedBox(height: 12),
          ],
          FloatingActionButton(
            heroTag: 'add_btn',
            onPressed: openAddContact,
            backgroundColor: const Color(0xFFFFF1D4),
            child: Icon(Icons.add, color: AppColors.darkBlue, size: 28),
          ),
        ],
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset("assets/images/route.png", width: 120),

              const SizedBox(height: 20),

              Expanded(
                child: contacts.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Lottie.asset(
                              "assets/animations/empty_list.json",
                              width: 250,
                              height: 250,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "There is No Contacts Added Here",
                              textAlign: TextAlign.center,
                              style: titleMedium(),
                            ),
                          ],
                        ),
                      )
                    : GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                              childAspectRatio: 0.62,
                            ),
                        itemCount: contacts.length,
                        itemBuilder: (context, index) {
                          final contact = contacts[index];
                          return _buildContactCard(contact, index);
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactCard(Map<String, String?> contact, int index) {
    const Color goldColor = Color(0xFFFFF1D4);

    return Container(
      decoration: BoxDecoration(
        color: goldColor,
        borderRadius: BorderRadius.circular(16),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // الصورة مع شارة الاسم
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                contact["image"] != null
                    ? Image.file(File(contact["image"]!), fit: BoxFit.cover)
                    : Container(
                        color: AppColors.darkBlue.withOpacity(0.15),
                        child: Icon(
                          Icons.person,
                          size: 60,
                          color: AppColors.darkBlue,
                        ),
                      ),
                Positioned(
                  bottom: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: goldColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      contact["name"] ?? "",
                      style: TextStyle(
                        color: AppColors.darkBlue,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // بيانات الإيميل والهاتف وزر الحذف
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.email, size: 16, color: AppColors.darkBlue),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        contact["email"] ?? "",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppColors.darkBlue,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(
                      Icons.phone_in_talk,
                      size: 16,
                      color: AppColors.darkBlue,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        contact["phone"] ?? "",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppColors.darkBlue,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  height: 32,
                  child: ElevatedButton.icon(
                    onPressed: () => deleteContact(index),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF93E3E),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.zero,
                    ),
                    icon: const Icon(Icons.delete, size: 16),
                    label: const Text("Delete", style: TextStyle(fontSize: 12)),
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
