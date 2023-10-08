package com.taomee.seer2.app.processor.quest.handler.branch.quest10138
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.actor.data.UserInfo;
   import com.taomee.seer2.app.controls.ToolBar;
   import com.taomee.seer2.app.controls.widget.HeaderShootWidgetClick;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.shoot.ShootController;
   import com.taomee.seer2.app.shoot.ShootEvent;
   import com.taomee.seer2.app.shoot.ShootInfo;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.app.utils.NpcUtil;
   import com.taomee.seer2.core.quest.events.QuestEvent;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestMapHandler_10138_360 extends QuestMapHandler
   {
       
      
      private var _mc_0:MovieClip;
      
      private var _count:int;
      
      public function QuestMapHandler_10138_360(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isCanAccepted(_quest.id))
         {
            this.addChicken();
         }
         if(QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id,1) == false)
         {
            this.addFire();
         }
         if(QuestManager.isStepComplete(_quest.id,1) && QuestManager.isStepComplete(_quest.id,2) == false)
         {
            this.addChickenAgain();
         }
      }
      
      private function addChicken() : void
      {
         this._mc_0 = _processor.resLib.getMovieClip("chicken");
         _map.content.addChild(this._mc_0);
         MovieClipUtil.playMc(this._mc_0,1,this._mc_0.totalFrames,function():void
         {
            QuestManager.addEventListener(QuestEvent.ACCEPT,onAcceptHandler);
            QuestManager.accept(_quest.id);
         },true);
      }
      
      private function onAcceptHandler(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAcceptHandler);
         this.addFire();
      }
      
      private function addFire() : void
      {
         if(this._mc_0)
         {
            DisplayUtil.removeForParent(this._mc_0);
         }
         this._mc_0 = _processor.resLib.getMovieClip("fire");
         _map.front.addChild(this._mc_0);
         this._mc_0.gotoAndStop(1);
         NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[0,"神马情况！这只鸡是在自焚吗？不行，我要救它！"]],["（用水属性头部射击给鸡灭火）"],[function():void
         {
            _processor.showMouseHintAt(453,498);
            ToolBar.getBtn(HeaderShootWidgetClick.SHOOT).addEventListener(MouseEvent.CLICK,onBtn);
         }]);
      }
      
      private function onBtn(param1:MouseEvent) : void
      {
         ToolBar.getBtn(HeaderShootWidgetClick.SHOOT).removeEventListener(MouseEvent.CLICK,this.onBtn);
         _processor.hideMouseClickHint();
         _processor.showMouseHintAt(431,449);
         ShootController.addEventListener(ShootEvent.PLAY_END,this.onShootEnd);
      }
      
      private function onShootEnd(param1:ShootEvent) : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:ShootInfo = param1.info;
         var _loc4_:UserInfo = ActorManager.actorInfo;
         if(_loc3_.id == 2 && _loc3_.userID == _loc4_.id)
         {
            _loc2_ = this._mc_0.hitTestPoint(param1.info.endPos.x,param1.info.endPos.y,true);
            if(_loc2_)
            {
               _processor.hideMouseClickHint();
               ++this._count;
               if(this._count == 3)
               {
                  this.playChicken();
               }
               else
               {
                  this._mc_0.gotoAndStop(this._count + 1);
               }
            }
         }
      }
      
      private function playChicken() : void
      {
         if(this._mc_0)
         {
            DisplayUtil.removeForParent(this._mc_0);
         }
         this._mc_0 = _processor.resLib.getMovieClip("chicken1");
         _map.content.addChild(this._mc_0);
         MovieClipUtil.playMc(this._mc_0,1,this._mc_0.totalFrames,function():void
         {
            NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[0,"这到底发生了什么？我想我还是应该先安慰安慰这只命苦的火鸡。"]],[],[function():void
            {
               NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[0,"小家伙，别想不开呀，有什么事可以好好说，别烧着自己了，这太危险了！"]],[],[function():void
               {
                  NpcDialog.show(525,"楼兰斯",[[0,"呜呜，大侠，刚刚是你用水枪帮我扑灭火的吧！谢谢哦！"]],["......"],[function():void
                  {
                     NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[0,"到底是怎么了！什么事让你想不开啊！自己烧自己，何苦呢？"]],["能不能给我说说？"],[function():void
                     {
                        NpcDialog.show(525,"楼兰斯",[[0,"哎！一言难尽啊……"]],["（火鸡开始讲述自己的故事）"],[function():void
                        {
                           MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10138_0"),function():void
                           {
                              QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStep1Handler);
                              QuestManager.completeStep(_quest.id,1);
                           },true,false,2);
                        }]);
                     }]);
                  }]);
               }]);
            }]);
         },true);
      }
      
      private function onStep1Handler(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep1Handler);
         this.NpcTalk();
      }
      
      private function addChickenAgain() : void
      {
         if(this._mc_0)
         {
            DisplayUtil.removeForParent(this._mc_0);
         }
         this._mc_0 = _processor.resLib.getMovieClip("chicken1");
         _map.content.addChild(this._mc_0);
         MovieClipUtil.playMc(this._mc_0,1,this._mc_0.totalFrames,function():void
         {
            NpcTalk();
         },true);
      }
      
      private function NpcTalk() : void
      {
         NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[0,"看来你就是那只奇特的长脖子鸡咯！哇，你是独一无二啊！金鸡独立吧，哇哈哈，真棒！"]],[],[function():void
         {
            NpcDialog.show(525,"楼兰斯",[[0,"哎！我不要做独一无二，我要做一直普通的鸡，我要和大家一样！我要正常点！"]],["（听火鸡继续讲述）"],[function():void
            {
               MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10138_1"),function():void
               {
                  NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[0,"嗯嗯，我完全能理解你的感受，被人孤立。哦不对，是被鸡孤立……"]],["你应该找到自信"],[function():void
                  {
                     NpcDialog.show(525,"楼兰斯",[[0,"呜呜，我好孤单，好害怕！我觉得他们都不喜欢我，我是一只被嫌弃的鸡。"]],["没关系，我是你的朋友"],[function():void
                     {
                        NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[0,"从现在开始我就是你的朋友，来！我为你唱首歌吧。哈哈"]],["啦啦啦啦……"],[function():void
                        {
                           NpcDialog.show(525,"楼兰斯",[[0," 哇哇！大侠，你真好！难道你就是我梦中的那个亲人？"]],["梦中。。"],[function():void
                           {
                              NpcDialog.show(NpcUtil.getSeerNpcId(),"我",[[0," 哈哈，不仅梦中是，在现实中我也是你的好伙伴！走，先送你回家吧。重新认识你的鸡群们。"]],["走咯，回家咯"],[function():void
                              {
                                 QuestManager.addEventListener(QuestEvent.STEP_COMPLETE,onStep2Handler);
                                 QuestManager.completeStep(_quest.id,2);
                              }]);
                           }]);
                        }]);
                     }]);
                  }]);
               },true,false,2);
            }]);
         }]);
      }
      
      private function onStep2Handler(param1:QuestEvent) : void
      {
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep2Handler);
         SceneManager.changeScene(SceneType.LOBBY,310);
      }
      
      override public function processMapDispose() : void
      {
         if(this._mc_0)
         {
            DisplayUtil.removeForParent(this._mc_0);
         }
         QuestManager.removeEventListener(QuestEvent.ACCEPT,this.onAcceptHandler);
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep1Handler);
         QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE,this.onStep2Handler);
      }
   }
}
