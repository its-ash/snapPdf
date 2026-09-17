# ML Kit text recognition ships script-specific recognizers (Chinese, Devanagari,
# Japanese, Korean) as optional dependencies. We only use the Latin recognizer,
# so R8 can't resolve those classes at compile time — keep them as no-ops.
-dontwarn com.google.mlkit.vision.text.chinese.**
-dontwarn com.google.mlkit.vision.text.devanagari.**
-dontwarn com.google.mlkit.vision.text.japanese.**
-dontwarn com.google.mlkit.vision.text.korean.**
-keep class com.google.mlkit.vision.text.** { *; }
