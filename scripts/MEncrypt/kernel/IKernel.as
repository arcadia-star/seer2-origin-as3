package MEncrypt.kernel
{
   public interface IKernel
   {
       
      
      function fork(param1:int) : int;
      
      function read(param1:int, param2:int, param3:int, param4:int) : int;
      
      function write(param1:int, param2:int, param3:int, param4:int) : int;
      
      function open(param1:int, param2:int, param3:int, param4:int) : int;
      
      function close(param1:int, param2:int) : int;
      
      function wait4(param1:int, param2:int, param3:int, param4:int, param5:int) : int;
      
      function link(param1:int, param2:int, param3:int) : int;
      
      function unlink(param1:int, param2:int) : int;
      
      function chdir(param1:int, param2:int) : int;
      
      function fchdir(param1:int, param2:int) : int;
      
      function chmod(param1:int, param2:int, param3:int) : int;
      
      function chown(param1:int, param2:int, param3:int, param4:int) : int;
      
      function lseek(param1:int, param2:int, param3:int, param4:int, param5:int) : Object;
      
      function getpid(param1:int) : int;
      
      function setuid(param1:int, param2:int) : int;
      
      function getuid(param1:int) : int;
      
      function geteuid(param1:int) : int;
      
      function access(param1:int, param2:int, param3:int) : int;
      
      function sync(param1:int) : void;
      
      function kill(param1:int, param2:int, param3:int) : int;
      
      function getppid(param1:int) : int;
      
      function dup(param1:int, param2:int) : int;
      
      function pipe(param1:int, param2:int) : int;
      
      function getegid(param1:int) : int;
      
      function getgid(param1:int) : int;
      
      function ioctl(param1:int, param2:int, param3:int, param4:int) : int;
      
      function revoke(param1:int, param2:int) : int;
      
      function symlink(param1:int, param2:int, param3:int) : int;
      
      function umask(param1:int, param2:int) : int;
      
      function chroot(param1:int, param2:int) : int;
      
      function msync(param1:int, param2:int, param3:int, param4:int) : int;
      
      function vfork(param1:int) : int;
      
      function getgroups(param1:int, param2:int, param3:int) : int;
      
      function setgroups(param1:int, param2:int, param3:int) : int;
      
      function getpgrp(param1:int) : int;
      
      function setpgid(param1:int, param2:int, param3:int) : int;
      
      function getdtablesize(param1:int) : int;
      
      function dup2(param1:int, param2:int, param3:int) : int;
      
      function fcntl(param1:int, param2:int, param3:int, param4:int) : int;
      
      function fsync(param1:int, param2:int) : int;
      
      function setpriority(param1:int, param2:int, param3:int, param4:int) : int;
      
      function socket(param1:int, param2:int, param3:int, param4:int) : int;
      
      function getpriority(param1:int, param2:int, param3:int) : int;
      
      function setsockopt(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int) : int;
      
      function listen(param1:int, param2:int, param3:int) : int;
      
      function sigsuspend(param1:int, param2:int) : int;
      
      function getrusage(param1:int, param2:int, param3:int) : int;
      
      function getsockopt(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int) : int;
      
      function readv(param1:int, param2:int, param3:int, param4:int) : int;
      
      function writev(param1:int, param2:int, param3:int, param4:int) : int;
      
      function fchown(param1:int, param2:int, param3:int, param4:int) : int;
      
      function fchmod(param1:int, param2:int, param3:int) : int;
      
      function setreuid(param1:int, param2:int, param3:int) : int;
      
      function setregid(param1:int, param2:int, param3:int) : int;
      
      function rename(param1:int, param2:int, param3:int) : int;
      
      function mkfifo(param1:int, param2:int, param3:int) : int;
      
      function shutdown(param1:int, param2:int, param3:int) : int;
      
      function socketpair(param1:int, param2:int, param3:int, param4:int, param5:int) : int;
      
      function mkdir(param1:int, param2:int, param3:int) : int;
      
      function rmdir(param1:int, param2:int) : int;
      
      function setsid(param1:int) : int;
      
      function getdirentries(param1:int, param2:int, param3:int, param4:int, param5:int) : int;
      
      function setgid(param1:int, param2:int) : int;
      
      function setegid(param1:int, param2:int) : int;
      
      function seteuid(param1:int, param2:int) : int;
      
      function stat(param1:int, param2:int, param3:int) : int;
      
      function fstat(param1:int, param2:int, param3:int) : int;
      
      function lstat(param1:int, param2:int, param3:int) : int;
      
      function pathconf(param1:int, param2:int, param3:int) : int;
      
      function fpathconf(param1:int, param2:int, param3:int) : int;
      
      function getpgid(param1:int, param2:int) : int;
      
      function semget(param1:int, param2:int, param3:int, param4:int) : int;
      
      function msgget(param1:int, param2:int, param3:int) : int;
      
      function msgsnd(param1:int, param2:int, param3:int, param4:int, param5:int) : int;
      
      function msgrcv(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int) : int;
      
      function shmdt(param1:int, param2:int) : int;
      
      function shmget(param1:int, param2:int, param3:int, param4:int) : int;
      
      function clock_gettime(param1:int, param2:int, param3:int) : int;
      
      function nanosleep(param1:int, param2:int, param3:int) : int;
      
      function lchown(param1:int, param2:int, param3:int, param4:int) : int;
      
      function getsid(param1:int, param2:int) : int;
      
      function sched_yield(param1:int) : int;
      
      function sched_get_priority_max(param1:int, param2:int) : int;
      
      function sched_get_priority_min(param1:int, param2:int) : int;
      
      function sigprocmask(param1:int, param2:int, param3:int, param4:int) : int;
      
      function sigpending(param1:int, param2:int) : int;
      
      function sigwait(param1:int, param2:int, param3:int) : int;
      
      function shm_unlink(param1:int, param2:int) : int;
      
      function pselect(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int) : int;
      
      function __getcwd(param1:int, param2:int, param3:int) : int;
      
      function issetugid(param1:int) : int;
   }
}

const §5§;
