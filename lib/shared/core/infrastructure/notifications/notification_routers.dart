import 'package:flutter/material.dart';
import 'package:icarus/shared/core/infrastructure/routes/app_router.dart';
import 'package:icarus/shared/core/infrastructure/routes/route_name.dart';
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
          pathParameters: {'id': model.id.toString()},
        );
        break;

      case FcmType.edutainment:
        context.goNamed(
          RouteName.detailEdutainment,
          pathParameters: {'id': model.id.toString()},
        );
        break;

      case FcmType.chat:
        context.goNamed(
          RouteName.chatDetail,
          pathParameters: {'userId': model.id.toString()},
        );
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
  unknown,
}

class NotificationModel {
  final FcmType type;
  final int id;

  NotificationModel({required this.type, required this.id});
}
