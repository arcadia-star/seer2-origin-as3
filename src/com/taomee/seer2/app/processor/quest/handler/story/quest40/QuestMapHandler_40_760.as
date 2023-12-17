package com.taomee.seer2.app.processor.quest.handler.story.quest40
{
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_40_760 extends QuestMapHandler
   {
       
      
      private var _mc_0:MovieClip;
      
      private var _mc_1:MovieClip;
      
      public function QuestMapHandler_40_760(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id,1) == false)
         {
            this.startQuest();
         }
         if(QuestManager.isStepComplete(_quest.id,1) && QuestManager.isStepComplete(_quest.id,2) == false)
         {
            this._mc_0 = _processor.resLib.getMovieClip("mc_3");
            _map.content.addChild(this._mc_0);
            this._mc_1 = _processor.resLib.getMovieClip("mc_2");
            _map.content.addChild(this._mc_1);
            this._mc_1.buttonMode = true;
            this._mc_1.addEventListener(MouseEvent.CLICK,this.onBrotherTalk);
         }
      }
      
      private function startQuest() : void
      {
         this._mc_0 = _processor.resLib.getMovieClip("mc_0");
         _map.content.addChild(this._mc_0);
         this._mc_0.buttonMode = true;
         this._mc_0.addEventListener(MouseEvent.CLICK,this.onNpcSay);
      }
      
      private function onNpcSay(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         this._mc_0.removeEventListener(MouseEvent.CLICK,this.onNpcSay);
         NpcDialog.show(87,"刚铎",[[0,"流水会让人的内心渐渐平静……"]],["刚铎，你当年为什么离开军队？"],[function():void
         {
            NpcDialog.show(87,"刚铎",[[0,"嚯！埋藏那么深的秘密居然被你发现！不愧是星际使者……！"]],["给我认真说话！真是的！"],[function():void
            {
               NpcDialog.show(87,"刚铎",[[0,"的确。我就是神翼总督的弟弟，当年的总兵团长。但是我已经忘记了这些头衔，因为我已经给我自己赋予了新的价值。"]],["（看来他终于打算说了……）"],[function():void
               {
                  playNextStep();
               }]);
            }]);
         }]);
      }
      
      private function playNextStep() : void
      {
         this._mc_0.buttonMode = false;
         this._mc_0.removeEventListener(MouseEvent.CLICK,this.onNpcSay);
         MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("40_1"),function():void
         {
            NpcDialog.show(87,"刚铎",[[0,"我想，证明给他看……！"]],["其实你也是个执拗的人呢"],[function():void
            {
               DisplayUtil.removeForParent(_mc_0);
               _mc_1 = _processor.resLib.getMovieClip("mc_1");
               _map.front.addChild(_mc_1);
               MovieClipUtil.playMc(_mc_1,1,_mc_1.totalFrames,function():void
               {
                  QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onCompleteHandler);
                  QuestManager.completeStep(_quest.id,1);
               },true);
            }]);
         },true,false,2);
      }
      
      private function onCompleteHandler(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onCompleteHandler);
         if(this._mc_0)
         {
            DisplayUtil.removeForParent(this._mc_0);
         }
         if(this._mc_1)
         {
            DisplayUtil.removeForParent(this._mc_1);
         }
         this._mc_0 = _processor.resLib.getMovieClip("mc_3");
         _map.content.addChild(this._mc_0);
         this._mc_1 = _processor.resLib.getMovieClip("mc_2");
         _map.content.addChild(this._mc_1);
         this._mc_1.buttonMode = true;
         this._mc_1.addEventListener(MouseEvent.CLICK,this.onBrotherTalk);
      }
      
      private function onBrotherTalk(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         this._mc_1.removeEventListener(MouseEvent.CLICK,this.onBrotherTalk);
         NpcDialog.show(107,"神翼总督",[[0,"额那个……额……这里，风景不错……流水声也很优美……"]],["总督大人，你是来请总兵团长回归的吧？"],[function():void
         {
            NpcDialog.show(107,"神翼总督",[[0,"咳。刚铎，其实经历了这次劫难，我真正理解了你当初所说的话。急功近利地追求别人赐予的力量，只能显得自己更加软弱。"]],["嗯，嗯。"],[function():void
            {
               NpcDialog.show(107,"神翼总督",[[0,"所以……不仅是作为哥哥，更作为飞翼氏族的总督，我希望你能够回来。没有人能够胜任总兵团长这个位置！"]],[" 哈哈，没错哦！"],[function():void
               {
                  NpcDialog.show(87,"刚铎",[[0,"其实，当我真正离开，放下总兵团长的身份，以流浪汉的身份去看我们的族人时才发现，他人给予的力量只会变成自己的枷锁。"]],["哎……"],[function():void
                  {
                     NpcDialog.show(87,"刚铎",[[0,"所以，我想我会一直留在民间，用自己的方式去帮助他们，去教会他们如何让自己变得更强大。"]],["难道说刚铎你……"],[function():void
                     {
                        NpcDialog.show(107,"神翼总督",[[0,"我尊重你的选择。刚铎，我最亲爱的弟弟，我最信任的总兵团长……就让我们用自己的方式和诚心让飞翼氏族变得更加强大吧！"]],["最重要的就是，要靠自己的双手去创造未来！"],[function():void
                        {
                           NpcDialog.show(87,"刚铎",[[0,"哈哈哈，不过你还是听了我的意见，让星际使者们进入群岛了！！这还真是个正确的决定！！"]],["哎？！所以最初是你提出的？！"],[function():void
                           {
                              NpcDialog.show(107,"神翼总督",[[0,"哈哈哈，像斯坦因博士只是一个说法而已。我们早就通过时镜之岛的观测台欣赏了你们的英勇壮举了！"]],["（这个不是偷窥嘛！）"],[function():void
                              {
                                 NpcDialog.show(87,"刚铎",[[0,"所以，作为答谢，把最强好男儿的象征送给你！！"]],["啊……这是！"],[function():void
                                 {
                                    QuestManager.addEventListener(QuestEvent.COMPLETE,onQuestComplete);
                                    QuestManager.completeStep(_quest.id,2);
                                 }]);
                              }]);
                           }]);
                        }]);
                     }]);
                  }]);
               }]);
            }]);
         }]);
      }
      
      private function onQuestComplete(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onQuestComplete);
         if(param1.questId == 40)
         {
            if(this._mc_0)
            {
               DisplayUtil.removeForParent(this._mc_0);
            }
            if(this._mc_1)
            {
               DisplayUtil.removeForParent(this._mc_1);
            }
         }
      }
      
      override public function processMapDispose() : void
      {
         if(this._mc_0)
         {
            DisplayUtil.removeForParent(this._mc_0);
         }
         if(this._mc_1)
         {
            DisplayUtil.removeForParent(this._mc_1);
         }
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onQuestComplete);
      }
   }
}
