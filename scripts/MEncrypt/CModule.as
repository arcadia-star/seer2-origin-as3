package MEncrypt
{
   import MEncrypt.kernel.*;
   import MEncrypt.vfs.*;
   import flash.profiler.*;
   import flash.utils.*;
   
   public class CModule
   {
      
      protected static var weakResolvers:Vector.<Function> = new Vector.<Function>();
      
      private static var workerSprite = null;
      
      public static var recordFixups:Boolean = false;
      
      public static var regsInitted:Boolean = false;
      
      internal static var preppedForThreadedExec:Boolean = false;
      
      internal static var explicitlyInittedAllModules:Boolean = false;
      
      internal static const modThunks:Dictionary = new Dictionary();
      
      protected static var text:int = -268435456;
      
      protected static const scratchBA:ByteArray = new ByteArray();
      
      protected static const modules:Vector.<MEncrypt.CModule> = new Vector.<MEncrypt.CModule>();
      
      private static var seenModuleInit:Boolean;
      
      private static var telemetrySupported:Boolean;
      
      private static var cachedCSyms:Dictionary = new Dictionary();
      
      private static var toBeMapped:Vector.<MEncrypt.CModule> = modules;
      
      public static var rootSprite:Object;
      
      private static var _kernel:Object = null;
      
      public static var activeConsole:Object;
      
      private static var _vfs:Object = null;
      
      {
         try
         {
            if(Telemetry != null)
            {
               telemetrySupported = true;
            }
         }
         catch(e:*)
         {
            telemetrySupported = false;
         }
         workerInits.push(function(param1:*):void
         {
            var _loc3_:String = null;
            var _loc6_:Object = null;
            prepForThreadedExec();
            var _loc2_:Vector.<MEncrypt.CModule> = getModuleVector();
            for each(var _loc4_ in _loc2_)
            {
               _loc3_ = String(_loc4_.modPackage);
               _loc6_ = _loc4_.getSections();
               for(var _loc5_ in _loc6_)
               {
                  param1.setSharedProperty("flascc.sect." + _loc3_ + "." + _loc5_,_loc6_[_loc5_][0]);
               }
               param1.setSharedProperty("flascc." + _loc3_ + ".oncep",_loc4_.oncep);
            }
         });
      }
      
      private var sections:Object;
      
      private var init:Function;
      
      private var script:Object;
      
      private var modSyms:Array;
      
      private var modPackage:String;
      
      private var fixups:Vector.<int>;
      
      public const oncep:int = (!!workerClass ? workerClass.current.getSharedProperty("flascc." + _loc4_ + ".oncep") : 0) || sbrk(1,1);
      
      public function CModule(param1:Object, param2:Function, param3:Array, param4:String)
      {
         super();
         this.sections = param1;
         this.init = param2;
         this.modSyms = param3;
         this.modPackage = param4;
         if(recordFixups)
         {
            fixups = new Vector.<int>();
         }
      }
      
      public static function get ram() : ByteArray
      {
         return ram;
      }
      
      public static function get throwWhenOutOfMemory() : Boolean
      {
         return throwWhenOutOfMemory;
      }
      
      public static function set throwWhenOutOfMemory(param1:Boolean) : void
      {
         throwWhenOutOfMemory = param1;
      }
      
      public static function get canUseWorkers() : Boolean
      {
         return workerClass;
      }
      
      public static function resolveWeaks(param1:Function) : void
      {
         weakResolvers.unshift(param1);
         while(weakResolvers.length)
         {
            if(!weakResolvers.pop()())
            {
               weakResolvers.unshift(param1);
            }
         }
      }
      
      public static function runningAsWorker() : Boolean
      {
         var _loc1_:Boolean = false;
         if(!MEncrypt.CModule.rootSprite)
         {
            throw new Error("specify a rootSprite using \"CModule.rootSprite = ...\"");
         }
         try
         {
            workerSWFBytes = MEncrypt.CModule.rootSprite.loaderInfo.bytes;
            if(workerClass["current"].getSharedProperty("flascc.ram"))
            {
               _loc1_ = true;
            }
         }
         catch(e:*)
         {
            _loc1_ = false;
         }
         if(_loc1_)
         {
            workerSprite = new AlcWorkerSprite();
         }
         return _loc1_;
      }
      
      public static function getPublicSymbol(param1:String) : int
      {
         var _loc3_:*;
         return [_loc3_ = "_" + param1];
      }
      
      public static function getSymsUsingMD() : Array
      {
         var _loc3_:Dictionary = mapCsymsWithExplicitValues();
         var _loc1_:Array = [];
         var _loc5_:int = 0;
         var _loc4_:Vector.<MEncrypt.CModule> = modules;
         while(§§hasnext(_loc4_,_loc5_))
         {
         }
         return _loc1_;
      }
      
      public static function prepForThreadedExec() : void
      {
         if(preppedForThreadedExec)
         {
            return;
         }
         if(typeof ptr2fun == "undefined" || ptr2fun is Array)
         {
            explicitlyInitAllModules();
         }
         preppedForThreadedExec = true;
      }
      
      public static function explicitlyInitAllModules() : void
      {
         if(explicitlyInittedAllModules)
         {
            return;
         }
         var _loc2_:Boolean = false;
         try
         {
            AlcDbgHelper.pauseLibraryNotifications();
            _loc2_ = true;
         }
         catch(e:*)
         {
         }
         try
         {
            for each(var _loc1_ in getModuleVector())
            {
               _loc1_.getScript();
            }
         }
         finally
         {
            try
            {
               if(_loc2_)
               {
                  AlcDbgHelper.resumeLibraryNotifications();
               }
            }
            catch(e:*)
            {
            }
         }
         explicitlyInittedAllModules = true;
      }
      
      internal static function makeThunk(param1:String, param2:Dictionary, param3:int, param4:int, param5:int) : Function
      {
         var modPkgName:String = param1;
         var thunkSet:Dictionary = param2;
         var start:int = param3;
         var end:int = param4;
         var index:int = param5;
         return function():void
         {
            var _loc2_:int = 0;
            delete modThunks[modPkgName];
            var _loc1_:MEncrypt.CModule = getModuleByPackage(modPkgName);
            _loc1_.getScript();
            _loc2_ = start;
            while(_loc2_ < end)
            {
               if(thunkSet[ptr2fun[_loc2_]])
               {
                  ptr2fun[_loc2_] = null;
               }
               _loc2_++;
            }
            if(index >= 0)
            {
               ptr2fun[index]();
            }
         };
      }
      
      public static function allocFunPtrs(param1:String, param2:int, param3:int) : int
      {
         var _loc4_:Dictionary = null;
         var _loc8_:* = 0;
         if(param3 < 1)
         {
            param3 = 1;
         }
         ptr2fun_init.length = int((ptr2fun_init.length + param3 - 1) / param3) * param3;
         var _loc5_:int = int(ptr2fun_init.length);
         ptr2fun_init.length += param2;
         if(param1 != null && workerClass)
         {
            _loc4_ = new Dictionary();
            _loc8_ = _loc5_;
            while(_loc8_ < _loc5_ + param2)
            {
               var _loc6_:Function = makeThunk(param1,_loc4_,_loc5_,_loc5_ + param2,_loc8_);
               _loc4_[_loc6_] = true;
               ptr2fun_init[_loc8_] = _loc6_;
               _loc8_++;
            }
            var _loc7_:Function = makeThunk(param1,_loc4_,_loc5_,_loc5_ + param2,-1);
            modThunks[param1] = _loc7_;
            _loc4_[_loc7_] = true;
         }
         return _loc5_;
      }
      
      public static function allocTextSect(param1:String, param2:String, param3:int) : int
      {
         var _loc4_:*;
         text = (_loc4_ = text + 15 & -16) + param3;
         return _loc4_;
      }
      
      public static function allocDataSect(param1:String, param2:String, param3:int, param4:int) : int
      {
         var _loc5_:int = 0;
         if(workerClass)
         {
            _loc5_ = int(workerClass.current.getSharedProperty("flascc.sect." + param1 + "." + param2));
         }
         if(!_loc5_)
         {
            if(param4 < 1)
            {
               param4 = 1;
            }
            _loc5_ = sbrk(param3,param4);
         }
         return _loc5_;
      }
      
      public static function describeType(param1:*) : XML
      {
         var _loc3_:Namespace = null;
         try
         {
            _loc3_ = new Namespace("flash.utils");
            return _loc3_::["describeType"](param1);
         }
         catch(e:*)
         {
            var _loc2_:Namespace = new Namespace("avmplus");
            return _loc2_::["describeType"](param1,_loc2_::["FLASH10_FLAGS"]);
         }
      }
      
      public static function write8(param1:int, param2:int) : void
      {
         ram_init.position = param1;
         ram_init.writeByte(param2);
      }
      
      public static function write16(param1:int, param2:int) : void
      {
         ram_init.position = param1;
         ram_init.writeShort(param2);
      }
      
      public static function write32(param1:int, param2:int) : void
      {
         ram_init.position = param1;
         ram_init.writeInt(param2);
      }
      
      public static function writeFloat(param1:int, param2:Number) : void
      {
         ram_init.position = param1;
         ram_init.writeFloat(param2);
      }
      
      public static function writeDouble(param1:int, param2:Number) : void
      {
         ram_init.position = param1;
         ram_init.writeDouble(param2);
      }
      
      public static function writeBytes(param1:int, param2:uint, param3:IDataInput) : void
      {
         param3.readBytes(ram_init,param1,param2);
      }
      
      public static function read8(param1:int) : int
      {
         ram_init.position = param1;
         return ram_init.readUnsignedByte();
      }
      
      public static function read16(param1:int) : int
      {
         ram_init.position = param1;
         return ram_init.readUnsignedShort();
      }
      
      public static function read32(param1:int) : int
      {
         ram_init.position = param1;
         return ram_init.readInt();
      }
      
      public static function readFloat(param1:int) : Number
      {
         ram_init.position = param1;
         return ram_init.readFloat();
      }
      
      public static function readDouble(param1:int) : Number
      {
         ram_init.position = param1;
         return ram_init.readDouble();
      }
      
      public static function readBytes(param1:int, param2:uint, param3:IDataOutput) : void
      {
         param3.writeBytes(ram_init,param1,param2);
      }
      
      public static function push32(param1:int) : void
      {
         ESP -= 4;
         write32(ESP,param1);
      }
      
      public static function pop32() : int
      {
         var _loc1_:int = read32(ESP);
         ESP += 4;
         return _loc1_;
      }
      
      public static function malloc(param1:int) : int
      {
         var _loc2_:Vector.<int> = new Vector.<int>();
         _loc2_.push(param1);
         return callI(_malloc,_loc2_);
      }
      
      public static function free(param1:int) : void
      {
         var _loc2_:Vector.<int> = new Vector.<int>();
         _loc2_.push(param1);
         callI(_free,_loc2_);
      }
      
      public static function alloca(param1:int) : int
      {
         ESP = int((ESP - param1) / 16) * 16;
         return ESP;
      }
      
      public static function writeString(param1:int, param2:String) : int
      {
         ram_init.position = param1;
         ram_init.writeUTFBytes(param2);
         return ram_init.position - param1;
      }
      
      public static function readString(param1:int, param2:int) : String
      {
         ram_init.position = param1;
         return String(ram_init.readUTFBytes(param2));
      }
      
      public static function writeLatin1String(param1:int, param2:String) : int
      {
         ram_init.position = param1;
         ram_init.writeUTFBytes(param2);
         return ram_init.position - param1;
      }
      
      public static function readLatin1String(param1:int, param2:int) : String
      {
         ram_init.position = param1;
         return String(ram_init.readUTFBytes(param2));
      }
      
      public static function readIntVector(param1:int, param2:int) : Vector.<int>
      {
         var _loc3_:Vector.<int> = new Vector.<int>();
         ram_init.position = param1;
         while(param2--)
         {
            _loc3_.push(ram_init.readInt());
         }
         return _loc3_;
      }
      
      public static function writeIntVector(param1:int, param2:Vector.<int>) : void
      {
         var _loc3_:int = 0;
         ram_init.position = param1;
         _loc3_ = 0;
         while(_loc3_ < param2.length)
         {
            ram_init.writeInt(param2[_loc3_]);
            _loc3_++;
         }
      }
      
      public static function mallocString(param1:String) : int
      {
         scratchBA.position = 0;
         scratchBA.writeUTFBytes(param1);
         scratchBA.writeByte(0);
         var _loc2_:int = int(scratchBA.position);
         var _loc3_:int = malloc(_loc2_);
         ram_init.position = _loc3_;
         ram_init.writeBytes(scratchBA,0,_loc2_);
         if(_loc2_ > 4096)
         {
            scratchBA.length = 4096;
         }
         return _loc3_;
      }
      
      public static function allocaString(param1:String) : int
      {
         scratchBA.position = 0;
         scratchBA.writeUTFBytes(param1);
         scratchBA.writeByte(0);
         var _loc2_:int = int(scratchBA.position);
         var _loc3_:int = alloca(_loc2_);
         ram_init.position = _loc3_;
         ram_init.writeBytes(scratchBA,0,_loc2_);
         if(_loc2_ > 4096)
         {
            scratchBA.length = 4096;
         }
         return _loc3_;
      }
      
      public static function mallocLatin1String(param1:String) : int
      {
         var _loc2_:int = param1.length;
         var _loc3_:int = malloc(_loc2_ + 1);
         ram_init.position = _loc3_;
         ram_init.writeUTFBytes(param1);
         ram_init[_loc3_ + _loc2_] = 0;
         return _loc3_;
      }
      
      public static function allocaLatin1String(param1:String) : int
      {
         var _loc2_:int = param1.length;
         var _loc3_:int = alloca(_loc2_ + 1);
         ram_init.position = _loc3_;
         ram_init.writeUTFBytes(param1);
         ram_init[_loc3_ + _loc2_] = 0;
         return _loc3_;
      }
      
      public static function regFun(param1:int, param2:Function) : void
      {
         if(param1 == 0)
         {
            throw new Error("Error: Attempting to register the null function pointer");
         }
         ptr2fun_init[param1] = param2;
      }
      
      public static function callI(param1:int, param2:Vector.<int>, param3:int = 0, param4:Boolean = false) : int
      {
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc5_:int = ESP;
         try
         {
            if(param3)
            {
               ESP = param3;
            }
            ESP = int(ESP / 16) * 16;
            _loc6_ = (16 - param2.length * 4 % 16) % 16;
            ESP -= _loc6_;
            _loc7_ = int(param2.length - 1);
            while(_loc7_ >= 0)
            {
               push32(param2[_loc7_]);
               _loc7_--;
            }
            ptr2fun_init[param1]();
         }
         finally
         {
            if(!param4)
            {
               ESP = _loc5_;
            }
         }
         return eax;
      }
      
      public static function callN(param1:int, param2:Vector.<int>, param3:int = 0, param4:Boolean = false) : Number
      {
         callI(param1,param2,param3);
         return st0;
      }
      
      public static function regModule(param1:Object, param2:Function, param3:Array, param4:String) : MEncrypt.CModule
      {
         if(seenModuleInit)
         {
            trace("WARNING: module registration after module initialization has begun");
         }
         var _loc5_:MEncrypt.CModule = new MEncrypt.CModule(param1,param2,param3,param4);
         modules.push(_loc5_);
         return _loc5_;
      }
      
      public static function getModuleByPackage(param1:String) : MEncrypt.CModule
      {
         for each(var _loc2_ in modules)
         {
            if(_loc2_.modPackage == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public static function getModuleVector() : Vector.<MEncrypt.CModule>
      {
         return modules.concat();
      }
      
      public static function sendMetric(param1:String, param2:*) : void
      {
         try
         {
            if(telemetrySupported)
            {
               Telemetry.sendMetric(param1,param2);
            }
         }
         catch(e:*)
         {
            trace("failed to send metric \'" + param1 + "\' value \'" + param2 + "\'");
         }
      }
      
      public static function sendSpanMetric(param1:String, param2:Number, param3:* = null) : void
      {
         if(telemetrySupported)
         {
            Telemetry.sendMetric(param1,param2,param3);
         }
      }
      
      private static function mapCsymsWithExplicitValues() : Dictionary
      {
         var _loc1_:* = null;
         var _loc2_:Vector.<MEncrypt.CModule> = new Vector.<MEncrypt.CModule>();
         for each(_loc1_ in toBeMapped)
         {
            if(_loc1_.script)
            {
               _loc1_.mapCsymsWithExplicitValues(cachedCSyms);
            }
            else
            {
               _loc2_.push(_loc1_);
            }
         }
         toBeMapped = _loc2_;
         return cachedCSyms;
      }
      
      public static function get kernel() : Object
      {
         if(!_kernel)
         {
            try
            {
               _kernel = new ShellPosix();
            }
            catch(e:ReferenceError)
            {
               _kernel = new PlayerKernel();
            }
         }
         return _kernel;
      }
      
      public static function set kernel(param1:Object) : void
      {
         _kernel = param1;
      }
      
      public static function get vfs() : IVFS
      {
         if(!_vfs)
         {
            _vfs = new DefaultVFS();
         }
         return _vfs;
      }
      
      public static function set vfs(param1:IVFS) : void
      {
         _vfs = param1;
      }
      
      private static function mallocStrings(param1:Vector.<String>) : Vector.<int>
      {
         var _loc3_:int = 0;
         var _loc2_:Vector.<int> = new Vector.<int>();
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_.push(mallocString(param1[_loc3_]));
            _loc3_++;
         }
         return _loc2_;
      }
      
      private static function mallocPtrArray(param1:Vector.<int>) : int
      {
         var _loc3_:int = 0;
         if(param1.length == 0)
         {
            return 0;
         }
         var _loc2_:int = malloc(param1.length * 4);
         ram_init.position = _loc2_;
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            ram_init.writeInt(param1[_loc3_]);
            _loc3_++;
         }
         return _loc2_;
      }
      
      private static function allocaStrings(param1:Vector.<String>) : Vector.<int>
      {
         var _loc3_:int = 0;
         var _loc2_:Vector.<int> = new Vector.<int>();
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_.push(allocaString(param1[_loc3_]));
            _loc3_++;
         }
         return _loc2_;
      }
      
      private static function allocaPtrArray(param1:Vector.<int>) : int
      {
         var _loc3_:int = 0;
         if(param1.length == 0)
         {
            return 0;
         }
         var _loc2_:int = alloca(param1.length * 4);
         ram_init.position = _loc2_;
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            ram_init.writeInt(param1[_loc3_]);
            _loc3_++;
         }
         return _loc2_;
      }
      
      public static function runCtors() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = getModuleVector().reverse();
         for each(_loc3_ in _loc2_)
         {
            (_loc3_).runCtors();
         }
      }
      
      public static function runDtors() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = getModuleVector();
         for each(_loc3_ in _loc2_)
         {
            (_loc3_).runDtors();
         }
      }
      
      public static function serviceUIRequests() : void
      {
         var _loc1_:int = read32(_flascc_uiTickProc);
         if(_loc1_)
         {
            callI(_loc1_,new Vector.<int>(0));
         }
      }
      
      public static function start(param1:Object, param2:Vector.<String>, param3:Vector.<String>, param4:Boolean = true) : int
      {
         var _loc6_:int = 0;
         var _loc8_:* = undefined;
         var _loc9_:int = 0;
         var _loc7_:* = undefined;
         if(param1)
         {
            if(activeConsole)
            {
               throw new Error("calling start with a console with an already active console");
            }
            activeConsole = param1;
         }
         var _loc5_:int = ESP;
         try
         {
            (_loc8_ = allocaStrings(param2)).push(0);
            (_loc8_ = _loc8_.concat(allocaStrings(param3))).push(0);
            _loc9_ = allocaPtrArray(_loc8_);
            _loc5_ = ESP;
            (_loc7_ = new Vector.<int>()).push(0,param2.length,_loc9_);
            _loc6_ = callI(__start1,_loc7_);
         }
         catch(exitCode:Exit)
         {
            _loc6_ = int(exitCode.code);
         }
         finally
         {
            if(!param4)
            {
               ESP = _loc5_;
            }
         }
         return _loc6_;
      }
      
      public static function startAsync(param1:Object = null, param2:Vector.<String> = null, param3:Vector.<String> = null, param4:Boolean = true) : void
      {
         if(activeConsole)
         {
            throw new Error("calling startAsync with an active console");
         }
         if(!param2)
         {
            param2 = new Vector.<String>();
         }
         if(!param3)
         {
            param3 = new Vector.<String>();
         }
         try
         {
            workerClass["current"].setSharedProperty("flascc.uiThread.threadId",realThreadId);
         }
         catch(e:*)
         {
         }
         try
         {
            MEncrypt.CModule.start(param1,param2,param3,param4);
         }
         catch(e:GoingAsync)
         {
         }
         catch(e:*)
         {
            activeConsole = undefined;
            throw e;
         }
      }
      
      public static function startBackground(param1:Object = null, param2:Vector.<String> = null, param3:Vector.<String> = null, param4:int = 65536) : void
      {
         var _loc8_:* = undefined;
         var _loc10_:int = 0;
         var _loc7_:* = undefined;
         var _loc9_:* = 0;
         var _loc5_:* = undefined;
         var _loc11_:int = 0;
         if(param1)
         {
            if(activeConsole)
            {
               throw new Error("calling startBackground with a console with an already active console");
            }
            activeConsole = param1;
         }
         if(param4 < 8192 || param4 % 4096)
         {
            throw new Error("invalid stack size");
         }
         if(!param2)
         {
            param2 = new Vector.<String>();
         }
         if(!param3)
         {
            param3 = new Vector.<String>();
         }
         var _loc6_:int = ESP;
         try
         {
            (_loc8_ = allocaStrings(param2)).push(0);
            (_loc8_ = _loc8_.concat(allocaStrings(param3))).push(0);
            _loc10_ = allocaPtrArray(_loc8_);
            _loc6_ = ESP;
            (_loc7_ = new Vector.<int>()).push(0,param2.length,_loc10_);
            _loc9_ = _loc6_;
            _loc5_ = newThread(0,_loc9_,__start1,_loc7_);
            threadId = realThreadId = 1;
            _loc5_.setSharedProperty("flascc.uiThread.threadId",threadId);
            _loc6_ = ESP_init = (_loc11_ = sbrk(param4,4096)) + param4;
            _loc5_.setSharedProperty("flascc.uiThread.esp_init",_loc6_);
            _loc5_.setSharedProperty("flascc.uiThread.stackSize",param4);
            _loc5_.setSharedProperty("flascc.uiThread.tcbpp",_loc11_);
            threadArbMutexLock();
            _loc5_.start();
            ESP = _loc11_ + 4096;
            do
            {
               threadArbCondWait(1);
               serviceUIRequests();
            }
            while(!(tcbp = read32(_loc11_)));
            
            write32(_loc11_,0);
            threadArbCondsNotify(-1);
            threadArbMutexUnlock();
         }
         finally
         {
            ESP = _loc6_;
         }
      }
      
      public function once(param1:Function, ... rest) : void
      {
         if(workerClass)
         {
            threadArbMutexLock();
         }
         try
         {
            if(!read8(oncep))
            {
               write8(oncep,1);
               param1.apply(undefined,rest);
            }
         }
         finally
         {
            if(workerClass)
            {
               threadArbMutexUnlock();
            }
         }
      }
      
      public function fixup32(param1:int, param2:int) : void
      {
         if(fixups)
         {
            fixups.push(param1);
         }
         write32(param1,param2);
      }
      
      public function fixup16(param1:int, param2:int) : void
      {
         write16(param1,param2);
      }
      
      public function fixup8(param1:int, param2:int) : void
      {
         write8(param1,param2);
      }
      
      public function getFixups() : Vector.<int>
      {
         return !!fixups ? fixups.concat() : null;
      }
      
      public function getSections() : Object
      {
         var _loc2_:Object = {};
         for(var _loc1_ in sections)
         {
            _loc2_[_loc1_] = sections[_loc1_].concat();
         }
         return _loc2_;
      }
      
      private function mapCsymsWithExplicitValues(param1:Dictionary) : void
      {
         var _loc15_:* = 0;
         var _loc12_:int = 0;
         var _loc4_:Array = null;
         var _loc8_:String = null;
         var _loc16_:String = null;
         var _loc3_:* = 0;
         var _loc7_:XML = null;
         var _loc11_:XMLList = null;
         var _loc5_:Array = null;
         if(!script)
         {
            return;
         }
         if(modSyms)
         {
            _loc12_ = 0;
            while(_loc12_ < modSyms.length)
            {
               if((_loc4_ = modSyms[_loc12_]).length >= 4)
               {
                  _loc8_ = String(_loc4_[1]);
                  _loc16_ = String(_loc4_[2]);
                  _loc3_ = uint(_loc4_[3]);
                  if(String(_loc4_[0]) == "t")
                  {
                     _loc15_ = uint(script.new Namespace(modPackage)::[_loc8_]);
                  }
                  else
                  {
                     _loc15_ = uint(script[_loc8_]);
                  }
                  param1[_loc16_ + "/" + _loc15_] = uint(_loc3_ + sections[_loc16_][0]);
               }
               _loc12_++;
            }
         }
         else
         {
            for each(var _loc14_ in (_loc10_ = MEncrypt.CModule.describeType(script))..metadata.(@name == "Csym"))
            {
               if(!(!(_loc7_ = _loc14_.parent()) || _loc7_.name() != "constant"))
               {
                  if((_loc11_ = _loc14_..arg).length() >= 4)
                  {
                     _loc5_ = [];
                     var _loc24_:int = 0;
                     var _loc23_:* = _loc11_;
                     for each(_loc24_ in _loc23_)
                     {
                        _loc5_.push(String((_loc24_).@value));
                     }
                     var _loc18_:String = _loc7_.@name;
                     _loc15_ = uint(script.new Namespace(String(_loc7_.@uri))::[_loc18_]);
                     param1[_loc5_[2] + "/" + _loc15_] = uint(uint(_loc5_[3]) + sections[_loc5_[2]][0]);
                  }
               }
            }
         }
      }
      
      public function getSymsUsingMD() : Array
      {
         var _loc1_:Dictionary = MEncrypt.CModule.mapCsymsWithExplicitValues();
         return getSymsUsingMDWithExplicitSyms(_loc1_);
      }
      
      private function getSymsUsingMDWithExplicitSyms(param1:Dictionary) : Array
      {
         var _loc18_:* = 0;
         var _loc19_:String = null;
         var _loc14_:int = 0;
         var _loc5_:Array = null;
         var _loc15_:String = null;
         var _loc9_:String = null;
         var _loc20_:String = null;
         var _loc6_:Array = null;
         var _loc12_:String = null;
         var _loc17_:String = null;
         var _loc8_:XML = null;
         var _loc4_:String = null;
         var _loc13_:Object = getScript();
         var _loc2_:Array = [];
         if(modSyms)
         {
            _loc14_ = 0;
            while(_loc14_ < modSyms.length)
            {
               _loc15_ = String((_loc5_ = modSyms[_loc14_])[0]);
               _loc9_ = String(_loc5_[1]);
               if(_loc5_.length == 2)
               {
                  _loc2_.push([_loc15_,_loc9_]);
               }
               else
               {
                  _loc20_ = String(_loc5_[2]);
                  if(_loc15_ == "t")
                  {
                     _loc18_ = uint(_loc13_.new Namespace(modPackage)::[_loc9_]);
                  }
                  else
                  {
                     _loc18_ = uint(_loc13_[_loc9_]);
                  }
                  _loc19_ = _loc20_ + "/" + _loc18_;
                  if(typeof param1[_loc19_] != "undefined")
                  {
                     _loc18_ = uint(param1[_loc19_]);
                  }
                  _loc2_.push([_loc15_,_loc9_,_loc20_,_loc18_]);
               }
               _loc14_++;
            }
         }
         else
         {
            for each(var _loc16_ in (_loc11_ = MEncrypt.CModule.describeType(_loc13_))..metadata.(@name == "Csym"))
            {
               _loc6_ = [];
               var _loc28_:int = 0;
               var _loc27_:* = _loc16_..arg;
               for each(_loc28_ in _loc27_)
               {
                  _loc6_.push(String((_loc28_).@value));
               }
               _loc12_ = String(_loc6_[0]);
               _loc17_ = String(_loc6_[1]);
               if((_loc8_ = _loc16_.parent()) && _loc8_.name() == "constant")
               {
                  _loc4_ = String(_loc6_[2]);
                  var _loc22_:String = _loc8_.@name;
                  _loc18_ = uint(_loc13_.new Namespace(String(_loc8_.@uri))::[_loc22_]);
                  _loc19_ = _loc4_ + "/" + _loc18_;
                  if(typeof param1[_loc19_] != "undefined")
                  {
                     _loc18_ = uint(param1[_loc19_]);
                  }
                  _loc2_.push([_loc12_,_loc17_,_loc4_,_loc18_]);
               }
               else
               {
                  _loc2_.push([_loc12_,_loc17_]);
               }
            }
         }
         return _loc2_;
      }
      
      public function notifyInit(param1:Object) : void
      {
         var _loc3_:* = new Namespace("MEncrypt");
         seenModuleInit = true;
         var _loc2_:Function = modThunks[modPackage];
         if(Boolean(_loc2_))
         {
            _loc2_();
         }
         this.script = param1;
         this.init = null;
         try
         {
            AlcDbgHelper.notifyScriptInit(this);
         }
         catch(e:*)
         {
         }
         try
         {
            if(param1["ESP"])
            {
               MEncrypt.CModule.regsInitted = true;
            }
         }
         catch(e:*)
         {
         }
      }
      
      public function getScript() : Object
      {
         if(!script)
         {
            init();
         }
         return script;
      }
      
      public function getPublicSym(param1:String) : int
      {
         var _loc3_:Object = getScript();
         return _loc3_["_" + param1];
      }
      
      public function runCtors() : void
      {
         var _loc5_:int = 0;
         var _loc1_:* = undefined;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:* = sections[".ctors"];
         if(_loc3_)
         {
            _loc5_ = int(_loc3_[1]);
            _loc1_ = new Vector.<int>();
            if(_loc5_)
            {
               getScript();
            }
            _loc2_ = int(_loc3_[0]);
            while(_loc5_ >= 4)
            {
               if(_loc4_ = read32(_loc2_))
               {
                  callI(_loc4_,_loc1_);
               }
               _loc5_ -= 4;
               _loc2_ += 4;
            }
         }
      }
      
      public function runDtors() : void
      {
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:* = undefined;
         var _loc4_:int = 0;
         var _loc1_:* = sections[".dtors"];
         if(_loc1_)
         {
            _loc5_ = int(_loc1_[1]);
            _loc3_ = int(_loc1_[0]);
            _loc2_ = new Vector.<int>();
            if(_loc5_)
            {
               getScript();
            }
            while(_loc5_ >= 4)
            {
               if(_loc4_ = read32(_loc3_))
               {
                  callI(_loc4_,_loc2_);
               }
               _loc5_ -= 4;
               _loc3_ += 4;
            }
         }
      }
   }
}

const §10§;
