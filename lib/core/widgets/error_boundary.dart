import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/colors.dart';

class ErrorBoundary extends StatefulWidget {
  final Widget child;
  final Widget? fallback;

  const ErrorBoundary({super.key, required this.child, this.fallback});

  @override
  State<ErrorBoundary> createState() => _ErrorBoundaryState();
}

class _ErrorBoundaryState extends State<ErrorBoundary> {
  bool hasError = false;
  FlutterErrorDetails? errorDetails;
  void Function(FlutterErrorDetails)? _originalErrorHandler;

  @override
  void initState() {
    super.initState();
    // Store original error handler
    _originalErrorHandler = FlutterError.onError;

    FlutterError.onError = (FlutterErrorDetails details) {
      // Call original handler first
      _originalErrorHandler?.call(details);
      
      // Skip rendering/layout errors - only catch actual exceptions
      final exception = details.exception;
      final exceptionString = exception.toString();
      
      // Skip rendering errors (overflow, layout issues, etc.)
      if (exception is AssertionError ||
          exceptionString.contains('RenderFlex overflowed') ||
          exceptionString.contains('RenderBox') ||
          exceptionString.contains('layout') ||
          exceptionString.contains('rendering library')) {
        // This is a rendering/layout error, don't catch it
        return;
      }
      
      // Only catch actual exceptions, not rendering errors
      if (mounted) {
        // Use post-frame callback to avoid build during frame error
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            setState(() {
              hasError = true;
              errorDetails = details;
            });
          }
        });
      }
    };
  }

  @override
  void dispose() {
    // Restore original error handler
    if (_originalErrorHandler != null) {
      FlutterError.onError = _originalErrorHandler;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (hasError) {
      return widget.fallback ?? _DefaultErrorWidget(errorDetails: errorDetails);
    }
    return widget.child;
  }
}

class _DefaultErrorWidget extends StatelessWidget {
  final FlutterErrorDetails? errorDetails;

  const _DefaultErrorWidget({this.errorDetails});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Material(
        color: AppColors.quaternary,
        child: Scaffold(
          backgroundColor: AppColors.quaternary,
          body: SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 64,
                      color: AppColors.secondary,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Oops! Something went wrong',
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(
                            color: AppColors.tertiary,
                            fontWeight: FontWeight.bold,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'We encountered an unexpected error. Please try again later.',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: AppColors.nonary),
                      textAlign: TextAlign.center,
                    ),
                    if (errorDetails != null) ...[
                      const SizedBox(height: 24),
                      ExpansionTile(
                        title: const Text('Error Details'),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: SelectableText(
                              errorDetails!.toString(),
                              style: const TextStyle(fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ],
                    const SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: () {
                        HapticFeedback.mediumImpact();
                        // Restart app or navigate to home
                      },
                      child: const Text('Go Back'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
