import 'package:cached_network_image/cached_network_image.dart';
import 'package:client/app/pages/courses/bloc/courses_bloc.dart';
import 'package:core_components/core_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hwdb_models/hwdb_models.dart';

class CoursesPage extends StatelessWidget {
  const CoursesPage({super.key});

  // TODO(xiru): change all blocbuilders to build on demand
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          CoursesBloc(userRepository: context.read(), courseRepository: context.read())..add(const LoadPage()),
      child: BlocBuilder<CoursesBloc, CoursesState>(
        builder: (context, state) {
          return switch (state.status) {
            CoursesStatus.loading => const LoadingPage(),
            CoursesStatus.loaded => CoursesView(state),
            CoursesStatus.error => ErrorPage(errorMessage: state.errorMessage),
          };
        },
      ),
    );
  }
}

class CoursesView extends StatelessWidget {
  const CoursesView(this.state, {super.key});

  final CoursesState state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
      appBar: AppBar(
        title: const Text('HW Courses'),
        centerTitle: true,
        actions: _appBarTrailing(context),
      ),
      body: Padding(
        padding: const EdgeInsets.all(Space.space60),
        child: Column(
          children: [
            const CourseSearchBar(),
            const SizedBox(height: Space.space40),
            CourseList(state),
          ],
        ),
      ),
    );
  }

  List<Widget> _appBarTrailing(BuildContext context) {
    return [
      IconButton(onPressed: () => context.goNamed('home'), icon: const Icon(Icons.home_rounded)),
      const SizedBox(width: Space.space24),
    ];
  }
}

class CourseList extends StatelessWidget {
  const CourseList(this.state, {super.key});

  final CoursesState state;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: state.filteredCourses.isEmpty
          ? const Center(child: Text('No Courses Found'))
          : ListView.builder(
              itemCount: state.filteredCourses.length,
              itemBuilder: (BuildContext context, int index) {
                final currentCourse = state.filteredCourses[index];
                final currentTeacher = state.teachers![currentCourse.id]!;
                return CourseTile(currentCourse: currentCourse, currentTeacher: currentTeacher);
              },
            ),
    );
  }
}

class CourseTile extends StatelessWidget {
  const CourseTile({
    required this.currentCourse,
    required this.currentTeacher,
    super.key,
  });

  final Course currentCourse;
  final User currentTeacher;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.pushNamed('courseDetail', pathParameters: {'courseID': currentCourse.id}),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _courseTitle(context),
            _courseDetail(context),
          ],
        ),
      ),
    );
  }

  Padding _courseDetail(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: Space.space24),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: Space.space8,
                backgroundImage: CachedNetworkImageProvider(currentTeacher.profile),
              ),
              const SizedBox(width: Space.space8),
              Text(currentTeacher.name),
            ],
          ),
          Text(
            'G${currentCourse.grade} ${currentCourse.year}-${currentCourse.year + 1}',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }

  Padding _courseTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Space.space16),
      child: Text(currentCourse.name, style: Theme.of(context).textTheme.titleMedium),
    );
  }
}

class CourseSearchBar extends StatelessWidget {
  const CourseSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      leading: const Icon(Icons.search_rounded),
      padding: const MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: Space.space16)),
      hintText: 'Search Courses',
      onSubmitted: (value) => context.read<CoursesBloc>().add(SearchCourses(keyword: value)),
      elevation: const MaterialStatePropertyAll(1),
      overlayColor: const MaterialStatePropertyAll(Colors.transparent),
    );
  }
}
