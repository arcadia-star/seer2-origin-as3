package MEncrypt.vfs
{
   import flash.utils.ByteArray;
   
   public class DefaultVFS implements IVFS
   {
       
      
      private var _bslist:Array;
      
      private var _fdTable:Array;
      
      private var _specialFileTable:Object;
      
      private const consolePath:String = "/dev/tty";
      
      public function DefaultVFS()
      {
         _bslist = [];
         _fdTable = [null,null,null];
         _specialFileTable = {};
         super();
         addBackingStore(new InMemoryBackingStore(),null);
      }
      
      private function getBackingStoreForPath(param1:String) : Object
      {
         var _loc2_:int = 0;
         param1 = PathUtils.toCanonicalPath(param1);
         _loc2_ = 0;
         while(_loc2_ < _bslist.length)
         {
            if(_bslist[_loc2_].prefix.substr(1) == param1.substr(1,_bslist[_loc2_].prefix.length - 1))
            {
               return {
                  "store":_bslist[_loc2_].store,
                  "path":PathUtils.toCanonicalPath(param1.substr(_bslist[_loc2_].prefix.length))
               };
            }
            _loc2_++;
         }
         return null;
      }
      
      private function getPrefixForBackingStore(param1:IBackingStore) : String
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _bslist.length)
         {
            if(_bslist[_loc2_].store === param1)
            {
               return _bslist[_loc2_].prefix;
            }
            _loc2_++;
         }
         return null;
      }
      
      public function addBackingStore(param1:IBackingStore, param2:String) : void
      {
         var bsdesc:Object;
         var a:Vector.<FileHandle>;
         var bs:IBackingStore = param1;
         var prefix:String = param2;
         if(!prefix)
         {
            prefix = "";
         }
         prefix = PathUtils.toCanonicalPath(prefix);
         bsdesc = {
            "prefix":prefix,
            "store":bs
         };
         if(prefix != "/")
         {
            a = getDirectoryEntries(prefix);
            if(!a || a.length)
            {
               throw new Error("prefix \'" + prefix + "\' must be an empty directory");
            }
            _bslist.push(bsdesc);
         }
         else
         {
            _bslist = [bsdesc];
         }
         _bslist.sort(function(param1:*, param2:*):*
         {
            return param2.prefix.length - param1.prefix.length;
         });
         if(!getFileHandleFromPath(prefix))
         {
            addDirectory(prefix);
         }
      }
      
      public function addFile(param1:String, param2:ByteArray) : void
      {
         if(!param2)
         {
            throw new Error("data may not be null");
         }
         addFileImpl(param1,param2);
      }
      
      public function addDirectory(param1:String) : void
      {
         addFileImpl(param1,null);
      }
      
      private function addFileImpl(param1:String, param2:ByteArray) : void
      {
         param1 = PathUtils.toCanonicalPath(param1);
         if(getFileHandleFromPath(param1))
         {
            throw new Error("cannot create \'" + param1 + "\', file exists");
         }
         var _loc3_:Object = getBackingStoreForPath(param1);
         if(param2)
         {
            _loc3_.store.addFile(_loc3_.path,param2);
         }
         else
         {
            _loc3_.store.addDirectory(_loc3_.path);
         }
      }
      
      public function deleteFile(param1:String) : void
      {
         var _loc2_:FileHandle = getFileHandleFromPath(param1);
         if(!_loc2_)
         {
            throw new Error("cannot delete \'" + param1 + "\', file does not exist");
         }
         if(_loc2_.isDirectory && getDirectoryEntries(param1).length)
         {
            throw new Error("cannot delete \'" + param1 + "\', directory not empty");
         }
         _loc2_.backingStore.deleteFile(_loc2_.backingStoreRelativePath);
      }
      
      public function set console(param1:ISpecialFile) : void
      {
         if(_fdTable[0])
         {
            closeFile(0);
         }
         if(_fdTable[1])
         {
            closeFile(1);
         }
         if(_fdTable[2])
         {
            closeFile(2);
         }
         addSpecialFile("/dev/tty",param1);
         var _loc2_:FileHandle = getFileHandleFromPath("/dev/tty");
         _fdTable[0] = _loc2_;
         _fdTable[1] = _loc2_;
         _fdTable[2] = _loc2_;
      }
      
      public function get console() : ISpecialFile
      {
         var _loc1_:FileHandle = getFileHandleFromPath("/dev/tty");
         return _loc1_.callback;
      }
      
      public function addSpecialFile(param1:String, param2:ISpecialFile) : void
      {
         var _loc3_:FileHandle = FileHandle.makeSpecialFile(param2);
         _specialFileTable[param1] = _loc3_;
      }
      
      public function getDirectoryEntries(param1:String) : Vector.<FileHandle>
      {
         var _loc7_:FileHandle;
         if(!(_loc7_ = getFileHandleFromPath(param1)) || !_loc7_.isDirectory)
         {
            return null;
         }
         var _loc3_:Vector.<FileHandle> = new Vector.<FileHandle>();
         var _loc5_:* = _loc7_.backingStoreRelativePath + "/";
         var _loc6_:String = getPrefixForBackingStore(_loc7_.backingStore);
         for each(var _loc2_ in _loc7_.backingStore.getPaths())
         {
            if(_loc2_ && _loc2_.substr(0,_loc5_.length) == _loc5_ && _loc2_.length > _loc5_.length)
            {
               var _loc4_:String;
               if((_loc4_ = _loc2_.substr(_loc7_.backingStoreRelativePath.length + 1)).indexOf("/") == -1)
               {
                  _loc3_.push(getFileHandleFromPath(_loc6_ + "/" + _loc2_));
               }
            }
         }
         return _loc3_;
      }
      
      public function getFileHandleFromPath(param1:String) : FileHandle
      {
         param1 = PathUtils.toCanonicalPath(param1);
         if(_specialFileTable.hasOwnProperty(param1))
         {
            return _specialFileTable[param1];
         }
         var _loc3_:Object = getBackingStoreForPath(param1);
         var _loc2_:IBackingStore = _loc3_.store;
         if(!_loc3_)
         {
            return null;
         }
         if(_loc2_.pathExists(_loc3_.path))
         {
            return FileHandle.makeRegularFile(param1,_loc3_.path,_loc2_,_loc2_.getFile(_loc3_.path),_loc2_.isDirectory(_loc3_.path));
         }
         return null;
      }
      
      public function checkPath(param1:String) : String
      {
         var _loc3_:FileHandle = null;
         var _loc2_:String = "pathValid";
         param1 = PathUtils.toCanonicalPath(param1);
         while(param1 != "/")
         {
            param1 = PathUtils.getDirectory(param1);
            _loc3_ = getFileHandleFromPath(param1);
            if(!_loc3_)
            {
               _loc2_ = "pathComponentDoesNotExist";
               break;
            }
            if(!_loc3_.isDirectory)
            {
               _loc2_ = "pathComponentIsNotDirectory";
               break;
            }
         }
         return _loc2_;
      }
      
      public function openFile(param1:FileHandle, param2:int = -1) : int
      {
         if(param2 == -1)
         {
            return _fdTable.push(param1) - 1;
         }
         _fdTable[param2] = param1;
         return param2;
      }
      
      public function closeFile(param1:int) : void
      {
         if(_fdTable[param1].backingStore)
         {
            _fdTable[param1].backingStore.flush();
         }
         _fdTable[param1] = null;
      }
      
      public function isValidFileDescriptor(param1:int) : Boolean
      {
         return param1 >= 0 && param1 < _fdTable.length && _fdTable[param1];
      }
      
      public function getFileHandleFromFileDescriptor(param1:int) : FileHandle
      {
         if(isValidFileDescriptor(param1))
         {
            return _fdTable[param1];
         }
         return null;
      }
   }
}

const §3§;
