import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:menejemen_waktu/src/core/controllers/theme_controller.dart';
import 'package:menejemen_waktu/src/core/controllers/user_controller.dart';
import 'package:menejemen_waktu/src/core/models/user_builder.dart';
import 'package:menejemen_waktu/src/ui/screens/app/pages/layout_screen.dart';
import 'package:menejemen_waktu/src/utils/contants/colors.2.0.dart';
import 'package:menejemen_waktu/src/utils/contants/contants.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final _theme = Get.find<ThemeController>();
  final _user = Get.find<UserController>();

  Widget _buildBody() {
    UserBuilder user = _user.currentUser ?? UserBuilder();

    return Obx(() {
      return Column(
        children: [
          Card(
            color: defaultContainerSecondaryLayoutColor,
            margin: const EdgeInsets.only(
              bottom: defaultPadding,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: InkWell(
              onTap: () {
                Get.toNamed("/profile");
              },
              borderRadius: BorderRadius.circular(8.0),
              splashColor: Colors.grey.withOpacity(0.5),
              child: ListTile(
                title: Text(
                  user.displayName,
                  style: bodyTextStyle.copyWith(
                    fontSize: 17.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                subtitle: Text(
                  user.email,
                  style: bodyTextStyle.copyWith(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(50.0),
                  child: CircleAvatar(
                    radius: 25.0,
                    backgroundImage: (_user.currentUser != null &&
                            _user.currentUser!.photoURL.isNotEmpty)
                        ? NetworkImage(
                            _user.currentUser!.photoURL,
                          )
                        : null,
                  ),
                ),
                trailing: const Icon(Icons.arrow_forward_ios, size: 20.0),
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          _buildCard(
            onTap: () {},
            child: ListTile(
              title: Text(
                "Dark Mode",
                style: bodyTextStyle.copyWith(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              trailing: Transform.scale(
                scale: 0.8,
                child: Switch(
                  activeColor:
                      _theme.isDarkMode.value ? Colors.white : Colors.black,
                  value: _theme.isDarkMode.value,
                  onChanged: (value) {
                    _theme.setThemeData(
                      value ? ThemeMode.dark : ThemeMode.light,
                    );
                  },
                ),
              ),
            ),
          ),
          const Spacer(
            flex: 15,
          ),
          _buildCard(
            onTap: () async {
              await _user.logout();
            },
            child: ListTile(
              title: Text(
                "Logout",
                style: bodyTextStyle.copyWith(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              leading: const Icon(Icons.logout, size: 25.0),
            ),
          ),
          const Spacer(),
        ],
      );
    });
  }

  Widget _buildCard({
    required Function() onTap,
    required Widget child,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: defaultPadding),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      color: defaultContainerSecondaryLayoutColor,
      child: InkWell(
        borderRadius: BorderRadius.circular(8.0),
        splashColor: Colors.grey.withOpacity(0.5),
        onTap: onTap,
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return LayoutScreen(
        title: Text(
          "Settings",
          style: appBarTitleStyle,
        ),
        bodyChild: _buildBody(),
      );
    });
  }
}
