package com.taomee.seer2.app.starMagic
{
   import com.taomee.seer2.app.info.BuyPropInfo;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.net.parser.Parser_1262;
   import com.taomee.seer2.app.net.parser.Parser_1263;
   import com.taomee.seer2.app.net.parser.Parser_1264;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.core.net.LittleEndianByteArray;
   import com.taomee.seer2.core.net.MessageEvent;
   import flash.utils.ByteArray;
   
   public class StarMagicManager
   {
      
      private static var _sellCallBack:Function;
      
      private static var _sellerrorCallBack:Function;
      
      private static var _successCallBack:Function;
      
      private static var _errorCallBack:Function;
      
      private static var _levelUpsuccessCallBack:Function;
      
      private static var _levelUperrorCallBack:Function;
      
      private static var _OncePutsuccessCallBack:Function;
      
      private static var _OncePuterrorCallBack:Function;
      
      private static var _getTempsuccessCallBack:Function;
      
      private static var _getTemperrorCallBack:Function;
      
      private static var _getTemporaryCallBack:Function;
      
      private static var _getTemporaryErrorCallBack:Function;
      
      private static var _getPetsuccessCallBack:Function;
      
      private static var _getPeterrorCallBack:Function;
      
      private static var _waitList:Array;
      
      private static var _isRequesting:Boolean = false;
      
      private static var _isBuyRequesting:Boolean = false;
      
      private static var _tryId:uint = 0;
      
      private static var _count:uint;
      
      private static var _obj:Object;
      
      private static var _buyWaitList:Array;
      
      private static var _byte:ByteArray;
      
      private static var _buyInfo:BuyPropInfo = new BuyPropInfo();
      
      public static var bagStarInfo:Vector.<com.taomee.seer2.app.starMagic.StarInfo>;
      
      public static var depotStarInfo:Vector.<com.taomee.seer2.app.starMagic.StarInfo>;
      
      public static var temporaryStarInfo:Vector.<com.taomee.seer2.app.starMagic.StarInfo>;
      
      public static var curPet:Vector.<com.taomee.seer2.app.starMagic.StarInfo>;
      
      public static var petNum:int = 5;
      
      public static var bagNum:int = 7;
      
      public static var depotNum:int = 18;
      
      public static var temporaryNum:int = 16;
      
      public static var starMoney:int;
      
      public static var TASK:int = 0;
      
      public static var newTaskStop:int = 0;
      
      {
         initialize();
      }
      
      public function StarMagicManager()
      {
         super();
      }
      
      private static function initialize() : void
      {
         _waitList = new Array();
         _buyWaitList = new Array();
         if(!bagStarInfo)
         {
            bagStarInfo = new Vector.<com.taomee.seer2.app.starMagic.StarInfo>();
         }
         if(!depotStarInfo)
         {
            depotStarInfo = new Vector.<com.taomee.seer2.app.starMagic.StarInfo>();
         }
         if(!temporaryStarInfo)
         {
            temporaryStarInfo = new Vector.<com.taomee.seer2.app.starMagic.StarInfo>();
         }
         if(!curPet)
         {
            curPet = new Vector.<com.taomee.seer2.app.starMagic.StarInfo>();
         }
      }
      
      public static function getTemporaryStar(param1:Function, param2:Function = null) : void
      {
         _getTemporaryErrorCallBack = param2;
         _getTemporaryCallBack = param1;
         processGetTemporaryStarStarBagRequest();
      }
      
      private static function processGetTemporaryStarStarBagRequest() : void
      {
         Connection.addErrorHandler(CommandSet.CLI_ENTER_XINGHUNSHENGYU_1262,onGetTemporaryStarBagError);
         Connection.addCommandListener(CommandSet.CLI_ENTER_XINGHUNSHENGYU_1262,onGetTemporaryStarBag);
         Connection.send(CommandSet.CLI_ENTER_XINGHUNSHENGYU_1262);
      }
      
      private static function onGetTemporaryStarBag(param1:MessageEvent) : void
      {
         Connection.removeErrorHandler(CommandSet.CLI_ENTER_XINGHUNSHENGYU_1262,onGetTemporaryStarBagError);
         Connection.removeCommandListener(CommandSet.CLI_ENTER_XINGHUNSHENGYU_1262,onGetTemporaryStarBag);
         var _loc2_:Parser_1262 = new Parser_1262(param1.message.getRawData());
         clearAllBagStar();
         resetBagStar(_loc2_.shoucangstarInfo);
         clearAllDepotStar();
         resetDepotStar(_loc2_.bagstarInfo);
         clearAllTempStar();
         resetTempStar(_loc2_.starInfo);
         _getTemporaryCallBack();
         _getTemporaryCallBack = null;
      }
      
      private static function onGetTemporaryStarBagError(param1:MessageEvent) : void
      {
         Connection.removeErrorHandler(CommandSet.CLI_ENTER_XINGHUNSHENGYU_1262,onGetTemporaryStarBagError);
         Connection.removeCommandListener(CommandSet.CLI_ENTER_XINGHUNSHENGYU_1262,onGetTemporaryStarBag);
      }
      
      public static function getTempStar(param1:uint, param2:uint, param3:Function, param4:Function = null) : void
      {
         var _loc5_:Object = _buyWaitList.shift();
         _obj = _loc5_;
         _getTempsuccessCallBack = param3;
         _getTemperrorCallBack = param4;
         Connection.addErrorHandler(CommandSet.CLI_STARHUN_GET_STARHUN_1263,onGetTimpStarError);
         Connection.addCommandListener(CommandSet.CLI_STARHUN_GET_STARHUN_1263,onGetTimpStar);
         Connection.send(CommandSet.CLI_STARHUN_GET_STARHUN_1263,param1,param2);
      }
      
      private static function onGetTimpStar(param1:MessageEvent) : void
      {
         Connection.removeErrorHandler(CommandSet.CLI_STARHUN_GET_STARHUN_1263,onGetTimpStarError);
         Connection.removeCommandListener(CommandSet.CLI_STARHUN_GET_STARHUN_1263,onGetTimpStar);
         var _loc2_:Parser_1263 = new Parser_1263(param1.message.getRawData());
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.starInfo.length)
         {
            temporaryStarInfo.push(_loc2_.starInfo[_loc3_]);
            _loc3_++;
         }
         _getTempsuccessCallBack();
         _getTempsuccessCallBack = null;
      }
      
      private static function onGetTimpStarError(param1:MessageEvent) : void
      {
         Connection.removeErrorHandler(CommandSet.CLI_STARHUN_GET_STARHUN_1263,onGetTimpStarError);
         Connection.removeCommandListener(CommandSet.CLI_STARHUN_GET_STARHUN_1263,onGetTimpStar);
         ServerMessager.addMessage("星魂已满");
         _getTempsuccessCallBack();
         _getTempsuccessCallBack = null;
      }
      
      public static function sellStar(param1:uint, param2:int, param3:uint, param4:Function, param5:Function = null) : void
      {
         var _loc6_:Object = _buyWaitList.shift();
         _obj = _loc6_;
         _sellCallBack = param4;
         _sellerrorCallBack = param5;
         Connection.addErrorHandler(CommandSet.CLI_EXP_TO_COIN_STARHUN_1264,onSellStarError);
         Connection.addCommandListener(CommandSet.CLI_EXP_TO_COIN_STARHUN_1264,onSellStar);
         Connection.send(CommandSet.CLI_EXP_TO_COIN_STARHUN_1264,param1,param2,param3);
      }
      
      private static function onSellStar(param1:MessageEvent) : void
      {
         Connection.removeErrorHandler(CommandSet.CLI_EXP_TO_COIN_STARHUN_1264,onSellStarError);
         Connection.removeCommandListener(CommandSet.CLI_EXP_TO_COIN_STARHUN_1264,onSellStar);
         var _loc2_:Parser_1264 = new Parser_1264(param1.message.getRawData());
         starMoney = _loc2_.allLi;
         _sellCallBack();
         _sellerrorCallBack = null;
      }
      
      private static function onSellStarError(param1:MessageEvent) : void
      {
         Connection.removeErrorHandler(CommandSet.CLI_EXP_TO_COIN_STARHUN_1264,onSellStarError);
         Connection.removeCommandListener(CommandSet.CLI_EXP_TO_COIN_STARHUN_1264,onSellStar);
         _sellCallBack();
         _sellerrorCallBack = null;
      }
      
      public static function oncePutStar(param1:Function, param2:Function = null) : void
      {
         var _loc3_:Object = _buyWaitList.shift();
         _obj = _loc3_;
         _OncePutsuccessCallBack = param1;
         _OncePuterrorCallBack = param2;
         Connection.addErrorHandler(CommandSet.CLI_PUT_ALL_RUNES_STARHUN_1265,onOncePutStarError);
         Connection.addCommandListener(CommandSet.CLI_PUT_ALL_RUNES_STARHUN_1265,onOncePutStar);
         Connection.send(CommandSet.CLI_PUT_ALL_RUNES_STARHUN_1265);
      }
      
      private static function onOncePutStar(param1:MessageEvent) : void
      {
         Connection.removeErrorHandler(CommandSet.CLI_PUT_ALL_RUNES_STARHUN_1265,onOncePutStarError);
         Connection.removeCommandListener(CommandSet.CLI_PUT_ALL_RUNES_STARHUN_1265,onOncePutStar);
         _OncePutsuccessCallBack();
         _OncePutsuccessCallBack = null;
      }
      
      private static function onOncePutStarError(param1:MessageEvent) : void
      {
         Connection.removeErrorHandler(CommandSet.CLI_PUT_ALL_RUNES_STARHUN_1265,onOncePutStarError);
         Connection.removeCommandListener(CommandSet.CLI_PUT_ALL_RUNES_STARHUN_1265,onOncePutStar);
         _OncePutsuccessCallBack();
         _OncePutsuccessCallBack = null;
      }
      
      public static function levelUpStar(param1:int, param2:int, param3:int, param4:Function, param5:Function = null) : void
      {
         var _loc6_:Object = _buyWaitList.shift();
         _obj = _loc6_;
         _levelUpsuccessCallBack = param4;
         _levelUperrorCallBack = param5;
         Connection.addErrorHandler(CommandSet.CLI_STAR_LEVEL_UP_1266,onLevelUpStarError);
         Connection.addCommandListener(CommandSet.CLI_STAR_LEVEL_UP_1266,onLevelUpStar);
         Connection.send(CommandSet.CLI_STAR_LEVEL_UP_1266,param1,param2,param3);
      }
      
      private static function onLevelUpStar(param1:MessageEvent) : void
      {
         Connection.removeErrorHandler(CommandSet.CLI_STAR_LEVEL_UP_1266,onLevelUpStarError);
         Connection.removeCommandListener(CommandSet.CLI_STAR_LEVEL_UP_1266,onLevelUpStar);
         var _loc2_:Parser_1263 = new Parser_1263(param1.message.getRawData());
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < _loc2_.starInfo.length)
         {
            _loc3_ = 0;
            while(_loc3_ < bagStarInfo.length)
            {
               if(_loc2_.starInfo[_loc4_].id == bagStarInfo[_loc4_].id)
               {
                  bagStarInfo[_loc3_] = _loc2_.starInfo[_loc4_];
                  break;
               }
               _loc3_++;
            }
            _loc3_ = 0;
            while(_loc3_ < depotStarInfo.length)
            {
               if(_loc2_.starInfo[_loc4_].id == depotStarInfo[_loc3_].id)
               {
                  depotStarInfo[_loc3_] = _loc2_.starInfo[_loc4_];
                  break;
               }
               _loc3_++;
            }
            _loc4_++;
         }
         _levelUpsuccessCallBack();
         _levelUpsuccessCallBack = null;
      }
      
      private static function onLevelUpStarError(param1:MessageEvent) : void
      {
         Connection.removeErrorHandler(CommandSet.CLI_STAR_LEVEL_UP_1266,onLevelUpStarError);
         Connection.removeCommandListener(CommandSet.CLI_STAR_LEVEL_UP_1266,onLevelUpStar);
         _levelUpsuccessCallBack();
         _levelUpsuccessCallBack = null;
      }
      
      public static function movePetStar(param1:int, param2:int, param3:com.taomee.seer2.app.starMagic.StarInfo, param4:Function, param5:Function = null, param6:int = 0, param7:int = 0, param8:int = 0) : void
      {
         _successCallBack = param4;
         _sellerrorCallBack = param5;
         var _loc9_:LittleEndianByteArray;
         (_loc9_ = new LittleEndianByteArray()).writeUnsignedInt(param1);
         _loc9_.writeUnsignedInt(param2);
         var _loc10_:int = 0;
         while(_loc10_ < param2)
         {
            _loc9_.writeUnsignedInt(param3.user_id);
            _loc9_.writeUnsignedInt(param3.id);
            _loc9_.writeUnsignedInt(param3.buffId);
            _loc9_.writeUnsignedInt(param3.time);
            _loc9_.writeUnsignedInt(param3.level);
            _loc9_.writeUnsignedInt(param3.exp);
            _loc9_.writeUnsignedInt(param3.nextExp);
            _loc9_.writeUnsignedInt(param3.maxLevel);
            _loc9_.writeUnsignedInt(param3.level_cof);
            _loc9_.writeUnsignedInt(param3.pos);
            _loc9_.writeUnsignedInt(param6);
            _loc9_.writeUnsignedInt(param3.sell_exp);
            _loc9_.writeUnsignedInt(param3.type);
            _loc9_.writeUnsignedInt(param3.buffSwf);
            _loc9_.writeUnsignedInt(param8);
            _loc9_.writeUnsignedInt(param7);
            _loc10_++;
         }
         Connection.addErrorHandler(CommandSet.CLI_STAR_LEVEL_UP_1267,onMoveStarError);
         Connection.addCommandListener(CommandSet.CLI_STAR_LEVEL_UP_1267,onMoveStar);
         Connection.send(CommandSet.CLI_STAR_LEVEL_UP_1267,_loc9_);
      }
      
      public static function moveStar(param1:int, param2:int, param3:com.taomee.seer2.app.starMagic.StarInfo, param4:Function, param5:Function = null, param6:int = 0, param7:int = 0) : void
      {
         _successCallBack = param4;
         _sellerrorCallBack = param5;
         var _loc8_:LittleEndianByteArray;
         (_loc8_ = new LittleEndianByteArray()).writeUnsignedInt(param1);
         _loc8_.writeUnsignedInt(param2);
         var _loc9_:int = 0;
         while(_loc9_ < param2)
         {
            _loc8_.writeUnsignedInt(param3.user_id);
            _loc8_.writeUnsignedInt(param3.id);
            _loc8_.writeUnsignedInt(param3.buffId);
            _loc8_.writeUnsignedInt(param3.time);
            _loc8_.writeUnsignedInt(param3.level);
            _loc8_.writeUnsignedInt(param3.exp);
            _loc8_.writeUnsignedInt(param3.nextExp);
            _loc8_.writeUnsignedInt(param3.maxLevel);
            _loc8_.writeUnsignedInt(param3.level_cof);
            _loc8_.writeUnsignedInt(param3.pos);
            _loc8_.writeUnsignedInt(param3.petCatchTime);
            _loc8_.writeUnsignedInt(param3.sell_exp);
            _loc8_.writeUnsignedInt(param3.type);
            _loc8_.writeUnsignedInt(param3.buffSwf);
            _loc8_.writeUnsignedInt(param7);
            _loc8_.writeUnsignedInt(param6);
            _loc9_++;
         }
         Connection.addErrorHandler(CommandSet.CLI_STAR_LEVEL_UP_1267,onMoveStarError);
         Connection.addCommandListener(CommandSet.CLI_STAR_LEVEL_UP_1267,onMoveStar);
         Connection.send(CommandSet.CLI_STAR_LEVEL_UP_1267,_loc8_);
      }
      
      private static function onMoveStar(param1:MessageEvent) : void
      {
         Connection.removeErrorHandler(CommandSet.CLI_STAR_LEVEL_UP_1267,onMoveStarError);
         Connection.removeCommandListener(CommandSet.CLI_STAR_LEVEL_UP_1267,onMoveStar);
         _successCallBack();
         _successCallBack = null;
      }
      
      private static function onMoveStarError(param1:MessageEvent) : void
      {
         Connection.removeErrorHandler(CommandSet.CLI_STAR_LEVEL_UP_1267,onMoveStarError);
         Connection.removeCommandListener(CommandSet.CLI_STAR_LEVEL_UP_1267,onMoveStar);
         _successCallBack();
         _successCallBack = null;
      }
      
      public static function getPetStar(param1:uint, param2:Function, param3:Function = null) : void
      {
         var _loc4_:Object = _buyWaitList.shift();
         _obj = _loc4_;
         _getPetsuccessCallBack = param2;
         _getPeterrorCallBack = param3;
         Connection.addErrorHandler(CommandSet.CLI_STAR_LEVEL_UP_1268,onGetPetStarError);
         Connection.addCommandListener(CommandSet.CLI_STAR_LEVEL_UP_1268,onGetPetStar);
         Connection.send(CommandSet.CLI_STAR_LEVEL_UP_1268,param1);
      }
      
      private static function onGetPetStar(param1:MessageEvent) : void
      {
         Connection.removeErrorHandler(CommandSet.CLI_STAR_LEVEL_UP_1268,onGetPetStarError);
         Connection.removeCommandListener(CommandSet.CLI_STAR_LEVEL_UP_1268,onGetPetStar);
         var _loc2_:Parser_1263 = new Parser_1263(param1.message.getRawData());
         clearAllCurPetStar();
         resetCurPetStar(_loc2_.starInfo);
         _getPetsuccessCallBack();
         _getPetsuccessCallBack = null;
      }
      
      private static function onGetPetStarError(param1:MessageEvent) : void
      {
         Connection.removeErrorHandler(CommandSet.CLI_STAR_LEVEL_UP_1268,onGetPetStarError);
         Connection.removeCommandListener(CommandSet.CLI_STAR_LEVEL_UP_1268,onGetPetStar);
         _getPetsuccessCallBack();
         _getPetsuccessCallBack = null;
      }
      
      public static function clearTempStar(param1:com.taomee.seer2.app.starMagic.StarInfo) : void
      {
         var _loc2_:int = 0;
         if(temporaryStarInfo)
         {
            _loc2_ = 0;
            while(_loc2_ < temporaryStarInfo.length)
            {
               if(param1.id == temporaryStarInfo[_loc2_].id && param1.pos == temporaryStarInfo[_loc2_].pos)
               {
                  temporaryStarInfo.splice(_loc2_,1);
                  break;
               }
               _loc2_++;
            }
         }
      }
      
      public static function clearAllTempStar() : void
      {
         if(temporaryStarInfo)
         {
            while(temporaryStarInfo.length)
            {
               temporaryStarInfo.pop();
            }
         }
      }
      
      public static function addTempStar(param1:com.taomee.seer2.app.starMagic.StarInfo) : void
      {
         if(temporaryStarInfo)
         {
            temporaryStarInfo.push(param1);
         }
      }
      
      public static function resetTempStar(param1:Vector.<com.taomee.seer2.app.starMagic.StarInfo>) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < param1.length)
         {
            if(param1[_loc2_].pos == 1)
            {
               temporaryStarInfo.push(param1[_loc2_]);
            }
            _loc2_++;
         }
      }
      
      public static function clearBagStar(param1:com.taomee.seer2.app.starMagic.StarInfo) : void
      {
         var _loc2_:int = 0;
         if(bagStarInfo)
         {
            _loc2_ = 0;
            while(_loc2_ < bagStarInfo.length)
            {
               if(param1.id == bagStarInfo[_loc2_].id && param1.pos == bagStarInfo[_loc2_].pos)
               {
                  bagStarInfo.splice(_loc2_,1);
                  break;
               }
               _loc2_++;
            }
         }
      }
      
      public static function clearAllBagStar() : void
      {
         if(bagStarInfo)
         {
            while(bagStarInfo.length)
            {
               bagStarInfo.pop();
            }
         }
      }
      
      public static function addBagStar(param1:com.taomee.seer2.app.starMagic.StarInfo) : void
      {
         if(bagStarInfo)
         {
            bagStarInfo.push(param1);
         }
      }
      
      public static function resetBagStar(param1:Vector.<com.taomee.seer2.app.starMagic.StarInfo>) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < param1.length)
         {
            if(param1[_loc2_].pos == 3)
            {
               bagStarInfo.push(param1[_loc2_]);
            }
            _loc2_++;
         }
      }
      
      public static function clearDepotStar(param1:com.taomee.seer2.app.starMagic.StarInfo) : void
      {
         var _loc2_:int = 0;
         if(depotStarInfo)
         {
            _loc2_ = 0;
            while(_loc2_ < depotStarInfo.length)
            {
               if(param1.id == depotStarInfo[_loc2_].id && param1.pos == depotStarInfo[_loc2_].pos)
               {
                  depotStarInfo.splice(_loc2_,1);
                  break;
               }
               _loc2_++;
            }
         }
      }
      
      public static function clearAllDepotStar() : void
      {
         if(depotStarInfo)
         {
            while(depotStarInfo.length)
            {
               depotStarInfo.pop();
            }
         }
      }
      
      public static function clearAllCurPetStar() : void
      {
         if(curPet)
         {
            while(curPet.length)
            {
               curPet.pop();
            }
         }
      }
      
      public static function addDepotStar(param1:com.taomee.seer2.app.starMagic.StarInfo) : void
      {
         if(depotStarInfo)
         {
            depotStarInfo.push(param1);
         }
      }
      
      public static function addCurPetStar(param1:com.taomee.seer2.app.starMagic.StarInfo) : void
      {
         if(curPet)
         {
            curPet.push(param1);
         }
      }
      
      public static function resetCurPetStar(param1:Vector.<com.taomee.seer2.app.starMagic.StarInfo>) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < param1.length)
         {
            if(param1[_loc2_].pos == 4)
            {
               curPet.push(param1[_loc2_]);
            }
            _loc2_++;
         }
      }
      
      public static function resetDepotStar(param1:Vector.<com.taomee.seer2.app.starMagic.StarInfo>) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < param1.length)
         {
            if(param1[_loc2_].pos == 2)
            {
               depotStarInfo.push(param1[_loc2_]);
            }
            _loc2_++;
         }
      }
      
      public static function getTempStarNum(param1:int) : int
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < temporaryStarInfo.length)
         {
            if(temporaryStarInfo[_loc2_].type == 0)
            {
               _loc4_++;
            }
            else
            {
               _loc3_++;
            }
            _loc2_++;
         }
         if(param1 == 1)
         {
            return _loc4_;
         }
         if(param1 == 2)
         {
            return _loc3_;
         }
         return temporaryNum - _loc3_;
      }
      
      public static function getBagStarNum() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         return bagStarInfo.length;
      }
      
      public static function getDepotStarNum() : int
      {
         var _loc1_:int = 0;
         return depotStarInfo.length;
      }
      
      public static function checkStar(param1:int) : Boolean
      {
         var _loc2_:int = 0;
         while(_loc2_ < curPet.length)
         {
            if(StarMagicConfig.getInfo(curPet[_loc2_].buffId,curPet[_loc2_].type).buffSwf == param1)
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      public static function checkOnceStar(param1:int) : Boolean
      {
         var _loc2_:int = 0;
         while(_loc2_ < depotStarInfo.length)
         {
            if(depotStarInfo[_loc2_].type >= param1)
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
   }
}
