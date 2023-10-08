package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.arena.util.FightSide;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.app.utils.NpcUtil;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class ZhuaChapter1Processor extends MapProcessor
   {
       
      
      private var _zhuaMC:MovieClip;
      
      private const fightId:int = 474;
      
      private const mapIds:Array = [5201,5101,4701,4901,4801,3501,3703];
      
      public function ZhuaChapter1Processor(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         this._zhuaMC = _map.content["zhuaMC"];
         this._zhuaMC.buttonMode = true;
         if(SceneManager.prevSceneType == SceneType.ARENA && FightManager.currentFightRecord.initData.positionIndex == this.fightId)
         {
            if(FightManager.fightWinnerSide == FightSide.LEFT)
            {
               if(_map.id == this.mapIds[6])
               {
                  AlertManager.showAlert("哇，你已经找齐所有的线索了。",function():void
                  {
                     NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[0,"哎呀，经历千辛万苦，终于找到地沙纷争的线索。让我来仔细观看一下。"]],["仔细观察线索"],[function():void
                     {
                        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10193_0"),function():void
                        {
                           NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[0,"啊，两只灵兽一定很伤心，我想我应该去帮助他们和好了。"]],["从氏族纷争开始"],[function():void
                           {
                              QuestManager.completeStep(10193,2);
                           }]);
                        });
                     }]);
                  });
                  return;
               }
               AlertManager.showAlert("成功找到线索，前往下一个地图继续寻找吧！",function():void
               {
                  ModuleManager.toggleModule(URLUtil.getAppModule("ZhuaBeastPanel"),"","1");
               });
            }
            else
            {
               AlertManager.showAlert("线索中断，被精灵抢走，你要从头开始寻找了",function():void
               {
                  ModuleManager.toggleModule(URLUtil.getAppModule("ZhuaBeastPanel"),"","1");
               });
            }
            return;
         }
         if(QuestManager.isStepComplete(10193,1) && !QuestManager.isComplete(10193))
         {
            ActiveCountManager.requestActiveCount(202327,this.getCount);
         }
      }
      
      private function getCount(param1:uint, param2:uint) : void
      {
         var type:uint = param1;
         var count:uint = param2;
         if(type == 202327)
         {
            if(count <= this.mapIds.indexOf(_map.id))
            {
               this._zhuaMC.addEventListener(MouseEvent.CLICK,this.onZhuaMc);
            }
            else
            {
               if(_map.id == this.mapIds[6])
               {
                  AlertManager.showAlert("哇，你已经找齐所有的线索了。",function():void
                  {
                     NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[0,"哎呀，经历千辛万苦，终于找到地沙纷争的线索。让我来仔细观看一下。"]],["仔细观察线索"],[function():void
                     {
                        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10193_0"),function():void
                        {
                           NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[0,"啊，两只灵兽一定很伤心，我想我应该去帮助他们和好了。"]],["从氏族纷争开始"],[function():void
                           {
                              QuestManager.completeStep(10193,2);
                           }]);
                        });
                     }]);
                  });
                  return;
               }
               AlertManager.showAlert("恭喜你找到了线索，赶紧去寻找其他的吧",function():void
               {
                  ModuleManager.toggleModule(URLUtil.getAppModule("ZhuaBeastPanel"),"","1");
               });
            }
         }
      }
      
      private function onZhuaMc(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         var p:int = Math.floor(Math.random() * 100);
         if(p < 20)
         {
            SwapManager.swapItem(1534,1);
            AlertManager.showAlert("恭喜你找到线索，前往下一张地图寻找吧",function():void
            {
               ModuleManager.toggleModule(URLUtil.getAppModule("ZhuaBeastPanel"),"","1");
            });
         }
         else
         {
            FightManager.startFightWithWild(474);
         }
      }
      
      override public function dispose() : void
      {
         if(this._zhuaMC)
         {
            this._zhuaMC.addEventListener(MouseEvent.CLICK,this.onZhuaMc);
         }
         super.dispose();
      }
   }
}
