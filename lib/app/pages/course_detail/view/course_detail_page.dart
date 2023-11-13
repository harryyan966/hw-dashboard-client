import 'package:client/app/pages/course_detail/bloc/course_detail_bloc.dart';
import 'package:core_components/core_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hwdb_models/hwdb_models.dart';

class CourseDetailPage extends StatelessWidget {
  const CourseDetailPage({required this.courseID, super.key});

  final String? courseID;

  // TODO(xiru): change all blocbuilders to build on demand
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CourseDetailBloc(courseRepository: context.read())..add(LoadPage(courseID: courseID)),
      child: BlocBuilder<CourseDetailBloc, CourseDetailState>(
        builder: (context, state) {
          return switch (state.status) {
            CourseDetailStatus.loading => const LoadingPage(),
            CourseDetailStatus.loaded => CourseDetailView(state),
            CourseDetailStatus.error => ErrorPage(errorMessage: state.errorMessage),
          };
        },
      ),
    );
  }
}

class CourseDetailView extends StatelessWidget {
  const CourseDetailView(this.state, {super.key});

  final CourseDetailState state;

  @override
  Widget build(BuildContext context) {
    final course = state.course!;
    final assignments = state.assignments!;
    final selectedAssignment = state.selectedAssignment;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
      appBar: AppBar(
        title: Text(course.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(Space.space40),
        child: Column(
          children: [
            Text('Assignments 📖', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: Space.space24),
            Expanded(
              child: Row(
                children: [
                  AssignmentList(assignments: assignments),
                  Expanded(
                    child: Column(
                      children: [
                        AssignmentDetail(assignment: selectedAssignment),
                        const Expanded(
                          child: ColoredBox(color: Colors.blueAccent, child: Center(child: Text('Graph 📈'))),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AssignmentDetail extends StatelessWidget {
  const AssignmentDetail({
    this.assignment,
    super.key,
  });

  final Assignment? assignment;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: assignment == null
          ? Center(
              child: Text(
                'No Assignments Selected',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(Space.space16),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(Space.space40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(assignment!.name, style: Theme.of(context).textTheme.titleMedium),
                          Text(assignment!.type.name, style: Theme.of(context).textTheme.labelLarge),
                        ],
                      ),
                      const SizedBox(height: Space.space16),
                      Expanded(child: SingleChildScrollView(child: Text(assignment!.description))),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

class AssignmentList extends StatelessWidget {
  const AssignmentList({required this.assignments, super.key});

  final List<Assignment> assignments;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(Space.space24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: assignments.isEmpty
                  ? const Center(child: Text('No Assignments Yet.'))
                  : ListView.builder(
                      itemCount: assignments.length,
                      itemBuilder: (_, index) => AssignmentTile(assignment: assignments[index]),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class AssignmentTile extends StatelessWidget {
  const AssignmentTile({required this.assignment, super.key});

  final Assignment assignment;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Row(
        children: [
          _assignmentInfo(context),
          const AssignmentScore(),
        ],
      ),
    );
  }

  Expanded _assignmentInfo(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () => context.read<CourseDetailBloc>().add(SelectAssignment(assignment: assignment)),
        child: Row(
          children: [
            Container(
              width: Space.space8,
              height: Space.space80,
              color: Colors.red,
            ),
            const SizedBox(width: Space.space16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(assignment.type.name, style: Theme.of(context).textTheme.labelMedium),
                  const SizedBox(height: Space.space8),
                  Text(assignment.name, style: Theme.of(context).textTheme.labelLarge),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AssignmentScore extends StatelessWidget {
  const AssignmentScore({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Space.space80,
      height: Space.space80,
      child: Center(child: Text('100', textAlign: TextAlign.center, style: Theme.of(context).textTheme.labelLarge)),
    );
  }
}
