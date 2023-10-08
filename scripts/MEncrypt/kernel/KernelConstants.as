package MEncrypt.kernel
{
   public class KernelConstants
   {
      
      public static const O_RDONLY:int = 0;
      
      public static const O_WRONLY:int = 1;
      
      public static const O_RDWR:int = 2;
      
      public static const O_ACCMODE:int = 3;
      
      public static const O_NONBLOCK:int = 4;
      
      public static const O_APPEND:int = 8;
      
      public static const O_CREAT:int = 512;
      
      public static const O_TRUNC:int = 1024;
      
      public static const O_EXCL:int = 2048;
      
      public static const O_SHLOCK:int = 16;
      
      public static const O_EXLOCK:int = 32;
      
      public static const O_NOFOLLOW:int = 256;
      
      public static const O_DIRECT:int = 65536;
      
      public static const O_SYNC:int = 128;
      
      public static const O_FSYNC:int = 128;
      
      public static const S_IFIFO:int = 4096;
      
      public static const S_IFCHR:int = 8192;
      
      public static const S_IFDIR:int = 16384;
      
      public static const S_IFBLK:int = 24576;
      
      public static const S_IFREG:int = 32768;
      
      public static const S_IFLNK:int = 40960;
      
      public static const S_IFSOCK:int = 49152;
      
      public static const SEEK_SET:int = 0;
      
      public static const SEEK_CUR:int = 1;
      
      public static const SEEK_END:int = 2;
      
      public static const DT_UNKNOWN:int = 0;
      
      public static const DT_FIFO:int = 1;
      
      public static const DT_CHR:int = 2;
      
      public static const DT_DIR:int = 4;
      
      public static const DT_BLK:int = 6;
      
      public static const DT_REG:int = 8;
      
      public static const DT_LNK:int = 10;
      
      public static const DT_SOCK:int = 12;
      
      public static const DT_WHT:int = 14;
      
      public static const EPERM:int = 1;
      
      public static const ENOENT:int = 2;
      
      public static const ESRCH:int = 3;
      
      public static const EINTR:int = 4;
      
      public static const EIO:int = 5;
      
      public static const ENXIO:int = 6;
      
      public static const E2BIG:int = 7;
      
      public static const ENOEXEC:int = 8;
      
      public static const EBADF:int = 9;
      
      public static const ECHILD:int = 10;
      
      public static const EDEADLK:int = 11;
      
      public static const ENOMEM:int = 12;
      
      public static const EACCESS:int = 13;
      
      public static const EFAULT:int = 14;
      
      public static const ENOTBLK:int = 15;
      
      public static const EBUSY:int = 16;
      
      public static const EEXIST:int = 17;
      
      public static const EXDEV:int = 18;
      
      public static const ENODEV:int = 19;
      
      public static const ENOTDIR:int = 20;
      
      public static const EISDIR:int = 21;
      
      public static const EINVAL:int = 22;
      
      public static const ENFILE:int = 23;
      
      public static const EMFILE:int = 24;
      
      public static const ENOTTY:int = 25;
      
      public static const ETXBSY:int = 26;
      
      public static const EFBIG:int = 27;
      
      public static const ENOSPC:int = 28;
      
      public static const ESPIPE:int = 29;
      
      public static const EROFS:int = 30;
      
      public static const EMLINK:int = 31;
      
      public static const EPIPE:int = 32;
      
      public static const ENOTEMPTY:int = 66;
      
      public static const ENOSYS:int = 78;
      
      public static const EOVERFLOW:int = 84;
      
      public static const F_DUPFD:int = 0;
       
      
      public function KernelConstants()
      {
         super();
      }
   }
}
