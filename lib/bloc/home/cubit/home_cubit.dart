import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:haptext_api/exports.dart';
import 'package:haptext_api/repository/home_repo/home_repo.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeRepo homeRepo;
  HomeCubit(this.homeRepo) : super(HomeInitial()) {
    fetchPosts();
  }

  int page = 1;
  PostModel posts = PostModel();
  fetchPosts({String? feedType}) async {
    emit(HomeLoading());
    try {
      final response = await homeRepo.fetchPost(page: page, feedType: feedType);
      final body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        posts = PostModel.fromJson(body['data']);
        emit(HomeLoaded());
      } else {
        ToastMessage.showErrorToast(
            message: body["errors"]["detail"].toString());
        emit(HomeError());
      }
    } catch (e) {
      emit(HomeError());
      log("fetch post $e");
    }
  }

  commentOnPost({ResultPostModel? post, postId, comment}) async {
    emit(PostCommenting());
    try {
      final response = await homeRepo.commentOnPost(
          postId: post?.id ?? postId, comment: comment);
      final body = jsonDecode(response.body);
      if (response.statusCode == 201) {
        if (post != null) {
          post.comments.add(CommentModel.fromJson(body['data']));
        }
        emit(PostCommented());
      } else {
        ToastMessage.showErrorToast(
            message: body["errors"]["detail"].toString());
        emit(HomeError());
      }
    } catch (e) {
      emit(HomeError());
      log("fetch post $e");
    }
  }

  fetchPostComents({required ResultPostModel post}) async {
    emit(HomeLoading());
    try {
      final response = await homeRepo.fetchPostComment(postId: post.id ?? '');
      final body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        post.comments.clear();
        for (var comment in body['data']['result']) {
          post.comments.add(CommentModel.fromJson(comment));
        }
        emit(HomeLoaded());
      } else {
        ToastMessage.showErrorToast(
            message: body["errors"]["detail"].toString());
        emit(HomeError());
      }
    } catch (e) {
      emit(HomeError());
      log("fetch post comments $e");
    }
  }

  Future<List<ResultPostModel>?> fetchUserPosts({userId}) async {
    emit(HomeLoading());
    try {
      final response = await homeRepo.fetchUserPost(page: page, userId: userId);
      final body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        List<ResultPostModel> posts = [];
        for (var post in body['data']['result']) {
          posts.add(ResultPostModel.fromJson(post));
        }
        emit(HomeLoaded());
        return posts;
      } else {
        ToastMessage.showErrorToast(
            message: body["errors"]["detail"].toString());
        emit(HomeError());
        return null;
      }
    } catch (e) {
      emit(HomeError());
      log("fetch post $e");
      return null;
    }
  }

  sharePost({postId}) async {
    emit(HomeLoading());
    try {
      final response = await homeRepo.sharePost(id: postId);
      final body = jsonDecode(response.body);
      if (response.statusCode == 201) {
        emit(PostShared());
        fetchPosts();
      } else {
        ToastMessage.showErrorToast(
            message: body["errors"]["detail"].toString());
        emit(HomeError());
      }
    } catch (e) {
      emit(HomeError());
      log("share post $e");
    }
  }

  reactToPost({postId, reaction}) async {
    emit(HomeLoading());
    try {
      final response = await homeRepo.reactPost(id: postId, reaction: reaction);
      final body = jsonDecode(response.body);
      if (response.statusCode == 201) {
        emit(PostReact());
        fetchPosts();
      } else {
        ToastMessage.showErrorToast(
            message: body["errors"]["detail"].toString());
        emit(HomeError());
      }
    } catch (e) {
      emit(HomeError());
      log("react post $e");
    }
  }

  fetchNotification() async {
    emit(HomeLoading());
    try {
      final response = await homeRepo.fetchNotification(page: 1);
      final body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        emit(HomeLoaded());
      } else {
        ToastMessage.showErrorToast(
            message: body["errors"]["detail"].toString());
        emit(HomeError());
      }
    } catch (e) {
      emit(HomeError());
      log("fetch notification $e");
    }
  }

  createTextPost(
      {required String textContent,
      String? scheduledAt,
      String? taggedUser}) async {
    if (textContent.isEmpty) return;
    emit(HomeLoading());
    try {
      final response = await homeRepo.createTextPost(
          textContent: textContent,
          scheduledAt: scheduledAt,
          taggedUser: taggedUser);
      final body = jsonDecode(response.body);
      if (response.statusCode == 201 || response.statusCode == 200) {
        emit(HomePostCreated());
        await Future.delayed(const Duration(seconds: 2));

        fetchPosts();
      } else {
        ToastMessage.showErrorToast(
            message: body["errors"]["detail"].toString());
        emit(HomeError());
      }
    } catch (e) {
      emit(HomeError());
      log("create Text post $e");
    }
  }

  createAudioPost(
      {required File audio, String? taggedUser, String? scheduledAt}) async {
    emit(HomeLoading());
    try {
      final response = await homeRepo.createAudioPost(
          audioFile: audio, taggedUser: taggedUser, scheduledAt: scheduledAt);
      if (response.statusCode == 201 || response.statusCode == 200) {
        emit(HomePostCreated());
        fetchPosts();
      } else {
        final body = jsonDecode(await response.stream.bytesToString());

        ToastMessage.showErrorToast(
            message: body["errors"]["detail"].toString());
        emit(HomeError());
      }
    } catch (e) {
      emit(HomeError());
      log("create audio post $e");
    }
  }

  createImagePost(
      {required List<File> image,
      required caption,
      String? scheduledAt,
      String? taggedUser}) async {
    emit(HomeLoading());
    try {
      final response = await homeRepo.createImagePost(
          images: image,
          caption: caption,
          taggedUser: taggedUser,
          scheduledAt: scheduledAt);
      if (response.statusCode == 201 || response.statusCode == 200) {
        emit(HomePostCreated());
        fetchPosts();
      } else {
        final body = jsonDecode(await response.stream.bytesToString());
        log("message$body");
        ToastMessage.showErrorToast(
            message: body["errors"]["detail"].toString());
        emit(HomeError());
      }
    } catch (e) {
      emit(HomeError());
      log("create audio post $e");
    }
  }

  createVideoPost(
      {required File video,
      String? caption,
      String? scheduledAt,
      String? taggedUser}) async {
    emit(HomeLoading());
    try {
      final response = await homeRepo.createVideoPost(
          videoFile: video,
          caption: caption,
          taggedUser: taggedUser,
          scheduledAt: scheduledAt);
      if (response.statusCode == 201) {
        emit(HomePostCreated());
        fetchPosts();
      } else {
        final body = jsonDecode(await response.stream.bytesToString());
        ToastMessage.showErrorToast(
            message: body["errors"]["detail"].toString());
        emit(HomeError());
      }
    } catch (e) {
      emit(HomeError());
      log("create audio post $e");
    }
  }
}
