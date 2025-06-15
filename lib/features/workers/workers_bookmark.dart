import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workdey_frontend/core/providers/saved_worker_provider.dart';

class WorkerBookmarkWidget extends ConsumerStatefulWidget {
  final int workerId;
  final bool isSaved;

  const WorkerBookmarkWidget({
    super.key, 
    required this.workerId,
    this.isSaved = false,
  });

  @override
  ConsumerState<WorkerBookmarkWidget> createState() => _WorkerBookmarkWidgetState();
}

class _WorkerBookmarkWidgetState extends ConsumerState<WorkerBookmarkWidget> {
  late bool _localIsSaved;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _localIsSaved = widget.isSaved;
  }

  @override
  void didUpdateWidget(covariant WorkerBookmarkWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isSaved != widget.isSaved) {
      setState(() {
        _localIsSaved = widget.isSaved;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: _isLoading 
          ? const _BookmarkIcon(isSaved: true, isLoading: true)
          : _BookmarkIcon(isSaved: _localIsSaved),
      onPressed: () async {
        if (_isLoading) return;
        
        setState(() {
          _localIsSaved = !_localIsSaved; // Immediate visual change
          _isLoading = true;
        });

        try {
          await ref.read(savedWorkersProvider.notifier)
            .toggleSave(widget.workerId, !_localIsSaved);
        } catch (e) {
          // Revert on error
          if (mounted) {
            setState(() => _localIsSaved = !_localIsSaved);
          }
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to update: ${e.toString()}')),
          );
        } finally {
          if (mounted) {
            setState(() => _isLoading = false);
          }
        }
      },
    );
  }
}

class _BookmarkIcon extends StatelessWidget {
  final bool isSaved;
  final bool isLoading;

  const _BookmarkIcon({
    this.isSaved = false,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(strokeWidth: 2),
      );
    }

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      transitionBuilder: (child, animation) => ScaleTransition(
        scale: animation,
        child: child,
      ),
      child: Icon(
        isSaved ? Icons.bookmark : Icons.bookmark_outline,
        key: ValueKey<bool>(isSaved),
        color: isSaved ? Theme.of(context).colorScheme.primary : Colors.grey,
      ),
    );
  }
}