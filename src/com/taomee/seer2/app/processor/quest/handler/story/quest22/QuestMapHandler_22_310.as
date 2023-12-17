package com.taomee.seer2.app.processor.quest.handler.story.quest22
{
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.quest.constant.QuestStatus;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_22_310 extends QuestMapHandler
   {
       
      
      private var _mc_1:MovieClip;
      
      private var _mc_1_1:MovieClip;
      
      private var _mc_1_2:MovieClip;
      
      private var _mc_1_3:MovieClip;
      
      private var _mc_2:MovieClip;
      
      public function QuestMapHandler_22_310(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(_quest.status == QuestStatus.ACCEPTABLE)
         {
            this.initAccept();
         }
         if(QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id,1) == false)
         {
            this.initQuest1();
         }
      }
      
      private function initAccept() : void
      {
         this._mc_1 = _processor.resLib.getMovieClip("mc_1");
         this._mc_1.x -= 50;
         _map.front.addChild(this._mc_1);
         this._mc_1.gotoAndStop(1);
         this._mc_1_1 = _processor.resLib.getMovieClip("mc_1_1");
         this._mc_1_1.x -= 50;
         _map.front.addChild(this._mc_1_1);
         this._mc_1.buttonMode = true;
         this._mc_1.addEventListener(MouseEvent.CLICK,this.onMC1Click);
      }
      
      private function initQuest1() : void
      {
         this._mc_1 = _processor.resLib.getMovieClip("mc_1");
         this._mc_1.x -= 50;
         _map.front.addChild(this._mc_1);
         this._mc_1.gotoAndStop(2);
         this._mc_1.buttonMode = true;
         this._mc_1.addEventListener(MouseEvent.CLICK,this.onQuest1);
         this._mc_2 = _processor.resLib.getMovieClip("mc_2");
         _map.front.addChild(this._mc_2);
         this._mc_2.buttonMode = true;
         this._mc_2.addEventListener(MouseEvent.CLICK,this.onMC2Click);
      }
      
      private function onQuest1(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         NpcDialog.show(52,"蒂萨特",[[2,"给你个提示留心场景中发亮的物体哦！"]],["谢谢！"],[function():void
         {
         }]);
      }
      
      private function onMC1Click(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         this._mc_1.removeEventListener(MouseEvent.CLICK,this.onMC1Click);
         NpcDialog.show(52,"蒂萨特",[[2,"我不知道，我真的不知道……呜哇…………"]],["蒂萨特？你怎么了？"],[function():void
         {
            NpcDialog.show(52,"蒂萨特",[[2,"我真的不知道兰德在哪里……呜呜……兰德德……"]],["兰德？他不见了吗？"],[function():void
            {
               NpcDialog.show(53,"兰德妈妈",[[3,"我家兰德说要到这里来找这个沙爪小鬼玩！怎么都不听话！结果，已经一天一夜没有回家了！！！快说！你把他藏到哪里去了！"]],["（还是那么凶……）"],[function():void
               {
                  NpcDialog.show(52,"蒂萨特",[[2,"从那次分开后，我就再也没有见过兰德德了……"]],["奇怪，那兰德去哪里了呢？"],[function():void
                  {
                     NpcDialog.show(53,"兰德妈妈",[[3,"你们沙爪的小鬼都那么爱撒谎吗？！兰德走时还说呢，跑道线上有三个亮闪闪的小朋友……除了你以外，难道还有别的什么坏孩子？？"]],["（三个亮闪闪的小朋友？）"],[function():void
                     {
                        NpcDialog.show(53,"兰德妈妈",[[3,"我自己去找！！如果今天还找不到……我就把大家都叫过来，要人！！"]],["……"],[function():void
                        {
                           DisplayUtil.removeForParent(_mc_1_1);
                           _mc_1_2 = _processor.resLib.getMovieClip("mc_1_2");
                           _map.front.addChild(_mc_1_2);
                           MovieClipUtil.playMc(_mc_1_2,2,_mc_1_2.totalFrames,function():void
                           {
                              NpcDialog.show(52,"蒂萨特",[[2,"三个……呜呜，亮闪闪的小朋友……没有啊……啊！！难道是？！"]],["想到什么了吗？"],[function():void
                              {
                                 NpcDialog.show(52,"蒂萨特",[[1,"也许……也许是暗号！我和兰德德还有吉吉导游一直玩的……我们四下找找！"]],["（在三八跑道线（沙）四处找找线索！）"],[function():void
                                 {
                                    QuestManager.addEventListener(QuestEvent.ACCEPT,onAccept);
                                    QuestManager.accept(_quest.id);
                                 }]);
                              }]);
                           },true);
                        }]);
                     }]);
                  }]);
               }]);
            }]);
         }]);
      }
      
      private function onAccept(param1:QuestEvent) : void
      {
         if(param1.questId == _quest.id)
         {
            this._mc_1.gotoAndStop(2);
            QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAccept);
            this._mc_2 = _processor.resLib.getMovieClip("mc_2");
            _map.front.addChild(this._mc_2);
            this._mc_2.buttonMode = true;
            this._mc_2.addEventListener(MouseEvent.CLICK,this.onMC2Click);
         }
      }
      
      private function onMC2Click(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         this._mc_2.removeEventListener(MouseEvent.CLICK,this.onMC2Click);
         NpcDialog.show(52,"蒂萨特",[[1,"哇！找到了！这肯定是兰德德留下的线索！！"]],["看看写的什么？"],[function():void
         {
            MovieClipUtil.playNpcTalkNew(URLUtil.getQuestNpcTalkAnimation("22_0"),1,[[1,0]],function():void
            {
               NpcDialog.show(52,"蒂萨特",[[0,"齿轮和烟囱……嗯……附近唯一符合的地方，就是沙爪主城了！"]],["旋转呼呼是虾米……"],[function():void
               {
                  NpcDialog.show(52,"蒂萨特",[[4,"好！去看看就知道了！"]],["（去沙爪主城找找线索！）"],[function():void
                  {
                     DisplayUtil.removeForParent(_mc_1);
                     _mc_1_3 = _processor.resLib.getMovieClip("mc_1_3");
                     _map.front.addChild(_mc_1_3);
                     MovieClipUtil.playMc(_mc_1_3,2,_mc_1_3.totalFrames,function():void
                     {
                        QuestManager.completeStep(_quest.id,1);
                        _processor.showMouseHintAt(550,435);
                     },true);
                  }]);
               }]);
            });
         }]);
      }
      
      override public function processMapDispose() : void
      {
         _processor.hideMouseClickHint();
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAccept);
         DisplayUtil.removeForParent(this._mc_1);
         DisplayUtil.removeForParent(this._mc_2);
         DisplayUtil.removeForParent(this._mc_1_1);
         DisplayUtil.removeForParent(this._mc_1_2);
         DisplayUtil.removeForParent(this._mc_1_3);
         this._mc_1 = null;
         this._mc_2 = null;
         this._mc_1_1 = null;
         this._mc_1_2 = null;
         this._mc_1_3 = null;
      }
   }
}
