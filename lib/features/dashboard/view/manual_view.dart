import 'package:build_smart/config/common_imports.dart';
import 'package:build_smart/core/utils/extensions.dart';
import 'package:build_smart/features/dashboard/view/widgets/cached_image.dart';
import 'package:build_smart/features/dashboard/view_model/manual_state.dart';
import 'package:build_smart/features/dashboard/view_model/manual_view_model.dart';

class ManualView extends ConsumerStatefulWidget {
  const ManualView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ManualViewState();
}

class _ManualViewState extends ConsumerState<ManualView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(manualViewModelProvider.notifier).getManual();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final manualState = ref.watch(manualViewModelProvider);
    switch (manualState.status) {
      case ManualStatus.loading:
        return const Center(
          child: CircularProgressIndicator(),
        );
      case ManualStatus.success:
        return _buildBody(theme, manualState).giveHPadding(padding: 15.w);

      case ManualStatus.error:
        return Center(
          child: Text(manualState.error ?? 'Something Went Wrong'),
        );

      default:
        return const SizedBox.shrink();
    }
  }

  Column _buildBody(ThemeData theme, ManualState manualState) {
    return Column(
      children: [
        height(30.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Home Manauls',
              style: TextStyle(
                  color: theme.secondaryHeaderColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp),
            ),
            Container(
              height: 40.h,
              width: 50.w,
              decoration: BoxDecoration(
                color: theme.primaryColor,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(
                Icons.download_for_offline_outlined,
                color: theme.highlightColor,
              ),
            )
          ],
        ),
        height(30.h),
        Expanded(
            child: ListView.builder(
                itemCount: manualState.data?.image.length,
                itemBuilder: (_, index) {
                  return Container(
                    height: 200.h,
                    width: 1.sw,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.r))),
                    child: CachedImageWithProgress(
                        height: 200.h,
                        width: 1.sw,
                        imageUrl: manualState.data!.image[index]),
                  ).giveBPadding(padding: 10);
                }))
      ],
    );
  }
}
