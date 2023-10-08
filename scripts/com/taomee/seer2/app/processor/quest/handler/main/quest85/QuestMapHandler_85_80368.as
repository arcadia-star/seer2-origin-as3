package com.taomee.seer2.app.processor.quest.handler.main.quest85
{
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.quest.mark.InProgressMark;
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
   
   public class QuestMapHandler_85_80368 extends QuestMapHandler
   {
       
      
      private var _mc1:MovieClip;
      
      private var _npc:Mobile;
      
      public function QuestMapHandler_85_80368(param1:QuestProcessor)
      {
         super(param1);
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(!QuestManager.isAccepted(questID))
         {
            QuestManager.accept(questID);
            QuestManager.addEventListener(QuestEvent.ACCEPT,this.onAccepted);
         }
         if(QuestManager.isAccepted(questID) && !QuestManager.isStepComplete(questID,1))
         {
            this.initStep1();
         }
         if(QuestManager.isAccepted(questID) && QuestManager.isStepComplete(questID,1) && !QuestManager.isComplete(questID))
         {
            this.createNpc();
         }
      }
      
      private function onAccepted(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAccepted);
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
         this._npc = null;
         MobileManager.showMoileVec(MobileType.NPC);
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
         SceneManager.changeScene(SceneType.LOBBY,70);
      }
      
      private function initStep1() : void
      {
         MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("85_0"),function():void
         {
            NpcDialog.show(766,"小梦",[[0,"你终于醒来了！"]],["我们这是……在哪儿？"],[function():void
            {
               NpcDialog.show(766,"小梦",[[0,"这是、这里是地球！"]],["地球！我们到地球了？"],[function():void
               {
                  NpcDialog.show(400,"小赛尔",[[0,"地球……这就是地球……原来的我们的地球，现在已经变成了这样吗？"]],["这一切到底是怎么回事呢？"],[function():void
                  {
                     NpcDialog.show(766,"小梦",[[0,"我也不知道呢，那时候我周围的空气仿佛都扭曲了，然后一个身影朝我袭来，接着我就什么都不知道了。"]],["不知道其他人怎么样了？"],[function():void
                     {
                        initContinue();
                     }]);
                  }]);
               }]);
            }]);
         },false);
      }
      
      private function initContinue() : void
      {
         this._mc1 = _processor.resLib.getMovieClip("Mc85_0");
         _map.front.addChild(this._mc1);
         this._mc1.gotoAndStop(1);
         MovieClipUtil.playMc(this._mc1,1,this._mc1.totalFrames,function():void
         {
            DisplayObjectUtil.removeFromParent(_mc1);
            initStep1Complete();
         },true);
      }
      
      private function initStep1Complete() : void
      {
         QuestManager.completeStep(questID,1);
         QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,this.onComplete1);
      }
      
      private function onComplete1(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onComplete1);
         this.initStep2();
      }
      
      private function initStep2() : void
      {
         this.createNpc();
      }
      
      private function createNpc() : void
      {
         var _loc1_:InProgressMark = null;
         if(!this._npc)
         {
            this._npc = new Mobile();
            this._npc.setPostion(new Point(372,460));
            this._npc.resourceUrl = URLUtil.getNpcSwf(833);
            this._npc.buttonMode = true;
            MobileManager.addMobile(this._npc,MobileType.NPC);
            _loc1_ = new InProgressMark();
            _loc1_.y = -120;
            this._npc.addChild(_loc1_);
            this._npc.addEventListener(MouseEvent.CLICK,this.initStep2Continue);
         }
      }
      
      private function initStep2Continue(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         NpcDialog.show(833,"银河星王",[[0,"去看看你们的小伙伴吧"]],[" ！！"],[function():void
         {
            NpcDialog.show(400,"小赛尔",[[1,"巴蒂、多罗、雷霆，你们都没事，太好了！"]],["……"],[function():void
            {
               NpcDialog.show(10,"巴蒂",[[0,"这是……哪儿呀？"]],["这是地球！我们的家园！"],[function():void
               {
                  NpcDialog.show(400,"小赛尔",[[1,"啊对了，谢谢您将我的伙伴带来！但请问，您又是谁呢？是您救了我们么？"]],[" ……"],[function():void
                  {
                     NpcDialog.show(833,"银河星王",[[0,"是帕斯塔委托我将你们送回地球的。"]],["太空武斗场场主！"],[function():void
                     {
                        NpcDialog.show(766,"小梦",[[0,"他不是和那个阿修雷是一伙的么！他不是规则的制定者么！我们之所以被困在太空武斗场那么久，不正是因为他们？"]],[" 对啊！"],[function():void
                        {
                           NpcDialog.show(833,"银河星王",[[0,"身为武斗场场主之一、规则的制定者，他不能容许任何人破坏规则。所以，他让你们留在太空武斗场，要求你们获得100连胜才可以离开。"]],[" ……"],[function():void
                           {
                              NpcDialog.show(833,"银河星王",[[0,"然而，在你们一场又一场战斗中，他看到了你们对梦想的坚持、对家园的热爱，他从你们身上，看到了以往银河战队的影子！"]],[" 银河战队？！"],[function():void
                              {
                                 NpcDialog.show(833,"银河星王",[[0,"银河战队曾经是一个强大的战队，它护卫着银河时空的和平，我曾经也是其中的一员。然而，战队却因为力量的强大产生了分歧。"]],[" ！！"],[function():void
                                 {
                                    NpcDialog.show(833,"银河星王",[[0,"有人选择用统治来掌控和平，而我们依旧坚持着守护，寻找着曾经的战友……"]],[" 希望你们可以找到他们！"],[function():void
                                    {
                                       NpcDialog.show(833,"银河星王",[[0,"正是因为在你们这些小家伙身上看到了曾经的银河精神，帕斯塔不愿让你们永远留在太空武斗场、被永无止境的战斗摧垮。 "]],[" ……"],[function():void
                                       {
                                          NpcDialog.show(833,"银河星王",[[0,"再加上你们也确实完成了100场连胜，所以，当毁灭者完成超进化，情势危急下，他让我扭曲时空，将你们救出武斗场，送来地球。"]],[" 原来是这样"],[function():void
                                          {
                                             NpcDialog.show(833,"银河星王",[[0,"好了，小家伙们，我也该继续我的职责了。想必你们在地球上也有许多事情要做。重建家园不是一件容易的事情，但我相信凭借你们的努力，你们可以成功，我会持续关注你们的进展。加油！"]],["谢谢你！"],[function():void
                                             {
                                                initStep2FullScreenAnimation2();
                                             }]);
                                          }]);
                                       }]);
                                    }]);
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
      
      private function initStep2FullScreenAnimation2() : void
      {
         MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("85_1"),function():void
         {
            QuestManager.addEventListener(QuestEvent.COMPLETE,onComplete);
            QuestManager.completeStep(questID,2);
         },false);
      }
      
      override public function processMapDispose() : void
      {
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete);
         if(this._npc)
         {
            this._npc.removeEventListener(MouseEvent.CLICK,this.initStep2Continue);
         }
         this._npc = null;
         super.processMapDispose();
      }
   }
}
