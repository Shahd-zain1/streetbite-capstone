import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streetbite/core/utils/error_kind_message.dart';
import 'package:streetbite/core/utils/l10n_extension.dart';
import 'package:streetbite/core/utils/snackbar.dart';
import 'package:streetbite/domain/entities/app_user.dart';
import 'package:streetbite/presentation/blocs/profile/profile_cubit.dart';
import 'package:streetbite/presentation/blocs/profile/profile_state.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({required this.user, super.key});

  final AppUser user;

  Future<void> _changePhoto(BuildContext context) async {
    final failure = await context.read<ProfileCubit>().changePhoto();
    if (failure != null && context.mounted) {
      showAppSnackBar(context, failure.kind.message(context.l10n));
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        BlocBuilder<ProfileCubit, ProfileState>(
          buildWhen: (previous, current) =>
              previous.photoBase64 != current.photoBase64 ||
              previous.isUploading != current.isUploading,
          builder: (context, state) {
            final photo = state.photoBase64;
            return Stack(
              children: [
                CircleAvatar(
                  radius: 56,
                  backgroundImage: photo == null
                      ? null
                      : MemoryImage(base64Decode(photo)),
                  child: photo == null
                      ? const Icon(Icons.person, size: 56)
                      : null,
                ),
                if (state.isUploading)
                  const Positioned.fill(child: CircularProgressIndicator()),
                PositionedDirectional(
                  end: 0,
                  bottom: 0,
                  child: IconButton.filled(
                    tooltip: context.l10n.changePhoto,
                    icon: const Icon(Icons.photo_camera_outlined),
                    onPressed: state.isUploading
                        ? null
                        : () => _changePhoto(context),
                  ),
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 12),
        Text(
          user.name,
          style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
        ),
        Text(user.email, style: textTheme.bodyMedium),
      ],
    );
  }
}
