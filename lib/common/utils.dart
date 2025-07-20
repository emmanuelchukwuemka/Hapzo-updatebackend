class UsefulMethods {
  static String formatDate(String date) {
    DateTime parsedDate = DateTime.parse(date);
    Duration difference = DateTime.now().toUtc().difference(parsedDate);

    if (difference.inDays > 365) {
      return '${difference.inDays ~/ 365} year${difference.inDays ~/ 365 > 1 ? 's' : ''} ago';
    } else if (difference.inDays > 30) {
      return '${difference.inDays ~/ 30} month${difference.inDays ~/ 30 > 1 ? 's' : ''} ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} min${difference.inMinutes > 1 ? 's' : ''} ago';
    } else {
      return 'just now';
    }
  }
}
