import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:waybill_sender/theme/app-theme.dart';
class SearchBar extends StatelessWidget {
  const SearchBar({
    Key key,
    this.searchController,
    this.showIcon,
    this.hintText,
    this.fillColor,
    this.borderColor,
    this.icon,
  }) : super(key: key);

  final TextEditingController searchController;
  final String hintText;
  final bool showIcon;
  final String icon;
  final Color fillColor;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 0.5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: searchController,
              cursorColor: Colors.black26,
              decoration: InputDecoration(
                  filled: true,
                  hintStyle: TextStyle(
                    fontSize: 14.5,
                    height: 1.6,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'DMSans',
                    color: AppColors.grey8,
                  ),
                  prefixIconConstraints: BoxConstraints(
                      minHeight: 24,
                      minWidth: 24
                  ),
                  prefixIcon:  showIcon?
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.asset(icon,
                        height: 22,
                        width: 22,),
                  ):
                  Container(),
                  hintText: hintText,
                  fillColor: fillColor,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0,
                      vertical: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: borderColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: borderColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: borderColor),
                  )
              ),
            ),
          ),
        ],
      ),
    );
  }
}