part of 'tasklist_view.dart';

class MiniNav extends StatelessWidget{
  const MiniNav({super.key});


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      children: [
        
        Badge(
                    backgroundColor: ORANGE,
                    label: Text(
                      '1',
                      style: context.textTheme.bodySmall,
                    ),
                    child: Icon(Icons.note_outlined),),
        SizedBox(width: context.mediaQuery.size.width * RATIO_PADDING),
        Badge(
                    backgroundColor: GREEN,
                    label: Text(
                      '1',
                      style: context.textTheme.bodySmall,
                    ),
                    child: Icon(Icons.note_outlined),),
        SizedBox(width: context.mediaQuery.size.width * RATIO_PADDING),
        Badge(
                    backgroundColor: PURPLE,
                    label: Text(
                      '1',
                      style: context.textTheme.bodySmall,
                    ),
                    child: Icon(Icons.chat_outlined),),
        SizedBox(width: context.mediaQuery.size.width * RATIO_PADDING),
        Icon(Icons.output_outlined)
      ],
    );
  }

}