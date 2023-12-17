package com.taomee.seer2.app.processor.quest.handler.story.quest20
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_20_540 extends QuestMapHandler
   {
       
      
      private var _mc_0:MovieClip;
      
      private var _mc_3:MovieClip;
      
      private var _mc_3_1:MovieClip;
      
      public function QuestMapHandler_20_540(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isCanAccepted(_quest.id))
         {
            this.initMc0();
         }
         if(QuestManager.isStepComplete(_quest.id,1) && QuestManager.isStepComplete(_quest.id,2) == false)
         {
            this.initMc0();
         }
      }
      
      private function initMc0() : void
      {
         this._mc_0 = _processor.resLib.getMovieClip("mc_0");
         _map.front.addChild(this._mc_0);
         this._mc_0.buttonMode = true;
         this._mc_0.addEventListener(MouseEvent.CLICK,this.onMC1Click);
      }
      
      private function onMC1Click(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         if(QuestManager.isCanAccepted(_quest.id))
         {
            NpcDialog.show(49,"冰系酋长",[[0,ActorManager.actorInfo.nick + "我再一次代表冰沁氏族对你表示感谢。是你的努力让冰沁氏族的情况好转。"]],["这是我应该做的！"],[function():void
            {
               NpcDialog.show(49,"冰系酋长",[[0,"现在，沁灵兽已经被唤醒……虽然扼制冰封之轴需要很长的时间，但是我冰沁族人一定不会放弃！"],[0,"由此我做了一个重大的决定！冰沁氏族……同意与阿卡迪亚星球南部各氏族结盟，并认可赛尔是我们最可靠的抗敌伙伴！"]],["这当中也有目之魂的功劳！"],[function():void
               {
                  onShowAnimation();
               }]);
            }]);
         }
         if(QuestManager.isStepComplete(_quest.id,1) && QuestManager.isStepComplete(_quest.id,2) == false)
         {
            NpcDialog.show(49,"冰系酋长",[[0,"嗯，冰沁宫殿已经是他们最后的据点，防守肯定格外严密。虽然凝结氏族所有居民的力量有机会赶走他们，但是就不能问出真相了。"]],["那该怎么办才好？"],[function():void
            {
               _mc_3 = _processor.resLib.getMovieClip("mc_3");
               _map.front.addChild(_mc_3);
               MovieClipUtil.playMc(_mc_3,2,_mc_3.totalFrames,function():void
               {
                  NpcDialog.show(32,"小兵",[[0,"也许我可以帮助你们……"]],["吓！你是在监狱时帮忙救人的那个？"],[function():void
                  {
                     NpcDialog.show(32,"小兵",[[0,"嗯，我早就下定决心不再追随萨伦帝国了。我想，也是到了我脱下这身军装的时候了。"]],["咦？咦？？！"],[function():void
                     {
                        NpcDialog.show(32,"小兵",[[0,"想要探听出萨伦帝国的阴谋，不乔装打扮是不可能的。这身军装能够帮你骗过他们的眼睛，但是如果阿修队长来的话……也只能试试看了！"]],["这的确是一个可行的办法。"],[function():void
                        {
                           NpcDialog.show(49,"冰系酋长",[[0,"事不宜迟，" + ActorManager.actorInfo.nick + "。你先潜入敌方内部，我会趁此机会集结部分冰沁氏族的精灵，一旦时机成熟，就一举把他们赶走！"]],["好！（乔装打扮去冰沁宫殿！）"],[function():void
                           {
                              _mc_3.visible = false;
                              _mc_3_1 = _processor.resLib.getMovieClip("mc_3_1");
                              _map.front.addChild(_mc_3_1);
                              MovieClipUtil.playMc(_mc_3_1,2,_mc_3_1.totalFrames,function():void
                              {
                                 QuestManager.completeStep(_quest.id,2);
                                 _mc_0.gotoAndStop(_mc_0.totalFrames);
                              },true);
                           }]);
                        }]);
                     }]);
                  }]);
               },true);
            }]);
         }
      }
      
      private function onShowAnimation() : void
      {
         MovieClipUtil.playNpcTalkNew(URLUtil.getQuestNpcTalkAnimation("20_0"),3,[[1,0]],function():void
         {
            NpcDialog.show(49,"冰系酋长",[[0,"目之魂在那场战斗中消耗了太多力量，已经不能时刻都维持可见的形态。至于它当初为什么会在冰沁氏族苏醒，我也百思不得其解……"]],["而且，它总说自己的伙伴不见了。"],[function():void
            {
               NpcDialog.show(49,"冰系酋长",[[0,"还有，萨伦帝国解封冰封之轴的真正目的是什么……疑问过多。现在，冰沁宫殿还有他们的驻军，你们不妨亲自去调查一下真相。"]],["只有这个办法了！（去冰沁宫殿！）"],[function():void
               {
                  QuestManager.accept(_quest.id);
                  _mc_0.gotoAndStop(_mc_0.totalFrames);
               }]);
            }]);
         });
      }
      
      override public function processMapDispose() : void
      {
         DialogPanel.removeCloseEventListener(this.onShowAnimation);
         DisplayUtil.removeForParent(this._mc_3);
         this._mc_3 = null;
         DisplayUtil.removeForParent(this._mc_3_1);
         this._mc_3_1 = null;
         DisplayUtil.removeForParent(this._mc_0);
         this._mc_0 = null;
      }
   }
}
