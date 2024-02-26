import 'package:flutter/material.dart';
import 'package:pg_mobile/constraints/app_color.dart';
import 'package:pg_mobile/constraints/app_controller.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({Key? key}) : super(key: key);

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final double textFormFieldHeight = 36;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: textFormFieldHeight,
      child: TextFormField(
        controller: AppController.searchController,
        style: const TextStyle(
          color: AppColor.white,
        ),
        decoration: InputDecoration(
          hintText: 'Search',
          hintStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.035,
            color: AppColor.gray3,
          ),
          prefixIcon: const Icon(
            Icons.search,
            size: 25,
            color: AppColor.gray3,
          ),
          suffixIcon: IconButton(
            icon: const Icon(
              Icons.close,
              color: AppColor.gray3,
              size: 20,
            ),
            onPressed: () {
              setState(() {
                AppController.searchController.text = "";
              });
            },
          ),
          filled: true,
          fillColor: AppColor.gray2,
          isDense: true,
          // hintTextのSearchが真ん中に来るように調整
          contentPadding: const EdgeInsets.symmetric(vertical: 6),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
        ),
      ),
    );
  }
}
