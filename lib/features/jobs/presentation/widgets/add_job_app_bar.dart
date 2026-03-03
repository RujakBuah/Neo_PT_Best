import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pt_best/core/theme/app_palete.dart';

class AddJobAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AddJobAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(200);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(color: AppPalette.surfaceDark),
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 15),
            Icon(
              CupertinoIcons.arrowtriangle_left_circle,
              size: 50,
              color: AppPalette.tabUnselectedLabel,
            ),
            SizedBox(width: 20),
            RichText(
              text: TextSpan(
                text: 'Post a New Job\n',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge!.copyWith(color: Colors.white),
                children: [
                  TextSpan(
                    text: 'Fill in the details below',
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: AppPalette.textHint,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
