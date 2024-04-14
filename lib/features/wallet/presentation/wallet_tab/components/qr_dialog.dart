import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:genesix/features/wallet/application/wallet_provider.dart';
import 'package:genesix/shared/theme/constants.dart';
import 'package:genesix/shared/theme/extensions.dart';

class QrDialog extends ConsumerWidget {
  const QrDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final loc = ref.watch(appLocalizationsProvider);
    final walletSnapshot = ref.watch(walletStateProvider);

    // final userThemeMode = ref.watch(userThemeModeProvider);

    // var iconTarget = '';
    // switch (userThemeMode.themeMode) {
    //   case ThemeMode.system:
    //     if (context.mediaQueryData.platformBrightness == Brightness.light) {
    //       iconTarget = AppResources.svgIconWhiteTarget;
    //     } else {
    //       iconTarget = AppResources.svgIconBlackTarget;
    //     }
    //   case ThemeMode.light:
    //     iconTarget = AppResources.svgIconWhiteTarget;
    //   case ThemeMode.dark:
    //     iconTarget = AppResources.svgIconBlackTarget;
    // }

    return AlertDialog(
      scrollable: true,
      content: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 200,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: Spaces.small),
            SelectableText(
              walletSnapshot.address,
              style: context.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: context.moreColors.mutedColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: Spaces.large),
            PrettyQrView.data(
              data: walletSnapshot.address,
              decoration: PrettyQrDecoration(
                shape: PrettyQrSmoothSymbol(color: context.colors.onBackground),
                // image: PrettyQrDecorationImage(
                //   image: Image.network(iconTarget).image,
                // ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
