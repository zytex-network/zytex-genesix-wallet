import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:xelis_mobile_wallet/features/settings/application/app_localizations_provider.dart';
import 'package:xelis_mobile_wallet/features/settings/presentation/components/layout_widget.dart';
import 'package:xelis_mobile_wallet/features/wallet/application/wallet_provider.dart';
import 'package:xelis_mobile_wallet/shared/providers/snackbar_content_provider.dart';
import 'package:xelis_mobile_wallet/shared/providers/snackbar_event.dart';
import 'package:xelis_mobile_wallet/shared/theme/extensions.dart';
import 'package:xelis_mobile_wallet/shared/theme/constants.dart';
import 'package:xelis_mobile_wallet/shared/widgets/components/background_widget.dart';
import 'package:xelis_mobile_wallet/shared/widgets/components/password_textfield_widget.dart';

class ChangePasswordScreen extends ConsumerStatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  ConsumerState<ChangePasswordScreen> createState() =>
      _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends ConsumerState<ChangePasswordScreen> {
  final _openFormKey = GlobalKey<FormBuilderState>(debugLabel: '_openFormKey');

  void _changePassword() async {
    if (_openFormKey.currentState?.saveAndValidate() ?? false) {
      final loc = ref.read(appLocalizationsProvider);

      final oldPassword =
          _openFormKey.currentState?.value['old_password'] as String;
      final newPassword =
          _openFormKey.currentState?.value['new_password'] as String;
      final confirmNewPassword =
          _openFormKey.currentState?.value['confirm_new_password'] as String;

      if (oldPassword == newPassword) {
        _openFormKey.currentState?.fields['new_password']
            ?.invalidate(loc.same_old_new_password_error);
      } else if (newPassword != confirmNewPassword) {
        _openFormKey.currentState?.fields['confirm_new_password']
            ?.invalidate(loc.not_match_new_password_error);
      } else {
        try {
          context.loaderOverlay.show();

          await ref
              .read(walletStateProvider)
              .nativeWalletRepository!
              .changePassword(
                  oldPassword: oldPassword, newPassword: newPassword);

          ref
              .read(snackbarContentProvider.notifier)
              .setContent(SnackbarEvent.info(message: loc.password_changed));
        } catch (e) {
          ref
              .read(snackbarContentProvider.notifier)
              .setContent(SnackbarEvent.error(
                message: e.toString(),
              ));
        }

        if (mounted) {
          context.loaderOverlay.hide();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = ref.watch(appLocalizationsProvider);
    return Scaffold(
      body: Background(
        child: Padding(
          padding: const EdgeInsets.all(Spaces.large),
          child: FormBuilder(
            key: _openFormKey,
            onChanged: () => _openFormKey.currentState!.save(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BackHeader(title: loc.change_password),
                const SizedBox(height: Spaces.large),
                PasswordTextField(
                  textField: FormBuilderTextField(
                    name: 'old_password',
                    style: context.bodyLarge,
                    autocorrect: false,
                    decoration: InputDecoration(
                      hintText: loc.old_password,
                    ),
                    validator: FormBuilderValidators.required(),
                  ),
                ),
                const SizedBox(height: Spaces.medium),
                PasswordTextField(
                  textField: FormBuilderTextField(
                    name: 'new_password',
                    style: context.bodyLarge,
                    autocorrect: false,
                    decoration: InputDecoration(
                      hintText: loc.new_password,
                    ),
                    validator: FormBuilderValidators.required(),
                  ),
                ),
                const SizedBox(height: Spaces.medium),
                PasswordTextField(
                  textField: FormBuilderTextField(
                    name: 'confirm_new_password',
                    style: context.bodyLarge,
                    autocorrect: false,
                    decoration: InputDecoration(
                      hintText: loc.confirm_password,
                    ),
                    validator: FormBuilderValidators.required(),
                  ),
                ),
                const SizedBox(height: Spaces.medium),
                FilledButton(
                  onPressed: _changePassword,
                  child: Text(loc.confirm_button),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
