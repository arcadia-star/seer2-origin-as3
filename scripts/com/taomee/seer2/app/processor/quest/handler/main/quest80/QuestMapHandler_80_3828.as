package com.taomee.seer2.app.processor.quest.handler.main.quest80
{
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.quest.mark.AcceptableMark;
   import com.taomee.seer2.app.quest.mark.InProgressMark;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.entity.Mobile;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class QuestMapHandler_80_3828 extends QuestMapHandler
   {
       
      
      private var _npc:Mobile;
      
      private var _npc1:Mobile;
      
      public function QuestMapHandler_80_3828(param1:QuestProcessor)
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
            this.createNpc();
         }
         if(QuestManager.isAccepted(questID) && QuestManager.isStepComplete(questID,2) && !QuestManager.isStepComplete(questID,3))
         {
            this.createNpc3();
         }
      }
      
      private function onAccepted(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAccepted);
         if(QuestManager.isAccepted(questID) && !QuestManager.isStepComplete(questID,1))
         {
            this.createNpc();
         }
         if(QuestManager.isStepComplete(questID,1) && !QuestManager.isComplete(questID))
         {
            this.onComplete(null);
         }
      }
      
      private function createNpc3() : void
      {
         var _loc1_:InProgressMark = null;
         if(!this._npc)
         {
            this._npc = MobileManager.getMobile(1016,MobileType.NPC);
            _loc1_ = new InProgressMark();
            this._npc.addChild(_loc1_);
            _loc1_.y = -150;
            this._npc.addEventListener(MouseEvent.CLICK,this.initStep3,false,1);
         }
      }
      
      private function initStep3(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         e.stopImmediatePropagation();
         NpcDialog.show(1016,"里格",[[0,"你们回来了。恭喜你们通过了第一个考验。"]],["…"],[function():void
         {
            NpcDialog.show(10,"巴蒂",[[0,"这到底是怎么回事？刚才我们到底在哪儿？"]],["对啊，那地方和秘密基地很相似"],[function():void
            {
               NpcDialog.show(1016,"里格",[[0,"那是我用超能力构筑的一个幻境，它确实和秘密基地差不多，但它的存在，只是因为你们相信它存在。当你们意识到它不是真的秘密基地，这个幻境也就消失了。"]],["原来是这样"],[function():void
               {
                  NpcDialog.show(1016,"里格",[[0,"小赛尔，你的理智让你做出了正确的判断，好样的！接下来，还有一项考验在等待着你们。"]],["来吧！"],[function():void
                  {
                     DoGame();
                  }]);
               }]);
            }]);
         }]);
      }
      
      private function DoGame() : void
      {
         var _loc1_:Object = new Object();
         _loc1_.fun = this.gameComplete;
         ModuleManager.showAppModule("DoFigurePanel",_loc1_);
      }
      
      private function gameComplete(param1:Boolean) : void
      {
         if(param1)
         {
            this.successDoFigure();
         }
         else
         {
            this.failureDoFigure();
         }
      }
      
      private function successDoFigure() : void
      {
         NpcDialog.show(1016,"里格",[[1,"很好，你们已经通过了我的全部考验。我相信，凭借你们的意志和判断，你们一定可以用能量碎片拯救你们的家园！这枚碎片就送给你们吧！"]],[" 谢谢您！"],[function():void
         {
            NpcDialog.show(766,"小梦",[[0,"太好了！小赛尔，我们赶紧准备行囊，准备回地球吧！"]],["嗯！"],[function():void
            {
               NpcDialog.show(766,"小梦",[[0,"太好了！小赛尔，我们赶紧准备行囊，准备回地球吧！"]],["嗯！"],[function():void
               {
                  NpcDialog.show(10,"巴蒂",[[1,"等我们解决了地球家园的危机，就会回来和你们一起战斗！"]],["对，到那时，让我们一起为超能氏族的自由而战！"],[function():void
                  {
                     NpcDialog.show(1016,"里格",[[1,"好，我期待着你们的归来！小赛尔们，一路顺风！"]],["嗯，再见！"],[function():void
                     {
                        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("80_2"),function():void
                        {
                           QuestManager.addEventListener(QuestEvent.COMPLETE,onComplete1);
                           QuestManager.completeStep(questID,3);
                        });
                     }]);
                  }]);
               }]);
            }]);
         }]);
      }
      
      private function failureDoFigure() : void
      {
         this.createNpc4();
      }
      
      private function createNpc4() : void
      {
         MobileManager.removeMobile(this._npc,MobileType.NPC);
         if(!this._npc1)
         {
            this._npc1 = new Mobile();
            this._npc1.setPostion(new Point(552,490));
            this._npc1.resourceUrl = URLUtil.getNpcSwf(1016);
            this._npc1.buttonMode = true;
            MobileManager.addMobile(this._npc1,MobileType.NPC);
            this._npc1.addEventListener(MouseEvent.CLICK,this.initStep4,false,1);
         }
      }
      
      private function initStep4(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         NpcDialog.show(1016,"里格",[[0,"第二项考验还没有通过，现在要去完成吗？"]],["来吧！","我再准备一下"],[function():void
         {
            DoGame();
         },function():void
         {
         }]);
      }
      
      private function onComplete(param1:QuestEvent) : void
      {
         MobileManager.showMoileVec(MobileType.NPC);
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onComplete);
         SceneManager.changeScene(SceneType.COPY,80333);
      }
      
      private function onComplete1(param1:QuestEvent) : void
      {
         MobileManager.showMoileVec(MobileType.NPC);
         QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onComplete1);
         SceneManager.changeScene(SceneType.LOBBY,70);
      }
      
      private function createNpc() : void
      {
         var _loc1_:AcceptableMark = null;
         if(!this._npc)
         {
            this._npc = MobileManager.getMobile(1016,MobileType.NPC);
            _loc1_ = new AcceptableMark();
            this._npc.addChild(_loc1_);
            _loc1_.y = -150;
            this._npc.addEventListener(MouseEvent.CLICK,this.initStep1,false,1);
         }
      }
      
      private function initStep1(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         e.stopImmediatePropagation();
         NpcDialog.show(1016,"里格",[[1,"小赛尔，你们回来了！碎片找到了吗？"]],["嗯"],[function():void
         {
            initStep2();
         }]);
      }
      
      private function initStep2() : void
      {
         MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("80_0"),function():void
         {
            NpcDialog.show(1016,"里格",[[1,"这、这正是我们在寻找的能量碎片！小赛尔，你们真的成功了，太了不起了！但是，你怎么犹豫不决的样子？"]],["我……"],[function():void
            {
               NpcDialog.show(1016,"里格",[[0,"咦，这是谁？似乎也不是超能氏族的精灵……"]],["…"],[function():void
               {
                  NpcDialog.show(766,"小梦",[[0,"我叫小梦，和小赛尔一样，也来自地球。我来阿卡迪亚星，是为了寻找传说中的“永恒能源”，因为我们的地球因为缺乏能量已经到了毁灭的边缘！"]],[" …"],[function():void
                  {
                     NpcDialog.show(1016,"里格",[[0,"居然有这样的事！"]],["唉……"],[function():void
                     {
                        NpcDialog.show(10,"巴蒂",[[0,"事实上，我们离开地球、前往星际探索，也是出于和小梦一样的目的。但是想不到，现在地球的能源危机已经到了这么紧急的地步！"]],["是啊"],[function():void
                        {
                           NpcDialog.show(766,"小梦",[[0,"我在这里无意间碰到了小赛尔，而我可以感觉到，他们找到的“能量碎片”，正是拯救地球的关键！"]],["…"],[function():void
                           {
                              NpcDialog.show(1016,"里格",[[0,"能量碎片……所以，你们需要能量碎片去拯救地球？"]],["嗯"],[function():void
                              {
                                 NpcDialog.show(400,"小赛尔",[[0,"但是能量碎片属于超能氏族，也是你们恢复能量水晶的关键。我们不能据为己有，不然，这和萨伦帝国那些家伙有什么区别！"]],["…"],[function():void
                                 {
                                    NpcDialog.show(11,"多罗",[[0,"对，该如何使用能量碎片，应该由你们来决定。"]],["…"],[function():void
                                    {
                                       NpcDialog.show(1016,"里格",[[0,"小赛尔，你们的正直令我感佩。既然你们可以无私的帮助我们，超能氏族也愿意为朋友作出牺牲。我们可以赠送你们一部分能量碎片，让你们前去拯救自己的家园。"]],["真的吗？那太好了！"],[function():void
                                       {
                                          NpcDialog.show(1016,"里格",[[0,"别急，我还没说完。在此之前，我需要让你们再接受一些考验。只有通过了这些考验、证明了你们具备坚强的意志和理智的判断，我才能放心的把碎片交给你们。"]],["嗯！您要怎样考验我们呢？"],[function():void
                                          {
                                             initContinue();
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
         });
      }
      
      private function initContinue(param1:MouseEvent = null) : void
      {
         var event:MouseEvent = param1;
         if(event)
         {
            event.stopImmediatePropagation();
         }
         NpcDialog.show(1016,"里格",[[0,"去秘密基地找“提尔”吧，他会告诉你们怎么做。"]],[" 好的","待会儿再去"],[function():void
         {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onComplete);
            QuestManager.completeStep(questID,1);
         },function():void
         {
            _npc.removeEventListener(MouseEvent.CLICK,initStep1);
            _npc = null;
            createNpc1();
         }]);
      }
      
      private function createNpc1() : void
      {
         var _loc1_:InProgressMark = null;
         if(!this._npc)
         {
            this._npc = MobileManager.getMobile(1016,MobileType.NPC);
            _loc1_ = new InProgressMark();
            this._npc.addChild(_loc1_);
            _loc1_.y = -150;
            this._npc.addEventListener(MouseEvent.CLICK,this.initContinue,false,2);
         }
      }
      
      override public function processMapDispose() : void
      {
         if(this._npc)
         {
            this._npc.removeEventListener(MouseEvent.CLICK,this.initStep1);
         }
         this._npc = null;
         super.processMapDispose();
      }
   }
}
