part of 'tasklist_view.dart';

class ListTag extends StatelessWidget {
  const ListTag({
    super.key,
    required this.tags,
  });

  final List<Tag> tags;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: context.mediaQuery.size.width * RATIO_PADDING * 2.5,
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: tags.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return FutureBuilder(
              future: TagBuilder.instance.getColorFromTag(
                tags[index],
              ),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ProjectTagWidget(
                    color: snapshot.data as Color,
                    tag: tags[index],
                    forProjectView: false,
                  );
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Icon(
                      Icons.error_outline_rounded,
                      size: context.mediaQuery.size.width * RATIO_PADDING * 1.8,
                      color: context.colorScheme.error,
                    ),
                  );
                }
                return Center(
                  child: CustomCircularProgressIndicator(
                    size: context.mediaQuery.size.width * RATIO_PADDING * 1.8,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
