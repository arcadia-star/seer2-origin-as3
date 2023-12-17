package com.taomee.seer2.app.processor.activity.xegg
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.inventory.ItemManager;
   import com.taomee.seer2.app.inventory.events.ItemEvent;
   import com.taomee.seer2.app.processor.activity.devilActivity.DevilLoad;
   import com.taomee.seer2.core.manager.TimeManager;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import org.taomee.utils.DisplayUtil;
   
   public class XeggHome
   {
      
      private static var _load:DevilLoad;
      
      private static var _mc:MovieClip;
      
      private static const questList:Vector.<uint> = Vector.<uint>([30031,30032,30033,30034,30035,30036]);
       
      
      public function XeggHome()
      {
         super();
      }
      
      public static function setup() : void
      {
         SceneManager.addEventListener(SceneEvent.SWITCH_START,onSwitchStart);
         SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,onSwitchComplete);
      }
      
      private static function onSwitchComplete(param1:SceneEvent) : void
      {
         if(SceneManager.active.mapID == ActorManager.actorInfo.id && SceneManager.active.type == SceneType.HOME)
         {
            ItemManager.addEventListener1(ItemEvent.REQUEST_SPECIAL_ITEM_SUCCESS,onSeer);
            ItemManager.requestSpecialItemList();
         }
      }
      
      private static function onSeer(param1:ItemEvent) : void
      {
         ItemManager.removeEventListener1(ItemEvent.REQUEST_SPECIAL_ITEM_SUCCESS,onSeer);
         if(ItemManager.getSpecialItem(500514))
         {
            _load = new DevilLoad();
            _load.playLoad("xegg/xeggLoad",startRanking);
         }
      }
      
      private static function startRanking() : void
      {
         var _loc1_:uint = new Date(2012,8,8,14,0).getTime() / 1000;
         if(TimeManager.getServerTime() < _loc1_)
         {
            _mc = _load.getMC("angryEgg");
            if(_mc == null)
            {
               if(_load == null)
               {
                  _load = new DevilLoad();
               }
               else
               {
                  _load.dispose();
               }
               _load.playLoad("xegg/xeggLoad",startRanking);
               return;
            }
            _mc.x = 262;
            _mc.y = 46;
            SceneManager.active.mapModel.content.addChild(_mc);
         }
         else
         {
            _mc = _load.getMC("xegg");
            if(_mc == null)
            {
               if(_load == null)
               {
                  _load = new DevilLoad();
               }
               else
               {
                  _load.dispose();
               }
               _load.playLoad("xegg/xeggLoad",startRanking);
               return;
            }
            _mc.x = 290;
            _mc.y = 150;
            _mc.stop();
            SceneManager.active.mapModel.content.addChild(_mc);
            updateQuest();
         }
      }
      
      private static function updateQuest() : void
      {
         _mc.addEventListener(MouseEvent.CLICK,onClick);
      }
      
      private static function onClick(param1:MouseEvent) : void
      {
         var _loc2_:Object = new Object();
         _loc2_.hide = removeXegg;
         ModuleManager.toggleModule(URLUtil.getAppModule("XeggPanel"),"正在打开面板...",_loc2_);
      }
      
      private static function removeXegg() : void
      {
         DisplayUtil.removeForParent(_mc);
      }
      
      private static function onSwitchStart(param1:SceneEvent) : void
      {
         if(_load)
         {
            _load.dispose();
         }
         DisplayUtil.removeForParent(_mc);
         _load = null;
         _mc = null;
      }
   }
}
