extension DateTimeExt on DateTime {
  String currentTimelapseString() {
    final duration = DateTime.now().difference(this);

    if (duration.inDays > 365) {
      return '${duration.inDays ~/ 365} years ago';
    } else if (duration.inDays > 30) {
      return '${duration.inDays ~/ 30} months ago';
    } else if (duration.inDays > 7) {
      return '${duration.inDays ~/ 7} weeks ago';
    } else if (duration.inHours > 24) {
      return '${duration.inHours ~/ 24} days ago';
    } else if (duration.inMinutes > 60) {
      return '${duration.inMinutes ~/ 60} hours ago';
    } else if (duration.inSeconds > 60) {
      return '${duration.inSeconds ~/ 60} mins ago';
    } else {
      return 'Now';
    }
  }
}
