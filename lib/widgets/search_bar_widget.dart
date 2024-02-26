import 'package:flutter/material.dart';
import 'package:pg_mobile/constraints/app_color.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({Key? key}) : super(key: key);
  final double textFormFieldHeight = 36;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: textFormFieldHeight,
      child: TextFormField(
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
          filled: true,
          fillColor: AppColor.gray2,
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
