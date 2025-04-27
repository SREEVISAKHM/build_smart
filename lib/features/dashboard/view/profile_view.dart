import 'package:build_smart/config/common_imports.dart';
import 'package:build_smart/core/utils/build_smart_icons.dart';
import 'package:build_smart/core/utils/pref.dart';
import 'package:build_smart/features/dashboard/view_model/dashboard_state.dart';
import 'package:build_smart/features/splash/view/splash_view.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Info
            Row(
              children: [
                CircleAvatar(
                  radius: 35.r,
                  backgroundColor: theme.cardColor,
                  child: Text(
                    'NA',
                    style: TextStyle(color: Colors.white, fontSize: 24.sp),
                  ),
                ),
                width(16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Aaron N. Kaiser',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      height(4.h),
                      Text(
                        'aaron.n.kaiser',
                        style: TextStyle(color: theme.disabledColor),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.edit, size: 20.sp),
                ),
              ],
            ),
            height(20.h),

            // Email, Mobile, Address
            ProfileInfoRow(
              title: 'Email',
              value: 'aaron.n.kaiser@email.com',
              theme: theme,
            ),
            height(10.h),
            ProfileInfoRow(
                title: 'Mobile', value: '+1 (555) 123-4567', theme: theme),
            height(10.h),
            ProfileInfoRow(
                title: 'Address',
                value: '70 Washington Square South, New York, NY 10012, US',
                theme: theme),

            height(20.h),
            const Divider(thickness: 1),

            height(20.h),

            // House Image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl:
                    'https://starkhomes.ca/wp-content/uploads/stark-homes-custom-home-kelowna.jpg', // sample house image
                height: 120.h,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),

            const SizedBox(height: 20),

            // Property Info
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'The OAKS',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.sp,
                ),
              ),
            ),
            height(2.h),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Scarlet 35 Frontage',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                  color: theme.secondaryHeaderColor,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Features
            Wrap(
              alignment: WrapAlignment.spaceBetween,
              spacing: 100,
              runSpacing: 15,
              children: [
                PropertyFeature(
                  icon: BuildSmartIcons.edit,
                  label: '2,397 Sq Ft',
                  theme: theme,
                ),
                PropertyFeature(
                  icon: BuildSmartIcons.bed,
                  label: '4 Beds',
                  theme: theme,
                ),
                PropertyFeature(
                  icon: BuildSmartIcons.bath,
                  label: '3.5 Bath',
                  theme: theme,
                ),
                PropertyFeature(
                  icon: BuildSmartIcons.caravan,
                  label: '2 Car Garage',
                  theme: theme,
                ),
                PropertyFeature(
                  icon: BuildSmartIcons.home,
                  label: '2 Story',
                  theme: theme,
                ),
              ],
            ),

            height(20.h),

            // Logout Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  smartPref.clear();

                  Navigator.pushReplacementNamed(context, SplashView.route);
                  await Future.delayed(const Duration(milliseconds: 200));
                  ref.read(bottomNavProvider.notifier).change(0);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.indicatorColor,
                  foregroundColor: theme.hoverColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    'Logout',
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileInfoRow extends StatelessWidget {
  final String title;
  final String value;
  final ThemeData theme;

  const ProfileInfoRow(
      {super.key,
      required this.title,
      required this.value,
      required this.theme});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
            width: 70.w,
            child: Text(title, style: TextStyle(color: theme.disabledColor))),
        width(15.w),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}

class PropertyFeature extends StatelessWidget {
  final IconData icon;
  final String label;
  final ThemeData theme;
  const PropertyFeature(
      {super.key,
      required this.icon,
      required this.label,
      required this.theme});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 115.w,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 20, color: theme.secondaryHeaderColor),
          width(10.w),
          Text(
            label,
            style: TextStyle(color: theme.secondaryHeaderColor),
          ),
        ],
      ),
    );
  }
}
