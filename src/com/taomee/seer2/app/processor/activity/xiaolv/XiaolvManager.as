package com.taomee.seer2.app.processor.activity.xiaolv
{
   import com.taomee.seer2.app.component.MouseClickHintSprite;
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.DialogPanelEventData;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.app.morphSystem.MorphUpdate;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.events.MouseEvent;
   import flash.utils.IDataInput;
   
   public class XiaolvManager
   {
      
      private static var _npc:Mobile;
      
      private static var _mouseClickHintSprite:MouseClickHintSprite;
       
      
      public function XiaolvManager()
      {
         super();
      }
      
      public static function setup() : void
      {
         DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK,showNpcChallengePanel);
         _npc = MobileManager.getMobile(534,MobileType.NPC);
         _npc.buttonMode = true;
         _npc.addEventListener(MouseEvent.CLICK,onNpc,false,1);
         _mouseClickHintSprite = new MouseClickHintSprite();
         _mouseClickHintSprite.x = 265;
         _mouseClickHintSprite.y = 482;
         SceneManager.active.mapModel.front.addChild(_mouseClickHintSprite);
         _mouseClickHintSprite.visible = false;
      }
      
      private static function onNpc(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         event.stopImmediatePropagation();
         _mouseClickHintSprite.visible = false;
         SwapManager.swapItem(857,1,function(param1:IDataInput):void
         {
            MorphUpdate.updateMorph();
         });
         StatisticsManager.sendNovice(StatisticsManager.ui_interact_293);
      }
      
      private static function showNpcChallengePanel(param1:DialogPanelEvent) : void
      {
         var event:DialogPanelEvent = param1;
         if((event.content as DialogPanelEventData).params == "kangte")
         {
            NpcDialog.show(177,"小绿",[[0,"嘿！快点击下面那个神奇的变身雪糕吧！变成我的样子你就能多摸一次康特的口袋哦！"]],["哇哦！听起来不错！","我一会再去变身！"],[function():void
            {
               _mouseClickHintSprite.visible = true;
            }]);
            StatisticsManager.sendNovice(StatisticsManager.ui_interact_292);
         }
         if((event.content as DialogPanelEventData).params == "koudai")
         {
            ModuleManager.showModule(URLUtil.getAppModule("CounterLuckyPackagePanel"),"正在打开面板...");
         }
      }
      
      public static function dispose() : void
      {
         DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK,showNpcChallengePanel);
         DisplayObjectUtil.removeFromParent(_mouseClickHintSprite);
      }
   }
}
