package com.taomee.seer2.app.processor.quest.handler.main.quest1
{
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.processor.activity.diluControl.DiluManager;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.swap.info.SwapInfo;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.net.MessageEvent;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.external.ExternalInterface;
   import flash.geom.Rectangle;
   import flash.utils.IDataInput;
   import org.taomee.bean.BeanManager;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_1_5 extends QuestMapHandler
   {
       
      
      private var _toolBar:MovieClip;
      
      private var _shipBtn:SimpleButton;
      
      private var _mapPanel:MovieClip;
      
      private var _mapBtn:SimpleButton;
      
      private var _mc1:MovieClip;
      
      private var _mc6:MovieClip;
      
      public function QuestMapHandler_1_5(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         this.extractAssets();
         ActorManager.showRemoteActor = false;
         if(_quest.isStepCompletable(4))
         {
            this.processStep3();
         }
         StatisticsManager.newSendNovice("新手引导","2014上半年版新手引导","传送至船长室（开始加载）");
      }
      
      private function extractAssets() : void
      {
      }
      
      private function processStep3() : void
      {
         this._mc1 = _processor.resLib.getMovieClip("mc1_4");
         LayerManager.stage.addEventListener(Event.RESIZE,this.onResize);
         LayerManager.stage.addChild(this._mc1);
         this._mc1.addEventListener(MouseEvent.CLICK,this.onMC1);
         this.layIcon();
         BeanManager.start("2");
      }
      
      private function onResize(param1:Event) : void
      {
         this.layIcon();
      }
      
      private function layIcon() : void
      {
         if(this._mc1)
         {
            this._mc1.scaleX = LayerManager.stage.stageWidth / 1200;
            this._mc1.scaleY = LayerManager.stage.stageHeight / 660;
         }
      }
      
      private function onMC1(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         LayerManager.stage.removeEventListener(Event.RESIZE,this.onResize);
         DisplayUtil.removeForParent(this._mc1);
         NpcDialog.showForNew(1,"辛迪船长",[[0,"{$name}，再次欢迎你来到赛尔号Ⅱ飞船，我是船长辛迪。"]],"哇！船长，好帅！",function():void
         {
            NpcDialog.showForNew(1,"辛迪船长",[[0,"接下来还有更多的考验在等待着你，现在我任命你为<font color=\'#ff0000\'>" + "精灵训练师，和多罗、巴蒂组成第七小队，开始你们真正的冒险之旅吧！" + "</font>"]],"太棒了！我一定会成为一名勇敢的小赛尔。",function():void
            {
               _mc6 = _processor.resLib.getMovieClip("mc6");
               _map.front.addChild(_mc6);
               var _loc1_:Rectangle = new Rectangle(0,0,LayerManager.stage.stageWidth,LayerManager.stage.stageHeight);
               DisplayUtil.align(_mc6,4,_loc1_);
               _mc6["goBtn"].addEventListener(MouseEvent.CLICK,onGo);
               _mc6["closeBtn"].addEventListener(MouseEvent.CLICK,onClose);
            });
         });
      }
      
      private function onStepComplete(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onStepComplete);
         StatisticsManager.newSendNovice("新手引导","2014上半年版新手引导","获得新手任务奖励");
         DisplayUtil.removeForParent(this._mc6);
         var _loc2_:Mobile = MobileManager.getMobile(1,MobileType.NPC);
         if(_loc2_)
         {
            _loc2_.visible = false;
         }
         DiluManager._isNoShowPanel = true;
         SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,this.onSwitch);
         SceneManager.changeScene(SceneType.LOBBY,60);
      }
      
      private function onSwitch(param1:SceneEvent) : void
      {
         SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE,this.onSwitch);
         var _loc2_:Object = new Object();
         _loc2_.isNew = 2;
         ModuleManager.toggleModule(URLUtil.getAppModule("QuestNewPanel"),"正在打开...",_loc2_);
      }
      
      private function onGo(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         ExternalInterface.call("addBookmark","约瑟传说-飞跃巅峰！","http://seer2.61.com");
         ActiveCountManager.requestActiveCount(203963,function(param1:uint, param2:uint):void
         {
            var type:uint = param1;
            var count:uint = param2;
            if(count == 0)
            {
               SwapManager.swapItem(2626,1,function(param1:IDataInput):void
               {
                  new SwapInfo(param1);
                  StatisticsManager.newSendNovice("新手引导","2014上半年版新手引导","领取收藏奖励的");
               });
            }
         });
         StatisticsManager.newSendNovice("新手引导","2014上半年版新手引导","点击收藏约瑟的");
      }
      
      private function onClose(param1:MouseEvent) : void
      {
         this.completeQuest();
      }
      
      private function completeQuest() : void
      {
         if(QuestManager.isAccepted(1))
         {
            if(QuestManager.getQuest(1).getCurrentOrNextStep().id == 4)
            {
               QuestManager.addEventListener(QuestEvent.COMPLETE,this.onStepComplete);
            }
            else
            {
               QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,this.onStepStepComplete);
            }
            Connection.addErrorHandler(CommandSet.QUEST_SUBMIT_STEP_BUFFER_1015,this.onError);
            QuestManager.completeStep(1,QuestManager.getQuest(1).getCurrentOrNextStep().id);
         }
         else
         {
            SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,this.onSwitch);
            SceneManager.changeScene(SceneType.LOBBY,60);
         }
      }
      
      private function onError(param1:MessageEvent) : void
      {
         if(param1.message.statusCode == 17)
         {
            SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,this.onSwitch);
            SceneManager.changeScene(SceneType.LOBBY,60);
         }
      }
      
      private function onStepStepComplete(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStepStepComplete);
         this.completeQuest();
      }
      
      override public function processMapDispose() : void
      {
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onStepComplete);
         DisplayUtil.removeForParent(this._mc6);
         DisplayUtil.removeForParent(this._mc1);
         SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE,this.onSwitch);
         LayerManager.stage.removeEventListener(Event.RESIZE,this.onResize);
         Connection.removeErrorHandler(CommandSet.QUEST_SUBMIT_STEP_BUFFER_1015,this.onError);
         super.processMapDispose();
      }
   }
}
