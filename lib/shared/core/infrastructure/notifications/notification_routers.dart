import 'package:flutter/material.dart';
import 'package:gaia/shared/core/infrastructure/routes/app_router.dart';
import 'package:gaia/shared/core/infrastructure/routes/route_name.dart';
import 'package:go_router/go_router.dart';

class NotificationRouters {
  NotificationRouters._();
  static final NotificationRouters instance = NotificationRouters._();

  Map<String, dynamic>? _pendingPayload;

  void handlePayloads(Map<String, dynamic> payload) {
    debugPrint('FCM NotificationRouters.handlePayloads payload=$payload');
    final rawType = payload['type'] as String?;
    final rawId = payload['id'];

    final type = _mapper(rawType ?? 'unknown');

    int? id;
    if (rawId is int) {
      id = rawId;
    } else if (rawId is String) {
      id = int.tryParse(rawId);
    }

    final data = NotificationModel(type: type, id: id ?? 0);

    _route(data);
  }

  void flushPendingIfAny() {
    final context = rootNavigatorKey.currentContext;
    if (context == null) return;

    final payload = _pendingPayload;
    if (payload == null) return;

    _pendingPayload = null;
    debugPrint('NotificationRouters: flushing pending payload: $payload');
    handlePayloads(payload);
  }

  FcmType _mapper(String type) {
    switch (type) {
      case 'announcement':
        return FcmType.announcement;
      case 'edutainment':
        return FcmType.edutainment;
      case 'chat':
        return FcmType.chat;
      case 'module':
        return FcmType.module;
      case 'sub_module':
        return FcmType.subModule;
      case 'discussion':
        return FcmType.discussion;
      case 'class_discussion':
        return FcmType.classDiscussion;
      case 'learning_media':
        return FcmType.learningMedia;
      case 'exam':
        return FcmType.exam;
      case 'quiz':
        return FcmType.quiz;
      case 'task':
        return FcmType.task;
      case 'topup':
        return FcmType.topup;
      default:
        return FcmType.unknown;
    }
  }

  String _unmap(FcmType type) {
    switch (type) {
      case FcmType.edutainment:
        return 'edutainment';
      case FcmType.announcement:
        return 'announcement';
      case FcmType.chat:
        return 'chat';
      case FcmType.module:
        return 'module';
      case FcmType.subModule:
        return 'sub_module';
      case FcmType.discussion:
        return 'discussion';
      case FcmType.classDiscussion:
        return 'class_discussion';
      case FcmType.learningMedia:
        return 'learning_media';
      case FcmType.exam:
        return 'exam';
      case FcmType.quiz:
        return 'quiz';
      case FcmType.task:
        return 'task';
      case FcmType.topup:
        return 'topup';
      case FcmType.unknown:
        return 'unknown';
    }
  }

  void _route(NotificationModel model) {
    final context = rootNavigatorKey.currentContext;
    if (context == null) {
      debugPrint('NotificationRouters: context is null, queueing navigation');
      _pendingPayload = {
        'type': _unmap(model.type),
        'id': model.id,
      };
      return;
    }

    switch (model.type) {
      case FcmType.announcement:
        context.goNamed(
          RouteName.detailAnnouncement,
          pathParameters: {'id': model.id.toString()}, // id = announcement id
        );
        break;

      case FcmType.edutainment:
        context.goNamed(
          RouteName.detailEdutainment,
          pathParameters: {'id': model.id.toString()}, // id = edutainment id
        );
        break;

      case FcmType.chat:
        context.goNamed(
          RouteName.chatDetail,
          pathParameters: {'userId': model.id.toString()}, // id = userId
        );
        break;

      case FcmType.module:
        context.goNamed(
          RouteName.detailSubject,
          pathParameters: {'id': model.id.toString()},
          queryParameters: {'initial_tab': '0'},
        );
        break;

      case FcmType.subModule:
        context.goNamed(
          RouteName.detailSubModule,
          pathParameters: {'id': model.id.toString()},
          queryParameters: {'initial_tab': '0'},
        );
        break;

      case FcmType.discussion:
        context.goNamed(
          RouteName.detailSubject,
          pathParameters: {'id': model.id.toString()},
          queryParameters: {'initial_tab': '1'},
        );
        break;

      case FcmType.classDiscussion:
        context.goNamed(RouteName.classDiscussion);
        break;

      case FcmType.learningMedia:
        context.goNamed(
          RouteName.detailSubject,
          pathParameters: {'id': model.id.toString()},
          queryParameters: {'initial_tab': '2'},
        );
        break;

      case FcmType.exam:
        context.goNamed(
          RouteName.detailSubject,
          pathParameters: {'id': model.id.toString()},
          queryParameters: {'initial_tab': '3'},
        );
        break;

      case FcmType.quiz:
        context.goNamed(
          RouteName.detailSubject,
          pathParameters: {'id': model.id.toString()},
          queryParameters: {'initial_tab': '4'},
        );
        break;

      case FcmType.task:
        context.goNamed(
          RouteName.detailSubject,
          pathParameters: {'id': model.id.toString()},
          queryParameters: {'initial_tab': '5'},
        );
        break;

      case FcmType.topup:
        context.goNamed(RouteName.balance);
        break;

      case FcmType.unknown:
        debugPrint('NotificationRouters: unknown FCM type, going home');
        context.go('/home');
        break;
    }
  }
}

enum FcmType {
  announcement,
  edutainment,
  chat,
  module,
  subModule,
  discussion,
  classDiscussion,
  learningMedia,
  exam,
  quiz,
  task,
  topup,
  unknown,
}

class NotificationModel {
  final FcmType type;
  final int id;

  NotificationModel({required this.type, required this.id});
}
