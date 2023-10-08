package com.taomee.seer2.app.actives
{
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.config.ItemConfig;
   import com.taomee.seer2.app.inventory.ItemManager;
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.swap.info.SwapInfo;
   import com.taomee.seer2.app.swap.special.SpecialInfo;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.loader.ContentInfo;
   import com.taomee.seer2.core.loader.LoadType;
   import com.taomee.seer2.core.loader.QueueLoader;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.system.ApplicationDomain;
   import flash.utils.IDataInput;
   import org.taomee.utils.DisplayUtil;
   import org.taomee.utils.DomainUtil;
   
   public class PlutoSealManager
   {
      
      private static const fightIdList:Vector.<uint> = Vector.<uint>([1540,1542,1541,1543]);
      
      private static const mapIdList:Vector.<uint> = Vector.<uint>([100,240,170,360]);
      
      private static const itemIdList:Vector.<uint> = Vector.<uint>([401173,401174,401175,401176]);
      
      private static var _resLib:ApplicationDomain;
      
      private static var _boxMc:MovieClip;
      
      private static var _playMC:MovieClip;
      
      private static var _currIndex:int;
       
      
      public function PlutoSealManager()
      {
         super();
      }
      
      public static function setup() : void
      {
         SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,onComplete);
      }
      
      private static function onComplete(param1:SceneEvent) : void
      {
         var _loc2_:uint = uint(SceneManager.active.mapID);
         _currIndex = mapIdList.indexOf(_loc2_);
         if(_currIndex != -1)
         {
            if(_resLib)
            {
               startPluto();
            }
            else
            {
               QueueLoader.load(URLUtil.getRes("loaderLibrary/plutoSeal.swf"),LoadType.SWF,onLoadComplete);
            }
            if(SceneManager.prevSceneType == SceneType.ARENA)
            {
               checkMaxItem();
            }
         }
      }
      
      private static function onLoadComplete(param1:ContentInfo) : void
      {
         _resLib = param1.domain;
         startPluto();
      }
      
      private static function startPluto() : void
      {
         _boxMc = getMovie("boxMC" + _currIndex);
         _boxMc.x = Math.random() * 600 + 200;
         _boxMc.y = Math.random() * 400 + 100;
         SceneManager.active.mapModel.front.addChild(_boxMc);
         _boxMc.buttonMode = true;
         _boxMc.addEventListener(MouseEvent.CLICK,onBox);
         SceneManager.addEventListener(SceneEvent.SWITCH_START,onStart);
      }
      
      private static function onStart(param1:SceneEvent) : void
      {
         SceneManager.removeEventListener(SceneEvent.SWITCH_START,onStart);
         DisplayUtil.removeForParent(_boxMc);
         if(_boxMc)
         {
            _boxMc.removeEventListener(MouseEvent.CLICK,onBox);
            _boxMc = null;
         }
         DisplayUtil.removeForParent(_playMC);
         _playMC = null;
      }
      
      private static function checkMaxItem() : void
      {
         ItemManager.requestItemList(function():void
         {
            if(ItemManager.getItemQuantityByReferenceId(itemIdList[_currIndex]) != 0 && ItemManager.getItemQuantityByReferenceId(itemIdList[_currIndex]) % 5 == 0)
            {
               AlertManager.showConfirm("已收集到足够的" + ItemConfig.getItemName(itemIdList[_currIndex]) + "，继续收集其他封印。",function():void
               {
                  SceneManager.changeScene(SceneType.COPY,80420);
               });
            }
         });
      }
      
      private static function onBox(param1:MouseEvent) : void
      {
         var statis:String;
         var event:MouseEvent = param1;
         var random:int = int(Math.random() * 3);
         if(random == 0)
         {
            SwapManager.swapItem(3773,1,function(param1:IDataInput):void
            {
               new SwapInfo(param1);
               onStart(null);
               checkMaxItem();
               startPluto();
            },null,new SpecialInfo(1,_currIndex));
         }
         else if(random == 1)
         {
            _playMC = getMovie("play1");
            SceneManager.active.mapModel.front.addChild(_playMC);
            playMC(function():void
            {
               FightManager.startFightWithWild(fightIdList[_currIndex]);
               onStart(null);
               startPluto();
            });
         }
         else if(random == 2)
         {
            _playMC = getMovie("play2");
            SceneManager.active.mapModel.front.addChild(_playMC);
            playMC(function():void
            {
               onStart(null);
               startPluto();
            });
         }
         statis = "点击蛮之印";
         if(_currIndex == 1)
         {
            statis = "点击尘之印";
         }
         else if(_currIndex == 2)
         {
            statis = "点击焰之印";
         }
         else if(_currIndex == 3)
         {
            statis = "点击洛之印";
         }
         StatisticsManager.newSendNovice("2015活动","冥神封印",statis);
      }
      
      private static function playMC(param1:Function) : void
      {
         var cookBack:Function = param1;
         MovieClipUtil.playMc(_playMC,2,_playMC.totalFrames,function():void
         {
            DisplayUtil.removeForParent(_playMC);
            cookBack();
         },true);
      }
      
      private static function getMovie(param1:String) : MovieClip
      {
         if(_resLib)
         {
            return DomainUtil.getMovieClip(param1,_resLib);
         }
         return null;
      }
   }
}
