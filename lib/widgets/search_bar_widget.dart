import 'package:flutter/material.dart';
import 'package:pg_mobile/constants/app_colors.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({Key? key}) : super(key: key);

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final TextEditingController _searchController = TextEditingController();
  final double textFormFieldHeight = 36;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: textFormFieldHeight,
      child: TextFormField(
        controller: _searchController,
        style: Theme.of(context).textTheme.bodyMedium,
        decoration: InputDecoration(
          hintText: 'Search',
          hintStyle: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: AppColors.gray3),
          prefixIcon: const Icon(
            Icons.search,
            size: 25,
            color: AppColors.gray3,
          ),
          suffixIcon: IconButton(
            icon: const Icon(
              Icons.close,
              color: AppColors.gray3,
              size: 20,
            ),
            onPressed: () {
              setState(() {
                _searchController.text = '';
              });
            },
          ),
          filled: true,
          fillColor: AppColors.gray2,
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
