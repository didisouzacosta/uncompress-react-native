package com.uncompress.utils

import java.io.*
import java.util.zip.ZipInputStream


/**
 * This utility extracts files and directories of a standard zip file to
 * a destination directory.
 * @author www.codejava.net
 */
class UnzipUtility {
  /**
   * Extracts a zip file specified by the zipFilePath to a directory specified by
   * destDirectory (will be created if does not exists)
   * @param zipFilePath
   * @param destDirectory
   * @throws IOException
   */
  @Throws(IOException::class)
  fun unzip(zipFilePath: String?, destDirectory: String) {
    val destDir = File(destDirectory)
    if (!destDir.exists()) {
      destDir.mkdir()
    }
    val zipIn = ZipInputStream(FileInputStream(zipFilePath))
    var entry = zipIn.nextEntry
    // iterates over entries in the zip file
    while (entry != null) {
      val filePath = destDirectory + File.separator + entry.name
      if (!entry.isDirectory) {
        // if the entry is a file, extracts it
        extractFile(zipIn, filePath)
      } else {
        // if the entry is a directory, make the directory
        val dir = File(filePath)
        dir.mkdir()
      }
      zipIn.closeEntry()
      entry = zipIn.nextEntry
    }
    zipIn.close()
  }

  /**
   * Extracts a zip entry (file entry)
   * @param zipIn
   * @param filePath
   * @throws IOException
   */
  @Throws(IOException::class)
  private fun extractFile(zipIn: ZipInputStream, filePath: String) {
    val bos = BufferedOutputStream(FileOutputStream(filePath))
    val bytesIn = ByteArray(BUFFER_SIZE)
    var read = 0
    while (zipIn.read(bytesIn).also { read = it } != -1) {
      bos.write(bytesIn, 0, read)
    }
    bos.close()
  }

  companion object {
    /**
     * Size of the buffer to read/write data
     */
    private const val BUFFER_SIZE = 4096
  }
}
