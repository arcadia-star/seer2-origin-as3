package com.taomee.seer2.app.arena.data
{
   import com.taomee.seer2.app.arena.Fighter;
   import com.taomee.seer2.app.arena.resource.ResourceQueue;
   import com.taomee.seer2.app.arena.util.FightPostion;
   import com.taomee.seer2.app.config.FitConfig;
   import com.taomee.seer2.core.cache.CacheType;
   
   public class FighterTeam
   {
       
      
      private var _teamInfo:TeamInfo;
      
      private var _fighterVec:Vector.<Fighter>;
      
      private var _fighterInfoVec:Vector.<FighterInfo>;
      
      private var _changeFighterVec:Vector.<Fighter>;
      
      private var _changeFighterInfoVec:Vector.<FighterInfo>;
      
      private var _initFighterVec:Vector.<Fighter>;
      
      public function FighterTeam(param1:TeamInfo)
      {
         var _loc2_:FightUserInfo = null;
         var _loc3_:FighterInfo = null;
         var _loc4_:FighterInfo = null;
         super();
         this._teamInfo = param1;
         this._fighterVec = new Vector.<Fighter>();
         this._fighterInfoVec = new Vector.<FighterInfo>();
         this._changeFighterVec = new Vector.<Fighter>();
         this._changeFighterInfoVec = new Vector.<FighterInfo>();
         this._initFighterVec = Vector.<Fighter>([]);
         for each(_loc2_ in this._teamInfo.fightUserInfoVec)
         {
            for each(_loc3_ in _loc2_.fighterInfoVec)
            {
               this._fighterInfoVec.push(_loc3_);
            }
            for each(_loc4_ in _loc2_.changeFighterInfoVec)
            {
               this._changeFighterInfoVec.push(_loc4_);
            }
         }
      }
      
      public function dispose() : void
      {
         var _loc1_:Fighter = null;
         for each(_loc1_ in this._fighterVec)
         {
            _loc1_.dispose();
         }
         this._fighterInfoVec = null;
         this._changeFighterInfoVec = null;
         this._changeFighterVec = null;
         this._fighterVec = null;
         this._initFighterVec = null;
         this._teamInfo = null;
      }
      
      public function replaceFighterPositionWithActive(param1:int, param2:Fighter) : void
      {
         this.replaceFighterPosition(param1,param2);
         param2.active();
      }
      
      public function replaceFighterPosition(param1:int, param2:Fighter) : void
      {
         if(param1 == FightPostion.INACTIVE)
         {
            return;
         }
         var _loc3_:Fighter = this.getFighterAtPos(param1);
         if(_loc3_ != null)
         {
            _loc3_.fighterInfo.position = FightPostion.INACTIVE;
         }
         if(param2 == null)
         {
            return;
         }
         param2.fighterInfo.position = param1;
      }
      
      public function changeMainSubPosition(param1:Function) : void
      {
         var oldMainFighter:Fighter = null;
         var oldSubFighter:Fighter = null;
         var counter:uint = 0;
         var onChangeComplete:Function = null;
         var onComplete:Function = param1;
         onChangeComplete = function():void
         {
            ++counter;
            if(counter == 2)
            {
               if(oldSubFighter)
               {
                  oldSubFighter.updatePosition();
               }
               oldMainFighter.updatePosition();
               if(onComplete != null)
               {
                  onComplete();
               }
            }
         };
         oldMainFighter = this.mainFighter;
         oldSubFighter = this.subFighter;
         this.replaceFighterPosition(FightPostion.MAIN,oldSubFighter);
         this.replaceFighterPosition(FightPostion.SUB,oldMainFighter);
         counter = 0;
         if(oldSubFighter)
         {
            oldSubFighter.tweenToPosition(onChangeComplete);
         }
         oldMainFighter.tweenToPosition(onChangeComplete);
      }
      
      public function createFighter(param1:ResourceQueue, param2:ArenaDataInfo) : void
      {
         var _loc3_:Fighter = null;
         var _loc4_:FighterInfo = null;
         var _loc5_:FighterInfo = null;
         for each(_loc4_ in this._fighterInfoVec)
         {
            _loc3_ = new Fighter(_loc4_,this._teamInfo.clientSide,param2,this.isFitInfo(_loc4_));
            param1.addCache(CacheType.PET,_loc3_.resourceUrl,_loc3_.onResoureceLoaded);
            this._fighterVec.push(_loc3_);
            this._initFighterVec.push(_loc3_);
         }
         for each(_loc5_ in this._changeFighterInfoVec)
         {
            _loc3_ = new Fighter(_loc5_,this._teamInfo.clientSide,param2,this.isFitInfo(_loc5_));
            param1.addCache(CacheType.PET,_loc3_.resourceUrl,_loc3_.onResoureceLoaded);
            this._changeFighterVec.push(_loc3_);
            this._initFighterVec.push(_loc3_);
         }
      }
      
      public function hasFighter(param1:Fighter) : Boolean
      {
         return this.containsFighter(param1.fighterInfo.userId,param1.id);
      }
      
      public function containsFighter(param1:uint, param2:uint) : Boolean
      {
         var _loc3_:Fighter = this.getFighter(param1,param2);
         if(_loc3_ == null)
         {
            _loc3_ = this.getChangeFighter(param1,param2);
         }
         return _loc3_ != null;
      }
      
      public function getFighter(param1:uint, param2:uint) : Fighter
      {
         var _loc3_:Fighter = null;
         var _loc4_:Fighter = null;
         for each(_loc4_ in this._fighterVec)
         {
            if(_loc4_.fighterInfo.userId == param1 && _loc4_.id == param2)
            {
               _loc3_ = _loc4_;
               break;
            }
         }
         if(_loc3_ == null)
         {
            _loc3_ = this.getChangeFighter(param1,param2);
         }
         return _loc3_;
      }
      
      public function getInitFighter(param1:uint, param2:uint) : Fighter
      {
         var _loc3_:Fighter = null;
         var _loc4_:Fighter = null;
         for each(_loc4_ in this._initFighterVec)
         {
            if(_loc4_.fighterInfo.userId == param1 && _loc4_.id == param2)
            {
               _loc3_ = _loc4_;
               break;
            }
         }
         return _loc3_;
      }
      
      public function getChangeFighter(param1:uint, param2:uint) : Fighter
      {
         var _loc3_:Fighter = null;
         var _loc4_:Fighter = null;
         for each(_loc4_ in this._changeFighterVec)
         {
            if(_loc4_.fighterInfo.userId == param1 && _loc4_.id == param2)
            {
               _loc3_ = _loc4_;
               break;
            }
         }
         return _loc3_;
      }
      
      public function containsFightUser(param1:uint) : Boolean
      {
         var _loc2_:FightUserInfo = null;
         for each(_loc2_ in this._teamInfo.fightUserInfoVec)
         {
            if(_loc2_.userId == param1)
            {
               return true;
            }
         }
         return false;
      }
      
      public function getRandomAliveFighterInfo() : FighterInfo
      {
         var _loc1_:FighterInfo = null;
         var _loc2_:FighterInfo = null;
         for each(_loc2_ in this._fighterInfoVec)
         {
            if(_loc2_.hp > 0 && this.isFitInfo(_loc2_) == false)
            {
               _loc1_ = _loc2_;
               break;
            }
         }
         return _loc1_;
      }
      
      public function get aliveFighterCount() : Number
      {
         var _loc2_:FighterInfo = null;
         var _loc1_:int = 0;
         for each(_loc2_ in this._fighterInfoVec)
         {
            if(_loc2_.hp > 0 && this.isFitInfo(_loc2_) == false)
            {
               _loc1_++;
            }
         }
         return _loc1_;
      }
      
      public function get fighterCount() : Number
      {
         return this._fighterInfoVec.length;
      }
      
      public function get fighterVec() : Vector.<Fighter>
      {
         return this._fighterVec;
      }
      
      public function get changeFighterVec() : Vector.<Fighter>
      {
         return this._changeFighterVec;
      }
      
      public function get mainFighter() : Fighter
      {
         return this.getFighterAtPos(FightPostion.MAIN);
      }
      
      public function set mainFighter(param1:Fighter) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < this._fighterVec.length)
         {
            if(this._fighterVec[_loc2_].fighterInfo.position == FightPostion.MAIN)
            {
               this._fighterVec[_loc2_] = param1;
            }
            _loc2_++;
         }
      }
      
      public function get mainFighterInfo() : FighterInfo
      {
         var _loc1_:FighterInfo = null;
         var _loc2_:FighterInfo = null;
         for each(_loc2_ in this._fighterInfoVec)
         {
            if(_loc2_.position == FightPostion.MAIN)
            {
               _loc1_ = _loc2_;
               break;
            }
         }
         return _loc1_;
      }
      
      public function get subFighter() : Fighter
      {
         return this.getFighterAtPos(FightPostion.SUB);
      }
      
      public function get subFighterInfo() : FighterInfo
      {
         var _loc1_:FighterInfo = null;
         var _loc2_:FighterInfo = null;
         for each(_loc2_ in this._fighterInfoVec)
         {
            if(_loc2_.position == FightPostion.SUB)
            {
               _loc1_ = _loc2_;
               break;
            }
         }
         return _loc1_;
      }
      
      public function get teamInfo() : TeamInfo
      {
         return this._teamInfo;
      }
      
      public function getFitFighterInfo() : Fighter
      {
         var _loc1_:Fighter = null;
         var _loc2_:Fighter = null;
         for each(_loc2_ in this._fighterVec)
         {
            if(_loc2_.isFit == true)
            {
               _loc1_ = _loc2_;
               break;
            }
         }
         return _loc1_;
      }
      
      public function isFitInfo(param1:FighterInfo) : Boolean
      {
         var _loc2_:Boolean = false;
         if(FitConfig.isPetFit(param1.bunchId))
         {
            _loc2_ = true;
         }
         return _loc2_;
      }
      
      public function getFighterToBounchId(param1:uint) : Fighter
      {
         var _loc2_:Fighter = null;
         for each(_loc2_ in this._fighterVec)
         {
            if(_loc2_.fighterInfo.bunchId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      private function getFighterAtPos(param1:int) : Fighter
      {
         var _loc3_:Fighter = null;
         var _loc4_:Fighter = null;
         var _loc2_:int = 0;
         for each(_loc3_ in this._fighterVec)
         {
            if(_loc3_.fighterInfo.position == param1)
            {
               return _loc3_;
            }
         }
         for each(_loc4_ in this._changeFighterVec)
         {
            if(_loc4_.fighterInfo.position == param1)
            {
               return _loc4_;
            }
         }
         return null;
      }
   }
}
