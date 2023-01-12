// stores ExpansionPanel state information
class CItem {
  CItem({
    this.selectedId,
    this.selectedCateogry,
    this.isExpanded = false,
  });

  int? selectedId;
  String? selectedCateogry;
  bool? isExpanded;
}
