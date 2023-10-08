package com.taomee.seer2.app.processor.quest.handler.branch.quest10253
{
   import com.greensock.TweenNano;
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.app.pet.MonsterManager;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.quest.QuestManager;
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
   
   public class QuestMapHandler_10253_3846 extends QuestMapHandler
   {
       
      
      private var _npc1032:Mobile;
      
      private var _npc1017:Mobile;
      
      public function QuestMapHandler_10253_3846(param1:QuestProcessor)
      {
         super(param1);
      }
      
      override public function processMapDispose() : void
      {
         super.processMapDispose();
         if(this._npc1032)
         {
            MobileManager.removeMobile(this._npc1032,MobileType.NPC);
            this._npc1032 = null;
         }
         if(this._npc1017)
         {
            MobileManager.removeMobile(this._npc1017,MobileType.NPC);
            this._npc1017 = null;
         }
      }
      
      override public function processMapComplete() : void
      {
         super.processMapComplete();
         if(QuestManager.isAccepted(10253) && QuestManager.isComplete(10253) == false)
         {
            if(QuestManager.isStepComplete(10253,1) && QuestManager.isStepComplete(10253,2) == false)
            {
               MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10253_0"),function():void
               {
                  createNpc1032();
               });
            }
         }
      }
      
      private function createNpc1032() : void
      {
         var _loc1_:InProgressMark = null;
         if(!this._npc1032)
         {
            this._npc1032 = new Mobile();
            this._npc1032.setPostion(new Point(400,470));
            this._npc1032.resourceUrl = URLUtil.getNpcSwf(1032);
            this._npc1032.buttonMode = true;
            MobileManager.addMobile(this._npc1032,MobileType.NPC);
            _loc1_ = new InProgressMark();
            this._npc1032.addChild(_loc1_);
            _loc1_.y = -130;
            this._npc1032.addEventListener(MouseEvent.CLICK,this.initStep2);
         }
      }
      
      private function initStep2(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         NpcDialog.show(1032,"梵拉",[[0,"原魂兽，你怎么了？这里都是你的族人和朋友，不要伤害他们！"]],["原魂兽是生病了吗？"],[function():void
         {
            NpcDialog.show(3011,"原魂兽",[[0,"我感觉有人在控制着我的心志，企图利用我来破坏超能氏族。尽力阻止我吧，我不想伤害善良的人。"]],["竟然有人会干这种是。"],[function():void
            {
               NpcDialog.show(12,"萨伦",[[0,"（远处传来回响……）哈哈哈哈，你们以为萨伦帝国会毫无防备的让你们偷走能量碎片？天真的机器人！"]],["萨伦，我就知道一定是你！"],[function():void
               {
                  NpcDialog.show(1032,"梵拉",[[0,"太卑鄙了，竟然对能量碎片动手脚！"]],["萨伦，有本事就出来！别躲着！"],[function():void
                  {
                     NpcDialog.show(12,"萨伦",[[0,"（远处传来回响……）哼，放弃吧。你们不可能找到我，更不可能救回原魂兽……"]],["我们一定有办法，等着瞧！"],[function():void
                     {
                        if(_npc1032)
                        {
                           MobileManager.removeMobile(_npc1032,MobileType.NPC);
                           _npc1032 = null;
                        }
                        createNpc1017();
                     }]);
                  }]);
               }]);
            }]);
         }]);
      }
      
      private function createNpc1017() : void
      {
         var _loc1_:InProgressMark = null;
         if(!this._npc1017)
         {
            this._npc1017 = new Mobile();
            this._npc1017.setPostion(new Point(420,560));
            this._npc1017.resourceUrl = URLUtil.getNpcSwf(1017);
            this._npc1017.buttonMode = true;
            MobileManager.addMobile(this._npc1017,MobileType.NPC);
            _loc1_ = new InProgressMark();
            this._npc1017.addChild(_loc1_);
            _loc1_.y = -130;
            this._npc1017.addEventListener(MouseEvent.CLICK,this.initStep3);
         }
      }
      
      private function initStep3(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         NpcDialog.show(1017,"瓦利",[[0,"咳咳，我有一个方法也许能成功。"]],["大叔我太崇拜你了。"],[function():void
         {
            NpcDialog.show(1017,"瓦利",[[0,"我曾听说水脉氏族有能够净化心灵的圣水，应该能够为原魂兽解除邪恶的诅咒。我年纪大了，需要你们去水脉氏族跑一趟了。"]],["立马就去。"],[function():void
            {
               NpcDialog.show(1017,"瓦利",[[0,"咳咳，等……等一下，还有一点我忘了说。"]],["（-_-#  果然大叔年纪大了）"],[function():void
               {
                  NpcDialog.show(1017,"瓦利",[[0,"圣水必须储存在特殊材料制作的时净瓶里才能保持纯净。"]],["这你都知道。"],[function():void
                  {
                     NpcDialog.show(1017,"瓦利",[[0,"因为我曾帮助水脉族长制作过一批时净瓶，所以我才知道这些嘛。有一个瓶子被摔碎了，碎片拜托沙吉塔帮忙保管。你们可能需要战胜他才能拿回来哦。"]],["明白了，我速去速回。"],[function():void
                     {
                        QuestManager.addEventListener(QuestEvent.COMPLETE,onCompleted);
                        QuestManager.completeStep(questID,2);
                     }]);
                  }]);
               }]);
            }]);
         }]);
      }
      
      private function onCompleted(param1:QuestEvent) : void
      {
         var event:QuestEvent = param1;
         if(event.questId == 10253)
         {
            QuestManager.removeEventListener(QuestEvent.COMPLETE,this.onCompleted);
            MonsterManager.showAllMonster();
            SceneManager.changeScene(SceneType.LOBBY,70);
            TweenNano.delayedCall(1,function():void
            {
               ModuleManager.toggleModule(URLUtil.getAppModule("YuanHunBeastPanel"),"","2");
            });
         }
      }
   }
}
