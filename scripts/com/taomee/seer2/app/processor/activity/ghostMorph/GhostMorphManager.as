package com.taomee.seer2.app.processor.activity.ghostMorph
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.inventory.ItemManager;
   import com.taomee.seer2.app.inventory.events.ItemEvent;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.app.processor.activity.devilActivity.DevilLoad;
   import com.taomee.seer2.app.serverBuffer.ServerBuffer;
   import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
   import com.taomee.seer2.app.serverBuffer.ServerBufferType;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.swap.info.SwapInfo;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.IDataInput;
   import org.taomee.manager.EventManager;
   import org.taomee.utils.DisplayUtil;
   
   public class GhostMorphManager
   {
      
      public static var CHOST_MORPH_CLICK:String = "chostMorphClick";
      
      public static var CHOST_MOPRH_GAME_COMPLETE:String = "chostMorphGameComplete";
      
      private static const mapIdList:Vector.<uint> = Vector.<uint>([124,212,500,480,570,840]);
      
      private static const pointArr:Array = [[new Point(196,199),new Point(375,182),new Point(574,210)],[new Point(613,185),new Point(555,326)],[new Point(476,127)],[new Point(730,257),new Point(437,417)],[new Point(111,141),new Point(331,371),new Point(322,279)],[new Point(515,135)]];
      
      private static const bufList:Array = [[2,3,4],[5,6],[7],[8,9],[10,11,12],[13]];
      
      private static var _currPointArr:Array = [];
      
      private static var _bufArr:Array = [];
      
      private static var _load:DevilLoad;
      
      private static var _actorList:Vector.<com.taomee.seer2.app.processor.activity.ghostMorph.GhostActor>;
      
      private static var _currActor:com.taomee.seer2.app.processor.activity.ghostMorph.GhostActor;
      
      private static var _ran:uint;
      
      private static var _ser:ServerBuffer;
       
      
      public function GhostMorphManager()
      {
         super();
      }
      
      public static function setup() : void
      {
         EventManager.addEventListener(CHOST_MORPH_CLICK,onGame);
         EventManager.addEventListener(CHOST_MOPRH_GAME_COMPLETE,onGameComplete);
         SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,onComplete);
         SceneManager.addEventListener(SceneEvent.SWITCH_START,onStart);
      }
      
      private static function onComplete(param1:SceneEvent) : void
      {
         var event:SceneEvent = param1;
         var index:int = mapIdList.indexOf(SceneManager.active.mapID);
         if(GhostMorphLibrary.checkTime() && index != -1)
         {
            _actorList = Vector.<com.taomee.seer2.app.processor.activity.ghostMorph.GhostActor>([]);
            _currPointArr = pointArr[index];
            _bufArr = bufList[index];
            _load = new DevilLoad();
            _load.playLoad("ghostMorph/ghostMorph",function():void
            {
               ItemManager.addEventListener1(ItemEvent.REQUEST_SPECIAL_ITEM_SUCCESS,requestItemSuccess);
               ItemManager.requestSpecialItemList();
            });
         }
      }
      
      private static function onGameComplete(param1:Event) : void
      {
         var event:Event = param1;
         SwapManager.swapItem(673,1,function(param1:IDataInput):void
         {
            new SwapInfo(param1);
            MovieClipUtil.playFullScreen(URLUtil.getActivityAnimation("ghostMorph/ghostAnimationEnd"),null,true,false,2);
            AlertManager.showAlert("你已经变成幽灵，1小时内将享有4倍经验2倍学习力");
            ActorManager.actorInfo.activityData[2] = 1;
            ServerBufferManager.updateServerBuffer(ServerBufferType.GHOST_MORPH,40,1);
            GhostMorphStart.startMorph(ActorManager.getActor());
         });
      }
      
      private static function requestItemSuccess(param1:ItemEvent) : void
      {
         ItemManager.removeEventListener1(ItemEvent.REQUEST_SPECIAL_ITEM_SUCCESS,requestItemSuccess);
         ServerBufferManager.getServerBuffer(ServerBufferType.GHOST_MORPH,onGhostMorph);
      }
      
      private static function onGhostMorph(param1:ServerBuffer) : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:com.taomee.seer2.app.processor.activity.ghostMorph.GhostActor = null;
         var _loc4_:int = 0;
         _ser = param1;
         if(param1.readDataAtPostion(49) == 1)
         {
            return;
         }
         _loc4_ = 0;
         while(_loc4_ < _bufArr.length)
         {
            if(param1.readDataAtPostion(_bufArr[_loc4_]) != 1)
            {
               _loc2_ = _load.getMC("ghost" + _loc4_);
               _loc2_.x = _currPointArr[_loc4_].x;
               _loc2_.y = _currPointArr[_loc4_].y;
               _loc3_ = new com.taomee.seer2.app.processor.activity.ghostMorph.GhostActor();
               _loc3_.mc = _loc2_;
               _loc3_.index = _bufArr[_loc4_];
               _loc3_.addMC();
               SceneManager.active.mapModel.content.addChild(_loc3_);
               _loc3_.addEventListener(MouseEvent.CLICK,onClick);
               _loc3_.update();
               _actorList.push(_loc3_);
            }
            _loc4_++;
         }
      }
      
      private static function onClick(param1:MouseEvent) : void
      {
         _currActor = param1.currentTarget as com.taomee.seer2.app.processor.activity.ghostMorph.GhostActor;
         _ran = uint(Math.random() * 30);
         if(_ran < 10)
         {
            _ran = 1;
         }
         else if(_ran < 20)
         {
            _ran = 2;
         }
         else if(_ran < 30)
         {
            _ran = 3;
         }
         MovieClipUtil.playSelectNpcTalk(URLUtil.getActivityAnimation("ghostMorph/ghostTalk" + _ran),_ran,clickYes,clickNo);
      }
      
      private static function clickYes() : void
      {
         var str:String = null;
         if(ItemManager.getSpecialItem(601527) != null && ItemManager.getSpecialItem(601527).quantity >= 5)
         {
            ServerBufferManager.updateServerBuffer(ServerBufferType.GHOST_MORPH,_currActor.index,1);
            str = "";
            switch(_ran)
            {
               case 0:
                  str = "你好心给了小幽灵5个糖果";
                  break;
               case 1:
                  str = "你好心给了小幽灵5个糖果";
                  break;
               case 2:
                  str = "你好心收留了小幽灵，还赔上了5颗糖果！";
                  break;
               case 3:
                  str = "你承认小幽灵是万圣节明星，还上供了5颗糖果";
            }
            SwapManager.swapItem(682,1,function(param1:IDataInput):void
            {
               var _loc3_:com.taomee.seer2.app.processor.activity.ghostMorph.GhostActor = null;
               AlertManager.showAlert(str);
               DisplayUtil.removeForParent(_currActor);
               new SwapInfo(param1);
               var _loc2_:uint = uint(_ser.readDataAtPostion(1));
               _loc2_++;
               ServerMessager.addMessage("你已经捕捉到" + _loc2_ + "个小幽灵");
               ServerBufferManager.updateServerBuffer(ServerBufferType.GHOST_MORPH,1,_loc2_);
               if(_loc2_ >= 10)
               {
                  ServerBufferManager.updateServerBuffer(ServerBufferType.GHOST_MORPH,49,1);
                  for each(_loc3_ in _actorList)
                  {
                     DisplayUtil.removeForParent(_loc3_);
                  }
                  ModuleManager.toggleModule(URLUtil.getAppModule("GhostMorphPanel"),"正在打开...");
               }
            });
         }
         else
         {
            AlertManager.showAlert("糖果不够");
         }
      }
      
      private static function clickNo() : void
      {
      }
      
      private static function onGame(param1:Event) : void
      {
         ModuleManager.toggleModule(URLUtil.getAppModule("GhostMorphGame"),"正在打开...");
      }
      
      private static function onStart(param1:SceneEvent) : void
      {
         var _loc2_:com.taomee.seer2.app.processor.activity.ghostMorph.GhostActor = null;
         ItemManager.removeEventListener1(ItemEvent.REQUEST_SPECIAL_ITEM_SUCCESS,requestItemSuccess);
         for each(_loc2_ in _actorList)
         {
            DisplayUtil.removeForParent(_loc2_);
         }
      }
   }
}
