package com.taomee.seer2.app.processor.quest.handler.main.quest75
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   
   public class QuestMapHandler_75_230 extends QuestMapHandler
   {
       
      
      private var _mc2:MovieClip;
      
      private var _mc3:MovieClip;
      
      private var _mc4:MovieClip;
      
      private var _mc5:MovieClip;
      
      public function QuestMapHandler_75_230(param1:QuestProcessor)
      {
         super(param1);
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isAccepted(questID) && QuestManager.isStepComplete(questID,1) && !QuestManager.isStepComplete(questID,2))
         {
            _map.content.visible = false;
            ActorManager.hideActor();
            MobileManager.hideMoileVec(MobileType.NPC);
            this.initStep2();
         }
      }
      
      private function onComplete(param1:QuestEvent) : void
      {
         this._mc2 = null;
         MobileManager.showMoileVec(MobileType.NPC);
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
         SceneManager.changeScene(SceneType.LOBBY,70);
      }
      
      private function initStep2() : void
      {
         this._mc2 = _processor.resLib.getMovieClip("Mc75_1");
         _map.front.addChild(this._mc2);
         this._mc2.gotoAndStop(1);
         MovieClipUtil.playMc(this._mc2,1,this._mc2.totalFrames,function():void
         {
            NpcDialog.show(14,"S",[[0,"乘着火系氏族内乱的时机进行突袭，我真是天才！"]],["太卑鄙了！"],[function():void
            {
               NpcDialog.show(32,"洛克",[[4,"萨伦！来战！"]],["战胜他们洛克！"],[function():void
               {
                  MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("75_0"),function():void
                  {
                     initContinue();
                  });
               }]);
            }]);
         },true);
      }
      
      private function initContinue() : void
      {
         NpcDialog.show(14,"S",[[0,"切！没想到水系精灵居然会输给你们！"]],["兄弟齐心！其利断金！"],[function():void
         {
            NpcDialog.show(14,"S",[[0,"不过火系氏族的这场大火，你们怕是阻止不了了，哈哈！"]],["会有办法的！"],[function():void
            {
               NpcDialog.show(14,"S",[[0,"再见了！火系氏族的蠢货们！哈哈~"]],["别逃S！"],[function():void
               {
                  DisplayObjectUtil.removeFromParent(_mc2);
                  _mc3 = _processor.resLib.getMovieClip("Mc75_2");
                  _map.front.addChild(_mc3);
                  _mc3.gotoAndStop(1);
                  MovieClipUtil.playMc(_mc3,1,_mc3.totalFrames,function():void
                  {
                     NpcDialog.show(32,"洛克",[[4,"可恶！那么大的火我们根本没办法扑灭！"]],[" 怎么办？"],[function():void
                     {
                        NpcDialog.show(31,"巴尔卡",[[0,"好不容易，才回到火幻氏族的……"]],["快想想怎么灭火！"],[function():void
                        {
                           NpcDialog.show(400,"小赛尔",[[0,"兄弟和好了，一定会有办法的！"]],["火越来越大了！"],[function():void
                           {
                              DisplayObjectUtil.removeFromParent(_mc3);
                              initContinue2();
                           }]);
                        }]);
                     }]);
                  },true);
               }]);
            }]);
         }]);
      }
      
      private function initContinue2() : void
      {
         this._mc4 = _processor.resLib.getMovieClip("Mc75_3");
         _map.front.addChild(this._mc4);
         this._mc4.gotoAndStop(1);
         MovieClipUtil.playMc(this._mc4,1,this._mc4.totalFrames,function():void
         {
            NpcDialog.show(31,"巴尔卡",[[0,"幻灵兽！"]],[" 灵兽出现了！"],[function():void
            {
               NpcDialog.show(561,"幻灵兽",[[0,"你们两兄弟终于和好了，这样我也就能放心把火幻氏族交给你们了。"]],["好！"],[function():void
               {
                  NpcDialog.show(561,"幻灵兽",[[0,"虽然有点不合时宜，不过，从现在开始，你们两个就是火幻氏族的族长了。"]],["两个族长？"],[function():void
                  {
                     NpcDialog.show(561,"幻灵兽",[[0,"拥有仁慈之心的巴尔克和拥有狂暴之力的洛克，这样的组合会给氏族带来怎样的未来呢？"]],["一定行的！"],[function():void
                     {
                        NpcDialog.show(561,"幻灵兽",[[0,"哈哈，就让我拭目以待吧。两位族长大人。"]],["族长大人！ "],[function():void
                        {
                           DisplayObjectUtil.removeFromParent(_mc4);
                           _mc5 = _processor.resLib.getMovieClip("Mc75_4");
                           _map.front.addChild(_mc5);
                           _mc5.gotoAndStop(1);
                           MovieClipUtil.playMc(_mc5,1,_mc5.totalFrames,function():void
                           {
                              DisplayObjectUtil.removeFromParent(_mc5);
                              MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("75_1"),function():void
                              {
                                 QuestManager.addEventListener(QuestEvent.COMPLETE,onComplete);
                                 QuestManager.completeStep(questID,2);
                              });
                           },true);
                        }]);
                     }]);
                  }]);
               }]);
            }]);
         },true);
      }
   }
}
