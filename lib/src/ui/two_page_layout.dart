import 'package:flutter/material.dart';
import 'package:multi_screen_layout/multi_screen_layout.dart';
import 'package:multi_screen_layout/src/ui/multi_screen_info.dart';

/// Always displays [child], [secondChild] is displayed if the app is spanned
/// across 2 displays.
///
/// Relevant Microsoft layout documentation:
/// Two Page: https://docs.microsoft.com/en-us/dual-screen/introduction#two-page
/// Dual View: https://docs.microsoft.com/en-us/dual-screen/introduction#dual-view
/// Companion Pane: https://docs.microsoft.com/en-us/dual-screen/introduction#companion-pane
class TwoPageLayout extends StatelessWidget {
  final Widget child;
  final Widget secondChild;

  /// Allows you to disable the two page layout behavior for specific types of
  /// multi screen devices
  final List<MultiScreenType> disableFor;

  const TwoPageLayout({
    Key? key,
    required this.child,
    required this.secondChild,
    this.disableFor = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiScreenInfo(
      builder: (info) {
        if (info.shouldDisplayAcrossScreens()) {
          if (info.foldDirection == FoldDirection.horizontal ||
              info.foldDirection == FoldDirection.none) {
            return Row(
              children: <Widget>[
                Expanded(child: child),
                if (info.surfaceDuoInfoModel.seemThickness > 0)
                  SizedBox(width: info.surfaceDuoInfoModel.seemThickness),
                Expanded(child: secondChild),
              ],
            );
          } else {
            return Column(
              children: <Widget>[
                Expanded(child: child),
                if (info.surfaceDuoInfoModel.seemThickness > 0)
                  SizedBox(width: info.surfaceDuoInfoModel.seemThickness),
                Expanded(child: secondChild),
              ],
            );
          }
        }
        return child;
      },
    );
  }
}
