




class LangListDataModel {
  static final langitems = [
    LangListItem(
        id: 1,
        title: 'English'),

    LangListItem(
        id: 2,
        title: 'हिन्दी'),


  ];
}




class LangListItem {
  final int id;
  final String title;

  LangListItem({
    required this.id,
    required this.title,
  });
}