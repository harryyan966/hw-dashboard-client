import 'package:client/app/components/profile_button/view/user_settings_drawer.dart';
import 'package:client/app/pages/home/bloc/home_bloc.dart';
import 'package:core_components/core_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // TODO(xiru): change all blocbuilders to build on demand
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(clientAuth: context.read())..add(const LoadPage()),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return switch (state.status) {
            HomeStatus.loading => const LoadingPage(),
            HomeStatus.loaded => HomeView(state),
          };
        },
      ),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView(this.state, {super.key});

  final HomeState state;

  @override
  Widget build(BuildContext context) {
    final scaffold = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffold,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('HW Dashboard', style: Theme.of(context).textTheme.titleMedium),
        actions: _appBarActions(context, scaffold),
      ),
      endDrawer: _endDrawer(),
      body: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView(
          children: const [
            TitleAndMainImage(),
            ImageWithContent(
              title: 'Brings Essential Information Together',
              description:
                  'HW Dashboard connects the enthusiasts with their passions, the strivers with their performances, the wanderers with the experienced, and the learners with the world.',
            ),
            ImageWithContent(
              title: 'Encourages students to improve their lives',
              description:
                  'A software developed and maintained by students, HW Dashboard is free to modification for the benefit of the student body. It is an extensible tool open to updates and improvements by those striving to make school life better.',
              imageAtLeft: false,
            ),
            CallToContribution(),
            Footer(),
          ],
        ),
      ),
    );
  }

  List<Widget> _appBarActions(BuildContext context, GlobalKey<ScaffoldState> scaffold) {
    return [
        TextButton(onPressed: () {}, child: const Text('Clubs')),
        TextButton(onPressed: () => context.pushNamed('courses'), child: const Text('Courses')),
        TextButton(onPressed: () {}, child: const Text('Homerooms')),
        TextButton(onPressed: () {}, child: const Text('Blogs')),
        TextButton(onPressed: () {}, child: const Text('College Application')),
        const SizedBox(width: Space.space8),
        _appBarTrailing(context, scaffold),
        const SizedBox(width: Space.space24),
      ];
  }

  UserSettingsDrawer? _endDrawer() =>
      state.currentUser == null ? null : UserSettingsDrawer(currentUser: state.currentUser!);

  Widget _appBarTrailing(BuildContext context, GlobalKey<ScaffoldState> scaffold) {
    if (state.currentUser == null) {
      return FilledButton(onPressed: () => context.pushNamed('signIn'), child: const Text('Sign In'));
    }
    return IconButton(onPressed: () => scaffold.currentState!.openEndDrawer(), icon: const Icon(Icons.person));
  }
}

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surfaceVariant,
      height: Space.space240,
      padding: const EdgeInsets.all(Space.space40),
      child: Row(
        children: [
          _contact(context),
          _faqs(context),
        ],
      ),
    );
  }

  Expanded _faqs(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('FAQ', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: Space.space24),
          Text(
            'none yet.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }

  Expanded _contact(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Contact', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: Space.space24),
          Text(
            'WeChat / Dingtalk / Tel: 13621120573',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: Space.space24),
        ],
      ),
    );
  }
}

class CallToContribution extends StatelessWidget {
  const CallToContribution({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Space.space40),
      child: Column(
        children: [
          Text('Become givers like them.', style: Theme.of(context).textTheme.headlineLarge),
          const SizedBox(height: Space.space40),
          _contributorsCarousel(),
          const SizedBox(height: Space.space40),
          _extraButtons(),
        ],
      ),
    );
  }

  Row _extraButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        FilledButton(onPressed: () {}, child: const Text('CONTRIBUTE')),
        FilledButton(onPressed: () {}, child: const Text('DONATE')),
      ],
    );
  }

  HWDBCarousel _contributorsCarousel() {
    return HWDBCarousel(
      itemCount: 3,
      itemBuilder: (context, index, realIndex) => const ImageWithContent(
        title: 'Jingyuan XU',
        description: 'Helped resolve global exception handling issue.',
      ),
      aspectRatio: 4 / 1,
      enlargeCenterPage: true,
      enlargeFactor: 0.6,
    );
  }
}

class ImageWithContent extends StatelessWidget {
  const ImageWithContent({
    required this.title,
    required this.description,
    this.imageAtLeft = true,
    super.key,
  });

  final String title;
  final String description;
  final bool imageAtLeft;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).colorScheme.surfaceVariant,
      child: Row(
        children: [
          if (imageAtLeft) _image(context),
          _text(context),
          if (!imageAtLeft) _image(context),
        ],
      ),
    );
  }

  Expanded _text(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Space.space40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: Space.space24),
            Text(
              description,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }

  Widget _image(BuildContext context) {
    return Expanded(
      child: Image.asset(
        'assets/sample.png',
        fit: BoxFit.cover,
      ),
    );
  }
}

class TitleAndMainImage extends StatelessWidget {
  const TitleAndMainImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        // image: DecorationImage(
        //   image: AssetImage('assets/homepage-background.png'),
        //   fit: BoxFit.cover,
        //   opacity: 0.5,
        // ),
        gradient: RadialGradient(
          colors: [
            Theme.of(context).colorScheme.surface,
            Theme.of(context).colorScheme.primaryContainer,
            Theme.of(context).colorScheme.surfaceVariant,
          ],
        ),
      ),
      // color: Colors.blue,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('HW Dashboard', style: Theme.of(context).textTheme.displayLarge),
            Text('by Xiru yan', style: Theme.of(context).textTheme.labelLarge),
          ],
        ),
      ),
    );
  }
}
