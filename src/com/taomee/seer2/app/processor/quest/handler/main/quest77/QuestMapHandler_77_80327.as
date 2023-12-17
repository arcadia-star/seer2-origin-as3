package com.taomee.seer2.app.processor.quest.handler.main.quest77
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.actor.data.UserInfo;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.quest.mark.AcceptableMark;
   import com.taomee.seer2.app.shoot.ShootController;
   import com.taomee.seer2.app.shoot.ShootEvent;
   import com.taomee.seer2.app.shoot.ShootInfo;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class QuestMapHandler_77_80327 extends QuestMapHandler
   {
       
      
      private var _mc1:MovieClip;
      
      private var _mc2:MovieClip;
      
      private var _mc3:MovieClip;
      
      private var _mc4:MovieClip;
      
      private var _npc:Mobile;
      
      private var _count:int;
      
      private var rangePos:Array;
      
      public function QuestMapHandler_77_80327(param1:QuestProcessor)
      {
         this.rangePos = [[395,310],[568,530]];
         super(param1);
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isAccepted(questID) && QuestManager.isStepComplete(questID,1) && !QuestManager.isStepComplete(questID,2))
         {
            this.initStep2();
         }
      }
      
      private function onComplete(param1:QuestEvent) : void
      {
         this._mc1 = null;
         this._mc2 = null;
         this._mc3 = null;
         this._mc4 = null;
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
         SceneManager.changeScene(SceneType.LOBBY,70);
      }
      
      private function initStep2() : void
      {
         _map.content.setChildIndex(_map.content["mcDown"],_map.content.numChildren - 2);
         MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("77_0"),function():void
         {
            NpcDialog.show(11,"多罗",[[0,"怎么办啊，我们被困住了！"]],[" 别急，让我想想办法"],[function():void
            {
               NpcDialog.show(10,"巴蒂",[[4,"这笼子的栏杆摸起来怎么这么冷，难道是冰做的？"]],["试试用火焰融化它！"],[function():void
               {
                  LayerManager.focusOnUILayer();
                  ShootController.addEventListener(ShootEvent.PLAY_END,onShootEnd);
               }]);
            }]);
         });
      }
      
      private function onShootEnd(param1:ShootEvent) : void
      {
         var shoot:Boolean = false;
         var evt:ShootEvent = param1;
         var shootInfo:ShootInfo = evt.info;
         var actorInfo:UserInfo = ActorManager.actorInfo;
         if(shootInfo.id == 3 && shootInfo.userID == actorInfo.id)
         {
            if(evt.info.endPos.x > this.rangePos[0][0] && evt.info.endPos.x < this.rangePos[1][0] && evt.info.endPos.y > this.rangePos[0][1] && evt.info.endPos.y < this.rangePos[1][1])
            {
               _processor.hideMouseClickHint();
               ++this._count;
               if(this._count == 2)
               {
                  _map.front["mcUp"].visible = false;
                  _map.content["mcDown"].visible = false;
                  _map.content["npc0"].visible = false;
                  _map.content["npc1"].visible = false;
                  this._mc1 = _processor.resLib.getMovieClip("Mc77_0");
                  _map.front.addChild(this._mc1);
                  this._mc1.gotoAndStop(1);
                  MovieClipUtil.playMc(this._mc1,1,this._mc1.totalFrames,function():void
                  {
                     DisplayObjectUtil.removeFromParent(_mc1);
                     LayerManager.resetOperation();
                     createNpc(821);
                  },true);
               }
            }
         }
      }
      
      private function createNpc(param1:int) : void
      {
         var _loc2_:AcceptableMark = null;
         if(!this._npc)
         {
            this._npc = new Mobile();
            this._npc.setPostion(new Point(510,550));
            this._npc.resourceUrl = URLUtil.getNpcSwf(param1);
            this._npc.buttonMode = true;
            MobileManager.addMobile(this._npc,MobileType.NPC);
            this._npc.addEventListener(MouseEvent.CLICK,this.dialogShow);
            _loc2_ = new AcceptableMark();
            _loc2_.y = -100;
            this._npc.addChild(_loc2_);
         }
      }
      
      private function removeNpc(param1:int) : void
      {
         MobileManager.removeMobile(this._npc,MobileType.NPC);
      }
      
      private function dialogShow(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         NpcDialog.show(821,"提尔",[[0,"你们居然挣脱了牢笼！"]],["  你为什么把我们抓起来？"],[function():void
         {
            NpcDialog.show(821,"提尔",[[0,"你们不是虫系氏族的人，为什么会来到这里！一定是萨伦帝国的奸细！"]],["我们不是奸细，你听我解释"],[function():void
            {
               NpcDialog.show(400,"小赛尔",[[0,"我们是为寻找南半球的灵兽，才来到了这里。虫群氏族新的女王大人——白雪告诉我们，这里能够通往超能氏族。"]],["..."],[function():void
               {
                  NpcDialog.show(821,"提尔",[[2,"哼，别以为就这么几句话就能让我相信！萨伦帝国的家伙诡计多端，最会伪装！"]],["你！"],[function():void
                  {
                     removeNpc(821);
                     _mc2 = _processor.resLib.getMovieClip("Mc77_1");
                     _map.front.addChild(_mc2);
                     _mc2.gotoAndStop(1);
                     MovieClipUtil.playMc(_mc2,1,_mc2.totalFrames,function():void
                     {
                        dialogShow2();
                     },true);
                  }]);
               }]);
            }]);
         }]);
      }
      
      private function dialogShow2() : void
      {
         NpcDialog.show(821,"提尔",[[0,"哼，你们果然是萨伦派来的奸细！"]],["  不是这样的！"],[function():void
         {
            NpcDialog.show(694,"黑武士",[[0,"哈哈哈哈，我如此机智，怎么会和这些愚蠢的家伙是同谋！"]],["可恶，那你是怎么进来的！"],[function():void
            {
               NpcDialog.show(694,"黑武士",[[0,"你们以为之前我真的离开了吗？你们后来的一举一动我都看得一清二楚！包括开门的方法，哈哈哈哈！"]],["太过分了！"],[function():void
               {
                  NpcDialog.show(694,"黑武士",[[0,"哼，既然给我找到了这里，你这胆敢反对萨伦大王的小子，还不束手就擒，供出同党！"]],["小心！"],[function():void
                  {
                     MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("77_1"),function():void
                     {
                        dialogSow3();
                     });
                  }]);
               }]);
            }]);
         }]);
      }
      
      private function dialogSow3() : void
      {
         NpcDialog.show(11,"多罗",[[0,"啊，你的手断了！"]],["  我……没事"],[function():void
         {
            NpcDialog.show(694,"黑武士",[[0,"嘿嘿，你们没办法了吧，乖乖束手就擒吧！"]],["……"],[function():void
            {
               MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("77_2"),function():void
               {
                  DisplayObjectUtil.removeFromParent(_mc2);
                  QuestManager.completeStep(questID,2);
                  QuestManager.addEventListener(QuestEvent.COMPLETE,onComplete);
               });
            }]);
         }]);
      }
   }
}
