import 'package:cached_network_image/cached_network_image.dart';
import 'package:client/app/components/profile_button/bloc/user_settings_bloc.dart';
import 'package:core_components/core_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hwdb_models/hwdb_models.dart';

class UserSettingsDrawer extends StatelessWidget {
  const UserSettingsDrawer({required this.currentUser, super.key});

  final User currentUser;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserSettingsBloc(
        auth: context.read(),
        userRepository: context.read(),
      ),
      child: Drawer(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: Space.space40,
            horizontal: Space.space24,
          ),
          child: ListView(
            children: [
              Text(
                'Hi, ${currentUser.name}',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: Space.space40),
              CircleAvatar(radius: 40, backgroundImage: CachedNetworkImageProvider(currentUser.profile)),
              const SizedBox(height: Space.space16),
              Center(
                child: TextButton(
                  onPressed: () {
                    // TODO(xiru): pick image
                    // context.read<UserSettingsBloc>().add(ChangeProfileImage(profile: profile));
                  },
                  child: const Text('Change Profile Image'),
                ),
              ),
              const SizedBox(height: Space.space24),
              ListTile(
                onTap: _goToMyAccount,
                title: const Text('Account'),
                trailing: const Icon(Icons.person),
              ),
              ListTile(
                onTap: _goToSettings,
                title: const Text('Settings'),
                trailing: const Icon(Icons.settings),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _goToSettings() {
    print('TAPPED SETTINGS');
  }

  void _goToMyAccount() {
    print('TAPPED PERSON');
  }
}
