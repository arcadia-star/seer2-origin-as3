package com.taomee.seer2.app.processor.quest.handler.main.quest92
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.component.MouseClickHintSprite;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.quest.mark.AcceptableMark;
   import com.taomee.seer2.app.rightToolbar.RightToolbarConter;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class QuestMapHandler_92_3837 extends QuestMapHandler
   {
       
      
      private var _mc2:MovieClip;
      
      private var _npc1020:Mobile;
      
      private var _npc:Mobile;
      
      private var _mouseHint:MouseClickHintSprite;
      
      public function QuestMapHandler_92_3837(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         RightToolbarConter.instance.hide();
         ActorManager.getActor().hide();
         ActorManager.getActor().blockFollowingPet = true;
         ActorManager.getActor().blockNoNo = true;
         this._npc1020 = MobileManager.getMobile(1020,MobileType.NPC);
         this._npc1020.visible = false;
         if(QuestManager.isComplete(questID))
         {
            this.onComplete(null);
         }
         else if(QuestManager.isStepComplete(questID,2) && !QuestManager.isStepComplete(questID,3))
         {
            this._mc2 = _processor.resLib.getMovieClip("Mc92_2");
            _map.front.addChild(this._mc2);
            this._mc2.gotoAndStop(1);
            MovieClipUtil.playMc(this._mc2,1,this._mc2.totalFrames,function():void
            {
               DisplayObjectUtil.removeFromParent(_mc2);
               createNpc();
            },true);
         }
      }
      
      private function onComplete(param1:QuestEvent) : void
      {
         ActorManager.getActor().show();
         ActorManager.getActor().blockFollowingPet = false;
         ActorManager.getActor().blockNoNo = false;
         RightToolbarConter.instance.show();
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
         SceneManager.changeScene(SceneType.LOBBY,70);
      }
      
      private function createNpc() : void
      {
         this._npc = new Mobile();
         this._npc.setPostion(new Point(758,328));
         this._npc.resourceUrl = URLUtil.getNpcSwf(1020);
         this._npc.buttonMode = true;
         MobileManager.addMobile(this._npc,MobileType.NPC);
         var _loc1_:AcceptableMark = new AcceptableMark();
         this._npc.addChild(_loc1_);
         _loc1_.y = -150;
         this._npc.addEventListener(MouseEvent.CLICK,this.dialogShow);
      }
      
      private function dialogShow(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         NpcDialog.show(11,"巴蒂",[[2,"555~~~~~~队长~~~~~快救我们~~~~~~~~~  "]],[" 快把多罗和巴蒂放了！"],[function():void
         {
            NpcDialog.show(1020,"达斯维达",[[0,"还有一个铁皮人，把他一起抓了！是你拿走了能量水晶吧？ "]],[" 族长大人我有话要说！"],[function():void
            {
               NpcDialog.show(1020,"达斯维达",[[0,"犯人，自己送上门来还有何要说？ "]],[" 有一个人想见你，他希望你一个人去见他。"],[function():void
               {
                  NpcDialog.show(1020,"达斯维达",[[0,"哼，什么人如此嚣张？竟然要本王大驾亲自去见他？ "]],[" 他叫梵拉。（也不知道族长认不认识这个人……）"],[function():void
                  {
                     NpcDialog.show(883,"鬼瞳",[[0,"（空中回响）他背叛了自己的氏族，背叛了自己的挚友，背叛了先祖的意志。不要相信那个叛徒的谎言。 "]],[" 什么声音？？谁在说话？？"],[function():void
                     {
                        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("92_0"),function():void
                        {
                           NpcDialog.show(1020,"达斯维达",[[0,"嗯，先祖的意志不能违背！去告诉那个叛徒，我和他之间没什么好谈的。我会找到他，让他乖乖认罪！ "]],["梵拉是超能氏族的叛徒?"],[function():void
                           {
                              NpcDialog.show(883,"鬼瞳",[[0,"（空中回响）你们一定也是受了那个叛徒的迷惑，不要相信他说的任何一个字。 "]],["这到底是怎么回事？去找里格问清楚吧！"],[function():void
                              {
                                 NpcDialog.show(11,"巴蒂",[[2,"队长，不要丢下我们~~~~~~~~~~"]],[" 我会想办法把你们救出去的！"],[function():void
                                 {
                                    QuestManager.completeStep(questID,3);
                                    QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,initStep2);
                                 }]);
                              }]);
                           }]);
                        });
                     }]);
                  }]);
               }]);
            }]);
         }]);
      }
      
      private function initStep2(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.initStep2);
         ActorManager.getActor().show();
         ActorManager.getActor().blockFollowingPet = false;
         ActorManager.getActor().blockNoNo = false;
         if(this._npc != null)
         {
            MobileManager.removeMobile(this._npc,MobileType.NPC);
         }
         this._mouseHint = new MouseClickHintSprite();
         this._mouseHint.x = 163;
         this._mouseHint.y = 503;
         _map.content.addChild(this._mouseHint);
      }
      
      override public function processMapDispose() : void
      {
         super.processMapDispose();
         if(this._mouseHint)
         {
            DisplayObjectUtil.removeFromParent(this._mouseHint);
         }
      }
   }
}
