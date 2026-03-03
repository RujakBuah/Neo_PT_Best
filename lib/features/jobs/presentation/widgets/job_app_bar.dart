import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pt_best/core/theme/app_palete.dart';

class JobAppBar extends StatelessWidget implements PreferredSizeWidget {
  const JobAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(250);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: AppPalette.surfaceDark),
      child: Stack(
        children: [
          Positioned(
            top: -10,
            right: -40,
            child: Container(
              width: 180,
              height: 180,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Color(0x2900BFA5), // ~16% opacity teal
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Icon(
                      CupertinoIcons.person_crop_circle_fill,
                      color: AppPalette.iconDefault,
                      size: 50,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Icon(
                      CupertinoIcons.bell_circle_fill,
                      color: AppPalette.iconDefault,
                      size: 50,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: RichText(
                  text: TextSpan(
                    text: 'Find your\n',
                    style: Theme.of(context).textTheme.displayLarge,
                    children: [
                      TextSpan(
                        text: 'next ',
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      TextSpan(
                        text: 'job.',
                        style: Theme.of(context).textTheme.displayLarge!
                            .copyWith(color: AppPalette.primary),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  color: AppPalette.border,
                  height: 30,
                  width: double.infinity,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
