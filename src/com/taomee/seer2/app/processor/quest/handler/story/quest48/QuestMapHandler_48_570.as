package com.taomee.seer2.app.processor.quest.handler.story.quest48
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
   
   public class QuestMapHandler_48_570 extends QuestMapHandler
   {
       
      
      private var paulJamesMc:MovieClip;
      
      private var jamesMc:MovieClip;
      
      public function QuestMapHandler_48_570(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isStepComplete(_quest.id,1) && !QuestManager.isStepComplete(_quest.id,2))
         {
            this.paulJamesMc = _processor.resLib.getMovieClip("paulJamesMc");
            this.paulJamesMc.gotoAndStop(1);
            _map.content.addChild(this.paulJamesMc);
            MovieClipUtil.playMc(this.paulJamesMc,1,"runEnd",function():void
            {
               jamesMc = paulJamesMc["jamesMc"];
               jamesMc.buttonMode = true;
               jamesMc.addEventListener(MouseEvent.CLICK,showJamesDia);
            },true);
         }
      }
      
      private function showJamesDia(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         this.jamesMc.removeEventListener(MouseEvent.CLICK,this.showJamesDia);
         NpcDialog.show(486,"詹姆斯",[["0","唔——~~~~(-_-)~~~~ ！！"]],["难道那个冰块里面就是？"],[function():void
         {
            NpcDialog.show(114,"蒂芙伦",[["0","那板凳……看来的确是派瑞大人没错。可是，虽然找到了他，这冰块却没那么容易打破啊……"]],["不试试看怎么知道！！"],[function():void
            {
               MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("48_0"),function():void
               {
                  NpcDialog.show(486,"詹姆斯",[["0","唔——~~~~(-_-)~~~~ ！！"]],["看来这个不行！！考虑用精神力量吧！"],[function():void
                  {
                     NpcDialog.show(114,"蒂芙伦",[["0","对了……唱歌！大家曾经和冰后一起唱歌……！詹姆斯也是其中的一员呢……"]],["对啊，詹姆斯，试试看吧！"],[function():void
                     {
                        MovieClipUtil.playMc(paulJamesMc,"runEnd","helpEnd",function():void
                        {
                           NpcDialog.show(122,"派瑞",[["3","詹姆斯！这段唱错了！好多次了！多学学玉树临风身材高挑的我吧！"]],["…………喂喂"],[function():void
                           {
                              NpcDialog.show(122,"派瑞",[["1","咦，难道，难道我从那个可怕的冰冻中出来了？哈哈，詹姆斯，你走调走得真够惊天地泣鬼神的！连冰块都震碎了~"]],["…………喂喂"],[function():void
                              {
                                 NpcDialog.show(486,"詹姆斯",[["0","唔——！！唔唔！！！=。=#"]],["真想让詹姆斯开口骂你……"],[function():void
                                 {
                                    NpcDialog.show(114,"蒂芙伦",[["0","派瑞大人，大家都被雪女卡尼娅冰冻了……我们，我们把他们救出来吧！就像今天詹姆斯用歌声救出你一样……"]],["看来精神力量还是有用的。"],[function():void
                                    {
                                       NpcDialog.show(122,"派瑞",[["0","对……文森特……琳达……大家……我一定要全都救出来！！"]],["嗯！！"],[function():void
                                       {
                                          QuestManager.addEventListener(QuestEvent.COMPLETE,onComplete);
                                          QuestManager.completeStep(_quest.id,2);
                                       }]);
                                    }]);
                                 }]);
                              }]);
                           }]);
                        });
                     }]);
                  }]);
               });
            }]);
         }]);
      }
      
      private function onComplete(param1:QuestEvent) : void
      {
         if(param1.questId == 48)
         {
            QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
            _map.content.removeChild(this.paulJamesMc);
         }
      }
      
      override public function processMapDispose() : void
      {
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
         this.jamesMc.removeEventListener(MouseEvent.CLICK,this.showJamesDia);
         super.processMapDispose();
      }
   }
}
