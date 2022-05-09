extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}

String getInitials(String bankAccountName) => bankAccountName.isNotEmpty
    ? bankAccountName.trim().split(RegExp(' +')).map((s) => s[0]).take(2).join()
    : '';