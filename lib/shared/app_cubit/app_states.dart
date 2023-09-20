import '../../models/course_model.dart';

abstract class AppStates{}

class AppInitialState extends AppStates{}

//Navbar States..

class ChangeNavigationPageState extends AppStates{}

class AddPostPageState extends AppStates{}

//Courses States..

class LoadCoursesState extends AppStates{}

class CoursesLoadedSuccessfullyState extends AppStates{}

class GetCourseDataState extends AppStates{}

class GetCourseDataSuccessfullyState extends AppStates{}

class AddCourseToFavSuccessfullyState extends AppStates{}

class DeleteCourseToFavSuccessfullyState extends AppStates{}

class AddCourseToFavListSuccessfullyState extends AppStates{}

class EditShowedCoursesState extends AppStates{}

class EditSearchedCoursesState extends AppStates{}

class EditRecentlyCoursesState extends AppStates{
  final List<CourseModel> recentlyCourses;
  EditRecentlyCoursesState(this.recentlyCourses);
}

// Files States

class UploadFileLoadingState extends AppStates{}

class UploadFileSuccessfullyState extends AppStates{}

class GetTitlesSuccessfullyState extends AppStates{}

class EditTextPopMenuSuccessfullyState extends AppStates{}

class ChooseFileLoadingState extends AppStates{}

class ChooseFileSuccessfullyState extends AppStates{}

class DeleteFileState extends AppStates{}

class GetCourseFilesLoadingState extends AppStates{}

class GetCourseFilesSuccessfullyState extends AppStates{}

class GetFileDataLoadingState extends AppStates{}

class GetFileDataSuccessfullyState extends AppStates{}

class LikeFileState extends AppStates{}

class DislikeFileState extends AppStates{}