import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:w2d_customer_mobile/core/routes/routes_constants.dart';
import 'package:w2d_customer_mobile/core/utils/app_colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchCtrl = TextEditingController();
  bool notEmpty = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextField(
                autofocus: true,
                controller: _searchCtrl,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                    borderSide: BorderSide(color: AppColors.black70),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                    borderSide: BorderSide(color: AppColors.black70),
                  ),
                  hintText: 'Search',
                  hintStyle: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 16,
                  ),
                ),
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                ),
                onChanged: (text) {
                  if (text.isNotEmpty) {
                    setState(() {
                      notEmpty = true;
                    });
                  } else {
                    setState(() {
                      notEmpty = false;
                    });
                  }
                },
              ),
              if (notEmpty) ...[
                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.black70),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          context.pop();
                          context.push(AppRoutes.listingRoute);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            'Search Result',
                            style: TextStyle(fontSize: 30),
                          ),
                        ),
                      );
                    },
                    itemCount: 200,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
