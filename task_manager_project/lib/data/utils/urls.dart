class Urls {
  static const String _baseUrl = 'https://task.teamrabbil.com/api/v1';
  static const String registration = '$_baseUrl/registration';
  static const String login = '$_baseUrl/login';
  static const String createTask = '$_baseUrl/createTask';
  static const String getNewTasks = '$_baseUrl/listTaskByStatus/New';
  static const String getCompletedTasks =
      '$_baseUrl/listTaskByStatus/Completed';
  static const String getCancelledTasks =
      '$_baseUrl/listTaskByStatus/Cancelled';
  static const String getInProgressTasks =
      '$_baseUrl/listTaskByStatus/Progress';
  static const String getTaskStatusCount = '$_baseUrl/taskStatusCount';

  static String updateTaskStatus(String taskId, String status) =>
      '$_baseUrl/updateTaskStatus/$taskId/$status';

  static String deleteTask(String taskId) => '$_baseUrl/deleteTask/$taskId';

  static const String updateProfile = '$_baseUrl/profileUpdate';

  static String recoverVerifyEmail(String email) =>
      "$_baseUrl/RecoverVerifyEmail/$email";

  static String recoverVerifyOTP(String email, String otp) {
    return "$_baseUrl/RecoverVerifyOTP/$email/$otp";
  }

  static const String recoverResetPass = "$_baseUrl/RecoverResetPass";
}
