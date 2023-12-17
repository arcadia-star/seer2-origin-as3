package com.taomee.seer2.app.manager
{
   import com.taomee.seer2.app.config.ItemConfig;
   import com.taomee.seer2.app.config.ShareToConfig;
   import com.taomee.seer2.app.config.info.shareToInfo;
   import com.taomee.seer2.app.controls.PetAvatarPanel;
   import com.taomee.seer2.app.inventory.constant.ItemCategory;
   import com.taomee.seer2.app.lobby.LobbyScene;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.app.serverBuffer.ServerBuffer;
   import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class CommonUseManager
   {
       
      
      public function CommonUseManager()
      {
         super();
      }
      
      public static function showSwapInfo(param1:int, param2:int) : void
      {
         if(param1 == 1)
         {
            AlertManager.showCoinsGainedAlert(param2);
         }
         else if(param1 > 606000 && param1 <= 610000 || param1 >= 400266 && param1 <= 400268)
         {
            ServerMessager.addMessage("恭喜你获得了" + param2 + "个[" + ItemConfig.getItemName(param1) + "]");
         }
         else if(param1 != 36 && param1 != 37)
         {
            if(ItemConfig.getItemCategory(param1) == ItemCategory.MEDAL)
            {
               AlertManager.showMedalGainedAlert(param1);
               if(ItemConfig.getMedalDefinition(param1).title != "")
               {
                  ServerMessager.addMessage("恭喜你获得了[" + ItemConfig.getMedalDefinition(param1).title + "称号]");
               }
            }
            else if(ItemConfig.getItemCategory(param1) == ItemCategory.PET_SPIRT_TRAIN)
            {
               AlertManager.showGetPetSpiritAlert(param1,param2);
            }
            else
            {
               AlertManager.showItemGainedAlert(param1,param2);
            }
         }
      }
      
      public static function firstPlayFullScreen(param1:int, param2:String) : void
      {
         var buffInt:int = param1;
         var fullString:String = param2;
         ServerBufferManager.getServerBuffer(buffInt,function(param1:ServerBuffer):void
         {
            var _loc2_:Boolean = Boolean(param1.readDataAtPostion(1));
            if(!_loc2_)
            {
               ServerBufferManager.updateServerBuffer(buffInt,1,1);
               MovieClipUtil.playFullScreen(URLUtil.getActivityFullScreen(fullString),null,true,true,2,true);
            }
         });
      }
      
      public static function hideLobbyMenu() : void
      {
         (SceneManager.active as LobbyScene).hideToolbar();
         PetAvatarPanel.show();
      }
      
      public static function showLobbyMenu() : void
      {
         (SceneManager.active as LobbyScene).showToolbar();
      }
      
      public static function getRandom(param1:int, param2:int) : int
      {
         var _loc3_:int = 0;
         _loc3_ = param1 + int(Math.random() * (param2 - param1) + 0.5);
         if(_loc3_ > param2)
         {
            _loc3_ = param2;
         }
         return _loc3_;
      }
      
      public static function getBit(param1:uint, param2:uint) : uint
      {
         var _loc3_:int = 32;
         var _loc4_:uint = 1;
         var _loc5_:int = 0;
         if(param2 == 0)
         {
            return param1 & _loc4_;
         }
         param1 >>= param2;
         return param1 & _loc4_;
      }
      
      public static function shareContentToQzone(param1:uint) : void
      {
         var shareID:uint = param1;
         ShareToConfig.Instance.getShareToInfo(function():void
         {
            var _loc2_:String = null;
            var _loc1_:shareToInfo = ShareToConfig.Instance.getallShare(shareID);
            if(_loc1_)
            {
               _loc2_ = "http://sns.qzone.qq.com/cgi-bin/qzshare/cgi_qzshare_onekey?url=" + _loc1_.url + "&desc=" + _loc1_.desc + "&showcount=1&summary=" + _loc1_.summary + "&title=" + _loc1_.title + "&site=" + _loc1_.site + "&pics=" + _loc1_.pics;
               navigateToURL(new URLRequest(_loc2_),"_blank");
            }
            else
            {
               AlertManager.showAlert("shareTo.xml表没有配置分享内容");
            }
         });
      }
      
      public static function shareContentToQQFriend(param1:uint) : void
      {
         var shareID:uint = param1;
         ShareToConfig.Instance.getShareToInfo(function():void
         {
            var _loc2_:String = null;
            var _loc1_:shareToInfo = ShareToConfig.Instance.getallShare(shareID);
            if(_loc1_)
            {
               _loc2_ = "http://connect.qq.com/widget/shareqq/index.html?url=" + _loc1_.url + "&desc=" + _loc1_.desc + "&summary=" + _loc1_.summary + "&title=" + _loc1_.title + "&site=" + _loc1_.site + "&width=" + _loc1_.width + "&height=" + _loc1_.height + "&style=" + _loc1_.style + "&pics=" + _loc1_.pics + "&flash=" + _loc1_.flash;
               navigateToURL(new URLRequest(_loc2_),"_blank");
            }
            else
            {
               AlertManager.showAlert("shareTo.xml表没有配置分享内容");
            }
         });
      }
      
      public static function chatWithQQfriend(param1:String) : void
      {
         var _loc2_:* = "tencent://message/?uin=" + param1 + "&websiteName=q-zone.qq.com&Menu=yes";
         navigateToURL(new URLRequest(_loc2_),"_blank");
      }
   }
}
