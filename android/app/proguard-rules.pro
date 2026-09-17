# ML Kit resolves its components (including MlKitInitProvider, which runs at
# app startup before any Dart code executes) via reflection-based dependency
# injection. R8 stripping any part of com.google.mlkit.** breaks that
# injection graph and crashes the app immediately on launch. Keep it whole.
-dontwarn com.google.mlkit.**
-keep class com.google.mlkit.** { *; }
-keep interface com.google.mlkit.** { *; }

# The vision text recognizer's optional script variants (Chinese, Devanagari,
# Japanese, Korean) are referenced reflectively even though we only bundle
# the Latin recognizer.
-dontwarn com.google.android.gms.internal.mlkit_vision_text_bundled_common.**
-dontwarn com.google.android.gms.internal.mlkit_vision_text_chinese.**
-dontwarn com.google.android.gms.internal.mlkit_vision_text_devanagari.**
-dontwarn com.google.android.gms.internal.mlkit_vision_text_japanese.**
-dontwarn com.google.android.gms.internal.mlkit_vision_text_korean.**
