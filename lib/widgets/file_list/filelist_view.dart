import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_managing_application/assets/assets.dart';
import 'package:task_managing_application/screens/base/base_screen.dart';
import 'package:task_managing_application/states/states.dart';
import 'package:task_managing_application/widgets/custom_floating_widget/custom_download_snackbar.dart';
import 'package:task_managing_application/widgets/custom_floating_widget/custom_error_icon.dart';
import 'package:task_managing_application/widgets/custom_floating_widget/custom_error_snackbar.dart';
import 'package:task_managing_application/widgets/custom_hea_bar/custom_header_bar.dart';
import 'package:task_managing_application/widgets/file_list/mini_nav.dart';
import 'package:task_managing_application/widgets/shimmer/shimmer_box.dart';
import 'filelist_widget.dart';

class FileListView extends StatelessWidget {
  const FileListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      hideFloatingActionButton: false,
      hideNavigationBar: true,
      child: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            floating: true,
            pinned: true,
            delegate: CustomHeaderBar(
              atHomePage: false,
              upperChild: DefaultTextStyle.merge(
                child: const Text("Documents"),
                style: context.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  fontSize: 20.0,
                ),
              ),
              bottomChild: Container(
                margin: EdgeInsets.only(
                    top: context.mediaQuery.size.width * RATIO_PADDING),
                child: Row(
                  children: [
                    Container(
                        padding: EdgeInsets.all(
                            context.mediaQuery.size.width * RATIO_PADDING),
                        decoration: BoxDecoration(
                          color: ORANGE,
                          borderRadius: BorderRadius.circular(MEDIUM_CORNER),
                        ),
                        child: SvgPicture.string(
                          SvgAssets.file,
                          width: 24,
                        )),
                    SizedBox(
                        width: context.mediaQuery.size.width * RATIO_PADDING),
                    const Text("All Files"),
                  ],
                ),
              ),
              onPressed: (context) {
                context.read<NavigationBloc>().add(
                      const NavigateToTask(
                        projectId: null,
                        leaderId: null,
                        projectName: null,
                      ),
                    );
              },
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(
              horizontal: context.mediaQuery.size.width * RATIO_PADDING,
            ),
            sliver: SliverToBoxAdapter(
              child: BlocConsumer<FilelistBloc, FilelistState>(
                listener: (context, state) {
                  if (state is FilelistFailure) {
                    context.scaffoldMessenger
                        .showSnackBar(
                          createErrorSnackBar(
                            context: context,
                            error: (state is FilelistFailureDownloading)
                                ? 'Downloading failed'
                                : 'Something went wrong. Please try again',
                          ),
                        )
                        .closed
                        .then(
                      (value) {
                        context.read<FilelistBloc>().add(
                              const FilelistSubscibeToStreamEvent(),
                            );
                      },
                    );
                  }
                  if (state is FilelistDownloading) {
                    context.scaffoldMessenger
                        .showSnackBar(
                          customDownloadSnackBar(
                            context: context,
                          ),
                        )
                        .close;
                  }
                  if (state is FilelistDownloadingSuccess) {
                    context.scaffoldMessenger
                        .showSnackBar(
                          customDownloadStateSnackBar(
                            context: context,
                            successful: true,
                          ),
                        )
                        .closed
                        .then(
                      (value) {
                        context.read<FilelistBloc>().add(
                              const FilelistSubscibeToStreamEvent(),
                            );
                      },
                    );
                  }
                  if (state is FilelistDownloadingFail) {
                    context.scaffoldMessenger
                        .showSnackBar(
                          customDownloadStateSnackBar(
                            context: context,
                            successful: false,
                            message: state.message,
                          ),
                        )
                        .closed
                        .then(
                      (value) {
                        context.read<FilelistBloc>().add(
                              const FilelistSubscibeToStreamEvent(),
                            );
                      },
                    );
                  }
                },
                builder: (context, state) {
                  if (state is FilelistInitial || state is FilelistLoading) {
                    return ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return ShimmerBox(
                          height: 100,
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(
                            horizontal:
                                context.mediaQuery.size.width * RATIO_PADDING,
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ),
                      itemCount: 4,
                    );
                  }
                  if (state is FilelistFailure) {
                    return const Center(
                      child: CustomErrorIcon(),
                    );
                  }
                  return Column(
                    children: [
                      const MiniNavFile(totalNotes: 1),
                      SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: FileListWidget(
                          files: (state as FilelistSuccess).files,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
