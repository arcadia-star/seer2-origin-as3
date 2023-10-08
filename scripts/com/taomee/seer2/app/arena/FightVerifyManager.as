package com.taomee.seer2.app.arena
{
   import com.taomee.seer2.app.arena.events.FightStartEvent;
   import com.taomee.seer2.app.pet.data.PetInfo;
   import com.taomee.seer2.app.pet.data.PetInfoManager;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.core.manager.TimeManager;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.net.MessageEvent;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   import org.taomee.utils.Tick;
   
   public class FightVerifyManager
   {
      
      private static const DELAY_TIME:uint = 30;
      
      private static var _forbiddenTime:int;
       
      
      public function FightVerifyManager()
      {
         super();
      }
      
      public static function validateFightStart() : Boolean
      {
         if(TimeManager.getAvailableTime() <= 0)
         {
            AlertManager.showAlert("电池已耗完不能进行对战");
            return false;
         }
         var _loc1_:PetInfo = PetInfoManager.getFirstPetInfo();
         if(_loc1_ != null)
         {
            if(_loc1_.hp == 0)
            {
               AlertManager.showAlert("首发精灵血量耗尽");
               return false;
            }
            return true;
         }
         AlertManager.showAlert("没有设置首发精灵");
         return false;
      }
      
      public static function checkVerifyStatus() : Boolean
      {
         if(_forbiddenTime > 0)
         {
            AlertManager.showAlert("您还需要等待" + _forbiddenTime + "秒才能再次发起对战",function():void
            {
               FightManager.dispatchEvent(new FightStartEvent(FightStartEvent.START_ERROR));
            });
            return false;
         }
         return true;
      }
      
      public static function startForbiddenTimer() : void
      {
         clearTimer();
         _forbiddenTime = DELAY_TIME;
         Tick.instance.addRender(onUpdateForbiddenTime,1000);
      }
      
      public static function onStartFightVerify(param1:MessageEvent, param2:Function, param3:Function) : void
      {
         var verifyStartFightSuccess:Function = null;
         var verifyStartFightError:Function = null;
         var event:MessageEvent = param1;
         var onSuccess:Function = param2;
         var onFail:Function = param3;
         verifyStartFightSuccess = function():void
         {
            if(onSuccess != null)
            {
               onSuccess();
            }
         };
         verifyStartFightError = function():void
         {
            if(onFail != null)
            {
               onFail();
            }
         };
         var data:ByteArray = event.message.getRawData();
         var side:int = int(data.readUnsignedInt());
         var len:int = int(data.readUnsignedInt());
         var picData:ByteArray = new ByteArray();
         picData.endian = Endian.LITTLE_ENDIAN;
         picData.writeBytes(data,8,len);
         ModuleManager.showModule(URLUtil.getAppModule("FindDifferentPanel"),"正在打开找不同面板...",{
            "side":side,
            "picData":picData,
            "successCallBack":verifyStartFightSuccess,
            "errorCallBack":verifyStartFightError
         });
      }
      
      private static function onUpdateForbiddenTime(param1:int) : void
      {
         --_forbiddenTime;
         if(_forbiddenTime <= 0)
         {
            clearTimer();
         }
      }
      
      private static function clearTimer() : void
      {
         Tick.instance.removeRender(onUpdateForbiddenTime);
      }
   }
}
