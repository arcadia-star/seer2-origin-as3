package com.taomee.seer2.app.actives
{
   import com.taomee.seer2.app.component.MouseClickHintSprite;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.serverBuffer.ServerBuffer;
   import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
   import com.taomee.seer2.app.serverBuffer.ServerBufferType;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.swap.info.SwapInfo;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.utils.IDataInput;
   import org.taomee.utils.DisplayUtil;
   
   public class PetMeleeActivity
   {
      
      private static var _npc:Mobile;
      
      private static var _mouse:MouseClickHintSprite;
       
      
      public function PetMeleeActivity()
      {
         super();
      }
      
      public static function setup70() : void
      {
         _npc = MobileManager.getMobile(330,MobileType.NPC);
         _npc.addEventListener(MouseEvent.CLICK,onNpc);
      }
      
      private static function onNpc(param1:MouseEvent) : void
      {
         ServerBufferManager.getServerBuffer(ServerBufferType.PETMELEE,onServerBuff);
      }
      
      private static function onServerBuff(param1:ServerBuffer) : void
      {
         if(param1.readDataAtPostion(0) == 0)
         {
            ServerBufferManager.updateServerBuffer(ServerBufferType.PETMELEE,0,1);
            SceneManager.changeScene(SceneType.LOBBY,60);
         }
         else
         {
            SceneManager.changeScene(SceneType.LOBBY,60);
         }
      }
      
      public static function dispose70() : void
      {
         if(_npc)
         {
            _npc.removeEventListener(MouseEvent.CLICK,onNpc);
         }
      }
      
      public static function setup60() : void
      {
         ServerBufferManager.getServerBuffer(ServerBufferType.PETMELEE,onServerBuff60);
      }
      
      private static function onServerBuff60(param1:ServerBuffer) : void
      {
         var _loc3_:GlowFilter = null;
         var _loc2_:MovieClip = SceneManager.active.mapModel.content["petMelee"];
         _loc2_.filters = [];
         if(param1.readDataAtPostion(0) == 1)
         {
            _loc3_ = new GlowFilter();
            _loc3_.blurX = 40;
            _loc3_.blurY = 40;
            _loc3_.color = 16711680;
            _loc3_.inner = false;
            _loc2_.filters = [_loc3_];
            _mouse = new MouseClickHintSprite();
            _mouse.x = _loc2_.x + 44;
            _mouse.y = _loc2_.y - 5;
            SceneManager.active.mapModel.content.addChild(_mouse);
         }
      }
      
      public static function clickPetmelee() : void
      {
         ServerBufferManager.getServerBuffer(ServerBufferType.PETMELEE,onServerBuffPetMelee);
      }
      
      private static function onServerBuffPetMelee(param1:ServerBuffer) : void
      {
         var ser:ServerBuffer = param1;
         if(ser.readDataAtPostion(0) == 1)
         {
            NpcDialog.show(6,"克拉克",[[0,"哈哈！又一个勇敢的赛尔！欢迎你！这是我最新的大乱斗战斗匹配仪！怎么样！够帅吧！哈哈！"]],["哇！Cool！"],[function():void
            {
               NpcDialog.show(6,"克拉克",[[0,"参加大乱斗不仅能够提高你的战术还能够给你带来更多的经验芯片，这可是升级的最佳途径呀！"]],["我听说礼物……"],[function():void
               {
                  NpcDialog.show(6,"克拉克",[[0,"哈哈！说到点子上了！参与大乱斗还可以获得许多星钻道具哦！当然现在我可以先送你1颗学习力精元！想得到更多就来参与大乱斗吧！"]],["哇！So Cool！"],[function():void
                  {
                     NpcDialog.show(6,"克拉克",[[0,"傻小子！傻笑什么呢！还不快试试我的新装置！快快快去战斗吧！唉……现在的年轻人慢性子真让我着急！！"]],["Yes Sir！教官！！"],[function():void
                     {
                        SwapManager.swapItem(1974,1,function(param1:IDataInput):void
                        {
                           new SwapInfo(param1);
                           ServerBufferManager.updateServerBuffer(ServerBufferType.PETMELEE,0,2);
                           ModuleManager.toggleModule(URLUtil.getAppModule("PetMeleePanel"),"正在打开...");
                           var _loc2_:* = SceneManager.active.mapModel.content["petMelee"];
                           _loc2_.filters = [];
                           DisplayUtil.removeForParent(_mouse);
                        },function(param1:uint):void
                        {
                           ServerBufferManager.updateServerBuffer(ServerBufferType.PETMELEE,0,2);
                           var _loc2_:* = SceneManager.active.mapModel.content["petMelee"];
                           _loc2_.filters = [];
                           DisplayUtil.removeForParent(_mouse);
                           ModuleManager.toggleModule(URLUtil.getAppModule("PetMeleePanel"),"正在打开...");
                        });
                     }]);
                  }]);
               }]);
            }]);
         }
         else
         {
            ModuleManager.toggleModule(URLUtil.getAppModule("PetMeleePanel"),"正在打开...");
         }
      }
   }
}
