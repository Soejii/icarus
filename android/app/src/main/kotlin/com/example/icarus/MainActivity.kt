package com.sidigs.walimurid

import android.Manifest
import android.content.ContentValues
import android.content.pm.PackageManager
import android.os.Build
import android.os.Environment
import android.os.Handler
import android.os.Looper
import android.provider.MediaStore
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import java.io.File
import java.util.concurrent.Executors

class MainActivity : FlutterActivity() {
    companion object {
        private const val WRITE_STORAGE_REQUEST_CODE = 4101
    }

    private val downloadsExecutor = Executors.newSingleThreadExecutor()
    private val mainHandler = Handler(Looper.getMainLooper())
    private var pendingFileName: String? = null
    private var pendingSourcePath: String? = null
    private var pendingResult: MethodChannel.Result? = null

    override fun onDestroy() {
        downloadsExecutor.shutdown()
        super.onDestroy()
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "icarus/downloads")
            .setMethodCallHandler { call, result ->
                if (call.method != "savePdfToDownloads") {
                    result.notImplemented()
                    return@setMethodCallHandler
                }

                val fileName = call.argument<String>("fileName")
                val sourcePath = call.argument<String>("sourcePath")
                if (fileName.isNullOrBlank() || sourcePath.isNullOrBlank()) {
                    result.error("INVALID_ARGUMENTS", "fileName and sourcePath are required", null)
                    return@setMethodCallHandler
                }

                if (needsLegacyStoragePermission()) {
                    if (pendingResult != null) {
                        result.error("DOWNLOAD_IN_PROGRESS", "Another download is waiting for permission", null)
                        return@setMethodCallHandler
                    }

                    pendingFileName = fileName
                    pendingSourcePath = sourcePath
                    pendingResult = result
                    requestPermissions(
                        arrayOf(Manifest.permission.WRITE_EXTERNAL_STORAGE),
                        WRITE_STORAGE_REQUEST_CODE
                    )
                    return@setMethodCallHandler
                }

                downloadsExecutor.execute {
                    savePdfToDownloads(fileName, sourcePath, result)
                }
            }
    }

    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<out String>,
        grantResults: IntArray
    ) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        if (requestCode != WRITE_STORAGE_REQUEST_CODE) return

        val fileName = pendingFileName
        val sourcePath = pendingSourcePath
        val result = pendingResult
        pendingFileName = null
        pendingSourcePath = null
        pendingResult = null

        if (fileName == null || sourcePath == null || result == null) return

        if (grantResults.firstOrNull() != PackageManager.PERMISSION_GRANTED) {
            result.error("PERMISSION_DENIED", "Storage permission is required to save this file", null)
            return
        }

        downloadsExecutor.execute {
            savePdfToDownloads(fileName, sourcePath, result)
        }
    }

    private fun needsLegacyStoragePermission(): Boolean {
        return Build.VERSION.SDK_INT in Build.VERSION_CODES.M until Build.VERSION_CODES.Q &&
            checkSelfPermission(Manifest.permission.WRITE_EXTERNAL_STORAGE) !=
            PackageManager.PERMISSION_GRANTED
    }

    private fun savePdfToDownloads(
        fileName: String,
        sourcePath: String,
        result: MethodChannel.Result
    ) {
        try {
            val sourceFile = File(sourcePath)
            if (!sourceFile.exists()) {
                postError(result, "SOURCE_NOT_FOUND", "Source file does not exist", null)
                return
            }

            if (Build.VERSION.SDK_INT < Build.VERSION_CODES.Q) {
                saveLegacyDownload(fileName, sourceFile, result)
                return
            }

            val resolver = applicationContext.contentResolver
            val downloadName = availableDownloadName(fileName)
                    val values = ContentValues().apply {
                        put(MediaStore.Downloads.DISPLAY_NAME, downloadName)
                        put(MediaStore.Downloads.MIME_TYPE, "application/pdf")
                        put(
                            MediaStore.Downloads.RELATIVE_PATH,
                            Environment.DIRECTORY_DOWNLOADS + "/Rapor/"
                        )
                        put(MediaStore.Downloads.IS_PENDING, 1)
                    }
            val collection = MediaStore.Downloads.getContentUri(MediaStore.VOLUME_EXTERNAL_PRIMARY)
            val uri = resolver.insert(collection, values)
            if (uri == null) {
                postError(result, "SAVE_FAILED", "Could not create Downloads entry", null)
                return
            }

            resolver.openOutputStream(uri)?.use { output ->
                sourceFile.inputStream().use { input ->
                    input.copyTo(output)
                }
            } ?: run {
                resolver.delete(uri, null, null)
                postError(result, "SAVE_FAILED", "Could not open Downloads entry", null)
                return
            }

            values.clear()
            values.put(MediaStore.Downloads.IS_PENDING, 0)
            resolver.update(uri, values, null, null)
            postSuccess(result, Environment.DIRECTORY_DOWNLOADS + "/Rapor/" + downloadName)
        } catch (e: Exception) {
            postError(result, "SAVE_FAILED", e.message, null)
        }
    }

    private fun saveLegacyDownload(
        fileName: String,
        sourceFile: File,
        result: MethodChannel.Result
    ) {
        val raporDir = File(
            Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_DOWNLOADS),
            "Rapor"
        )
        if (!raporDir.exists() && !raporDir.mkdirs()) {
            postError(result, "SAVE_FAILED", "Could not create Downloads/Rapor folder", null)
            return
        }

        val target = availableLegacyFile(raporDir, fileName)
        sourceFile.inputStream().use { input ->
            target.outputStream().use { output ->
                input.copyTo(output)
            }
        }
        postSuccess(result, target.absolutePath)
    }

    private fun postSuccess(result: MethodChannel.Result, value: String) {
        mainHandler.post { result.success(value) }
    }

    private fun postError(
        result: MethodChannel.Result,
        code: String,
        message: String?,
        details: Any?
    ) {
        mainHandler.post { result.error(code, message, details) }
    }

    private fun availableDownloadName(fileName: String): String {
        val dotIndex = fileName.lastIndexOf('.')
        val name = if (dotIndex > 0) fileName.substring(0, dotIndex) else fileName
        val extension = if (dotIndex > 0) fileName.substring(dotIndex) else ".pdf"
        var candidate = if (dotIndex > 0) fileName else "$fileName$extension"
        var index = 1
        while (downloadExists(candidate)) {
            candidate = "$name ($index)$extension"
            index++
        }
        return candidate
    }

    private fun availableLegacyFile(directory: File, fileName: String): File {
        val dotIndex = fileName.lastIndexOf('.')
        val name = if (dotIndex > 0) fileName.substring(0, dotIndex) else fileName
        val extension = if (dotIndex > 0) fileName.substring(dotIndex) else ".pdf"
        var candidate = File(directory, if (dotIndex > 0) fileName else "$fileName$extension")
        var index = 1
        while (candidate.exists()) {
            candidate = File(directory, "$name ($index)$extension")
            index++
        }
        return candidate
    }

    private fun downloadExists(fileName: String): Boolean {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.Q) return false
        val resolver = applicationContext.contentResolver
        val collection = MediaStore.Downloads.getContentUri(MediaStore.VOLUME_EXTERNAL_PRIMARY)
        val projection = arrayOf(MediaStore.Downloads._ID)
        val selection =
            "${MediaStore.Downloads.DISPLAY_NAME} = ? AND ${MediaStore.Downloads.RELATIVE_PATH} = ?"
        val selectionArgs = arrayOf(fileName, Environment.DIRECTORY_DOWNLOADS + "/Rapor/")
        resolver.query(collection, projection, selection, selectionArgs, null)?.use { cursor ->
            return cursor.moveToFirst()
        }
        return false
    }
}
