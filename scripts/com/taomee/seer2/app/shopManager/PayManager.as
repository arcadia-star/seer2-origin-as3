package com.taomee.seer2.app.shopManager
{
   import com.adobe.crypto.MD5;
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.config.MatchingConfig;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.vip.VipManager;
   import com.taomee.seer2.core.net.LittleEndianByteArray;
   import com.taomee.seer2.core.net.MessageEvent;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.ui.UIManager;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import org.taomee.utils.DisplayUtil;
   
   public class PayManager
   {
      
      public static var isSetChpher:Boolean = true;
      
      private static var _checkCipherFun:Function;
      
      private static var _isSetupCipher:Boolean;
      
      private static var _chpherMC:MovieClip;
      
      private static var _entryTxt:TextField;
      
      private static var _okBtn:SimpleButton;
      
      private static var _cancelBtn:SimpleButton;
      
      private static var _yesFun:Function;
       
      
      public function PayManager()
      {
         super();
      }
      
      public static function checkSetopChpher(param1:Function) : void
      {
         _checkCipherFun = param1;
         if(_isSetupCipher)
         {
            _checkCipherFun(_isSetupCipher);
            _checkCipherFun = null;
            return;
         }
         Connection.addCommandListener(CommandSet.CHECK_SETUP_CIPHER_1226,checkSetupCipher);
         Connection.send(CommandSet.CHECK_SETUP_CIPHER_1226);
      }
      
      private static function checkSetupCipher(param1:MessageEvent) : void
      {
         Connection.removeCommandListener(CommandSet.CHECK_SETUP_CIPHER_1226,checkSetupCipher);
         var _loc2_:IDataInput = param1.message.getRawData();
         var _loc3_:uint = uint(_loc2_.readUnsignedInt());
         if(_loc3_ == 0)
         {
            _isSetupCipher = false;
         }
         else
         {
            _isSetupCipher = true;
         }
         _checkCipherFun(_isSetupCipher);
         _checkCipherFun = null;
      }
      
      public static function buyItem(param1:uint, param2:Function, param3:Function = null, param4:Function = null) : void
      {
         var buyId:uint = param1;
         var buyComplete:Function = param2;
         var buyFail:Function = param3;
         var setChpherFunc:Function = param4;
         checkSetopChpher(function(param1:Boolean):void
         {
            var isSetup:Boolean = param1;
            if(isSetup)
            {
               showEntryChpher(function(param1:ByteArray = null):void
               {
                  if(param1 == null)
                  {
                     param1 = getMD5Byte();
                  }
                  ShopManager.buyShopItem(MatchingConfig.getNewId(buyId),1,param1,buyComplete,buyFail);
               },setChpherFunc);
            }
            else
            {
               if(setChpherFunc != null)
               {
                  setChpherFunc();
                  setChpherFunc = null;
               }
               AlertManager.showAlert("未设置支付密码，请先设置支付密码",function():void
               {
                  setChpher();
               });
            }
         });
      }
      
      public static function showEntryChpher(param1:Function, param2:Function = null) : void
      {
         var yesFun:Function = param1;
         var setChpherFunc:Function = param2;
         _yesFun = yesFun;
         ActiveCountManager.requestActiveCount(202148,function(param1:uint, param2:uint):void
         {
            if(param2 != 0)
            {
               if(setChpherFunc != null)
               {
                  setChpherFunc();
               }
               _chpherMC = UIManager.getMovieClip("UI_Chpher");
               _entryTxt = _chpherMC["entryTxt"];
               _entryTxt.maxChars = 16;
               _entryTxt.displayAsPassword = true;
               _okBtn = _chpherMC["okBtn"];
               _cancelBtn = _chpherMC["cancelBtn"];
               _okBtn.addEventListener(MouseEvent.CLICK,onOk);
               _cancelBtn.addEventListener(MouseEvent.CLICK,onCancelBtn);
               LayerManager.topLayer.addChild(_chpherMC);
               DisplayUtil.align(_chpherMC,4,LayerManager.rootRect);
               LayerManager.focusOnTopLayer();
            }
            else
            {
               _yesFun(getMD5Byte());
            }
         });
      }
      
      private static function onCancelBtn(param1:MouseEvent) : void
      {
         DisplayUtil.removeForParent(_chpherMC);
         LayerManager.resetOperation();
      }
      
      private static function onOk(param1:MouseEvent) : void
      {
         var _loc6_:String = null;
         var _loc7_:int = 0;
         var _loc2_:LittleEndianByteArray = new LittleEndianByteArray();
         var _loc3_:String = String(MD5.hash(_entryTxt.text));
         var _loc4_:int = _loc3_.length;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            _loc6_ = _loc3_.substr(_loc5_,2);
            _loc7_ = parseInt(_loc6_,16);
            _loc2_.writeByte(_loc7_);
            _loc5_ += 2;
         }
         _yesFun(_loc2_);
         DisplayUtil.removeForParent(_chpherMC);
         LayerManager.resetOperation();
      }
      
      private static function getMD5Byte() : LittleEndianByteArray
      {
         var _loc5_:String = null;
         var _loc6_:int = 0;
         var _loc1_:LittleEndianByteArray = new LittleEndianByteArray();
         var _loc2_:String = String(MD5.hash("0"));
         var _loc3_:int = _loc2_.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = _loc2_.substr(_loc4_,2);
            _loc6_ = parseInt(_loc5_,16);
            _loc1_.writeByte(_loc6_);
            _loc4_ += 2;
         }
         return _loc1_;
      }
      
      public static function setChpher() : void
      {
         VipManager.setChpher();
      }
   }
}
