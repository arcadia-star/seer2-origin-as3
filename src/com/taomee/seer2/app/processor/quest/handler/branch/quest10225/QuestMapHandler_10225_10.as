package com.taomee.seer2.app.processor.quest.handler.branch.quest10225
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.arena.FightManager;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.pet.data.PetInfoManager;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.quest.mark.AcceptableMark;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_10225_10 extends QuestMapHandler
   {
       
      
      private var _mc2:MovieClip;
      
      private var _mc3:MovieClip;
      
      private var _mc4:MovieClip;
      
      private var _mack:AcceptableMark;
      
      public function QuestMapHandler_10225_10(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(!QuestMapHandler_10225_80174.haveBattle)
         {
            return;
         }
         if(QuestManager.isAccepted(10225) && QuestManager.isStepComplete(10225,2) == false)
         {
            this.initStep1();
         }
      }
      
      private function initStep1() : void
      {
         ActorManager.showRemoteActor = false;
         MobileManager.hideMoileVec(MobileType.NPC);
         ActorManager.getActor().isShow = false;
         ActorManager.getActor().blockNoNo = true;
         this._mc2 = _processor.resLib.getMovieClip("mc2");
         this._mc2["xidi"].visible = false;
         _map.front.addChild(this._mc2);
         MovieClipUtil.playMc(this._mc2,2,this._mc2.totalFrames,function():void
         {
            _mack = new AcceptableMark();
            _mack.x = _mc2["xidi"].x;
            _mack.y = _mc2["xidi"].y;
            _mc2.addChild(_mack);
            _mc2["xidi"].visible = true;
            _mc2["xidi"].buttonMode = true;
            _mc2["xidi"].addEventListener(MouseEvent.CLICK,onClick);
         },true);
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         this._mc2["xidi"].removeEventListener(MouseEvent.CLICK,this.onClick);
         NpcDialog.show(1,"辛迪",[[0,"你好这位外星客人，我是赛尔号Ⅱ的船长辛迪，初次见面。"]],["船长大人"],[function():void
         {
            NpcDialog.show(736,"赫",[[0,"初次见面，我是炎星的王子——赫。"]],[" 王子！！"],[function():void
            {
               NpcDialog.show(2,"伊娃",[[0,"炎星！难道说……是那颗已经消失的……"]],[" 诶？炎星怎么了？"],[function():void
               {
                  NpcDialog.show(736,"赫",[[0,"没错，如你们所观测到的，炎星，已经被黑洞吞噬了……我千辛万苦来到这！就是不能让“那群家伙”制造的黑洞再残害其他行星！"]],["赫……"],[function():void
                  {
                     NpcDialog.show(1,"辛迪",[[0,"王子，你说“那群家伙”，这么说黑洞是由人为制造的！"]],[" ！黑洞是人造的？"],[function():void
                     {
                        NpcDialog.show(736,"赫",[[0,"是的！这是场灭绝宇宙的大阴谋，幕后的黑手就是……"]],[" 是谁？"],[function():void
                        {
                           DisplayUtil.removeForParent(_mack);
                           DisplayUtil.removeForParent(_mc2);
                           initStep2();
                        }]);
                     }]);
                  }]);
               }]);
            }]);
         }]);
      }
      
      private function onOver(param1:Event) : void
      {
         if(SceneManager.prevSceneType == SceneType.ARENA)
         {
            SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE,this.onOver);
            this.initStep3();
         }
      }
      
      private function initStep2() : void
      {
         ActorManager.showRemoteActor = false;
         MobileManager.hideMoileVec(MobileType.NPC);
         ActorManager.getActor().isShow = false;
         ActorManager.getActor().blockNoNo = true;
         this._mc3 = _processor.resLib.getMovieClip("mc3");
         this._mc3["star"].visible = false;
         _map.front.addChild(this._mc3);
         MovieClipUtil.playMc(this._mc3,2,this._mc3.totalFrames,function():void
         {
            _mack = new AcceptableMark();
            _mack.x = _mc3["star"].x;
            _mack.y = _mc3["star"].y;
            _mc3.addChild(_mack);
            _mc3["star"].visible = true;
            _mc3["star"].buttonMode = true;
            _mc3["star"].addEventListener(MouseEvent.CLICK,onClick2);
         },true);
      }
      
      private function onClick2(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         this._mc3["star"].removeEventListener(MouseEvent.CLICK,this.onClick2);
         NpcDialog.show(737,"地飞星",[[0,"炎星的小王子，没想到让你逃出来了~"]],[" 难道你就是制造黑洞的家伙！？"],[function():void
         {
            NpcDialog.show(736,"赫",[[0,"你们这些毁灭了炎星的大坏蛋！"]],[" 大坏蛋！"],[function():void
            {
               NpcDialog.show(1,"辛迪",[[0,"这位突然闯入飞船的客人，我是这艘飞船的船长辛迪。请问你是……"]],[" 你是谁？！"],[function():void
               {
                  NpcDialog.show(737,"地飞星",[[0,"哈哈，辛迪船长，初次见面，我是噬神界的执行者——地飞星！请船长快把赫交给我，不然，这艘飞船会怎样，我就很难说了。"]],[" 噬神界？"],[function():void
                  {
                     NpcDialog.show(737,"地飞星",[[0,"顺便一说，你们看到的黑洞，就是我们制造的……或者说，黑洞就是我们本身。"]],[" 本身？！"],[function():void
                     {
                        NpcDialog.show(1,"辛迪",[[0,"既然这样，那我们就已经是敌人了！第七小队、克拉克、门罗、伊娃，准备战斗！"]],["  是！船长！"],[function():void
                        {
                           if(PetInfoManager.getFirstPetInfo().hp != 0)
                           {
                              SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,onOver);
                              QuestMapHandler_10225_80174.haveBattle = false;
                              FightManager.startFightWithWild(897);
                           }
                           else
                           {
                              initStep3();
                           }
                        }]);
                     }]);
                  }]);
               }]);
            }]);
         }]);
      }
      
      private function initStep3() : void
      {
         DisplayUtil.removeForParent(this._mack);
         DisplayUtil.removeForParent(this._mc3);
         ActorManager.showRemoteActor = false;
         MobileManager.hideMoileVec(MobileType.NPC);
         ActorManager.getActor().isShow = false;
         ActorManager.getActor().blockNoNo = true;
         this._mc4 = _processor.resLib.getMovieClip("mc4");
         _map.front.addChild(this._mc4);
         MovieClipUtil.playMc(this._mc4,2,this._mc4.totalFrames,function():void
         {
            DisplayUtil.removeForParent(_mc4);
            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10225_0"),function():void
            {
               QuestManager.addEventListener(QuestEvent.COMPLETE,onStepComplete);
               QuestManager.completeStep(10225,2);
            },true,true);
         },true);
      }
      
      private function onStepComplete(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onStepComplete);
         SceneManager.changeScene(SceneType.LOBBY,70);
      }
      
      override public function processMapDispose() : void
      {
         MobileManager.showMoileVec(MobileType.NPC);
         ActorManager.showRemoteActor = true;
         ActorManager.getActor().isShow = true;
         ActorManager.getActor().blockNoNo = false;
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onStepComplete);
         DisplayUtil.removeForParent(this._mc2);
         DisplayUtil.removeForParent(this._mc3);
         DisplayUtil.removeForParent(this._mc4);
         DisplayUtil.removeForParent(this._mack);
      }
   }
}
