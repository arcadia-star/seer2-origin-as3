package com.taomee.seer2.app.processor.quest.handler.branch.quest10237
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   
   public class QuestMapHandler_10237_80240 extends QuestMapHandler
   {
      
      private static var haveFight:int = 0;
       
      
      private var _mc1:MovieClip;
      
      private var _mc2:MovieClip;
      
      private var _mc3:MovieClip;
      
      private var _mc4:MovieClip;
      
      public function QuestMapHandler_10237_80240(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapDispose() : void
      {
         super.processMapDispose();
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         ActorManager.hideActor();
         MobileManager.hideMoileVec(MobileType.NPC);
         if(haveFight == 1)
         {
            haveFight = 0;
            return;
         }
         if(QuestManager.isAccepted(questID) && !QuestManager.isStepComplete(questID,1))
         {
            this.initStep1();
         }
         if(QuestManager.isStepComplete(questID,1) && !QuestManager.isComplete(questID))
         {
            this.onComplete(null);
         }
      }
      
      private function onComplete(param1:QuestEvent) : void
      {
         this._mc1 = null;
         this._mc2 = null;
         this._mc3 = null;
         this._mc4 = null;
         MobileManager.showMoileVec(MobileType.NPC);
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
         SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,this.onSwitchComplete);
         SceneManager.changeScene(SceneType.LOBBY,70);
      }
      
      private function onSwitchComplete(param1:SceneEvent) : void
      {
         SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE,this.onSwitchComplete);
         ModuleManager.showAppModule("YueSeThreeYearsGuessPanel");
      }
      
      private function initStep1() : void
      {
         this._mc1 = _processor.resLib.getMovieClip("Mc10237_0");
         _map.content.addChild(this._mc1);
         this._mc1.gotoAndStop(1);
         MovieClipUtil.playMc(this._mc1,1,this._mc1.totalFrames,function():void
         {
            NpcDialog.show(764,"万劫魔尊",[[0,"这才是魔域军团的真正组合。"]],["邪恶势力都联合了!"],[function():void
            {
               NpcDialog.show(400,"小赛尔",[[0,"不超梦小心！这些家伙都超级强的！"]],["BOSS级的！"],[function():void
               {
                  NpcDialog.show(774,"超梦",[[0,"      不管有多强也要打败他们！来战！"]],["超梦加油！"],[function():void
                  {
                     initStep2();
                  }]);
               }]);
            }]);
         },true);
      }
      
      private function initStep2() : void
      {
         MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10237_0"),function():void
         {
            NpcDialog.show(774,"超梦",[[0,"              可恶……"]],["超梦好像不行了!"],[function():void
            {
               NpcDialog.show(12,"萨伦",[[0,"如论单打独斗可能超梦不会输给他们，可是3打1的话……"]],["超梦就肯定不是对手了！"],[function():void
               {
                  NpcDialog.show(400,"小赛尔",[[0,"太卑鄙了！人多欺负人少！"]],["是啊！"],[function():void
                  {
                     NpcDialog.show(764,"万劫魔尊",[[0,"兵不厌诈！好了，该终结这只可怜的小精灵了。"]],["超梦小心啊！"],[function():void
                     {
                        DisplayObjectUtil.removeFromParent(_mc1);
                        initStep3();
                     }]);
                  }]);
               }]);
            }]);
         });
      }
      
      private function initStep3() : void
      {
         this._mc2 = _processor.resLib.getMovieClip("Mc10237_1");
         _map.content.addChild(this._mc2);
         this._mc2.gotoAndStop(1);
         MovieClipUtil.playMc(this._mc2,1,this._mc2.totalFrames,function():void
         {
            NpcDialog.show(591,"约瑟",[[0,"超梦，你没事吧。"]],["约瑟王!"],[function():void
            {
               NpcDialog.show(774,"超梦",[[0,"            还撑得住……"]],["他们三打一太不公平了！"],[function():void
               {
                  NpcDialog.show(591,"约瑟",[[0,"超梦，你就先休息一会儿吧。接下来，就交给我了。"]],["王要出场了！"],[function():void
                  {
                     NpcDialog.show(591,"约瑟",[[0,"阿卡迪亚可不会轻易交给你们的。"]],["加油！"],[function():void
                     {
                        DisplayObjectUtil.removeFromParent(_mc2);
                        initStep4();
                     }]);
                  }]);
               }]);
            }]);
         },true);
      }
      
      private function initStep4() : void
      {
         this._mc3 = _processor.resLib.getMovieClip("Mc10237_2");
         _map.content.addChild(this._mc3);
         this._mc3.gotoAndStop(1);
         MovieClipUtil.playMc(this._mc3,1,this._mc3.totalFrames,function():void
         {
            NpcDialog.show(774,"超梦",[[0,"             约瑟果然厉害……以一敌三还游刃有余。"]],["加油！"],[function():void
            {
               NpcDialog.show(400,"小赛尔",[[0,"不愧是阿卡迪亚最强的存在！"]],["北半球的王！"],[function():void
               {
                  NpcDialog.show(764,"万劫魔尊",[[0,"约瑟……其实我们早就料到你的到来了。为此还做足了准备。"]],["不要挣扎了！"],[function():void
                  {
                     NpcDialog.show(764,"万劫魔尊",[[0,"准备好魔域军团！封印约瑟！"]],["封印约瑟！？"],[function():void
                     {
                        DisplayObjectUtil.removeFromParent(_mc3);
                        initStep5();
                     }]);
                  }]);
               }]);
            }]);
         },true);
      }
      
      private function initStep5() : void
      {
         this._mc4 = _processor.resLib.getMovieClip("Mc10237_3");
         _map.content.addChild(this._mc4);
         this._mc4.gotoAndStop(1);
         MovieClipUtil.playMc(this._mc4,1,this._mc4.totalFrames,function():void
         {
            NpcDialog.show(591,"约瑟",[[0,"这结界是……"]],["约瑟被封印了！？"],[function():void
            {
               NpcDialog.show(764,"万劫魔尊",[[0,"我们三个倾注所有能量铸成的结界！你就在里面慢慢的死去吧约瑟！"]],["结界？？"],[function():void
               {
                  NpcDialog.show(591,"约瑟",[[0,"可是这样你们也不能离开这个结界，阿卡迪亚还是会持续安宁。"]],["约瑟要牺牲自己？"],[function():void
                  {
                     NpcDialog.show(764,"万劫魔尊",[[0,"太天真了约瑟，你以为，魔域军团只有我们3个吗？"]],["魔域军团还有同党？"],[function():void
                     {
                        DisplayObjectUtil.removeFromParent(_mc4);
                        initStep6();
                     }]);
                  }]);
               }]);
            }]);
         },true);
      }
      
      private function initStep6() : void
      {
         MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10237_1"),function():void
         {
            QuestManager.completeStep(questID,1);
            QuestManager.addEventListener(QuestEvent.COMPLETE,onComplete);
         });
      }
   }
}
