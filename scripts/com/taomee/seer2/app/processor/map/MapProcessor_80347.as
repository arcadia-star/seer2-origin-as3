package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.serverBuffer.ServerBuffer;
   import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
   import com.taomee.seer2.app.serverBuffer.ServerBufferType;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.swap.info.SwapInfo;
   import com.taomee.seer2.app.utils.ActsHelperUtil;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.loader.ContentInfo;
   import com.taomee.seer2.core.loader.LoadType;
   import com.taomee.seer2.core.loader.QueueLoader;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.IDataInput;
   
   public class MapProcessor_80347 extends MapProcessor
   {
      
      private static var _isFight:uint = 0;
       
      
      private var _npc:Mobile;
      
      private var _res:MovieClip;
      
      private const SWAP_TASK:uint = 3451;
      
      private const FIGHT_LIST:Array = [1367,1368,1369];
      
      private var _nick:String;
      
      public function MapProcessor_80347(param1:MapModel)
      {
         this._nick = ActorManager.actorInfo.nick;
         super(param1);
      }
      
      override public function init() : void
      {
         QueueLoader.load(URLUtil.getActivityAnimation("cindysMemory/Cindy4"),LoadType.SWF,this.onLoad);
         ActorManager.getActor().blockNoNo = true;
         ActorManager.getActor().blockFollowingPet = true;
         ActorManager.getActor().updateNick("雷霆");
         ActorManager.getActor().updateMedal(0);
         ActorManager.getActor().startTransform(830);
         switch(_isFight)
         {
            case 1:
               this.onComplete1();
               break;
            case 2:
               this.onComplete2();
               break;
            case 3:
               this.onComplete3();
         }
      }
      
      override public function dispose() : void
      {
         ActorManager.getActor().blockNoNo = false;
         ActorManager.getActor().blockFollowingPet = false;
         ActorManager.getActor().updateNick(this._nick);
         ActorManager.getActor().stopTransform();
         super.dispose();
      }
      
      private function onLoad(param1:ContentInfo) : void
      {
         this._res = param1.content;
         this._res.x = 0;
         this._res.y = 0;
         this.createNpc();
      }
      
      private function createNpc() : void
      {
         if(!this._npc)
         {
            this._npc = new Mobile();
            this._npc.setPostion(new Point(754,351));
            this._npc.resourceUrl = URLUtil.getNpcSwf(1);
            this._npc.buttonMode = true;
            this._npc.gotoAndStop(2);
            MobileManager.addMobile(this._npc,MobileType.NPC);
            this._npc.addEventListener(MouseEvent.CLICK,this.onClickNpc);
         }
      }
      
      private function onClickNpc(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         ServerBufferManager.getServerBuffer(ServerBufferType.CINDYS_MEMORY_TASK,function(param1:ServerBuffer):void
         {
            var _loc2_:int = param1.readDataAtPostion(2);
            switch(_loc2_)
            {
               case 0:
                  initDialog1();
                  break;
               case 1:
                  initDialog2();
                  break;
               case 2:
                  initDialog3();
            }
         });
      }
      
      private function initDialog1() : void
      {
         NpcDialog.show(1,"辛迪船长",[[0,"雷霆，你有着非常强大的能力，如今我们的飞船被困在此。我们需要你的帮助！"]],["……"],[function():void
         {
            NpcDialog.show(1,"辛迪船长",[[0,"但是，我发现你的性格上有弱点，作为回报我将帮你做特训来克服这些弱点。"]],["……"],[function():void
            {
               NpcDialog.show(1,"辛迪船长",[[0,"特训一：毅力训练——你的脾气太急躁，强大的精灵需要能够沉下心来。\n目标：战胜小树根"]],["我没有弱点","哼，说来听听。"],[null,function():void
               {
                  FightManager.startFightWithBoss(FIGHT_LIST[0],function():void
                  {
                     _isFight = 1;
                  });
               }]);
            }]);
         }]);
      }
      
      private function onComplete1() : void
      {
         if(SceneManager.prevSceneType == SceneType.ARENA)
         {
            if(this.FIGHT_LIST[0] == FightManager.currentFightRecord.initData.positionIndex)
            {
               _isFight = 0;
               ServerBufferManager.updateServerBuffer(ServerBufferType.CINDYS_MEMORY_TASK,2,1);
               NpcDialog.show(830,"雷霆",[[0,"我根本不需要这么没用的特训。"]],["我没有弱点","哼，听听下一个"],[null,this.initDialog2]);
            }
         }
      }
      
      private function initDialog2() : void
      {
         NpcDialog.show(1,"辛迪船长",[[0,"无论你是否承认，你的弱点显而易见。"]],["……"],[function():void
         {
            NpcDialog.show(1,"辛迪船长",[[0,"特训二： 怜悯之心——冷酷的精灵只是杀手，而非英雄。\n目标：帮助飞船上的小精灵们战胜敌人"]],["我没有弱点","哼，说来听听。"],[null,function():void
            {
               FightManager.startFightWithBoss(FIGHT_LIST[1],function():void
               {
                  _isFight = 2;
               });
            }]);
         }]);
      }
      
      private function onComplete2() : void
      {
         if(SceneManager.prevSceneType == SceneType.ARENA)
         {
            if(this.FIGHT_LIST[1] == FightManager.currentFightRecord.initData.positionIndex)
            {
               _isFight = 0;
               if(FightManager.isWinWar())
               {
                  ServerBufferManager.updateServerBuffer(ServerBufferType.CINDYS_MEMORY_TASK,2,2);
                  NpcDialog.show(830,"雷霆",[[0,"这种特训就是在浪费我的时间！"]],["我没有弱点","哼，听听下一个"],[null,this.initDialog3]);
               }
               else
               {
                  NpcDialog.show(830,"雷霆",[[0,"你们的精灵真是不堪一击，拖后腿的家伙！"]],["我不需要这种训练","再来一次！"],[null,function():void
                  {
                     FightManager.startFightWithBoss(FIGHT_LIST[1],function():void
                     {
                        _isFight = 2;
                     });
                  }]);
               }
            }
         }
      }
      
      private function initDialog3() : void
      {
         NpcDialog.show(1,"辛迪船长",[[0,"特训三： 知难而退——英雄也必有弱点，总有被击败的时刻。\n目标：挑战精灵王"]],["没这必要","哼，谁来都一样。"],[null,function():void
         {
            FightManager.startFightWithBoss(FIGHT_LIST[2],function():void
            {
               _isFight = 3;
            });
         }]);
      }
      
      private function onComplete3() : void
      {
         if(SceneManager.prevSceneType == SceneType.ARENA && this.FIGHT_LIST[2] == FightManager.currentFightRecord.initData.positionIndex)
         {
            _isFight = 0;
            NpcDialog.show(1,"辛迪船长",[[0,"英雄也不是无敌的。记住，要活下去！"]],["……"],[function():void
            {
               SwapManager.swapItem(SWAP_TASK,1,function(param1:IDataInput):void
               {
                  var data:IDataInput = param1;
                  ServerBufferManager.updateServerBuffer(ServerBufferType.CINDYS_MEMORY_TASK,2,0);
                  _npc.visible = false;
                  ActorManager.getActor().hide();
                  _map.content.addChild(_res["main"]);
                  MovieClipUtil.playMc(_res["main"],1,_res["main"].totalFrames,function():void
                  {
                     DisplayObjectUtil.removeFromParent(_res["main"]);
                     new SwapInfo(data);
                     ActorManager.getActor().show();
                     gameOver();
                  });
               });
            }]);
         }
      }
      
      private function gameOver() : void
      {
         SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,function switchOver():void
         {
            SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE,switchOver);
            ModuleManager.showAppModule("CindysMemoryPanel");
         });
         ActsHelperUtil.goHandle(70);
      }
   }
}
